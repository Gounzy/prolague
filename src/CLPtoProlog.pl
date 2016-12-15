%% Fichier standalone
%% Permet la conversion d'un programme CLP en Prolog exécutable, via des asserts

:-use_module(library(clpfd)).

convert(Faichier,WD):- 
	prepare(Faichier,WD,X), 
	gerome(X, Y),
	assert_clauses(Y),
	format('File asserted, you can now make requests to the initial constraint logic program.'). 

prepare(File,WD,Clauses):-
	working_directory(_, WD),
	init_terms,
	load_file(File, Clauses).

assert_clauses(Clauses):-
	maplist(assert_clause, Clauses). 
	
assert_clause(cl(H,C,B)):-
	list_to_tuple(C, NC), 
	list_to_tuple(B, NB),
	assert(:-(H, (NC, NB))). 
	
% J'ai pas pu me servir de celui de utils() qui foire dans ce cas
list_to_tuple([[]], true).
list_to_tuple([], true). 
list_to_tuple([C|Cs], NC):-
	list_to_tuple(Cs, NCs), 
	NC = (C, NCs).

gerome(Clauses, NewClauses):-
	rename_reset(Clauses, Clauses1),
	to_clpfd(Clauses1, Clauses2), 
	functor(Array, f, 1000), 
	to_real_vars(Clauses2, Array, NewClauses).

rename_reset([], []).
rename_reset([cl(H,C,B)|Clauses1], [cl(NH, NC, NB)|Clauses2]):- 
	init_terms,
	fresh_rename(cl(H,C,B),cl(NH,NC,NB)), 
	rename_reset(Clauses1, Clauses2).
	
init_terms:-
	retractall(var_counter(_)),
	assert(var_counter(1)). % Do not touch	

to_clpfd([], []). 
to_clpfd([cl(H,C,B)|Clauses], [cl(H, NC, B)|NewClauses]):- 
	prolog_to_clp(C, NC),
	!,
	to_clpfd(Clauses, NewClauses). 
	 
