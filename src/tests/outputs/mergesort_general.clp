p_start([],[]).
p_start([A],[A]).
p_start(A,B):-
     lists_1(A,C,D), 
     p_start(C,E), 
     p_start(D,F), 
     lists_2(E,F,B).

lists_1([],[],[]).
lists_1([A],[A],[]).
lists_1([A,B|C],[A|D],[B|E]):-
     lists_1(C,D,E).

lists_2(A,[],B):-
     { unify(A,B)}.
lists_2([],A,B):-
     { unify(A,B)}.
lists_2([A|B],[C|D],[C|E]):-
     { A>C},
     lists_2([A|B],D,E).
lists_2([A|B],[C|D],[A|E]):-
     { A=<C},
     lists_2(B,[C|D],E).

