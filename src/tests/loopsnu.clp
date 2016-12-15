p2_0(A,B,C,D,E,F,G,H):-
     { I=1},
     p2_2(E,I,C,D,E,F,G,H).

p2_2(A,B,C,D,E,F,F,B):-
     { A=<0},
     true.

p2_2(A,B,C,D,E,F,G,H):-
     { A=1, I=A+ -1, J=B+D},
     p2_2(I,J,C,D,E,F,G,H).

p2_2(A,B,C,D,E,F,G,H):-
     { A>1, I=A+ -1, J=B+D},
     p2_2(I,J,C,D,E,F,G,H).
