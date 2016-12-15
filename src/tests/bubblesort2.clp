p_start(A,B,A1,B1):- 
	{},
	bubble_sort(A,B,A1,B1).
	
bubble_sort(A,B,A1,B1) :-
	{},
	bubble_sort_once(A,B,AX, BX, DidSomething),
	bubble_sort_again(AX,BX, A1, B1, DidSomething). 
	 
bubble_sort_again(A,B, A1, B1,DidSomething):-
	{DidSomething = 1}, 
	bubble_sort(A,B,A1,B1). 
bubble_sort_again(A,B, A,B, DidSomething):- 
	{DidSomething = 0}.
	 
bubble_sort_once(A,B, MINAB, MAXAB, DidSomething) :-
	{},  
	max_min(A,B,MAXAB, MINAB), 
	didsomething(A,B,MINAB,MAXAB, DidSomething).
	
didsomething(A,B,MINAB,MAXAB,DidSomething) :-
 	{\/(MINAB \= A, MAXAB \= B), DidSomething = 1}. 
didsomething(A,B,A,B,DidSomething) :-
	{DidSomething = 0}. 
	
max_min(A,B,B,A):- 
	{A =< B}.
max_min(A,B,A,B):-
	{A > B}.  
