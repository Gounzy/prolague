%%% Renommage : 
%% - normal = renommer en utilisant des noms de variables qui n'ont pas encore été utilisées depuis le dernier appel à terms:init
%% - avec reset = renommer en appelant terms:init avant de renommer chaque clause pour avoir des noms de variables pas trop horribles (X13, etc.). 
%% - renommer un seul prédicat (avec un nouveau nom de prédicat donné) 
%% - renommer tous les prédicats sauf 1 (typiquement p_start) (avec des nouveaux noms de prédicats autogénérés)
%% - renommer tous les prédicats (avec des nouveaux noms de prédicats autogénérés)
%% - flatten = renommage en faisant en sorte que chaque argument (d'une tête/d'un appel) ait un nom unique, quitte à rajouter des contraintes A = B pour garder le mapping

:- module(rename, []). 

:-use_module(utils). 
:-use_module(terms).

%%%%
rename([], []).
rename([cl(H, C, B)|Clauses1], [cl(NH,NC,NB)|Clauses2]):- 
	terms:fresh_rename(cl(H,C,B),cl(NH,NC,NB)), 
	rename(Clauses1, Clauses2).
	
%%%%

rename_reset([], []).
rename_reset([cl(H,C,B)|Clauses1], [cl(NH, NC, NB)|Clauses2]):- 
	terms:init, % TODO improve
	terms:fresh_rename(cl(H,C,B),cl(NH,NC,NB)), 
	rename_reset(Clauses1, Clauses2).
	
%%%%

rename_one_pred([], _, _, []). 
rename_one_pred([cl(H,C,B)|Clauses], PredName, NewPredName, [cl(NH, C, NB)|NewClauses]):- 
	rop([H], PredName, NewPredName, [NH]), 
	rop(B, PredName, NewPredName, NB),
	rename_one_pred(Clauses, PredName, NewPredName, NewClauses). 

rop([], _, _, []). 
rop([Call|Calls], PredName, NewPredName, [NewCall|NewCalls]) :-
	Call =..[PredName|Args], 
	!,
	NewCall =..[NewPredName|Args], 
	rop(Calls, PredName, NewPredName, NewCalls).
rop([Call|Calls], PN, NPN, [Call|NewCalls]):-
	rop(Calls, PN, NPN, NewCalls). 

%%%%

rename_preds_except(Clauses, Name, Except/Arity, NewClauses):- 
	rename_preds(Clauses, Name, 1, [(Except/Arity, Except)], NewClauses). 
	
%%%%

rename_preds(Clauses, Name, NewClauses):-
	rename_preds(Clauses, Name, 1, [], NewClauses).
	
rename_preds([], _, _, _, []). 
rename_preds([cl(H,C,B)|Clauses], Name, N, Mapping, [cl(NH, C, NB)|NewClauses]):- 
	rp([H], Name, N, N1, Mapping, NewMapping, [NH]), 
	remove_trues_and_empties(B, CleanB),
	rp(CleanB, Name, N1, N2, NewMapping, FinalMapping, NB),
	rename_preds(Clauses, Name, N2, FinalMapping, NewClauses). 
	
rp([], _, N, N, Mapping, Mapping, []).
rp([P|Ps], Name, N, N1, Mapping, NewMapping, [NP|NPs]):-
	P =..[Pred|Args],
	length(Args, L), 
	member((Pred/L, X), Mapping), 
	!,
	NP =..[X|Args], 
	rp(Ps, Name, N, N1, Mapping, NewMapping, NPs). 
rp([P|Ps], Name, N, N1, Mapping, NewMapping, [NP|NPs]):- % if Pred not member yet
	P =..[Pred|Args], 
	length(Args, L),
	new_pred_name(Name, N, X), 
	NewN is N + 1,
	NP =..[X|Args],
	rp(Ps, Name, NewN, N1, [(Pred/L, X)|Mapping], NewMapping, NPs). 
	
%%%%

flatten([], []). 
flatten([Cl|Clauses], [NCl|NewClauses]) :-
	flatten_clause(Cl, NCl),
	flatten(Clauses, NewClauses). 
	
flatten_clause(cl(H, C, B), cl(NH, NC, NB)):-
	flatten_head(H, [], Mapping, 0, AC, NH, J), 
		%print(flatten_body(B, J, Mapping, NMapping, AC, NAC, NB, K)),
	flatten_body(B, J, Mapping, NMapping, AC, NAC, NB, K), 
		%print(flatten_constraints(C, [], K, NMapping, NAC, _, NC)),
	flatten_constraints(C, [], K, NMapping, NAC, _, NC).

