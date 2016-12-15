p_start(A, B, C, D, E, A1, B1, C1, D1, E1):- 
	{},
	merge_sort(A,B,C, X1, X2, X3), 
	merge_sort(D,E, X4, X5), 
	merge(X1,X2,X3,X4,X5,A1,B1,C1,D1,E1). 
	
merge_sort(A,B,C,MINAB,MINABC,MAXABC):-
	merge_sort(A,B, MINAB, MAXAB), 
	merge_sort(MAXAB, C, MINABC, MAXABC).
	
merge_sort(A,B,A,B):- 
	{A < B}.
merge_sort(A,B,B,A):-
	{B =< A}. 
	
merge(X1,X2,X3,Y1,Y2,X1, O2, O3, O4, O5) :-
    {X1 =< Y1},
    merge2_2(X2,X3,Y1,Y2, O2,O3,O4,O5). 
merge(X1, X2, X3, Y1, Y2, Y1, O2, O3, O4, O5) :-
    {Y1 < X1}, 
    merge3_1(X1, X2, X3, Y1, O2, O3, O4, O5). 
	
merge2_2(X1, X2, Y1, Y2, X1, O2, O3, O4):- 
	{X1 =< Y1},
	merge1_2(X2, Y1, Y2, O2,O3,O4). 
merge2_2(X1, X2, Y1, Y2, Y1, O2, O3, O4):- 
	{Y1 < X1},
	merge1_2(Y2, X1, X2, O2,O3,O4). 
	
merge3_1(X1,X2,X3,Y1, X1, O2,O3,O4):- 
	{X1 =< Y1}, 
	merge1_2(Y1, X2, X3, O2, O3, O4). 
merge3_1(X1,X2,X3,Y1, Y1, X1,X2,X3):- 
	{Y1 < X1}.
	
merge1_2(X1, Y1, Y2, X1, Y1, Y2):- 
	{ X1 =< Y1 }.
merge1_2(X1, Y1, Y2, Y1, O1, O2):-
	{ Y1 < X1 }, 
	merge_sort(X1, Y2, O1, O2). 
	