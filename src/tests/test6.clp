p_start(A,B):-
	 {I = 1}, 
	 iterate(I, A, B). 
	
iterate(I, A, B):- 
	{ I < 5, J = I + 1}, 
	iterate(J, A, B). 
	
iterate(I, A, B):- 
	{ I = 5, B = A + I}.
	
