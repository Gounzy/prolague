%%% Thinning 
%% - Suppression de clauses inutilisées, vides, et des termes "true" inutiles
%% - Thinning des slices : implémentation très désastreuse et impure mais l'idée y est 
%%   (parcourir tout le programme et marquer les positions de variables qui, une fois au moins, sont occupées par une variable d'intérêt ou une variable liée par une contrainte à une variable d'intérêt)

:-module(thin, []).

:-use_module(utils). 
:-use_module(terms).
:-use_module(slice).
:-use_module(constraints).
:-use_module(transformation).
:-use_module(pprint).

:-dynamic marked/2.
:-dynamic added/1.
:-dynamic visited/1.

%%%
% Removes unused and empty clauses
%%%
thin(Clauses, RootPreds, FinalClauses, ThinnedSomething):-
	remove_unused_clauses(Clauses, Clauses, RootPreds, NewClauses, false, ThinnedSomething),
	remove_empty_clauses(NewClauses, NewClauses, RootPreds, FinalClauses1), 
	remove_trues_clauses(FinalClauses1, FinalClauses).
	
remove_trues_clauses([], []). 
remove_trues_clauses([cl(H,C,B)|Clauses], [cl(H,C,NB)|NClauses]):- 
	remove_trues_and_empties(B,NB), 
	remove_trues(Clauses, NClauses). 

% Unused clauses
remove_unused_clauses([], _, _, [], ThinnedSomething, ThinnedSomething).
remove_unused_clauses([Cl|Clauses], AllClauses, RootPreds, NewClauses, _, ThinnedSomething):-
	not(any_root_call_to(Cl, AllClauses, RootPreds, [])), 
	!,
	remove_unused_clauses(Clauses, AllClauses, RootPreds, NewClauses, true, ThinnedSomething).
remove_unused_clauses([Cl|Clauses], AllClauses, RootPreds, [Cl|NewClauses], ThinnedTemp, ThinnedFinal):-
	remove_unused_clauses(Clauses, AllClauses, RootPreds, NewClauses, ThinnedTemp, ThinnedFinal). 

% true if there exist a root call to Cl
any_root_call_to(Cl, AllClauses, [RP|_], X):- 
	root_call_to(Cl, AllClauses, RP, X), !. 
any_root_call_to(Cl, AllClauses, [_|RootPreds], X):-
	any_root_call_to(Cl, AllClauses, RootPreds, X). 

% true iff a call is made to H, starting from Firstpred (except recursive calls)
root_call_to(cl(H, _, _), _, FirstPred, _):-
	H =..[FirstPred|_],
	!.
root_call_to(cl(H, _, _), Clauses, FirstPred, Seen):- 
	member(cl(NH, NC, NB), Clauses),
	not(member(cl(NH, NC, NB), Seen)),
	member(X, NB),
	unify(X, H),
	append([cl(NH, NC, NB)], Seen, NewSeen),
	root_call_to(cl(NH, NC, NB), Clauses, FirstPred, NewSeen).

% Empty clauses : we need to remove them but also to suppress the calls that refer to them, if the suppressed clause was the last of its kind (name & arity)
remove_empty_clauses([], LastClauses, _, LastClauses). 
remove_empty_clauses([cl(H,C,B)|Clauses], AllClauses, RootPreds, NewClauses):-
	H =..[Pred|Args], 
 	not(member(Pred, RootPreds)), % not really well handled
 	all_different_elems(Args),
	empty_or_true(C),
	empty_or_true(B), 
	!,
	select(cl(H,C,B), AllClauses, AllClausesExceptCl),
	remove_calls_if_last(AllClausesExceptCl, H, NewAllClauses),
	remove_empty_clauses(Clauses, NewAllClauses, RootPreds, NewClauses). 
remove_empty_clauses([cl(_,_,_)|Clauses], AllClauses, RootPreds, NewClauses):-
	remove_empty_clauses(Clauses, AllClauses, RootPreds, NewClauses).

remove_calls_if_last(Clauses, H, NewClauses):-
	last_of_a_kind(H, Clauses), !,
	remove_calls(Clauses, H, NewClauses).
