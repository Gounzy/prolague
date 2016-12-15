%%% Gestion des graphes
%% - graphe avec constraintes = node(H,Constr,B) qui sert pour la comparaison dans l'algo naïf
%% - graphe d'appels sans contraintes = node(Pred/Arity, Pred2/Arity) qui sert pour détecter des cycles par ex. 

:-module(graph, []). 

:-use_module(library(clpfd)). 

:-use_module(utils). 
:-use_module(transformation).  
:-use_module(terms). 

%%%%%
% Graph construction and handling
%%%%%
call_graph_with_constraints(Clauses, Graph):- 
	call_graph_with_constraints(Clauses, [], Graph). 
	
call_graph_with_constraints([], CG, CG). 
call_graph_with_constraints([cl(H,C,B)|Clauses], CurrentGraph, Graph) :- 
	transformation:canonicalForm(H, Pred/_), 
	extract_predicate(Clauses, Pred, [], PredClauses, OtherClauses), 
	getCallsWithConstraints([cl(H,C,B)|PredClauses], Calls),
	append(Calls, CurrentGraph, NGraph),
	call_graph_with_constraints(OtherClauses, NGraph, Graph).

getCallsWithConstraints([], []). 
getCallsWithConstraints([cl(H,C,B)|Clauses], [node(H, C, Pred)|Nodes]):- % one-call body
	remove_trues_and_empties(B, NB), 
	NB =[B1], 
	!,
	B1 =..[Pred|_],
	getCallsWithConstraints(Clauses, Nodes). 
getCallsWithConstraints([cl(H,C,B)|Clauses], [node(H,C,null)|Nodes]):- % no-call body
	remove_trues_and_empties(B, NB), 
	NB = [], 
	getCallsWithConstraints(Clauses,Nodes). 
	
cgwc_node(_, null, null). 
cgwc_node(Graph, Pred, node(H,C,B)):- 
	member(node(H, C, B), Graph), 
	H =..[Pred|_]. 
	
% Only simple cycles
cgwc_cycle(Graph, Pred):- 
	member(node(H,_,B), Graph), 
	H =..[Pred|_], 
	B =..[Pred|_]. 

call_graph(Clauses, Graph) :- 
	call_graph(Clauses, [], Graph). 

call_graph([], CG, CG). 
call_graph([cl(H, _, B)|Clauses], CurrentGraph, Graph) :-
	 transformation:canonicalForm(H, Pred/Arity),
	 transformation:getAllCalls(Pred/Arity, B, Calls),
	 append(Calls, CurrentGraph, NewCurrentGraph), 
	 call_graph(Clauses, NewCurrentGraph, Graph). 
	
graph_cycle(Graph, Atom):- 
	transformation:canonicalForm(Atom, Pred/Arity), 
	cycle(Graph, Pred/Arity).
	
cycle(Graph, P1):-
	select((P1, X), Graph, NGraph), 
	way(NGraph, X, P1). 
	
way(_, P1, P1).
way(Graph, P1, P2):-
	select((P1, X), Graph, NGraph), 
	way(NGraph, X, P2).  

directway(Graph, P1, P2):-
	member((P1, P2), Graph).
	
graph_multiple_arrows(Graph, Atom):-
	transformation:canonicalForm(Atom, Pred/Arity), 
	member((P1/_, Pred/Arity), Graph),
	member((P2/_, Pred/Arity), Graph), 
	not(transformation:same_pred(P1, P2)).

in_graph(Pred/Arity, Graph):-
	member((Pred/Arity, _), Graph)
	;
	member((_, Pred/Arity), Graph).