p_start([], Sum):- {Sum = 0}. 
p_start([A|As], Sum):- 
	{Sum = A + Sum2},
	p_start(As, Sum2).
	