remove_calls_if_last(Clauses, _, Clauses).


% true iff there are no more Head/Arity
last_of_a_kind(Head, Clauses):-
	not(other_member(Head, Clauses)).

other_member(Head, Clauses):- 
	member(cl(H, _, _), Clauses), 
	unify(H, Head). 

% Removes calls to Head
remove_calls([], _, []). 
remove_calls([cl(H, C, B)|Clauses], Head, [cl(H, C, NB)|NewClauses]):- 
	remove_calls_to_head(B, Head, NB),
	remove_calls(Clauses, Head, NewClauses). 
	
remove_calls_to_head([], _, []). 
remove_calls_to_head([Call|Calls], Head, NCalls):-
	unify(Call, Head),
	remove_calls_to_head(Calls, Head, NCalls). 
remove_calls_to_head([Call|Calls], Head, [Call|NewCalls]):-
	not(unify(Call, Head)),
	remove_calls_to_head(Calls, Head, NewCalls).  
	
	
%%%%%%
% Slice thinning
%%%

thin_slices([], [], _, [], _). 
thin_slices([IV|InVars], [IC|InClauses], Pred, [OC|OutClauses], SmartSlicing):-
		format('Thinning slice part ~w ...~n', [IC]), 
	thin_slice_part(IV, IC, Pred, OC, SmartSlicing), 
		format('Result : ~w ...~n', [OC]), 
	thin_slices(InVars, InClauses, Pred, OutClauses, SmartSlicing).
	 
thin_slice_part(IV, IC, Pred, OC, SmartSlicing):-
	transformation:extract_predicate(IC, Pred, [], [FirstPC|PredClauses], OtherClauses), 
	append([FirstPC|PredClauses], OtherClauses, AllClauses),
	calc_positions(IV, FirstPC, Positions),
	thin_down(AllClauses, Pred, [FirstPC|PredClauses], Positions, [], _, SmartSlicing), 
	%constraints:optimize(IC, IC1),
	add_smart_markages(IC, Pred),
	!,
	clear_slice(IC, OC),
	retractall(marked(_,_)).
	
calc_positions(Variables, cl(H, _, _), Positions) :-
	H =..[_|Args], 
	calc_positions(Variables, Args, 1, Positions).

calc_positions(_, [], _, []). 	
calc_positions(Variables, [A|Args], N, [N|Positions]):-
	member(A, Variables), 
	!,
	N1 is N + 1, 
	calc_positions(Variables, Args, N1, Positions).
calc_positions(Variables, [_|Args], N, Positions):- 
	N1 is N + 1, 
	calc_positions(Variables, Args, N1, Positions). 
	
thin_down(_, _, _, [], P, P,_). 
thin_down(_, _, [], _, P, P,_). 
thin_down(AllClauses, Pred, [PC|PredClauses], Positions, Processed, FinalProcessed, SmartSlicing):-
	thin_down_baseclause(Positions, Pred, AllClauses, PC, Processed, Processed1, SmartSlicing),
	append(Processed1, Processed, NewProcessed),
	thin_down(AllClauses, Pred, PredClauses, Positions, NewProcessed, FinalProcessed, SmartSlicing).
	
thin_down_baseclause(Positions, Pred, AllClauses, cl(H,C,B), Processed, FinalProcessed, SmartSlicing):-
		%format('~n Positions : ~w ~n', [Positions]),
	not(member((Positions, H), Processed)),
	!,
	append([(Positions, H)], Processed, NProcessed),
	vars_from_positions(H, Positions, Vars), 
		%format('TD baseclause : Vars : ~w ~n', [Vars]),
	slice:constraint_edge(cl(H, C, B), Vars, SliceVars, SmartSlicing),
		%format('TD baseclause : SliceVars : ~w ~n', [SliceVars]),
	calc_positions(SliceVars, cl(H,C,B), AllNewPositions),
		%format('TD baseclause : AllNewPositions : ~w ~n', [AllNewPositions]),
	sort(AllNewPositions, ANPositions),
		%format('Handling clause : ~w ~n', [cl(H,C,B)]),
	append([(ANPositions, H)], NProcessed, NewProcessed),
	mark_positions(ANPositions, H),
	thin_down_all_calls(cl(H, C, B), Pred, B, AllClauses, ANPositions, NewProcessed, FinalProcessed, SmartSlicing).
