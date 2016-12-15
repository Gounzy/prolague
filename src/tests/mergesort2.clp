p_start(A, B, A1, B1):- 
	{},
	merge_sort(A,B, A1, A2).
	
merge_sort(A,B,A,B):- 
	{A < B}.
merge_sort(A,B,B,A):-
	{B =< A}. 