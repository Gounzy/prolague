p_start(X, Y):-
	p_start2(X, [], Y). 

p_start2([],Acc, Sorted):-{unify(Acc, Sorted)}.
p_start2([H|T],Acc,Sorted):-
	bubble(H,T,NT,Max),
	re_p_start(NT, Max, Acc, Sorted). 
 
re_p_start(NT, Max, Acc, Sorted):- 
	p_start2(NT, [Max|Acc], Sorted). 

bubble(X,[],[],X).
bubble(X,[Y|T],[Y|NT],Max):-{X>Y},bubble(X,T,NT,Max).
bubble(X,[Y|T],[X|NT],Max):-{X=<Y},bubble(Y,T,NT,Max).