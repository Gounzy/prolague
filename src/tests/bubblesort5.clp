p_start(A,B,C,D,E, A1, B1, C1, D1, E1):- 
	{},
	bubble_sort(A,B,C,D,E,A1,B1,C1,D1,E1).
	
bubble_sort(A,B,C,D,E,AX4,BX4,CX3,DX2,EX) :-
	{},
	bubble_sort_once(A,B,C,D,E, AX, BX, CX, DX, EX),
	bubble_sort_once(AX,BX,CX,DX,AX2,BX2,CX2, DX2),
	bubble_sort_once(AX2, BX2,CX2, AX3, BX3,CX3),
	bubble_sort_once(AX3,BX3, AX4, BX4).
	 
bubble_sort_once(A,B,C,D,E,MINAB,MINABC,MINABCD,MINABCDE, MAXABCDE):- 
	{}, 
	max_min(A,B,MAXAB, MINAB), 
	max_min(MAXAB,C, MAXABC, MINABC), 
	max_min(MAXABC, D, MAXABCD, MINABCD),
	max_min(MAXABCD, E, MAXABCDE, MINABCDE). 
	 
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