flatten_body([], I, M, M, C, C, [], I). 
flatten_body([Call|Calls], J, Mapping, FinalMapping, AdditionalConstraints, FinalAdditionalConstraints, [NCall|NCalls], K):-
	flatten_head2(Call, Mapping, NMapping, J, AC, NCall, J1), 
	append(AC, AdditionalConstraints, NAdditionalConstraints),
	flatten_body(Calls, J1, NMapping, FinalMapping, NAdditionalConstraints, FinalAdditionalConstraints, NCalls, K). 

flatten_head2(H, CurrentMapping, NMapping, I, AdditionalConstraints, NH, J):-
	H =..[Pred|Args], 
		%print(flatten_args2(Args, I, I, CurrentMapping, NMapping, AdditionalConstraints, NArgs, J)),
	flatten_args2(Args, I, I, CurrentMapping, NMapping, AdditionalConstraints, NArgs, J), 
	NH =..[Pred|NArgs]. 
	
flatten_args2([], _, I, CM, CM, [], [], I). 
flatten_args2([Arg|Args], IBASE, I, CurrentMapping, FinalMapping, AdditionalConstraints, [NArg|NArgs], NewI):-
	(member((Arg, X), CurrentMapping) -> NArg = X, J is I, NewCurrentMapping = CurrentMapping 
						; NArg = '$VAR'(I), J is I + 1, append([(Arg, '$VAR'(I))], CurrentMapping, NewCurrentMapping)),
		%print(flatten_args2(Args, IBASE, J, NewCurrentMapping, FinalMapping, AdditionalConstraints, NArgs, NewI)),
	flatten_args2(Args, IBASE, J, NewCurrentMapping, FinalMapping, AdditionalConstraints, NArgs, NewI).


flatten_head(H, CurrentMapping, NMapping, I, AdditionalConstraints, NH, J):-
	H =..[Pred|Args], 
		%print(flatten_args(Args, I, CurrentMapping, NMapping, AdditionalConstraints, NArgs, J)),
	flatten_args(Args, I, I, CurrentMapping, NMapping, AdditionalConstraints, NArgs, J), 
	NH =..[Pred|NArgs]. 
	
flatten_args([], _, I, CM, CM, [], [], I). 
flatten_args([Arg|Args], IBASE, I, CurrentMapping, FinalMapping, AdditionalConstraints, ['$VAR'(I)|NArgs], NewI):-
	not(member(Arg, Args)),
	append([(Arg, '$VAR'(I))], CurrentMapping, NewCurrentMapping),
	J is I + 1,
		%print(flatten_args(Args, J, NewCurrentMapping, FinalMapping, AdditionalConstraints, NArgs, NewI)),
	flatten_args(Args, IBASE, J, NewCurrentMapping, FinalMapping, AdditionalConstraints, NArgs, NewI)
	; 
	
	J is I + 1, 
	member_pos(Arg, Args, J, Pos), 
	append([(Arg, '$VAR'(I))], CurrentMapping, NewCurrentMapping),
	N is IBASE + Pos,
	AdditionalConstraints = [=('$VAR'(I), '$VAR'(N))|OtherConstraints],
		%print(flatten_args(Args, IBASE, J, NewCurrentMapping, FinalMapping, OtherConstraints, NArgs, NewI)),
	flatten_args(Args, IBASE, J, NewCurrentMapping, FinalMapping, OtherConstraints, NArgs, NewI). 
	
% Shortcut
% Useful when the additional constraints don't matter
flatten_args(Args, NArgs):-
	flatten_args(Args, 0, 0, [], _, _, NArgs, _). 
	
flatten_constraints([], CurrentConstraints, _, M, AdditionalConstraints, M, FinalConstraints) :- 
 	append(AdditionalConstraints, CurrentConstraints, FinalConstraints). 
flatten_constraints([C|Cs], CurrentConstraints, I, Mapping, AdditionalConstraints, NewMapping, FinalConstraints):-
	get_vars(C, VarList), 
	update_mapping(VarList, Mapping, I, NMapping, J),
	terms:replace(c(C), NMapping, c(NC)),
	append([NC], CurrentConstraints, NewCurrentConstraints), 
	flatten_constraints(Cs, NewCurrentConstraints, J, NMapping, AdditionalConstraints, NewMapping, FinalConstraints). 

update_mapping([], Mapping, I, Mapping, I). 
update_mapping([Var|Vars], Mapping, I, NewMapping, J):- 
	member((Var, _), Mapping), 
	!, 
	update_mapping(Vars, Mapping, I, NewMapping, J). 
update_mapping([Var|Vars], Mapping, I, NewMapping, Z):-
	J is I + 1,
	update_mapping(Vars, [(Var,'$VAR'(I))|Mapping], J, NewMapping, Z). 
	