%%% Coeur des transformations 
%% Contient l'algorithme
%% + le chaînage de transformations 
%% + d'autres trucs utiles et typiques aux transformations, gente extract_predicate

:-module(transformation, [chain/3, get_arity/3, extract_predicate/5, extract_vars/2]).

:-use_module(utils). 
:-use_module(slice).
:-use_module(unfold).
:-use_module(constraints).
:-use_module(thin).
:-use_module(compare).
:-use_module(pprint).  
:-use_module(rename). 

%%%%%
launchAlgo(Prog1/Start1, Prog2/Start2, Trans):-
	chain([prune(Start1), unfold(Start1)], Prog1, NProg1), % Preprocessing 
	chain([prune(Start2), unfold(Start2)], Prog2, NProg2), % Preprocessing 
	algo([NProg1], [NProg2], Start1, Start2, Trans).  

algo(Progs1, Progs2, Start1, Start2, Trans):- 
	member(Prog1, Progs1), 
	member(Prog2, Progs2),
	member(T1, Trans), 
	member(T2, Trans), 
	(T1 = loops -> TT1 =..[T1,Prog2] ; TT1 =..[T1,Start1]),
	chain_one(TT1, Prog1, NewProgs1), 
	(T2 = loops -> NewProgs1 = [P1|_], TT2 =..[T2,P1] ; TT2 =..[T2,Start2]),
	chain_one(TT2, Prog2, NewProgs2), 
	append(NewProgs1, Progs1, Progs1b),
	append(NewProgs2, Progs2, Progs2b),
	(contains_similar_programs(Progs1b, Progs2b, Start1, Start2) -> abort; true), 
	(is_interesting_to_continue(NewProgs1, NewProgs2) 
		-> format('~n ~n No match found. Continuing algorithm. ~n ~n'), 
		   decalate(Trans, NewTrans),
		   algo(Progs1b, Progs2b, Start1, Start2, NewTrans) 
		; format('Not interesting to continue anymore \n')).  

decalate([T|Trans], NewTrans):-
	append(Trans, [T], NewTrans). 

contains_similar_programs([Prog1|Progs1], Progs2, Start1, Start2):-
	is_similar_to_one(Prog1, Progs2, Start1, Start2) 
	; 
	contains_similar_programs(Progs1, Progs2, Start1, Start2). 
	
is_similar_to_one(Prog1, [Prog2|Progs2], Start1, Start2):- 
	are_similar(Prog1, Prog2, Start1, Start2) 
	; 
	is_similar_to_one(Prog1, Progs2, Start1, Start2). 
	
are_similar(Prog1, Prog2, Start1, Start2):- 
	chain([prune(Start1),flatten, merge, clp], Prog1, NProg1),
	chain([prune(Start2),flatten, merge, clp], Prog2, NProg2),
	!,
	graph:call_graph_with_constraints(NProg1, G1),
	graph:call_graph_with_constraints(NProg2, G2),
	!,
	format('G1 : ~w ~n G2 : ~w ~n', [G1, G2]), 
	compare:compare_graphs(G1, G2, Start1, Start2).
	
is_interesting_to_continue(Prog1, Prog2):- 
	not(Prog1 = []), 
	not(Prog2 = []),
	true.

chain_one(unfold(P), InputClauses, [OutputClauses]):- 
		format('Starting ONE unfolding step... ~n'), 
	unfold:unfold_once(InputClauses, P, NewClauses), 
	thin:thin(NewClauses, [P], NClauses, _), 
	constraints:prune(NClauses, OutputClauses), 
		pp_print_clauses(OutputClauses).
chain_one(slice(P), InputClauses, OutputClauses) :- 
		format('Generating slices... ~n'), 
	slice:slice(InputClauses, P, _, OutputClauses),  
		format('Slices : ~w ~n', [OutputClauses]). 
chain_one(loops(Prog2), InputClauses, [OutputClauses]) :- 
		format('Checking for similar loops... ~n'), 
	pair:search_equal_loops(InputClauses, Prog2, OutputClauses), 
		pp_print_clauses(OutputClauses). 

%%%%%
% Transformations chaining
%%%%%
chain([], InputClauses, InputClauses) :-
	format('Transformation chaining done.~n'). 

chain([unfold(P)|Xs], InputClauses, OutputClauses):-
		format('Starting unfold (till the end) transformation... ~n'),
	unfold:unfold_tilltheend(InputClauses, P, NewClauses), 
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([unfold_once(P)|Xs], InputClauses, OutputClauses):- 
		format('Starting ONE unfold transformation... ~n'), 
	unfold:unfold_once(InputClauses, P, NewClauses), 
		pp_print_clauses(NewClauses), 
	chain(Xs, NewClauses, OutputClauses). 
	
