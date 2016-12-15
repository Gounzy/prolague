p1(C,E,F,G,H,I):-
     { },
     p1_2(F,E,C,E,G,H,I), true.

p1_2(N6,O6,P6,R6,T6,U6,V6):-
     { O6=V6, T6=U6, N6=<1},
     true.

p1_2(W6,X6,Y6,A7,C7,D7,E7):-
     { W6>1, F7=W6+ -1, G7=X6+A7, H7=1},
     p1_2(F7,G7,H7,A7,C7,D7,E7).