p1(C,E,F,G,H,I):-
     { F<0},
     p1_6(F,E,C,E,G,H,I), true.

p1(C,E,F,G,H,I):-
     { F=0, I=1, G=H},
     true.

p1(C,E,F,G,H,I):-
     { F>0},
     p1_6(F,E,C,E,G,H,I), true.

p1_6(S9,T9,U9,W9,Y9,Z9,A10):-
     { S9>1, B10=S9+ -1, C10=T9+W9, D10=1},
     p1_6(B10,C10,D10,W9,Y9,Z9,A10).

p1_6(E10,F10,G10,I10,K10,L10,M10):-
     { F10=M10, K10=L10, E10=<1},
     true.