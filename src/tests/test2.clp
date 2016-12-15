p1(X,Y,Z) :- 
	{X > Y}, 
	p1(X,Y,Z), 
	q(X,Y).
	
q(X,Y):-
	{X > 4}, 
	q(Y,X).
	
