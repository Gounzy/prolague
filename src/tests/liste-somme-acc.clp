p_start(As, Sum):-
	p2(As, 0, Sum). 
	
p2([], Acc, Acc).
p2([A|As], Acc, Sum):- 
	{ Acc2 = Acc + A}, 
	p2(As, Acc2, Sum). 