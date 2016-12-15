% Calculer A * B 

p_start(A, B, C, D, E):- 
	{D = 2}, p2(A, B, B, D, E). 

p2(A, B, I, D, E):- 
	{ I = 0, E = D + I}. 
	
p2(A, B, I, D, E):- 
	{ I > 0, J = I - 1, K = D + A}, 
	p2(A, B, J, K, E). 