thin_down_baseclause(_,_,_,_,P,P,_). 
	
vars_from_positions(H, Positions, Vars):- 
	H =..[_|Args], 
	vfp(Args, Positions, Vars). 
	
vfp(_, [], []). 
vfp(Args, [Pos|Positions], [Var|Vars]):-
	nth1(Pos, Args, Var), 
	vfp(Args, Positions, Vars). 
	
mark_positions([], _). 
mark_positions([Pos|Positions], H) :- 
	H =..[Pred|_],
		%format('mark_positions : Marking position ~w of pred ~w ~n', [Pos, Pred]), 
	assert(marked(Pred, Pos)), 
	mark_positions(Positions, H). 

thin_down_all_calls(cl(H,C,B), Pred, [true|Bs], AllClauses, Positions, Processed, FinalProcessed, SmartSlicing):-
	thin_down_all_calls(cl(H,C,B), Pred, Bs, AllClauses, Positions, Processed, FinalProcessed, SmartSlicing).
thin_down_all_calls(_, _, [], _, _, P, P, _). 
thin_down_all_calls(cl(H, C, B), Pred, [Call|Bs], AllClauses, Positions, Processed, FinalProcessed, SmartSlicing) :-
		%format('Checking calls of clause : ~w ~n', [cl(H, C, B)]),
	positions_h_b(H, Call, Positions, NPositions),
		%format('Positions : ~w , NPositions : ~w ~n', [Positions, NPositions]),
	vars_from_positions(Call, NPositions, Vars), 
		%format('TD all calls : Vars : ~w ~n', [Vars]),
	slice:constraint_edge(cl(H, C, B), Vars, SliceVars, SmartSlicing),
		%format('TD all calls : SliceVars : ~w ~n', [SliceVars]),
	calc_positions(SliceVars, cl(B,C,H), AllNewPositions), % we need positions in B
		%format('TD all calls : AllNewPositions : ~w ~n', [AllNewPositions]),
	append(NPositions, AllNewPositions, NNPositions),
	sort(NNPositions, NewPositions),
	bagofcalls(AllClauses, Call, Calls), 
	thin_down(AllClauses, Pred, Calls, NewPositions, Processed, NewProcessed, SmartSlicing),
	thin_down_all_calls(cl(H, C, B), Pred, Bs, AllClauses, Positions, NewProcessed, FinalProcessed, SmartSlicing). 
	
positions_h_b(H, B, Positions, FinalPositions):- 
	H =..[_|Args], 
	B =..[_|Args2], 
	phb(Args, Args2, Positions, NewPositions), 
	sort(NewPositions, FinalPositions).
	
phb(_, _, [], []). 
phb(Args, Args2, [Pos|Positions], [Pos2|NewPositions]):-
	nth1(Pos, Args, Elem), 
	nth1(Pos2, Args2, Elem), !,
	phb(Args, Args2, Positions, NewPositions). 
phb(Args, Args2, [_|Positions], NewPositions):- 
	phb(Args, Args2, Positions, NewPositions).
	
bagofcalls([], _, []).	
bagofcalls([cl(H,C,B)|AllClauses], OB, [cl(H,C,B)|Calls]):-
	unify(H, OB), !,
	bagofcalls(AllClauses, OB, Calls).
bagofcalls([_|AllClauses], OB, Calls):-
	bagofcalls(AllClauses, OB, Calls). 
	
add_smart_markages(Clauses, Pred):-
	retractall(visited(_)),
	retractall(added(_)),
	assert(added(false)),
	visit(Clauses, Pred), 
	(added(true) -> add_smart_markages(Clauses, Pred) ; true). 

visit(Clauses, Pred):-
	assert(visited(Pred)), 
	transformation:extract_predicate(Clauses, Pred, [], PredClauses, _), 
		%format('Extracted clauses : ~w ~n', [PredClauses]),
	visit_each(PredClauses, Clauses, Pred).
	
