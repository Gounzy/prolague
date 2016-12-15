:-module(main,[]).

:-use_module(utils). 
:-use_module(input). 
:-use_module(constraints).
:-use_module(terms). 
:-use_module(pprint). 
:-use_module(unfold). 
:-use_module(slice).  
:-use_module(thin).
:-use_module(transformation).
:-use_module(clp).
:-use_module(rename). 
:-use_module(fold). 
:-use_module(pair). 
:-use_module(compare). 
  
prepare(File, NewClauses):-
	working_directory(_, 'C:/Program Files/eclipse/workspace/Prolague/src/tests/'),
	terms:init,
	input:load_file(File, Clauses),
	format('Loading file done ! ~n'), 
	catch(get_arity(p_start, Clauses, Arity), _, (write('No predicate with name p_start found...'), nl, abort)), 
	!,
	file_to_name(File, Name),
	rename:rename_preds_except(Clauses, Name, p_start/Arity, NewClauses).

file_to_name(File, Name) :-
	atom_string(File, X), split_string(X, ".", "", [Name1|_]),
	string_concat(Name1, "_", Name).


testelolists:- 
	elodie_1('listfibo.clp', mdr), 
	elodie_1('listfibo2.clp', mdr2). 
testlists:-
	prepare('max_list_acc.clp', Clauses),
	chain([unfold_once(p_start), unfold_once(p_start), prune(p_start)], Clauses, NClauses), 
	
	prepare('max_list_rec.clp', Clauses2),
	chain([unfold_once(p_start), unfold_once(p_start), unfold_once(p_start), prune(p_start)], Clauses2, NClauses2),
	
	format('~n --------------- ~n SUM 1 :~n'),
	pp_print_clauses(NClauses), 
	
	format('~n --------------- ~n SUM 2 :~n'),
	pp_print_clauses(NClauses2). 

% Test de la recherche de boucles qui calculent la même chose
testloop:-
	prepare('loop1.clp', Clauses0), 
	rename:rename_one_pred(Clauses0, p_start, p_start1, RClauses0), 
	prepare('loop2.clp', Clauses1),
	rename:rename_one_pred(Clauses1, p_start, p_start2, RClauses1), 
	pair:search_equal_loops(RClauses0, RClauses1, NClauses0), 
		pp_print_clauses(NClauses0). 

% Test de l'algorithme
testalgo:- 
	prepare('test4.clp', Prog1),
	prepare('test5.clp', Prog2),
	rename:rename_one_pred(Prog1, p_start, p_start1, RProg1), 
	rename:rename_one_pred(Prog2, p_start, p_start2, RProg2), 
	%chain([unfold(p_start1), slice(p_start1), prune(p_start1)], RProg1, NProg1), 
	%chain([unfold(p_start2), slice(p_start2), prune(p_start2)], RProg2, NProg2),
	%transformation:are_similar(NProg1, NProg2, p_start1, p_start2). 
	transformation:launchAlgo(RProg1/p_start1, RProg2/p_start2, [loops, unfold]).

% Test du pairing + comparaison 
testpair:-
	format('First file to test :'), 
	nl, read(File1),  
	prepare(File1, Clauses4), 
	chain([prune(p_start), flatten, unfold(p_start)], Clauses4, NClauses4),
	
	format('Second file to test :'), 
	nl, read(File2),  
	prepare(File2, Clauses5),
	
	pp_print_clauses(Clauses5),
	
	chain([prune(p_start), flatten, unfold(p_start)], Clauses5, NClauses5),
	
	pair:launching_clause(NClauses4, NClauses5, LaunchingCl, RClauses4, RClauses5), 
	pair:pair(RClauses4, RClauses5, true, AllClauses, LaunchingCl),
	format(' - PAIRING DONE - ~n LaunchingClause : ~w ~n', [LaunchingCl]), 
	pp_print_clauses(AllClauses), 
	sort(AllClauses, AllClauses1),
	%chain([unfold(mdr)], AllClauses0, AllClauses1),
	(compare:compare_progs(AllClauses1, LaunchingCl, false, _) -> format('CE SONT LES MÊMES') ; format('RATÉ !!!!!!')).
	