chain([unroll(P)|Xs], InputClauses, OutputClauses):- 
		format('Starting unroll transformation... ~n'), 
	unfold:unroll(InputClauses, P, NewClauses), 
		pp_print_clauses(NewClauses), 
	chain(Xs, NewClauses, OutputClauses). 
	
chain([fold_unfold|Xs], InputClauses, OutputClauses):-
		format('Starting fold-unfold transformation... ~n'),
	pair:fold_unfold(InputClauses, NewClauses), 
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([slice(P)|Xs], InputClauses, OutputClauses):-
		format('Starting slice transformation... ~n'),
	slice:slice(InputClauses, P, NewClauses),
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([prune(P)|Xs], InputClauses, OutputClauses):-
		format('Starting prune transformation... (P = ~w) ~n', [P]),
	thin:thin(InputClauses, [P], NClauses, _), 
	constraints:prune(NClauses, NewClauses),
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([optimize|Xs], InputClauses, OutputClauses):- 
	format('Starting prune transformation... ~n'),
	constraints:prune(InputClauses, NewClauses),
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([rename|Xs], InputClauses, OutputClauses):-
		format('Starting rename transformation... ~n'),
	rename:rename(InputClauses, NewClauses), 
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([rename_r|Xs], InputClauses, OutputClauses):-
		format('Starting rename (with reset) transformation... ~n'),
	rename:rename_reset(InputClauses, NewClauses), 
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses).
	
chain([flatten|Xs], InputClauses, OutputClauses):-
		format('Starting flatten transformation... ~n'), 
	rename:flatten(InputClauses, NewClauses), 
		pp_print_clauses(NewClauses),
	chain(Xs, NewClauses, OutputClauses). 
	
chain([merge|Xs], InputClauses, OutputClauses):-
		format('Starting merge transformation... ~n'), 
	clp:merge(InputClauses, NewClauses),
		pp_print_clauses(NewClauses), 
	chain(Xs, NewClauses, OutputClauses). 
	
chain([clp|Xs], InputClauses, OutputClauses):-
		format('Starting toCLP transformation... ~n'), 
	clp:to_clpfd(InputClauses, NewClauses), 
		pp_print_clauses(NewClauses), 
	chain(Xs, NewClauses, OutputClauses). 
	
chain([vars(Array)|Xs], InputClauses, OutputClauses):-
		format('Starting vars transformation... ~n'), 
	terms:to_real_vars(InputClauses, Array, NewClauses), 
		pp_print_clauses(NewClauses), 
	chain(Xs, NewClauses, OutputClauses). 
	

%%%%%
% Other transformation tools
%%%%%

% Starting from all the clauses in first argument, returns all the clauses with given Pred name, and all other clauses, which is useful when that scission is needed 
extract_predicate(Clauses, Pred, CurrentPC, PredClauses, OtherClauses):- 
	select(cl(H, C, B), Clauses, NClauses), 
	H =..[Pred|_], 
	!,
	append([cl(H,C,B)], CurrentPC, NCurrentPC), 
	extract_predicate(NClauses, Pred, NCurrentPC, PredClauses, OtherClauses).
extract_predicate(Clauses, _, CurrentPC, CurrentPC, Clauses). 

% Get vars from clause head
extract_vars(cl(H,_,_), Vars) :-  
	H =..[_|Vars].

% Used to get a predicates name & arity
canonicalForm(H, Pred/Arity):-
	H =..[Pred|Args], 
	length(Args, Arity). 
	
% Get arity from pred name (use with caution if 2 preds have same name)
get_arity(Pred, Clauses, Arity) :-
	member(cl(H,_,_), Clauses), 
	canonicalForm(H, Pred/Arity). 
get_arity(Pred,_,_):-
	throw(Pred).

% get all calls that start from Pred/Arity ; each call is represented as (CallerName/CallerArity, CalledName/CalledArity)
getAllCalls(_, [], []). 
getAllCalls(Pred/Arity, [B|Bs], [(Pred/Arity, PredB/ArityB)|Calls]) :- 
	canonicalForm(B, PredB/ArityB),
	getAllCalls(Pred/Arity, Bs, Calls). 

% Identifies each clause by giving it a unique ID with which it is "zipped"	
identify(Clauses, NewClauses):-
	identify(Clauses, 0, NewClauses). 
	
identify([], _, []). 
identify([cl(H,C,B)|Clauses], N, [cl(NH, H, C, B)|NewClauses]):-
	H =..[Pred|_], 
	NH =..[Pred, N],
	N1 is N + 1, 
	identify(Clauses, N1, NewClauses). 