%%%% Unfolding 
%%% - Unfolding général qui va tout unfolder un max sauf les cycles (unfold_tilltheend)
%%% - Unrolling qui va tout unfolder un max, même les cycles, donc attention aux boucles infinies
%%% - Unfolding d'un seul prédicat qui va juste faire un tour d'unfolding sur le prédicat donné et renvoyer toutes les clauses
%%% NB l'unfolding conserve bien l'ordre des clauses d'un même prédicat (mais pas l'ordre des prédicats, ce qui n'est pas grave)

:- module(unfold, []).

:-use_module(utils). 
:-use_module(terms). 
:-use_module(thin).
:-use_module(constraints).
:-use_module(transformation).
:-use_module(graph).
:-use_module(pprint).

%%%
% Main unfolding predicates
%%%
unfold_tilltheend(Clauses, FirstPred, FinalClauses):-
	graph:call_graph(Clauses, Graph),
	unfold_tilltheend(Clauses, Graph, FirstPred, [], _, FinalClauses). 
	
unfold_tilltheend(Clauses, Graph, FirstPred, Visited, NewVisited, FinalClauses) :- 
		%format('Unfolding till the end : ~w with visited preds = ~w ~n', [FirstPred, Visited]),
	unfold_tte(Clauses, Graph, FirstPred, [FirstPred|Visited], ResultClauses), 
		%format('ResultClauses : ~w ~n', [ResultClauses]),
	get_arity(FirstPred, Clauses, Arity),
	graph:call_graph(ResultClauses, NewGraph), 
		%format('NewGraph : ~w ~n', [NewGraph]),
	findall(P, graph:directway(NewGraph, FirstPred/Arity, P/_), Ps), 
		%format('PS : ~w ~n', [Ps]),
	unfold_tte_all(ResultClauses, Ps, [FirstPred|Visited], NewVisited, FinalClauses).

unfold_tte_all(Clauses, [], V, V, Clauses).
unfold_tte_all(Clauses, [true|Preds], Visited, NewVisited, FinalClauses):- 
	!, unfold_tte_all(Clauses, Preds, Visited, NewVisited, FinalClauses).
unfold_tte_all(Clauses, [P|Preds], Visited, NewVisited, FinalClauses):- 
	not(member(P, Visited)),
	!, % Predicate not unfolded yet
	graph:call_graph(Clauses, Graph),
	unfold_tilltheend(Clauses, Graph, P, Visited, NVisited, ResultClauses),
	unfold_tte_all(ResultClauses, Preds, NVisited, NewVisited, FinalClauses).
unfold_tte_all(Clauses, [_|Preds], Visited, NewVisited, FinalClauses):-
	unfold_tte_all(Clauses, Preds, Visited, NewVisited, FinalClauses). 

unfold_tte(Clauses, FirstPred, ResultClauses):-
	graph:call_graph(Clauses, Graph), 
	unfold_tte(Clauses, Graph, FirstPred, [FirstPred], ResultClauses).

unfold_tte(Clauses, Graph, FirstPred, Visited, ResultClauses) :-
	unfold_once(Clauses, Graph, FirstPred, Visited, NewClauses, true),
	constraints:prune(NewClauses, NNClauses),
	thin:thin(NNClauses, Visited, NNNClauses, ThinnedSomething),
		%pp_print_clauses(NNNClauses),
	(ThinnedSomething = true 
		-> unfold_tte(NNNClauses, Graph, FirstPred, Visited, ResultClauses)
		; ResultClauses = NNNClauses
	).
	
%%%% Unfold un seul prédicat et ne garde que ses clauses
unfold_once_one_pred(InClauses, Pred, OutClauses):- % shortcut for predicate pairing 
	graph:call_graph(InClauses, Graph), 
	unfold_once(InClauses, Graph, Pred, [Pred], NewClauses, false), 
	transformation:extract_predicate(NewClauses, Pred, [], OutClauses, _). 

%%%% Unfold un seul prédicat et garde toutes les clauses
unfold_once(InClauses, Pred, OutClauses):-
	graph:call_graph(InClauses, Graph), 
	unfold_once(InClauses, Graph, Pred, [Pred], OutClauses, false).
	
%%%% Unfold au maximum, attention possibilité de boucle infinie
unroll(InClauses, Pred, OutClauses):- 
	graph:call_graph(InClauses, Graph), 
	unfold_once(InClauses, Graph, Pred, [Pred], NewClauses, false),
	constraints:optimize(NewClauses, FinalClauses), % removes contradictory clauses
	transformation:extract_predicate(FinalClauses, Pred, [], PredClauses, _),
	graph:call_graph(FinalClauses, Graph2),
	(contains_cyclic_call(PredClauses, Graph2) -> unroll(FinalClauses, Pred, OutClauses)
					   ; OutClauses = FinalClauses).
			
