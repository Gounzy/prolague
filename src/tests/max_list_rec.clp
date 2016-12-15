p_start(Xs, Max):- 
	max(Xs, Max). 
	
max([], X):- {X = 0}. 
max([X|Xs], Max):-
	max(Xs, Max1), 
	max_value(Max1, X, Max).  

max_value(X1, X2, X1):- 
	{X1 > X2}. 
	
max_value(X1, X2, X2):- 
	{X1 =< X2}.
	