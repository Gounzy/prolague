%%% Folding
% Inclut la définition d'un nouveau prédicat dans le cas où une clause est non "foldable". 

:-module(fold, []). 

:-use_module(utils). 
:-use_module(terms).  
:-use_module(rename). 

fold(cl(H,C,B), Clauses, [], cl(H,C,[NewCall])):-
	is_foldable(cl(H,C,B), Clauses, cl(H2,_,_), NB), 
	!,
	H2 =..[Pred|_],
	all_args(NB, NArgs),
	NewCall =..[Pred|NArgs]. 
fold(cl(H,C,B), Clauses, [cl(NH, [], NB)], NewClause):- % define
	all_args(B, Args), 
	rename:flatten_args(Args, FArgs),
	new_pred_name("defined", NewPredName),
	NH =..[NewPredName|FArgs], 
	inject_args(FArgs, B, NB), 
	fold(cl(H,C,B), [cl(NH, [], NB)|Clauses], _, NewClause).

is_foldable(cl(H,_,B), Clauses, cl(H2, C2, B2), NB):- 
	remove_trues_and_empties(B, Calls0),
	remove_calls_to_defs(Calls0, Clauses, Calls1), % par simplicité, parce que pour l'instant on ne gère pas bien le cas où B contient > 2 appels
	!,
	member(cl(H2, C2, B2), Clauses), 
	not(unify(H2, H)), % not recursive
	remove_trues_and_empties(C2, []), 
	total_n_args(B, N), 
	total_n_args([H2], N), 
	remove_trues_and_empties(B2, Calls2),
	same_calls(Calls2, Calls1, NB).
	
remove_calls_to_defs([], _, []). 
remove_calls_to_defs([Call|Calls], DefClauses, NCalls):- 
	member(cl(H,_,_), DefClauses), 
	unify(H, Call), 
	!,
	remove_calls_to_defs(Calls, DefClauses, NCalls). 
remove_calls_to_defs([Call|Calls], DefClauses, [Call|NCalls]):-
	remove_calls_to_defs(Calls, DefClauses, NCalls).  

inject_args([], [], []). 
inject_args(AllArgs, [B|Bs], [NB|NBs]):-
	B =..[Pred|Args], 
	length(Args, N), 
	take(N, AllArgs, NArgs, OtherArgs),
	NB =..[Pred|NArgs],
	inject_args(OtherArgs, Bs, NBs).