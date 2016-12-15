p_start(X):- 
	{I = 0, C = 0}, p2(I, C, X).
	
p2(I, C, X):- 
	{ I =< 2, NC = C + 1 + 0*I, J = I + 1}, p2(J, NC, X). 
	
p2(I,C, X):- 
	{ I > 2, I < 4, X = C}. 