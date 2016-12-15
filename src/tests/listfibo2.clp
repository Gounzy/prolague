p_start(Xs):- 
	{unify(Xs, Ys)}, 
	length_mdr(Xs, L), 
	create_fibo(L, Ys).
	
length_mdr(Xs, L):- 
	length_mdr(Xs, 0, L). 
	
length_mdr([], N, N). 
length_mdr([X|Xs], N1, N):- 
	{ N2 = N1 + 1 }, 
	length_mdr(Xs, N2, N). 
	
create_fibo(L, Ys):- 
	create_fibo(L, 1, Ys). 
	
create_fibo(L, N, []):- 
	{ N > L }. 
create_fibo(L, N, [Y|Ys]):- 
	{ N =< L, N1 = N + 1 }, 
	fibo(N, Y), 
	create_fibo(L, N1, Ys). 
	
fibo(0,1).
fibo(1,1).
fibo(F,N) :- 
    {F>1, F1 = F-1, F2 = F-2},
    fibo(F1,N1),
    fibo(F2,N2),
    sum(N1, N2, N).
    
sum(N1, N2, N):- { N1 + N2 = N}. 
	 
	