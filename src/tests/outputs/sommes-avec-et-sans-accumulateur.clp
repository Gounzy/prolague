 --------------- 
 SUM 1 :
p_start([],A):-
     { A=0},
     true.

p_start([A|B],C):-
     { C=A+D, A4=0, []=B, A4=D},
     true.

p_start([A|B],C):-
     { C=A+D, Y3=W3+Z3, [W3|X3]=B, Y3=D},
     p_start(X3,Z3).


 --------------- 
 SUM 2 :
p_start(A,B):-
     { []=A, B4=0, B4=B},
     true.

p_start(A,B):-
     { A4=Y3+W3, [W3|X3]=A, Y3=0, Z3=B, G4=E4+C4, [C4|D4]=X3, E4=A4, F4=Z3, []=D4, N4=G4, N4=F4},
     true.

p_start(A,B):-
     { A4=Y3+W3, [W3|X3]=A, Y3=0, Z3=B, G4=E4+C4, [C4|D4]=X3, E4=A4, F4=Z3, M4=K4+I4, [I4|J4]=D4, K4=G4, L4=F4},
     lists2_1(J4,M4,L4).

p_start(A,B):-
     { A4=Y3+W3, [W3|X3]=A, Y3=0, Z3=B, []=X3, H4=A4, H4=Z3},
     true.

lists2_1([A|B],C,D):-
     { E=C+A},
     lists2_1(B,E,D).

lists2_1([],A,A):-
     { },
     true.