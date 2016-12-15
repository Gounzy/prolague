p_start(A, B, C, A1, B1, C1):- 
	{},
	merge_sort(A,B, X1, X2), 
	merge(X1, X2, C, A1, B1, C1). 
	
merge_sort(A,B,A,B):- 
	{A < B}.
merge_sort(A,B,B,A):-
	{B =< A}. 
	
merge(X1, X2, X3, X1, MIN32, MAX32):- 
	{},
	merge_sort(X1, X3, X1, X3), 
	merge_sort(X3, X2, MIN32, MAX32). 
merge(X1, X2, X3, X3, MIN12, MAX12):- 
	{},
	merge_sort(X1, X3, X3, X1), 
	merge_sort(X1, X2, MIN12, MAX12).
	