visit_each([cl(_,_,[])|Clauses], AllClauses, Pred):-
	!,visit_each(Clauses, AllClauses, Pred). 
visit_each([], _, _):-!. 
visit_each([cl(H,C,[true|Bs])|Clauses], AllClauses, Pred) :-
	!,visit_each([cl(H,C,Bs)|Clauses], AllClauses, Pred).
visit_each([cl(H,C,[B|Bs])|Clauses], AllClauses, Pred) :-
	!,
	B =..[BPred|_], 
		%format('BPred : ~w ~n', [BPred]),
	(not(visited(BPred)) -> visit(AllClauses, BPred) ; true),
	visit_each([cl(H, C, Bs)], AllClauses, Pred),
	visit_each(Clauses, AllClauses, Pred),
	addMapped(H, C, B).

addMapped(H, C, B) :- 
		%format('AddMapped : H = ~w, B = ~w ~n', [H,B]),
	B =..[Pred|_],
	findall(Pos, marked(Pred, Pos), Positions),
		%format('AddMapped : Positions = ~w ~n', [Positions]),
	vars_from_positions(B, Positions, Vars),
	slice:constraint_edge(cl(_, C, _), Vars, AllVars),
		%format('AddMapped : Vars = ~w ~n', [Vars]), 
	mark_vars(H, AllVars).
	
mark_vars(_, []):-!. 
mark_vars(H, Vars):- 
	H =..[Pred|Args], 
	mv(Pred, Args, 1, Vars). 
	
mv(_,[], _, _). 
mv(Pred, [Arg|Args], Pos, Vars):-
	member(Arg, Vars),
	!,
	(not(marked(Pred, Pos)) -> %format('mark_vars: Marking position ~w of pred ~w ~n', [Pos, Pred]), 
				assert(marked(Pred, Pos)), 
				assert(added(true)) 
				; true),
	Pos1 is Pos + 1,
	mv(Pred, Args, Pos1, Vars).
mv(Pred, [Arg|Args], Pos, Vars):-
	not(member(Arg, Vars)),
	Pos1 is Pos + 1,
	mv(Pred, Args, Pos1, Vars).
	
clear_slice([], []).
clear_slice([cl(H,C,B)|IC], [cl(NH, NC, NB)|OC]):-
	clear_call(H, NH), 
	clear_calls(B, NB),
	clear_constr(NH, NB, C, NC),
	clear_slice(IC, OC). 
	
clear_calls([], []).
clear_calls([Call|Calls], [NC|NewCalls]):-
	clear_call(Call, NC), 
	clear_calls(Calls, NewCalls). 
	
clear_call(true, true). 
clear_call(H, NH):- 
	H =..[Pred|Args], 
	clear_args(Pred, Args, Args, 1, NArgs), 
	NH =..[Pred|NArgs].
	
clear_args(_, _, [], _, []). 
clear_args(Pred, AllArgs, [A|As], N, [A|Xs]):-
	marked(Pred, N),
	!,
	N1 is N + 1, 
	clear_args(Pred, AllArgs, As, N1, Xs).
clear_args(Pred, AllArgs, [_|As], N, Xs):-
	N1 is N + 1,
	clear_args(Pred, AllArgs, As, N1, Xs).
	
clear_constr(H, B, C, NC) :- 
	H =..[_|ArgsH],
	all_args(B, [], ArgsB),
	append(ArgsH, ArgsB, Args),
	filter_constraints(Args, C, NC).   
	
filter_constraints(_, [], []).
filter_constraints(SV, [C], []):-
	slice:constraint_vars(C, CVars),
	not(slice:at_least_one_member(SV, CVars)),
	!.
filter_constraints(SliceVariables, [C|Constraints], [C|NConstraints]):-
	slice:constraint_vars(C, CVars),
	slice:at_least_one_member(SliceVariables, CVars),
	!,
	filter_constraints(SliceVariables, Constraints, NConstraints).
filter_constraints(SliceVariables, [_|Constraints], NConstraints):-
	filter_constraints(SliceVariables, Constraints, NConstraints).
