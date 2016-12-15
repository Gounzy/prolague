p_start(A,B,C, A1, B1, C1):- 
	{},
	bubble_sort(A,B,C, A1,B1,C1).
	
bubble_sort(A,B,C,A1,B1,C1) :-
	{},
	bubble_sort_once(A,B,C, AX, BX, CX, DidSomething),
	bubble_sort_again(AX,BX,CX, A1, B1, C1, DidSomething). 
	 
bubble_sort_again(A,B,C, A1, B1, C1, DidSomething):-
	{DidSomething = 1}, 
	bubble_sort(A,B,C,A1,B1,C1). 
bubble_sort_again(A,B,C, A,B,C, DidSomething):- 
	{DidSomething = 0}.
	 
bubble_sort_once(A,B,C, MINAB, MINABC, MAXABC, DidSomething) :-
	{},  
	max_min(A,B,MAXAB, MINAB), 
	max_min(MAXAB,C, MAXABC, MINABC), 
	didsomething(A,B,C,MINAB,MINABC,MAXABC, DidSomething).
	
didsomething(A,B,C,MINAB,MINABC,MAXABC,DidSomething) :-
 	{\/(\/(MINAB \= A, MINABC \= B), MAXABC \= C), DidSomething = 1}. 
didsomething(A,B,C,A,B,C,DidSomething) :-
	{DidSomething = 0}. 
	
max_min(A,B,B,A):- 
	{A =< B}.
max_min(A,B,A,B):-
	{A > B}.  
