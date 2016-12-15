%% Affichage de clauses / de sliceparts

:- module(pprint,[pp_print_clauses/1, pp_print_slice_parts/2]).

:-use_module(utils). 

pp_print_slice_parts([], []). 
pp_print_slice_parts([Vars|VarsList], [Clauses|ClausesList]):-
	format('------- Slice part ------- ~n'),
	format('~w ~n', [Vars]), 
	pp_print_clauses(Clauses), 
	pp_print_slice_parts(VarsList, ClausesList). 

pp_print_clauses(Clauses):-
	maplist(print_clause, Clauses). 
	
print_clause(cl(H, C, B)):- 
	pp_print_atom(0, H), 
	format(":-~n"),
	pp_print_constraints(5,C),
	format("~n"),
	pp_print_body(5,B),
	format("~n").

pp_print_atom(Ind,A):-
	print_indent(Ind),
	format("~w",[A]).

pp_print_constraints(Ind,Cs):-
	print_indent(Ind),
	format("{ "),
	print_list(Cs),
	format("},").

print_list([]).
print_list([T]):- !, format("~w",[T]).
print_list([T|Ts]):-format("~w, ",[T]), print_list(Ts).

pp_print_body(Ind,[]):- print_indent(Ind), format("true.~n").
pp_print_body(Ind,[B]):- !, print_indent(Ind), format("~w.~n",[B]).
pp_print_body(Ind,[B|Bs]):- print_indent(Ind), print_list([B|Bs]), format(".~n").

print_indent(0):-!.
print_indent(N):- 
	N > 0,
	NN is N - 1,
	write(' '),
	print_indent(NN).