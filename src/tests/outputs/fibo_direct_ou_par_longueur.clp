% APRES QUELQUES UNFOLDINGS
  --------------- 
 FIBO 1 :
p_start(A):-
     { C4=[F4|G4], unify(G4,J4), F4=B4+Y3, B4=1, A4=0, B=[Y3|Z3], unify(Z3,C4), Y3=A4+B4, unify(A,B)},
     listfibo_1(J4,Y3,F4).

p_start(A):-
     { C4=[], B4=1, A4=0, B=[Y3|Z3], unify(Z3,C4), Y3=A4+B4, unify(A,B)},
     true.

p_start(A):-
     { B=[], unify(A,B)},
     true.

listfibo_1([A|B],C,D):-
     { unify(B,E), A=C+D},
     listfibo_1(E,D,A).

 --------------- 
 FIBO 2 :
p_start(A):-
     { B=[], A=[], unify(A,B)},
     true.

p_start(A):-
     { J4=[O4|P4], S4=M4+1, B=[], B4=1, B4>C, K4=0, A=[I4|J4], M4=K4+1, unify(A,B)},
     listfibo2_3(P4,S4,C).

p_start(A):-
     { J4=[], B=[], A=[I4|J4], unify(A,B)},
     true.

p_start(A):-
     { E4=1, F4=[], B=[E4|F4], A=[], unify(A,B)},
     true.

p_start(A):-
     { E4=1, F4=[], B=[E4|F4], A=[], unify(A,B)},
     true.

p_start(A):-
     { E4=1, F4=[], J4=[], B=[E4|F4], A=[I4|J4], unify(A,B)},
     true.

p_start(A):-
     { E4=1, F4=[], J4=[], B=[E4|F4], A=[I4|J4], unify(A,B)},
     true.

p_start(A):-
     { E4=1, F4=[], G4>C, J4=[H5|I5], L5=M4+1, B=[E4|F4], D4=1, G4=D4+1, D4=<C, K4=0, A=[I4|J4], M4=K4+1, unify(A,B)},
     listfibo2_3(I5,L5,C).

p_start(A):-
     { E4=1, F4=[W5|X5], Y5=G4+1, G4=<C, J4=[H5|I5], L5=M4+1, B=[E4|F4], D4=1, G4=D4+1, D4=<C, K4=0, A=[I4|J4], M4=K4+1, unify(A,B)},
     listfibo2_3(I5,L5,C), listfibo2_5(G4,W5), listfibo2_4(C,Y5,X5).

listfibo2_3([],A,A):-
     { },
     true.

listfibo2_3([A|B],C,D):-
     { E=C+1},
     listfibo2_3(B,E,D).

listfibo2_4(A,B,[]):-
     { B>A},
     true.

listfibo2_4(A,B,[C|D]):-
     { E=B+1, B=<A},
     listfibo2_5(B,C), listfibo2_4(A,E,D).

listfibo2_5(1,1):-
     { },
     true.

listfibo2_5(A,B):-
     { D=A-2, C=A-1, A>1},
     listfibo2_5(C,E), listfibo2_5(D,F), listfibo2_6(E,F,B).

listfibo2_6(A,B,C):-
     { C=A+B},
     true.