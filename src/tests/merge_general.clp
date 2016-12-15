% p_start( L, S )
% True if S is a sorted copy of L, using merge sort
p_start( [], [] ).
p_start( [X], [X] ).
p_start( U, S ) :- split(U, L, R), p_start(L, SL), p_start(R, SR), merge(SL, SR, S).
 
% split( LIST, L, R )
% Alternate elements of LIST in L and R
split( [], [], []).
split( [X], [X], [] ).
split( [L,R|T], [L|LT], [R|RT] ) :- split( T, LT, RT ).

merge( [], X, Y ):- {unify(X,Y)}.
merge( X, [], Y ):- {unify(X,Y)}.
merge( [L|LS], [R|RS], [L|T] ) :- { L =< R }, merge(LS, [R|RS], T).
merge( [L|LS], [R|RS], [R|T] ) :- { L > R },  merge([L|LS],   RS,  T).