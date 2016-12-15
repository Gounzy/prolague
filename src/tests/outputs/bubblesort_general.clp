p_start(A,B):-
     lists2_1(A,[],B).

lists2_1([],A,B):-
     { unify(A,B)}.
lists2_1([A|B],C,D):-
     lists2_1(E,[F|C],D), 
     lists2_2(A,B,E,F).

lists2_2(A,[],[],A).
lists2_2(A,[B|C],[A|D],E):-
     { A=<B},
     lists2_2(B,C,D,E).
lists2_2(A,[B|C],[B|D],E):-
     { A>B},
     lists2_2(A,C,D,E).