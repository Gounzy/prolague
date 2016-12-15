p_start(A, B, C, D, A1, B1, C1, D1):- 
	{},
	merge_sort(A,B, X1, X2), 
	merge_sort(C,D, X3, X4), 
	merge(X1, X2, X3, X4, A1, B1, C1, D1). 
	
merge_sort(A,B,A,B):- 
	{A < B}.
merge_sort(A,B,B,A):-
	{B =< A}. 
	
merge(X1, X2, X3, X4, MIN13, MIN132, MIN1324, MAX1324):- 
	{},
	merge_sort(X1, X3, MIN13, MAX13), 
	merge_sort(MAX13, X2, MIN132, MAX132),
	merge_sort(MAX132, X4, MIN1324, MAX1324).
	