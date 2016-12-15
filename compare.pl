%%%% Comparaison de programmes :
%%% - Comparaison de graphes d'appels avec contraintes (cgwc) pour l'algo naïf : voir si ce sont les mêmes graphes à un renommage près. 
%%% - Comparaison de programmes pour predicate pairing : voir si les dataflows correspondent. 

:-module(compare, []).

:-dynamic counter/1.

:-use_module(library(clpfd)). 

:-use_module(utils).
:-use_module(terms).
:-use_module(constraints).
:-use_module(clp).  
:-use_module(rename).
:-use_module(pprint).
:-use_module(transformation).
:-use_module(fold).
 
compare_graphs(G1, G2, Start1, Start2):-
	findall(N1, graph:cgwc_node(G1, Start1, N1), Ns),
		format('Nodes 1 : ~w ~n', [Ns]), 
	findall(N2, graph:cgwc_node(G2, Start2, N2), Ns2),
		format('Node 2 : ~w ~n', [Ns2]), 
	all_node_similar(G1, G2, Ns, Ns2). 
	
all_node_similar(_, _, [], []). 
all_node_similar(G1, G2, [N|Ns], Ns2):- 
	select(N2, Ns2, NNs2), 
	node_similar(G1, G2, N, N2),
	!, 
	all_node_similar(G1, G2, Ns, NNs2). 
	
node_similar(_, _, null, null). 
node_similar(G1, G2, node(H,_,_), node(H2,_,_)):- % cycle case
	H =..[Pred|_], 
	H2 =..[Pred2|_], 
	graph:cgwc_cycle(G1, Pred), 
	graph:cgwc_cycle(G2, Pred2),
	!,
	findall(N, graph:cgwc_node(G1, Pred, N), Ns), 
	findall(X, graph:cgwc_node(G2, Pred2, X), Ns2),
	!, 
		format('Ns : ~w ~n', [Ns]), 
		format('Ns2 : ~w ~n', [Ns2]),
	terms:get_vars(Ns, Vars), 
	terms:get_vars(Ns2, Vars2),
	sort(Ns2, NNs2),
		format('NNs2 : ~w ~n', [NNs2]), 
	compare:create_assoc(Vars, Vars2, Assoc), 
	terms:replace(Ns, Assoc, NNs), 
	sort(NNs, NNsmdr),
	!,
		format('Comparing NNs2 = ~w and NNsmdr = ~w ~n', [NNs2, NNsmdr]),
	same_cycle(NNs2, NNsmdr),
		format('NNs : ~w ~n', [NNs]),
	true.
node_similar(G1, G2, node(H,[C],B), node(H2,[C2],B2)):- % non-cycle
	terms:get_vars(node(H,C,B), Vars),
	terms:get_vars(node(H2,C2,B2), Vars2),
	length(Vars,L1),
	length(Vars2,L2),
	L is L1 + L2,
	functor(Array, f, L),
	!,
	compare:create_assoc(Vars, Vars2, Assoc),
		format('Assoc : ~w ~n', [Assoc]),
	terms:replace(node(H,C,B), Assoc, node(_, AC, _)),
	terms:constraints_to_real_vars(AC, VAC, Array),
	terms:constraints_to_real_vars(C2, VAC2, Array),
	terms:args_to_real_vars(Vars2, Array, RealVars2),
	compare:domain_constraints(RealVars2, DC),
		%format('Domain constraints : ~w ~n', [DC]), 
	constraints:exec_constraints(DC),
	VAC #\ VAC2, % Comparison
	not(labeling([ff], RealVars2)), % Vars2 because the mapping is Vars1->Vars2
	!,
	B =..[Pred|_], % only one-call bodies
	B2 =..[Pred2|_],
	findall(N1, graph:cgwc_node(G1, Pred, N1), Ns),
	findall(N2, graph:cgwc_node(G2, Pred2, N2), Ns2),
	all_node_similar(G1, G2, Ns, Ns2).

same_cycle([], []). 
same_cycle([node(H,C,null)|Nodes1], [node(H2,C,null)|Nodes2]):-  % Todo améliorer
	!,
	H =..[_|Args], 
	H2 =..[_|Args], 
	same_cycle(Nodes1, Nodes2). 
same_cycle([node(H,C,B)|Nodes1], [node(H2,C,B2)|Nodes2]):-  % Todo améliorer
	H =..[_|Args], 
	H2 =..[_|Args], 
	B =..[_|Args2], 
	B2 =..[_|Args2],
	same_cycle(Nodes1, Nodes2).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
