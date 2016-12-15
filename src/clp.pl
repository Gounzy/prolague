%%% Comprend des transformations typiques à l'utilisation du CLP technique en Prolog : 
%%% Merging (fusion des contraintes de clauses ayant même tête & même corps), 
%%% Transformation en CLP(fd) pour utilisation de cette librairie dans d'autres modules

:-module(clp, []). 

:-use_module(library(clpfd)).

:-use_module(utils). 
:-use_module(terms).

%%%
% Merge & CLP transformations
%%%

%%%
merge(Clauses, MergedClauses):-
	and_clauses(Clauses, NewClauses),
	merge_clauses(NewClauses, [], MergedClauses). 

and_clauses([], []). 
and_clauses([cl(H,C,B)|Clauses], [cl(H, [NC], B)|NClauses]):-
	and_constraints(C, NC), 
	and_clauses(Clauses, NClauses).

and_constraints([], true).
and_constraints([C], C). 
and_constraints([C|[D]], /\(C, D)).
and_constraints([C|Cs], /\(C, AndCs)):-
	and_constraints(Cs, AndCs). 
	
merge_clauses([], C, C).
merge_clauses([cl(H, C, B)|Clauses], NewClausesTemp, NewClauses):-
	 select(cl(H, NC, NB), Clauses, Clauses1),
	 remove_trues_and_empties(B, B1), 
	 remove_trues_and_empties(NB, B2),
	 same_calls_strict(B1, B2), 
	 !,
	 merge_constraints(C, NC, NNC), 
	 append([cl(H, NNC, NB)], Clauses1, Clauses2),
	 merge_clauses(Clauses2, NewClausesTemp, NewClauses). 
merge_clauses([X|Clauses], NewClausesTemp, NewClauses):-
	merge_clauses(Clauses, [X|NewClausesTemp], NewClauses). 
	
merge_constraints(C1, C2, NNC):- 
	list_to_tuple(C1, NC1),
	list_to_tuple(C2, NC2),
	NNC = [\/(NC1, NC2)]. 
	
%%%

to_clpfd([], []). 
to_clpfd([cl(H,C,B)|Clauses], [cl(H, NC, B)|NewClauses]):- 
	prolog_to_clp(C, NC),
	!,
	to_clpfd(Clauses, NewClauses). 
	 
prolog_to_clp([A|As], [X|Xs]) :- !, prolog_to_clp(A, X), prolog_to_clp(As, Xs).
prolog_to_clp([], []):-!.
prolog_to_clp([A], X):- !, prolog_to_clp(A, X).
prolog_to_clp(=(A,B), =(A,B)):- (is_list(A) ; is_list(B)), !. 
prolog_to_clp(=(A,[B|Bs]), =(A,[B|Bs])):-!. 
prolog_to_clp(=([A|As],B), =([A|As],B)):-!.  
prolog_to_clp(unify(A,B), =(X1,X2)):-!, prolog_to_clp(A,X1), prolog_to_clp(B, X2). 
prolog_to_clp(/\(A,B), #/\(X1, X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2).
prolog_to_clp(\/(A,B), #\/(X1, X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2).
prolog_to_clp(=(A,B), #=(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(\=(A,B), #\=(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(>(A,B), #>(X1,X2)) :- !,prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(<(A,B), #<(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(>=(A,B), #>=(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(=<(A,B), #=<(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(A, A). 