testelodie:-
	elodie_1('mergesort.clp', mergesort4),
 	elodie_1('mergesort3.clp', mergesort3),
 	elodie_1('mergesort5.clp', mergesort5),
 	
 	elodie_1('bubblesort.clp', bubblesort4),
 	elodie_1('bubblesort3.clp', bubblesort3),
 	elodie_1('bubblesort2.clp', bubblesort2),
 	elodie_1('bubblesort5.clp', bubblesort5),
 	
 	elodie_1('facto.clp', facto1), 
 	elodie_1('facto2.clp', facto2),
 	elodie_1('facto3.clp', facto3). 
 	
elodie_1(File, Name):-
	prepare(File, Clauses1), 
	rename:rename_one_pred(Clauses1, p_start, Name, Clauses),
	functor(Array, f, 100), % should be N
	chain([clp, vars(Array)], Clauses, NClauses), 
	compare:assert_clauses(NClauses).

testflatten:-
	prepare('test4.clp', Clauses), 
	chain([flatten], Clauses, _). 

testclp:-
	prepare('test4.clp', Clauses), 
	chain([clp], Clauses, _). 

testsort:-
	prepare('bubble_general.clp', Clauses),
	chain([unfold(p_start), prune(p_start), unfold_once(p_start), optimize, unfold_once(p_start), optimize], Clauses, NewClauses),
	
	prepare('merge_general.clp', Clauses2),
	chain([unfold(p_start), prune(p_start), unfold_once(p_start), optimize, unfold_once(p_start), optimize], Clauses2, NewClauses2),
	
	format('~n --------------- ~n BUBBLESORT :~n'),
	pp_print_clauses(NewClauses), 
	
	format('~n --------------- ~n MERGESORT :~n'),
	pp_print_clauses(NewClauses2).

testunfold:-
	prepare('liste-somme.clp', Clauses), 
	chain([unfold_once(p_start), unfold_once(p_start), unfold_once(p_start), unfold_once(p_start), unfold_once(p_start), unfold_once(p_start), prune(p_start)], Clauses, _). 

testfacto:-
	prepare('facto.clp', Clauses2),
	chain([unfold(p_start), unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, prune(p_start), flatten], Clauses2, [Cl1, _]),
	
	prepare('facto2.clp', Clauses3),
	chain([unfold(p_start), unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, prune(p_start), flatten], Clauses3, [_, Cl1b]),
	
	prepare('facto3.clp', Clauses4),
	chain([unfold(p_start), unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, unfold_once(p_start), optimize, prune(p_start), flatten], Clauses4, [Cl1c, _]),
	
	format('~n --------------- ~n FACTO VERSION 1 :~n'),
	pp_print_clauses([Cl1]),
	constraints:simplify(Cl1, Mdr, 1), 
	pp_print_clauses([Mdr]),
	
	format('~n --------------- ~n FACTO VERSION 2 :~n'),
	pp_print_clauses([Cl1b]),
	constraints:simplify(Cl1b, Mdrb, 1), 
	pp_print_clauses([Mdrb]),
	
	format('~n --------------- ~n FACTO VERSION 3 :~n'),
	pp_print_clauses([Cl1c]),
	constraints:simplify(Cl1c, Mdrc, 1), 
	pp_print_clauses([Mdrc]).
	 
% Déroulage de boucle (ATTENTION il faut un incrément fini sinon boucle infinie !!!)
testunroll:-
	prepare('loop1.clp', Clauses), 
	unfold:unroll(Clauses, p_start, OutClauses), 
		pp_print_clauses(OutClauses),
	unfold:unroll(OutClauses, p_start, NewClauses1), 
		pp_print_clauses(NewClauses1), 
	chain([prune(p_start)], NewClauses1, [NClause1|_]),
	constraints:simplify(NClause1, NNClause1, 2), 
	pp_print_clauses([NNClause1]).  
  
testgraph:-
	prepare('test4.clp', Clauses), 
	graph:call_graph(Clauses, Graph), 
	format('Call graph : ~w ~n', [Graph]).
	
testslice:-
	prepare('loop1.clp', Clauses),
	chain([ slice(p_start)], Clauses, _).  
	
testfu:- 
	prepare('test.clp', Clauses), 
	chain([fold_unfold], Clauses, _). 
	