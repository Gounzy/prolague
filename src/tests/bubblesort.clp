p_start(A,B,C,D, A1, B1, C1, D1):- 
	{},
	bubble_sort(A,B,C,D,A1,B1,C1,D1).
	
bubble_sort(A,B,C,D,AX3,BX3,CX2,DX) :-
	{},
	bubble_sort_once(A,B,C,D, AX, BX, CX, DX),
	bubble_sort_once(AX,BX,CX,AX2,BX2,CX2),
	bubble_sort_once(AX2, BX2, AX3, BX3).
	 
bubble_sort_once(A,B,C,D, MINAB, MINABC, MINABCD, MAXABCD) :-
	{},  
	max_min(A,B,MAXAB, MINAB), 
	max_min(MAXAB,C, MAXABC, MINABC), 
	max_min(MAXABC, D, MAXABCD, MINABCD).
	
bubble_sort_once(A,B,C,MINAB, MINABC, MAXABC) :-
	{},  
	max_min(A,B,MAXAB, MINAB), 
	max_min(MAXAB,C, MAXABC, MINABC).
	
bubble_sort_once(A, B, MINAB, MAXAB):- 
	max_min(A,B,MAXAB, MINAB). 
	
max_min(A,B,B,A):- 
	{A =< B}.
max_min(A,B,A,B):-
	{A > B}.  
