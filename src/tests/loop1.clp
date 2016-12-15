p_start(X, Y, Z):- 
	{I = 0, C = 0}, p2(I, C,  Y, X).
	
p2(I, C, D, X):- 
	{ I < 3, NC = C + 1, J = I + 1}, p2(J, NC, D, X). 
	
p2(I,C, D, X):- 
	{ I = 3, X = C}. 