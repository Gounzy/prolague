p1(X,Y,Z) :- 
	{X > Y}, 
	q(X,Y).
	
q(X,Z):-
	{X<45},
	r(X,Z).
	
r(X,Y):-
	{Y > 30, A = X},
	p1(X,Y,A).
