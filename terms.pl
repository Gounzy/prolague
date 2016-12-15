%%% Gestion des termes
%% - création d'un nouveau nom de prédicat
%% - transformation des clauses pour changer les '$VAR'(I) en _G3207 (sert pour l'utilisation de clpfd car avec $VAR ça passe pas)
%% - opérations de remplacement, renommage frais, etc., des '$VAR'(I)

:-module(terms,[fresh_rename/2, fresh_rename/3, get_vars/2,construct_final_renaming/2,replace/3,
	same_calls/3, same_calls_strict/2, new_pred_name/3, new_pred_name/2]).

:-use_module(utils). 

:-dynamic var_counter/1.
:-dynamic pred_counter/1.

%%%%
init:-
	retractall(var_counter(_)),
	assert(var_counter(100)), % Do not touch
	retractall(pred_counter(_)),
	assert(pred_counter(1)).
	
%%%%
new_pred_name(IDString, N, NewPredName):-
	number_string(N, NString),
	string_concat(IDString, NString, NameString), 
	atom_string(NewPredName, NameString).
new_pred_name(IDString, NewPredName) :-
	pred_counter(X), 
	number_string(X, XString), 
	string_concat(IDString, XString, NameString), 
	atom_string(NewPredName, NameString), 
	retract(pred_counter(X)), 
	X1 is X + 1,
	assert(pred_counter(X1)).

%%%
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

same_calls([], [], []).
same_calls([Call|Calls2], Calls1, [B|NBs]):- % todo à un renommage près !
	select(B, Calls1, NCalls1), 
	unify(B, Call), 
	same_calls(Calls2, NCalls1, NBs). 
	
same_calls_strict([], []). 
same_calls_strict(Calls1, Calls2):-
	select(B, Calls1, NCalls1), 
	select(B, Calls2, NCalls2), 
	same_calls_strict(NCalls1, NCalls2).

%%%
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
