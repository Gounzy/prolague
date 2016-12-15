p1(X,Y,Z) :- 
	{X > Y}, 
	q(X,Y,Z).
	
q(X,Y,Z):-
	{X<45},
	r(X,Y,Z).

r(X,Y,Z):- 
	{Y > 30},
	s(X,Y,Z).

s(X,Y,Z):-
	{ Z > 20 }, 
	f(X),
	g(Y),
	h(Z),
	t(X,Y,Z).
	
f(X):-
	{X < 40},
	true.
	
g(X):-
	{X < 35}, 
	true.
	
h(X):-
	{X < 100, X > 10}, 
	true.
	
t(X,Y,Z):-
	{X + Y < 100},
	t(Z, X, Y). 