contains_cyclic_call([cl(_,_,B)|Clauses], Graph):- 
	 take_cyclic_and_arrowed_calls(Graph, B, _, CyclicCalls),
	 CyclicCalls \= []
	 ;
	 contains_cyclic_call(Clauses, Graph). 
	
%%%% Vraie logique	 
unfold_once(InClauses, Graph, Pred, Visited, OutClauses, TakeCyclics):-
	transformation:extract_predicate(InClauses, Pred, [], PredClauses, OtherClauses),
		%format('PredClauses : ~w ~n', [PredClauses]),
		%format('OtherClauses : ~w ~n', [OtherClauses]), 
	unfold_all_clauses(PredClauses, Graph, InClauses, Visited, NewClauses, TakeCyclics),
		%format('NewClauses : ~n'), pp_print_clauses(NewClauses),
	append(NewClauses, OtherClauses, OutClauses),
	!.
	
unfold_all_clauses([], _, _, _, [], _). 
unfold_all_clauses([Cl|PredClauses], Graph, OtherClauses, Visited, OutClauses, TakeCyclics):-
	unfold_all_clauses(PredClauses, Graph, OtherClauses, Visited, OC, TakeCyclics), 
	unfold_clause(Cl, Graph, OtherClauses, Visited, Cls, TakeCyclics),
	append(OC, Cls, OutClauses). 
	
unfold_clause(cl(H,C,B), Graph, OtherClauses, Visited, Cls, TakeCyclics) :- 
	is_unfoldable(cl(H,C,B), Graph, Visited, TakeCyclics),
	!,
	remove_trues(B, B1),
	(TakeCyclics -> take_recursive_calls(H, B1, NB, RecursiveCalls) ; RecursiveCalls = [], NB = B1), % Remove the recursive calls for unfold_each_call
	(TakeCyclics -> take_cyclic_and_arrowed_calls(Graph, NB, NNB, CyclicCalls) ; CyclicCalls = [], NNB = NB),
	(TakeCyclics -> take_visited_calls(Graph, NNB, NNNB, VisitedCalls) ; VisitedCalls = [], NNNB = NB),
	append(CyclicCalls, RecursiveCalls, FirstCalls),
	append(VisitedCalls, FirstCalls, AdditionalCalls),
		%format('AdditionalCalls : ~w ~n NNNB : ~w : ~n', [AdditionalCalls, NNNB]),
  	unfold_each_call(cl(H, C, NNNB), AdditionalCalls, OtherClauses, [], Cls).
unfold_clause(cl(H,C,B), _, _, _, [cl(H, C, B)], _).
	
%%%
% Support predicate for unfold_clause
% Is true iff the given clause is not only making recursive, empty, cyclic or already visited calls
%%%
is_unfoldable(cl(H,_,B), Graph, Visited, TakeCyclics):-
	not_only_trues(B),
	remove_trues(B, B1),
	B1=[_|_],
	(TakeCyclics -> take_recursive_calls(H, B1, B2, _), B2 \= [] ; B2 = B1), 
	(TakeCyclics -> take_visited_calls(Visited, B2, B3, _), B3 \= [] ; B3 = B2),
	(TakeCyclics -> take_cyclic_and_arrowed_calls(Graph, B3, B4, _), B4 \= [] ; true).
	
take_recursive_calls(_, [], [], []).
take_recursive_calls(H, [Call|Calls], NewCalls, RecursiveCalls):-
		%format('H = ~w, Call = ~w, Calls = ~w ~n', [H, Call, Calls]),
	take_recursive_calls(H, Calls, NewCalls1, RecursiveCalls1),
	(unify(H, Call) ->
		(append(RecursiveCalls1, [Call], RecursiveCalls),
		append(NewCalls1, [], NewCalls))
			;
		(append(RecursiveCalls1, [], RecursiveCalls),
		append(NewCalls1, [Call], NewCalls))).
		
take_visited_calls(_, [], [], []). 
take_visited_calls(Visited, [B|Bs], [B|NBs], VCalls):-
	B =..[Pred|_], 
	not(member(Pred, Visited)),
	!,
	take_visited_calls(Visited, Bs, NBs, VCalls).
take_visited_calls(Visited, [B|Bs], NBs, [B|VCalls]):-
	take_visited_calls(Visited, Bs, NBs, VCalls). 

take_cyclic_and_arrowed_calls(_, [], [], []). 
take_cyclic_and_arrowed_calls(Graph, [Call|Calls], NNB, [Call|CyclicCalls]):-
	 graph:graph_cycle(Graph, Call),
	 graph:graph_multiple_arrows(Graph, Call),
	 !, 
	 take_cyclic_and_arrowed_calls(Graph, Calls, NNB, CyclicCalls). 
