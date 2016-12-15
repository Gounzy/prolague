p_start(B,C,D,E,F,G,H):-
     { F4=B, G4=C, H4=D, I4=E},
     test41(G4,H4,I4,F,G,H), true.

test41(L4,M4,N4,O4,P4,Q4):-
     { V4=N4, U4=M4, T4=L4, L4<M4},
     test42(T4,U4,V4,O4,P4,Q4).

test41(Y4,Z4,A5,B5,C5,D5):-
     { I5=A5, H5=Z4, G5=Y4, Y4>=Z4},
     test43(G5,H5,I5,B5,C5,D5).

test410(R10,W10,X10,Y10):-
     { Z10=R10},
     test45(Z10,W10,X10,Y10).

test42(G7,H7,I7,J7,K7,L7):-
     { Q7=I7, P7=H7, O7=G7, H7<G7},
     test46(Q7,J7,K7,L7).

test42(T7,U7,V7,W7,X7,Y7):-
     { D8=V7, C8=U7, B8=T7, U7>=T7},
     test47(C8,D8,W7,X7,Y7).

test43(L5,M5,N5,O5,P5,Q5):-
     { V5=N5, U5=M5, T5=L5, L5<N5},
     test42(T5,U5,V5,O5,P5,Q5).

test43(Y5,Z5,A6,B6,C6,D6):-
     { I6=A6, H6=Z5, G6=Y5, Y5>=A6},
     test44(G6,B6,C6,D6).

test44(L6,O6,P6,Q6):-
     { T6=L6, R6=L6},
     test45(R6,O6,P6,Q6).

test45(W6,B7,C7,D7):-
     { W6=D7, B7=C7},
     true.

test46(I10,J10,K10,L10):-
     { Q10=I10, M10=I10},
     test410(M10,J10,K10,L10).

test47(H8,I8,J8,K8,L8):-
     { Q8=I8, P8=H8, H8<I8},
     test46(Q8,J8,K8,L8).

test47(U8,V8,W8,X8,Y8):-
     { D9=V8, C9=U8, U8>=V8},
     test48(C9,W8,X8,Y8).

test48(H9,J9,K9,L9):-
     { P9=H9, M9=H9},
     test49(M9,J9,K9,L9).

test49(R9,W9,X9,Y9):-
     { Z9=R9},
     test45(Z9,W9,X9,Y9).