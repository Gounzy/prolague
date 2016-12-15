p_start(Xs, Max):- 
	max(Xs, 0, Max). 
	
max([], Max, Max).
max([X|Xs], CurrentMax, Max):- 
	{ X > CurrentMax}, 
	max(Xs, X, Max).
max([X|Xs], CurrentMax, Max):- 
	{ X =< CurrentMax}, 
	max(Xs, CurrentMax, Max). 
	