take_cyclic_and_arrowed_calls(Graph, [Call|Calls], [Call|NNB], CyclicCalls):-
	take_cyclic_and_arrowed_calls(Graph, Calls, NNB, CyclicCalls). 
  
%%%%% 
% Real unfolding 
%%%%%
unfold_each_call(cl(H,C,[]), RecursiveCalls, _, TempCls, FinalCls):-
		%format('~n RecursiveCalls : ~w ~n', [RecursiveCalls]),
	combine(TempCls, CombinedCls),
		format(' Combined calls : ~w ~n', [CombinedCls]),
	rewrap_clauses(CombinedCls, H, C, RecursiveCalls, FinalCls),
		format('RewrappedClauses : ~w ~n', [FinalCls]),
	true.
unfold_each_call(cl(H,C,[B|Bs]), RecursiveCalls, OtherClauses, TempCls, NewCls):-
	unfold_call(B, OtherClauses, [], UnfoldedClauses),
	append([UnfoldedClauses], TempCls, NewTempCls),
	unfold_each_call(cl(H,C,Bs), RecursiveCalls, OtherClauses, NewTempCls, NewCls).

combine([], []). 
combine([NewLists|[]], NewLists).
combine([A, B|Xs], FinalLists):-
		%format('A = ~w , B = ~w ~n', [A,B]), 
	appendall_all(A, B, A, [], NewList), 
		%format('NewLists : ~w ~n', [NewList]),
	combine([NewList|Xs], FinalLists). 
	
appendall_all([], [], _, Current, Current). 
appendall_all([A|_], [], _, Current, Current):-
	is_list(A). 
appendall_all([A|As], [B|Bs], _, Current, Final):- 
	is_list(A), 
	!,
	% list
	appendall([B], [A|As], NewB), 
		%format('NewB : ~w ~n', [NewB]), 
	append(NewB, Current, NewCurrent), 
	appendall_all([A|As], Bs, _, NewCurrent, Final). 

appendall_all([], [_|Bs], ABase, Current, Final):-
	appendall_all(ABase, Bs, ABase, Current, Final).
appendall_all([A|As], [B|Bs], ABase, Current, Final) :- 
	append([[A,B]], Current, NewCurrent), 
		%format('A = ~w, B = ~w ~n', [A, B]),
		%format('NewCurrent:  ~w ~n', [NewCurrent]),
	(both_empty(As, Bs) -> appendall_all(As, Bs, ABase, NewCurrent, Final) 
			    ; appendall_all(As, [B|Bs], ABase, NewCurrent, Final)).

rewrap_clauses([(NC,NB)|Others], H, C, RecursiveCalls, Rest):-
	rewrap_clauses([[(NC,NB)]], H, C, RecursiveCalls, Rest1),
	rewrap_clauses(Others, H,C,RecursiveCalls,Rest2),
	append(Rest1, Rest2, Rest).
rewrap_clauses([], _, _, _, []).	
rewrap_clauses([Sublist|Cls], H, C, RecursiveCalls, Rest):-	
	allFirst(Sublist, NC), 
		%format('AllFirst : ~w ~n', [NC]),
	constraints:contradictory_constraints(NC), 
	!,
	rewrap_clauses(Cls, H, C, RecursiveCalls, Rest).
rewrap_clauses([Sublist|Cls], H, C, RecursiveCalls, [cl(H, NNC, NNB)|Rest]):-	
	allFirst(Sublist, NC), 
	allSecond(Sublist, NB),
		%format('AllSecond: ~w ~n', [NB]),
	append(NB, RecursiveCalls, NNB), 
	append(C, NC, NNC), 
	rewrap_clauses(Cls, H, C, RecursiveCalls, Rest). 

unfold_call(_, [], TClauses, TClauses). 
unfold_call(B, OtherClauses, TempClauses, UnfoldedClauses):- 
	B =..[Pred|Args],
	length(Args, LB),
	select(cl(H2, C2, B2), OtherClauses, NOClauses), 
	H2 =..[Pred|Args2],
	length(Args2, LB),
	!,
	fresh_rename(cl(H2,C2,B2),cl(RCH,RCC,RCB)),
	RCH=..[_|RArgs],
	args_to_constraints(RArgs,Args,NC),
	append(RCC, NC, NNC),
	append([(NNC,RCB)], TempClauses, NTempClauses),
	unfold_call(B, NOClauses, NTempClauses, UnfoldedClauses).
unfold_call(_, _, TClauses, TClauses). 

%%%
% Creates constraints of type "=" (third argument), based on the corresponding values of two lists (two first arguments, which should be of the same size)
%%%
args_to_constraints([],[],[]).
args_to_constraints([A1|As1],[A2|As2],[=(A1,A2)|Rs]):-
  args_to_constraints(As1,As2,Rs).