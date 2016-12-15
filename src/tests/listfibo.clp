p_start(Xs) :- 
    { unify(Xs, Ys) }, 
	fibo(Ys, 0, 1). 

fibo([], X, Y). 
fibo([X|Xs], N1, N2):- 
	{X = N1 + N2, unify(Xs, Ys)}, 
	fibo(Ys, N2, X).