prolog_to_clp([A|As], [X|Xs]) :- !, prolog_to_clp(A, X), prolog_to_clp(As, Xs).
prolog_to_clp([], []):-!. 
prolog_to_clp(unify(A,B), =(X1,X2)):-!, prolog_to_clp(A,X1), prolog_to_clp(B, X2). 
prolog_to_clp(/\(A,B), #/\(X1, X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2).
prolog_to_clp(\/(A,B), #\/(X1, X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2).
prolog_to_clp(=(A,B), =(A,B)):- (is_list(A) ; is_list(B)), !. 
prolog_to_clp(=(A,[B|Bs]), =(A,[B|Bs])):-!. 
prolog_to_clp(=([A|As],B), =([A|As],B)):-!. 
prolog_to_clp(=(A,B), #=(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(\=(A,B), #\=(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(>(A,B), #>(X1,X2)) :- !,prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(<(A,B), #<(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(>=(A,B), #>=(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp(=<(A,B), #=<(X1,X2)) :- !, prolog_to_clp(A, X1), prolog_to_clp(B, X2). 
prolog_to_clp([A], X):- !, prolog_to_clp(A, X).
prolog_to_clp(A, A). 

to_real_vars([], _, []). 
to_real_vars([cl(H,C,B)|Clauses], Array, [cl(NH, NC, NB)|NewClauses]):- 
	trv([H], Array, [NH]),
		%format('NH : ~w ~n', [NH]),
	constraints_to_real_vars(C, NC, Array),
		%format('NC : ~w ~n', [NC]),
	remove_trues_and_empties(B, B2),
	trv(B2, Array, NB),
		%format('NB : ~w ~n', [NB]),
	to_real_vars(Clauses, Array, NewClauses).
	
trv([], _, []). 
trv([Call|Calls], Array, [NewCall|NewCalls]):-
	Call =..[Pred|Args], 
	args_to_real_vars(Args, Array, NArgs), 
	NewCall =..[Pred|NArgs],
	trv(Calls, Array, NewCalls). 

args_to_real_vars([], _, []). 
args_to_real_vars(['$VAR'(I)|Vars], Array, [X|NVars]):-
	!, 
	J is I + 1,
	arg(J, Array, X), 
	args_to_real_vars(Vars, Array, NVars). 
args_to_real_vars([Var|Vars], Array, [X|NVars]):-
	trv([Var], Array, [X]), 
	args_to_real_vars(Vars, Array, NVars).
	
constraints_to_real_vars('$VAR'(I), B, Array):-
	!,
	J is I + 1,
	arg(J, Array, B).
constraints_to_real_vars(C, D, Array):-
		%format('C =  ~w ~n', [C]),
	C =..[Func, Arg1, Arg2], % Only binary opérations
	!,
	constraints_to_real_vars(Arg1, NArg1, Array),
	constraints_to_real_vars(Arg2, NArg2,  Array),
	functor(D, Func, 2), 
	arg(1, D, NArg1),
	arg(2, D, NArg2). 
constraints_to_real_vars(C, C, _). 

remove_trues_and_empties([], []).
remove_trues_and_empties([[]|Ls], NLs):- !, remove_trues_and_empties(Ls, NLs). 
remove_trues_and_empties([true|Ls], NLs):- !, remove_trues_and_empties(Ls, NLs). 
remove_trues_and_empties([L|Ls], [L|NLs]):- remove_trues_and_empties(Ls, NLs).  

%%% TERMS

%%%
% Useful predicate
% True iff Call and Head actually unify
%%%
unify(Call, Head):-
	Call=..[Pred|Args],
	Head=..[Pred|Args2],
	length(Args, Arity),
	length(Args2, Arity).

replace('$VAR'(N1),Ren,T0):-
  member(('$VAR'(N1),T0),Ren), 
  !.
replace(Term1,Ren,Term0):-
  Term1 =..[F|Args],
  replace_list(Args,Ren,NArgs),
  Term0 =..[F|NArgs].

replace_list([],_,[]).
replace_list([T|Ts],Ren,[T0|Ts0]):-
  replace(T,Ren,T0),
  replace_list(Ts,Ren,Ts0).

get_vars(Term,VarList):-
  vars(Term,VL),
  sort(VL,VarList). % dups are removed

vars(Term,[Term]):-Term='$VAR'(_),!.
vars(Term,VarList):-
  Term=..[_|Args],
  varss(Args,VarList).
varss([],[]).
varss([T|Ts],VL):-
  vars(T,VL1),
  varss(Ts,VL2),
  append(VL1,VL2,VL).

get_var_renaming(VarList,NewVarList):-
  (var_counter(_) -> true ; assert(var_counter(100))),
  retract(var_counter(N)),
  construct_renaming(VarList,N,NewVarList,NN),
  assert(var_counter(NN)).

construct_renaming([],N,[],N).
construct_renaming([V|Vs],N,[(V,NV)|NVs],NN):-
  NV='$VAR'(N),
  N1 is N + 1,
  construct_renaming(Vs,N1,NVs,NN).

fresh_rename(Term1,Term0):-
  get_vars(Term1,VList1),
  get_var_renaming(VList1,Ren),
  replace(Term1,Ren,Term0).
  
% Utilisé pour garder la substitution
fresh_rename(Term1,Term0, Ren):-
  get_vars(Term1,VList1),
  get_var_renaming(VList1,Ren),
  replace(Term1,Ren,Term0).
  
% Renomme toutes les t_clauses
final_rename_all(Level):-
  retract(t_clause(Level,H,C,B,CNum)),
  construct_final_renaming(cl(H,C,B),Ren),
  replace(cl(H,C,B),Ren,cl(NH,NC,NB)),
  assert(t_clause(Level,NH,NC,NB,CNum)),
  fail.
final_rename_all(_).
  
construct_final_renaming(cl(H,C,B),Ren):-
  vars(cl(H,C,B),VarList),
  construct_fr(VarList,0,[],Ren).

construct_fr([],_,Ren,Ren).
construct_fr([V|Vs],N,Ren1,Ren0):-
  ( member((V,_),Ren1)
  ->
  construct_fr(Vs,N,Ren1,Ren0)
  ;
  N1 is N+1,
  construct_fr(Vs,N1,[(V,'$VAR'(N))|Ren1],Ren0)).
	
%%% INPUT
% Charge le fichier F et retient toutes ses clauses 
load_file(F, Clauses) :-
	see(F),
	remember_all(Clauses),
	seen.

remember_all(Clauses) :-
	read(C),
	(
	    C == end_of_file -> Clauses = []
	;
	    remember_clause(C, Cl),
	    Clauses = [Cl | Rest], 
	    remember_all(Rest)
	).

remember_clause((A :- B), Cl) :-
	!,
    tuple2list(B,BL),
    parse_body(BL,CL,AL),
    numbervars(cl(A,CL,AL),0,_),
	Cl = cl(A,CL,AL).
remember_clause(Clause, Cl):- 
	remember_clause((Clause :- ([], [])), Cl). 

parse_body([{}|Bs],[],Bs):- !.
parse_body([{C}|Bs],CL,Bs):- !, tuple2list(C,CL).
parse_body(Bs, [], Bs). 

tuple2list((A,As),[A|LAs]) :-
	!,
	tuple2list(As,LAs).
tuple2list(A,[A]).