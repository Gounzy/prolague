p_start(A,B,A):-{}, p2(A, B).
p2(X,Y) :- { X = 3, Y = 1 }. 
p2(X,Y) :- { X < 3, Y < 3 }.
p2(X,Y) :- { Y = 3, X = 1 }.

p_start(A,B,B):-{}, p3(A,B).
p3(X,Y) :- { Y > X, X = 1, Y > 3 }.
p3(X,Y) :- { Y > X, X = 2, Y > 2 }.
p3(X,Y) :- { Y > X, X = 3, Y > 1 }.
p3(X,Y) :- { X >= Y, X = 3, Y > 1 }.
p3(X,Y) :- { Y > X, X >= 4, Y >= 1 }.
p3(X,Y) :- { X >= Y, X >= 4, Y >= 1 }.

p3(X,Y) :- { Y > X, Y >= 4, X >= 1 }.
p3(X,Y) :- { X >= Y, Y >= 4, Y >= 1 }. 
p3(X,Y) :- { X > Y, Y = 1, X > 3 }. 
p3(X,Y) :- { X > Y, Y = 2, X > 2 }.
p3(X,Y) :- { X > Y, Y = 3, X > 1 }.
p3(X,Y) :- { Y >= X, Y = 3, X > 1 }.