compare_progs(Clauses, cl(H,_,B), Automatized, Assoc):-
	(not(counter(X)) -> assert(counter(0)) ; true), 
	(Automatized -> create_theorem(B, ImportantVars1, ImportantVars2, Theorem)  ;  ask_for_vars(H, B, ImportantVars1, ImportantVars2, Theorem)),
		format('Starting comparison ... ~n'), 
	functor(Array, f, 1000), % should be a dynamic number, not 1000
	chain([prune(launchingClause),flatten,clp,vars(Array)], Clauses, NewClauses), 
	assert_clauses(NewClauses), 
	!,
	create_assoc(ImportantVars1, ImportantVars2, Assoc), 
	assoc_to_constraints(Assoc, Constraints), 
	counter(X), 
	new_pred_name("clp", X, Name), 
	retract(counter(X)), 
	X1 is X + 1, 
	assert(counter(X1)),
	append(Theorem, Constraints, FinalConstraints),
	chain([clp, vars(Array)], [cl(Name, FinalConstraints, [H])], [cl(Name, NC, NB)]),
	NB = [Call], 
	Call =..[_|Args], 
	domain_constraints(Args, NewC),
	append(NewC, NC, FinalC),
	FinalB = [Call, labeling([ff], Args)],
	assert_clause(cl(Name, FinalC, FinalB)), 
		format('~n Final clause : ~w ~n', [cl(Name, FinalC, FinalB)]),
	not(call(Name)),
		format('Both programs seem to be calculating the same thing.').

create_theorem(Calls, ChosenVarsCall1, ChosenVarsCall2, IE):- 
	Calls = [Call1, Call2], 
	Call1 =..[_|Args1], 
	last(Args1, R1), 
	select(R1, Args1, ChosenVarsCall1), 
	Call2 =..[_|Args2],
	last(Args2, R2), 
	select(R2, Args2, ChosenVarsCall2), 
	length(Args1, L1), 
	length(Args2, L2), 
	create_inequalities_pos([(L1, L2)], Calls, IE). 

create_inequalities_pos([], _, []). 
create_inequalities_pos([(N1, N2)|Rest], [Call1, Call2], [Var1 \= Var2|E]):-
	Call1 =..[_|Args1],
	Call2 =..[_|Args2], 
	nth1(N1, Args1, Var1), 
	nth1(N2, Args2, Var2),
	create_inequalities_pos(Rest, [Call1,Call2], E).

ask_for_vars(Head, Calls, ChosenVarsCall1, ChosenVarsCall2, IE) :- 
	format('The pairing generated a paired clause ~w ~n with body ~w ~n', [Head, Calls]),
	
	Calls = [Call1, Call2],
	
	format('Give a list of numbers representing the positions of the input variables of the FIRST CALL'), 
	nl,read(ImportantPos1), 
	pos_to_variables(Call1, ImportantPos1, ChosenVarsCall1), 
	
	format('Give a list of numbers representing the positions of the input variables of the SECOND CALL'), 
	nl,read(ImportantPos2), 
	pos_to_variables(Call2, ImportantPos2, ChosenVarsCall2),  
	
	format('Done. Which variables express the return values and should be proved different in order to differentiate the programs ?'), 
	nl,read((Var1, Var2)),  
	create_inequalities_pos([(Var1, Var2)], Calls, IE), 
	format('All done. New inequalities (theorem to prove impossible) : ~w', [IE]).

pos_to_variables(_, [], []). 
pos_to_variables(Call, [Pos|OtherPos], [Var|OtherVars]):- 
	Call =..[_|Args],
	nth1(Pos, Args, Var), 
	pos_to_variables(Call, OtherPos, OtherVars).  

assert_clauses(Clauses):-
	maplist(assert_clause, Clauses). 
	
assert_clause(cl(H,C,B)):-
	list_to_tuple(C, NC), 
	list_to_tuple(B, NB),
	assert(:-(H, (NC, NB))). 
	
% L'overwriting est fait exprès, sinon l'autre list_to_tuple l'emporte alors qu'il ne marche pas pour notre cas ici 
list_to_tuple([[]], true).
list_to_tuple([], true). 
list_to_tuple([C|Cs], NC):-
	list_to_tuple(Cs, NCs), 
	NC = (C, NCs).

create_assoc([], _, []). 
create_assoc([X|Xs], Ys, [(X,Y)|Assoc]):- % One var of each are associated
	select(Y, Ys, NYs), 
	create_assoc(Xs, NYs, Assoc). 

assoc_to_constraints([], []). 
assoc_to_constraints([(X, Y)|Assocs], [X = Y|Constrs]):-
	assoc_to_constraints(Assocs, Constrs). 

domain_constraints([], []). 
domain_constraints([Arg|Args], [Arg in 0..10|C]):- 
	domain_constraints(Args, C). 	
