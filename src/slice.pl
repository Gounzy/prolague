%%% Slicing : 
%% - smart slicing = suppression des arguments inutilisés, càd des arguments de chaque pred qui sont à une position qui n'est jamais contrainte
%%   (l'implémentation est un peu absurde pour l'instant vu qu'on appelle le thinning avec SmartSlicing = true au final, ce qui suffit pour faire du smart slicing... (sauf pour les args de la clause de départ dont les complètement inutiles sont virés par is_interesting(slice))
%% - vrai slicing = utilisation de l'algo avec constraint, local et transition edge (avec transition edge en deux étapes : down puis up dans les appels).
 
:-module(slice, []).

:-use_module(utils). 
:-use_module(terms). 
:-use_module(transformation). 
:-use_module(pprint).
:-use_module(constraints).
:-use_module(rename).
:-use_module(thin).
  
%%%
% "Smart slicing"
% Removes unused arguments
%%%
slice(Clauses, Pred, FinalClauses):- 
	rename:flatten(Clauses, Clauses1),
	rename:rename(Clauses1, Clauses2),
	slice(Clauses2, Pred, SliceVars, Slices),
	thin:thin_slices(SliceVars, Slices, Pred, Slices1, false),
	merge_interesting_slices(Clauses2, Pred, SliceVars, Slices1, FinalClauses),!.
	
merge_interesting_slices(AllClauses, Pred, SliceVariables, Slices, FinalClauses):-
	find_interesting_vars(SliceVariables, Slices, [], Vars), 
		format('Interesting vars : ~w ~n', [Vars]), 
	transformation:extract_predicate(AllClauses, Pred, [], PredClauses, _), 
	rename:flatten(PredClauses, FPredClauses),
	slice_each(FPredClauses, AllClauses, [Vars], [FirstClauses|_]), 
	thin:thin_slices([Vars], [FirstClauses], Pred, [FinalClauses|_], true). 
	
find_interesting_vars([], [], CV, CV). 
find_interesting_vars([SV|SliceVariables], [Slice|Slices], CurrentVars, FinalVars):-
	is_interesting(Slice), 
	!,
	append(SV, CurrentVars, NewCurrentVars), 
	find_interesting_vars(SliceVariables, Slices, NewCurrentVars, FinalVars). 
find_interesting_vars([_|SliceVariables], [_|Slices], CurrentVars, FinalVars):-
	find_interesting_vars(SliceVariables,Slices,CurrentVars,FinalVars). 
	
is_interesting([cl(_,C,_)|_]):-
	C \= [], !. 
is_interesting([_|Clauses]):-
	is_interesting(Clauses). 
	
%%%	
% "Real" slicing
%  Generates one slice for each variable group from the starting predicate
%%%
slice(Clauses, Pred, NSliceVariables, NewClauses):- 
	transformation:extract_predicate(Clauses, Pred, [], PredClauses1, OtherClauses),
	rename:flatten(PredClauses1, [FirstClause|PredClauses]),
	transformation:extract_vars(FirstClause, Vars), 
		%format('Extracted vars : ~w ~n', [Vars]),
	slice_each_var(Vars, Vars, [FirstClause|PredClauses], OtherClauses, Clauses, [], SliceVariables),
		%format('FINAL SLICE VARS : ~w ~n FINAL CLAUSES : ~w ~n', [SliceVariables, Clauses]),
	filter_vars(Vars, SliceVariables, NSliceVariables),
		%format('REAL FINAL SLICE VARS : ~w ~n', [NSliceVariables]),
	slice_each([FirstClause|PredClauses], Clauses, NSliceVariables, NewClauses).
	
slice_each(_, _, [], []).
slice_each(Clauses, AllClauses, [SV|SliceVars], [NewClauses|OtherClauses]) :-
	local_edge(Clauses, SV, NClauses),
		%format('Local edge done. Result : ~w ~n', [NClauses]), 
	transition_edge(NClauses, AllClauses, NClauses, NC),
		%format('Transition edge done. Result : ~w ~n', [NC]),
	sort(NC, NewClauses),
	slice_each(Clauses, AllClauses, SliceVars, OtherClauses).
	
%%%%% Constraint edge
slice_each_var([], _, _, _, _, _, []). 
slice_each_var([Var|Vars], AllVars, PredClauses, OtherClauses, AllClauses, ExploredVars, SliceVars):-
	member(Var, ExploredVars),
	!, 
	slice_each_var(Vars, AllVars, PredClauses, OtherClauses, AllClauses, ExploredVars, SliceVars). 
slice_each_var([Var|Vars], AllVars, PredClauses, OtherClauses, AllClauses, ExploredVars, [RealVars|SliceVars]):-
	create_dummy_mapping([Var], Mapping),
	sev(PredClauses, AllClauses, AllVars, [Var], Mapping, RealVars),
	append(RealVars, ExploredVars, NewExploredVars),
	slice_each_var(Vars, AllVars, PredClauses, OtherClauses, AllClauses, NewExploredVars, SliceVars). 

sev(PredClauses, AllClauses, AllVars, Vars, Mapping, FinalSliceVariables) :-
	follow_calls(PredClauses, fist(dummy, dummy), AllClauses, Vars, AllSliceVariables, Mapping, NewMapping, [], _), 
	get_real_vars(AllSliceVariables, AllVars, NewMapping, MdrVars),
	sort(MdrVars, RealVars),
	(all_members(RealVars, Vars) -> FinalSliceVariables = RealVars ; sev(PredClauses, AllClauses, AllVars, RealVars, Mapping, FinalSliceVariables)).

create_dummy_mapping([], []).
create_dummy_mapping([Var|Vars], [(Var, Var)|Mapping]):-
	create_dummy_mapping(Vars, Mapping).  
	
follow_calls([], _, _, SliceVars, SliceVars, M, M, F, F). 
follow_calls([cl(H, C, B)|Clauses], fist(OH,OB), AllClauses, CurrentSliceVariables, AllSliceVariables, Mapping, M2, Followed, NewFollowed):-
	member((cl(H, C, B), Mapping), Followed), !,
	follow_calls(Clauses, fist(OH,OB), AllClauses, CurrentSliceVariables, AllSliceVariables, Mapping, M2, Followed, NewFollowed). 
follow_calls([cl(H, C, B)|Clauses], fist(OH,OB), AllClauses, CurrentSliceVariables, AllSliceVariables, Mapping, M2, Followed, CompletelyNewFollowed):- 
	(OH \= dummy -> reconstruct_mapping(Mapping, OB, H, NMapping) ; NMapping = Mapping),
	NMapping \= [],
	append(NMapping, Mapping, NNMapping),
	sort(NNMapping, NewMapping),
	append([(cl(H, C, B), Mapping)], Followed, NewFollowed),
	transformation:extract_vars(cl(H,C,B), Vars),
	get_from_mapping(Vars, CurrentSliceVariables, NewMapping, ActualSliceVariables),
	append(ActualSliceVariables, CurrentSliceVariables, ACSliceVariables),
	constraint_edge(cl(H, C, B), ACSliceVariables, NewCurrentSliceVariables),
		%update_slicevars(NewCurrentSliceVariables, NewMapping, XYVariables),
	follow_each_call(AllClauses, H, B, NewCurrentSliceVariables, NewMapping, M1, NewFollowed, NewNewFollowed, AllNewSliceVars),	
	follow_calls(Clauses, fist(OH,OB), AllClauses, AllNewSliceVars, AllSliceVariables, M1, M2, NewNewFollowed, CompletelyNewFollowed).
follow_calls([cl(H, C, B)|Clauses], fist(OH,OB), AllClauses, CurrentSliceVariables, AllSliceVariables, Mapping, M2, Followed, CompletelyNewFollowed):- 
	(OH \= dummy -> reconstruct_mapping(Mapping, OB, H, NewMapping) ; NewMapping = Mapping),
	NewMapping = [],
	append([(cl(H, C, B), Mapping)], Followed, NewFollowed),
	follow_calls(Clauses, fist(OH, OB), AllClauses, CurrentSliceVariables, AllSliceVariables, Mapping, M2, NewFollowed, CompletelyNewFollowed). 
	
follow_each_call(_, _, [], SV, M, M, F, F, SV). 
follow_each_call(AllClauses, H, [B|Bs], SliceVars, Mapping, M2, Followed, NewFollowed, NewSliceVars):-
	B =..[Pred|_], 
		%format('B : ~w ~n', [B]),
	transformation:extract_predicate(AllClauses, Pred, [], PredClauses, _), 
	follow_calls(PredClauses, fist(H,B), AllClauses, SliceVars, AllSliceVars, Mapping, M1, Followed, TempFollowed), 
	follow_each_call(AllClauses, H, Bs, AllSliceVars, M1, M2, TempFollowed, NewFollowed, NewSliceVars). 
	
reconstruct_mapping(Mapping, OB, H, NewMapping):- 
	OB =..[_|Args1],
	H =..[_|Args2], 
	create_mapping(Args2, Args1, OMap), 
	follow_mappings(Args2, OMap, Mapping, NMapping),
	append(Mapping, NMapping, M1),
	append(OMap, M1, NewMapping).
	
create_mapping([], [], []). 
create_mapping([V|Vs], [W|Ws], [(V, W)|OMap]):-
	create_mapping(Vs, Ws, OMap).
	
follow_mappings([], _, _, []). 
follow_mappings([V|Vs], Mapping1, Mapping2, [(V, Y)|NewMapping]):-
	member((V, X), Mapping1),
	member((X, Y), Mapping2),
	!,
	follow_mappings(Vs, Mapping1, Mapping2, NewMapping).
follow_mappings([_|Vs], M1, M2, NM):-
	follow_mappings(Vs, M1, M2, NM).
	
get_from_mapping([], _, _, []).
get_from_mapping([Var|Vars], SliceVars, Mapping, MappedSliceVars):-
	member((Var, SV), Mapping),
	not(member(SV, SliceVars)),
	!,
	get_from_mapping(Vars, SliceVars, Mapping, MappedSliceVars).
get_from_mapping([Var|Vars], SliceVars, Mapping, [Var|MappedSliceVars]):-
	 member((Var, SV), Mapping), 
	 member(SV, SliceVars),
	 !,
	 get_from_mapping(Vars, SliceVars, Mapping, MappedSliceVars).
get_from_mapping([Var|Vars], SliceVars, Mapping, MappedSliceVars):-
	not(member((Var, _), Mapping)),
	get_from_mapping(Vars, SliceVars, Mapping, MappedSliceVars).
	
constraint_edge(cl(_,C,_), VL, SV, true):- 
	get_vars(C, CV),
	append(CV, VL, SV),
	format('~n ~n SV : ~w ~n', [SV]).
constraint_edge(cl(_,C,_), VL, SV, false):- 
	constraint_edge(cl(_,C,_), VL, SV). 
constraint_edge(cl(_, C, _), VariableList, SliceVariables) :- 
	constraint_get_variables(C, VariableList, SliceVariables).
	
constraint_get_variables(CList, VariableList, SliceVariables):-
	constraint_one_round(CList, VariableList, SliceVariables1),
		%format('constraint_edge: VariableList = ~w, SliceVariables1 = ~w ~n', [VariableList, SliceVariables1]),
	(all_members(SliceVariables1, VariableList)
		-> (sort(SliceVariables1, SliceVariables))
		; (constraint_get_variables(CList, SliceVariables1, SliceVariables))).
	
constraint_one_round([], X, X).
constraint_one_round([C|Cs], VariableList, SliceVariables):- 
		%format('constraint_one_round: Examinating constraint ~w, VariableList = ~w ~n', [C, VariableList]),
	constraint_one_round(Cs, VariableList, SliceVariabless),
	constraint_vars(C, CVars), 
	(at_least_one_member(VariableList, CVars) -> 
		(
		 append(CVars, SliceVariabless, SliceVariablesDuplicates),
		 list_to_set(SliceVariablesDuplicates, SliceVariables)
		)
		;
		(
		 append(SliceVariabless, [], SliceVariables)
		)
	).
	
constraint_vars('$VAR'(N), ['$VAR'(N)]):- !.
constraint_vars(Constraint, []):-
	atomic(Constraint), 
	!.
constraint_vars([Constraint1,Constraint2], Vars):-
	!,
	constraint_vars(Constraint1, Vars1),
	constraint_vars(Constraint2, Vars2),
	append(Vars1, Vars2, Vars). 
constraint_vars(Constraint, Vars) :-
	Constraint =..[Part1|Part2],
	constraint_vars(Part1, Vars1), 
	constraint_vars(Part2, Vars2),
	append(Vars1, Vars2, Vars).

get_real_vars([], _, _, []).
get_real_vars([V|Vars], TrueVars, Mapping, [X|RealVars]):-
	mapped_way(V, Mapping, X, []), 
	member(X, TrueVars), !,
	get_real_vars(Vars, TrueVars, Mapping, RealVars).
get_real_vars([_|Vars], TrueVars, Mapping, RealVars):- 
	get_real_vars(Vars, TrueVars, Mapping, RealVars).

mapped_way(V, _, V, _).
mapped_way(V, Mapping, X, Explored):-
	member((V, Y), Mapping),
	not(member((V,Y), Explored)),
	mapped_way(Y, Mapping, X, [(V,Y)|Explored]). 

filter_vars(_, [], []). 
filter_vars(Vars, [SliceVars1|SliceVariables], [FSV1|Others]) :-
	fv(Vars, SliceVars1, FSV1),
	filter_vars(Vars, SliceVariables, Others). 
	
fv(_, [], []). 
fv(Vars, [V|Vs], [V|Xs]):-
	member(V, Vars),!, 
	fv(Vars, Vs, Xs). 
fv(Vars, [_|Vs], Xs):-
	fv(Vars, Vs, Xs). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Local edge	

%%%
% In: two first arguments
% Out : third argument
% Replaces the bodies of the clauses in the first argument with their "filtered" version wrt the slice variables
%%%
local_edge([], _, []).
local_edge([cl(H,C,B)|Clauses], SliceVariables, [cl(H,C,NB)|NewClauses]):-
	local_edge_clause(B, SliceVariables, NB),
		%format('local_edge: result = ~w ~n', [NB]),
	local_edge(Clauses, SliceVariables, NewClauses). 

%%%
% Support predicate for local_edge/3 
% In: two first arguments
% Out : third argument
% Removes from the list in the first argument, the calls to predicates with only arguments that are no slice variables (the slice variables are the second argument), which results in the third argument
% Exemple : if the slice variables are X and Y, then r(Z) will be removed but a(X,Z) or a(X) or a(X,Y) will be kept.
%%%
local_edge_clause([], _, [true]):- !.
local_edge_clause([true], _, [true]):- !.
local_edge_clause([B|Bs], SliceVariables, NewB) :- 
		%format('local_edge: B = ~w ~n', [B]),
	local_edge_clause(Bs, SliceVariables, NewNewB),
	(local_contains_variables(B, SliceVariables) 
		-> append([B], NewNewB, NewB)
		;  append([], NewNewB, NewB)).
	
%%%
% Support predicate for local_edge_clause/3
% True iff the call given in the first argument makes use of one of the variables listed in the second argument 
%%%
local_contains_variables(Call, [SliceVar1|_]):- 
	Call =..[_|Args], 
	member(SliceVar1, Args),
	!.
local_contains_variables(Call, [SliceVar1|SliceVars]):-
	Call =..[_|Args],
	not(member(SliceVar1, Args)),
	local_contains_variables(Call, SliceVars).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Transition edge
		
transition_edge([], _, AC, AC). 
transition_edge([cl(H,C,B)|Clauses], AllClauses, CurrentClauses, NewClauses):-
	transition_explore_up(cl(H,C,B), AllClauses, CurrentClauses, NClauses), 
	transition_explore_down(cl(H,C,B), AllClauses, CurrentClauses, NNClauses), 
	append(NClauses, NNClauses, NNNClauses),
	transition_edge(Clauses, AllClauses, NNNClauses, NewClauses).
	
transition_explore_up(cl(H,C,B), AllClauses, CurrentClauses, FinalClauses):- 
	member(cl(H2, C2, B2), AllClauses),
	not(member(cl(H2, C2, B2), CurrentClauses)), 
	member(Call, B2),
	not(unify(H, H2)), 
	unify(H, Call),
	!,
	transition_explore_up(cl(H,C,B), AllClauses, [cl(H2,C2,B2)|CurrentClauses], NClauses1),
	transition_explore_up(cl(H2,C2,B2), AllClauses, NClauses1, FinalClauses).
transition_explore_up(_, _, AC, AC). 

transition_explore_down(cl(H,C,[B|Bs]), AllClauses, CurrentClauses, FinalClauses):-
	member(cl(H2, C2, B2), AllClauses), 
	not(member(cl(H2,C2,B2), CurrentClauses)),
	not(unify(H2, H)), 
	unify(B, H2),
	!,
	transition_explore_down(cl(H,C,[B|Bs]), AllClauses, [cl(H2, C2, B2)|CurrentClauses], NClauses0),
	transition_explore_down(cl(H2, C2, B2), AllClauses, NClauses0, NClauses1),
	transition_explore_down(cl(H, C, Bs), AllClauses, NClauses1, FinalClauses).
transition_explore_down(cl(H,C,[_|Bs]), AllClauses, CurrentClauses, FinalClauses):-
	transition_explore_down(cl(H,C,Bs), AllClauses, CurrentClauses, FinalClauses). 	
transition_explore_down(cl(_,_,[]), _, AC, AC).