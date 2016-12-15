%%% Gestion des contraintes : 
%% - Compression = suppression des contraintes inutiles et application des valeurs liées par des "=" (par ex. dans les têtes, p1(A, B):- A = B devient p1(A,A). 
%% - Optimisation = suppression des clauses dont les contraintes sont insatisfaisables. 
%% - Simplification = réécriture des contraintes de façon à avoir la valeur d'un argument de base de la façon la plus claire possible (sans passer par 1000 vars intermédiaires). 

:- module(constraints,[prune/2, optimize/2, compress/2]).

:-use_module(library(clpfd)). 

:-use_module(utils).  
:-use_module(terms).
:-use_module(clp).
:-use_module(compare). 
:-use_module(slice).
:-use_module(rename).

prune(Clauses, NewClauses):- 
	compress(Clauses, NClauses),
	optimize(NClauses, NewClauses).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
compress([], []).
compress([cl(H, C, B)|Clauses], [cl(NNH, NNNC, NNB)|NewClauses]):-
	propagate(C,[],NC),
		%format('Compress : propagated = ~w ~n', [NC]),
	switch(NC,NCS),
		%format('Compress : switched = ~w ~n', [NCS]),
	terms:get_vars(f(H,B),VarList),
	slice:constraint_edge(cl(H,C,B), VarList, NVarList),
  	 	%format("removing unused constraints from clause ~w ~w ~w with varlist ~w ~n",[H,C,B, VarList]),
	remove_unused_constraints(NCS,NVarList,NC2),
		%format('Result : ~w ~n', [NC2]), 
	apply_bindings_from_constraints(NC2,cl(H,NC2,B),cl(NNH,NNC,NNB)),
	remove_superfluous_constraints(NNC,NNNC),
	compress(Clauses, NewClauses).
  
propagate([],Prev,Prev):-!.
propagate([=(X,X)|Cs],Prev,CsC):- !, propagate(Cs,Prev,CsC).
propagate([=('$VAR'(X),'$VAR'(T))|Cs],Prev,CsC):- !, substitute('$VAR'(X),Cs,'$VAR'(T),CsN), substitute('$VAR'(X),Prev,'$VAR'(T),NPrev),propagate(CsN,[=('$VAR'(X),'$VAR'(T))|NPrev],CsC).
propagate([C|Cs],Prev,CsC):- !, propagate(Cs,[C|Prev],CsC).
 
substitute(Term, Term, Term1, Term1):- !.
substitute(_, Term, _, Term):- atomic(Term), !.
substitute(Sub, Term, Sub1, Term1):- !,
	Term=..[F|Args],
	substlist(Sub, Args, Sub1, Args1),
	Term1=..[F|Args1].

substlist(_, [], _, []).
substlist(Sub, [Term|Terms], Sub1, [Term1|Terms1]):-
  substitute(Sub, Term, Sub1, Term1),
  substlist(Sub, Terms, Sub1, Terms1).
 
switch([],[]).
switch([=(X,T)|Cs],[=(T,X)|Scs]):- not(X='$VAR'(_)),T='$VAR'(_),!,switch(Cs,Scs).
switch([C|Cs],[C|Scs]):-switch(Cs,Scs).

remove_unused_constraints(Cs, VarList, Rs):- 
	get_real_varlist(Cs, VarList, NewVarList),
	ruc(Cs, NewVarList, Rs). 
	
get_real_varlist(Cs, VarList, NewVarList):-
	slice:constraint_edge(cl(_,Cs,_), VarList, NewVarList), 
	length(VarList, N1), 
	length(NewVarList, N1),
	!. 
get_real_varlist(Cs, VarList, NewVarList):-
	slice:constraint_edge(cl(_,Cs,_), VarList, NVarList), 
	get_real_varlist(Cs, NVarList, NewVarList),
	!. 

ruc([],_,[]).
ruc([C|Cs],VarList,Rs):-
	no_var_in(C, VarList), 
	!,
  		%format("removing ~w~n",[C]),write_canonical(C),
	ruc(Cs,VarList,Rs).
ruc([C|Cs],VarList,[C|Rs]):-
	ruc(Cs,VarList,Rs).
 
no_var_in(C, VarList):- 
		%format('Trying to ger the variables from a constraint. ~n'),
	get_vars(f(C), CVars), 
		%format('None member : ~w ~w ~n', [CVars, VarList]),
	none_member(CVars, VarList). 
	 
apply_bindings_from_constraints([],Term,Term).
apply_bindings_from_constraints([=(X,T)|Cs],Term,NTerm):- functor(X,'$VAR',_), functor(T,'$VAR',_), !, substitute(X,Term,T,TTerm),
apply_bindings_from_constraints(Cs,TTerm,NTerm).
apply_bindings_from_constraints([=(_,_)|Cs],Term,NTerm):- !, apply_bindings_from_constraints(Cs,Term,NTerm).
apply_bindings_from_constraints([_|Cs],Term,NTerm):- apply_bindings_from_constraints(Cs,Term,NTerm).

remove_superfluous_constraints([],[]).
remove_superfluous_constraints([=(X,X)|Cs],NCs):- !, remove_superfluous_constraints(Cs,NCs).
remove_superfluous_constraints([>=(X,X)|Cs],NCs):- !, remove_superfluous_constraints(Cs,NCs).
remove_superfluous_constraints([=<(X,X)|Cs],NCs):- !, remove_superfluous_constraints(Cs,NCs).
remove_superfluous_constraints([C|Cs], NCs):- member(C, Cs), !, remove_superfluous_constraints(Cs, NCs). 
remove_superfluous_constraints([C|Cs],[C|NCs]):- !, remove_superfluous_constraints(Cs,NCs).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optimize([], []).
optimize([cl(_,C,_)|Clauses], NewClauses):-
	propagate(C, [], NC),
		%format('Propagated NC : ~w ~n', [NC]),
	contradictory_constraints(NC), !,  
	optimize(Clauses, NewClauses).
optimize([cl(H, C, B)|Clauses],[cl(H, C2, B)|NewClauses]):-
  	combine_constraints(C,C1),
  		%format('Combined constraints : ~w ~n', [C1]),
	remove_implied_constraints(C1,C2),
	optimize(Clauses, NewClauses).
	
contradictory_constraints(CList):-
	member(C1, CList), 
	member(C2, CList), 
	are_contradictory(C1, C2). 
contradictory_constraints(CList):-
	rename:flatten_constraints(CList, [], 0, [], [], _, CList1),
	clp:prolog_to_clp(CList1, NC),
		%format('TO CLP : ~w ~n', [NC]),
	terms:get_vars(NC, Vars), 
		%format('Vars : ~w ~n', [Vars]),
	length(Vars, L), 
	functor(Array, f, L), 
	terms:constraints_to_real_vars(NC, NNC, Array),
		%format('TO REAL VARS : ~w ~n', [NNC]),
	Array =..[f|Args],
		%format('Args : ~w ~n', [Args]),
	compare:domain_constraints(Args, DC), 
		%format('DC : ~w ~n', [DC]),
	exec_constraints(DC),
	filter_clp_constraints(NNC, NNNC), 
	not(exec_constraints(NNNC)),
		format('~n CONTRADICTORY CONSTRAINTS FOUND ~n').

are_contradictory(<(A,B),>(A,B)).
are_contradictory(>(A,B),<(A,B)).
are_contradictory(<(A,B),<(B,A)).
are_contradictory(>(A,B),>(B,A)).
are_contradictory(=<(A,B),>(A,B)).
are_contradictory(>=(A,B),<(A,B)).
are_contradictory(>(A,B),=<(A,B)).
are_contradictory(<(A,B),>=(A,B)).
are_contradictory(=(A,[]),=(A,[_|_])). 

exec_constraints([]). 
exec_constraints([C|Cs]):- 
		%format('Executing ~w ~n',[C]),
	C, 
		%format(' Done ~n'),
	exec_constraints(Cs).

filter_clp_constraints([], []). 
filter_clp_constraints([C|Cs], NCs):- 
		%format('filter_clp_constraints : case 1, C = ~w ~n', [C]), 
	C =..[=, _, _],  
	!,
	filter_clp_constraints(Cs, NCs).
filter_clp_constraints([C|Cs], [C|NCs]):-
		format('filter_clp_constraints : case 2 ~n'), 
	filter_clp_constraints(Cs, NCs).

combine_constraints(CList1,CList0):-
	select(C1,CList1,CList2),
	select(C2,CList2,CList3),
	combine(C1,C2,C),!,
	combine_constraints([C|CList3],CList0).
combine_constraints(C,C).

combine(=<(A,B),=<(B,A),=(A,B)).
combine(=<(A,B),>=(A,B),=(A,B)).
combine(>=(A,B),>=(B,A),=(A,B)).
combine(>=(A,B),=<(A,B),=(A,B)).

remove_implied_constraints(CList1,CList0):-
	select(C,CList1,CListR),
	member(C2,CList1),
	member(C3, CList1),
	(is_implied_by(C,C2) ; is_implied_by_both(C, C2, C3)),
	!,
	remove_implied_constraints(CListR,CList0).
remove_implied_constraints(CList,CList).

is_implied_by(=<(A,B),<(A,B)).
is_implied_by(=<(A,B),>(B,A)).
is_implied_by(>=(A,B),>(A,B)).
is_implied_by(>=(A,B),<(B,A)).
is_implied_by(>=(A,B), =<(B,A)).
is_implied_by(=<(A,B), >=(B,A)).
is_implied_by(=(A,B), =(B,A)).

is_implied_by_both(Op1, =(A, B), Op2):-
	Op1 =..[Pred, A, C],
	Op2 =..[Pred, B, C].
is_implied_by_both(Op1, =(A, B), Op2):-
	Op1 =..[Pred, C, A],
	Op2 =..[Pred, C, B].
is_implied_by_both(<(A,B), <(A, C), <(C, B)).
is_implied_by_both(>(A,B), >(A, C), >(C, B)).
is_implied_by_both(=<(A,B), =<(A, C), =<(C, B)).
is_implied_by_both(>=(A,B), >=(A, C), >=(C, B)).


%%%%%%%%%%%%%%%%%%%%%%%%%%
simplify(cl(H,C,B), cl(H,NC,B), ArgumentPos) :- 
	H =..[_|Args], 
	nth1(ArgumentPos, Args, X),
	propagate_for_var(C, X, NC, [], _),
	!.   
	%get_calls_args(B, ArgsB), 
	%append(Args, ArgsB, AllArgs),
	%filter_c(NC, AllArgs, NNC). TODO
	
%filter_c(NC, AllArgs, NNC):- 
	
propagate_for_var([], _, [], CM, CM). 
propagate_for_var(C, X, C, CurrentMapping, CurrentMapping):- 
		%format('propagate_for_var (1): X =  ~w ~n', [X]), 
	member((X, _), CurrentMapping), 
	!. 
propagate_for_var(C, X, [=(X, NRS)|NC1], CurrentMapping, [(X, NRS)|Mapping]):- 
		%format('propagate_for_var (2): X =  ~w ~n', [X]), 
	look_for_equal_constraint(C, X, C1), 
	!,
	get_right_side(X, C1, RS),
		%format('Variable : ~w , Right side : ~w ~n', [X, RS]), 
	get_vars(f(RS), Vars), 
	select(C1, C, NC),
	propagate_for_each_var(NC, Vars, NC1, CurrentMapping, Mapping),
	simplify_with_mapping(RS, Mapping, NRS).
propagate_for_var(C, X, C, CM, [(X,X)|CM]).  
	
look_for_equal_constraint([=(A,B)|_], X, =(A,B)):-
		%format('look_for_equal_constraint (1): C =  ~w ~n', [=(A,B)]), 
	A = X,
	!
	; 
		%format('look_for_equal_constraint (1b): C =  ~w ~n', [=(A,B)]), 
	B = X,
	!. 
look_for_equal_constraint([_|Cs], X, Cons):-
		%format('look_for_equal_constraint (2): C =  ~w ~n', [C]), 
	look_for_equal_constraint(Cs, X, Cons). 
	
get_right_side(X, =(X, Y), Y). 
get_right_side(X, =(Y, X), Y).  
	
propagate_for_each_var(C, [], C, M, M). 
propagate_for_each_var(C, [V|Vs], NC, CurrentMapping, Mapping):- 
	propagate_for_var(C, V, NC1, CurrentMapping, NewMapping), 
	propagate_for_each_var(NC1, Vs, NC, NewMapping, Mapping). 
 
simplify_with_mapping('$VAR'(I), Mapping, RS) :- 
	member(('$VAR'(I), RS), Mapping), !.
simplify_with_mapping('$VAR'(I), _, '$VAR'(I)).
simplify_with_mapping([], _, []). 
simplify_with_mapping([X1|Xs], Mapping, [NX1|NRS]):-
	simplify_with_mapping(X1, Mapping, NX1), 
	simplify_with_mapping(Xs, Mapping, NRS). 
simplify_with_mapping(Expr, Mapping, NRS):- 
	Expr =..[Pred|Args], 
	simplify_with_mapping(Args, Mapping, NArgs), 
	NRS =..[Pred|NArgs]. 