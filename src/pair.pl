%%%%%%%%%%%%%%
%
% PAIRING  
% - Recherche de boucles équivalentes par pairing sans fold/unfold, juste relation dataflow
% - Pairing à l'aide de fold/unfold (ou uniquement avec une clause de lancement)
%
%%%%%%%%%%%%%%


:-module(pair, []). 

:-use_module(utils). 
:-use_module(fold). 
:-use_module(rename). 
:-use_module(pprint). 
:-use_module(unfold). 
:-use_module(graph).
:-use_module(compare).
:-use_module(transformation).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fold_unfold(Clauses, NClauses):-
	pair_transf(Clauses, Clauses, [], Clauses, _, NClauses, true). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
search_equal_loops(Prog1, Prog2, NProg1) :- 
	find_loop(Prog1, Loop1, Pred1), 
	find_loop(Prog2, Loop2, Pred2),
	def_launching_clause(Loop2, Pred2, Loop1, Pred1, LC), 
	pair(Loop2, Loop1, false, AllClauses, LC), 
	(compare:compare_progs(AllClauses, LC, true, Assoc) 
		-> format('~n FOUND SIMILAR LOOPS ~n'), 
		   apply_subst_loop(Loop2, Assoc, NLoop1), 
		   replace_loop(Prog1, Pred1, NLoop1, Pred2, NProg1) 
		; NProg1 = Prog1
	).
	
find_loop(Prog, Loop, Pred):- 
	graph:call_graph(Prog, Graph), 
	graph:cycle(Graph, Pred/_), 
	extract_predicate(Prog, Pred, [], Loop, _).
	
apply_subst_loop([], _, []). 
apply_subst_loop([CL|Loop], Assoc, [NCL|NLoop]):- 
		format('APPLY_SUBST_LOOP ~n'), 
	terms:fresh_rename(CL, _, Assoc2), 
	append(Assoc, Assoc2, AssocComplete),
	terms:replace(CL, AssocComplete, NCL),
	apply_subst_loop(Loop, Assoc, NLoop). 
	
replace_loop(Prog, Pred, NLoop, LoopPred, NProg1):-
	rename:rename_one_pred(NLoop, LoopPred, Pred, NNLoop),
	extract_predicate(Prog, Pred, [], _, OtherClauses), 
	append(NNLoop, OtherClauses, NProg1). 
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

launching_clause(Clauses1, Clauses2, LaunchingCl, RClauses1, RClauses2) :-  % Automated generation of launching clause
	rename:rename_one_pred(Clauses1, p_start, p_start1, RClauses1),
		%pp_print_clauses(RClauses1),
	rename:rename_one_pred(Clauses2, p_start, p_start2, RClauses2), 
		%pp_print_clauses(RClauses2),
	def_launching_clause(RClauses1, p_start1, RClauses2, p_start2, LaunchingCl).
	
def_launching_clause(Clauses1, StartingPred1, Clauses2, StartingPred2, cl(Head, [], Calls)):- % Manual generation
	transformation:get_arity(StartingPred1, Clauses1, Arity1),
	transformation:get_arity(StartingPred2, Clauses2, Arity2),
	create_calls(StartingPred1/Arity1, StartingPred2/Arity2, 0, Calls),
	all_args(Calls, Args), 
	Head =..[launchingClause|Args].

pair(Clauses1, Clauses2, WithTransf, AllClauses, LaunchingCl):-
	append(Clauses1, Clauses2, AllClauses1),
		%pp_print_clauses(AllClauses),
	(WithTransf -> pair_transf(AllClauses1, [LaunchingCl], [], AllClauses1, _, NewTransf, false), 
		       AllClauses = NewTransf 
		    ; append([LaunchingCl], AllClauses1, AllClauses)).
		%format('--------------- NEW DEFS : ---------------- ~n'),
		%pp_print_clauses(NewDefs).

create_calls(Pred1/A1, Pred2/A2, N, [Call1,Call2]) :- 
	create_call(Pred1/A1, N, Call1), 
	N1 is N + A1, 
	create_call(Pred2/A2, N1, Call2). 

create_call(Pred/N, I, Call):-
	N1 is N + I,
	create_n_args(I, N1, Args), 
	Call =..[Pred|Args].
	 
create_n_args(I, I, []). 
create_n_args(I, N, ['$VAR'(I)|Vars]):-
	I < N, 
	I1 is I + 1, 
	create_n_args(I1, N, Vars). 
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
pair_transf(_, [], D, T, D, T, _). 
pair_transf(AllClauses, [cl(H,C,B)|InCls], Defs, TransfCls, NewDefs, NewTransf, Unfold):-
	H =..[Pred|_],
	(Unfold -> unfold:unfold_once_one_pred([cl(H,C,B)|AllClauses],Pred,UC)
		; UC = [cl(H,C,B)]),
		%format('--------------------UC : -------------- ~n'), 
		%pp_print_clauses(UC),
	define_fold(UC, AllClauses, Defs, TransfCls, [], DeffedIn, NDefs, NTransf), 
		%format('--------------------DEFFEDIN : -------------- ~n'), 
		%pp_print_clauses(DeffedIn),
	append(DeffedIn, InCls, NewIn), 
	pair_transf(AllClauses, NewIn, NDefs, NTransf, NewDefs, NewTransf, true). 
	
define_fold([cl(H,C,B)|FC], AllClauses, Defs, TransfCls, DeffedIn, NewDeffedIn, NewDefs, NewTransf):-
	two_or_more_calls_from(B, AllClauses),
		%print(t1),
	!, 
	fold:fold(cl(H,C,B), Defs, NDef, NewClause), 
		%print(t2),
	append(NDef, Defs, NDefs),
	append(NDef, DeffedIn, NDeffedIn),
	define_fold([NewClause|FC], AllClauses, NDefs, TransfCls, NDeffedIn, NewDeffedIn, NewDefs, NewTransf).  
define_fold([Cl|FC], AllClauses, Defs, TransfCls, DeffedIn, NewDeffedIn, NewDefs, NewTransf) :-
	define_fold(FC, AllClauses, Defs, [Cl|TransfCls], DeffedIn, NewDeffedIn, NewDefs, NewTransf). 
define_fold([], _, Defs, TransfCls, DeffedIn, DeffedIn, Defs, TransfCls). 
	
two_or_more_calls_from(Calls, List):-
	remove_trues_and_empties(Calls, NCalls), 
	member(X1, NCalls), 
	member(X2, NCalls), 
	X1 \= X2, 
	X1 =..[Pred1|_], 
	X2 =..[Pred2|_], 
	member(cl(A1,_,_), List), 
	member(cl(A2,_,_), List), 
	A1 =..[Pred1|_], 
	A2 =..[Pred2|_]. 