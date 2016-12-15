 --------------- 
 MAX 1 :
p_start(A,B):-
     { A=[], B=0},
     true.

p_start(A,B):-
     { B>F, A=[B|D], F=0, E=<B, D=[E|C], C=[]},
     true.

p_start(A,B):-
     { F>I, A=[F|G], I=0, H=<F, G=[H|E], D>F, E=[D|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { D>I, A=[D|G], I=0, H=<D, G=[H|E], F=<D, E=[F|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { E>F, A=[E|D], F=0, B>E, D=[B|C], C=[]},
     true.

p_start(A,B):-
     { H>I, A=[H|G], I=0, F>H, G=[F|E], D>F, E=[D|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { H>I, A=[H|G], I=0, D>H, G=[D|E], F=<D, E=[F|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { B>D, A=[B|C], D=0, C=[]},
     true.

p_start(A,B):-
     { F=<B, A=[F|D], B=0, E=<B, D=[E|C], C=[]},
     true.

p_start(A,B):-
     { I=<F, A=[I|G], F=0, H=<F, G=[H|E], D>F, E=[D|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { I=<D, A=[I|G], D=0, H=<D, G=[H|E], F=<D, E=[F|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { F=<E, A=[F|D], E=0, B>E, D=[B|C], C=[]},
     true.

p_start(A,B):-
     { I=<H, A=[I|G], H=0, F>H, G=[F|E], D>F, E=[D|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { I=<H, A=[I|G], H=0, D>H, G=[D|E], F=<D, E=[F|C]},
     lists_1(C,D,B).

p_start(A,B):-
     { D=<B, A=[D|C], B=0, C=[]},
     true.

lists_1(A,B,C):-
     { E=<B},
     lists_1(D,B,C).

lists_1(A,B,C):-
     { E>B},
     lists_1(D,E,C).

lists_1(A,B,C):-
     { B=C},
     true.


 --------------- 
 MAX 2 :
p_start(A,B):-
     { D=<B, A=[B|C], D=0, C=[]},
     true.

p_start(A,B):-
     { E=<B, A=[B|G], E>H, G=[H|F], D=<E, F=[E|C]},
     lists2_1(C,D).

p_start(A,B):-
     { D=<B, A=[B|G], D>H, G=[H|E], D>F, E=[F|C]},
     lists2_1(C,D).

p_start(A,B):-
     { H=<B, A=[B|G], F=<H, G=[H|E], D=<F, E=[F|C]},
     lists2_1(C,D).

p_start(A,B):-
     { H=<B, A=[B|G], D=<H, G=[H|E], D>F, E=[F|C]},
     lists2_1(C,D).

p_start(A,B):-
     { F=<B, A=[B|E], D=<F, E=[F|C], D=0, C=[]},
     true.

p_start(A,B):-
     { B>H, A=[H|F], B>G, F=[G|E], D=<B, E=[B|C]},
     lists2_1(C,D).

p_start(A,B):-
     { B>H, A=[H|F], B>G, F=[G|D], B>E, D=[E|C]},
     lists2_1(C,B).

p_start(A,B):-
     { B>H, A=[H|G], F=<B, G=[B|E], D=<F, E=[F|C]},
     lists2_1(C,D).

p_start(A,B):-
     { B>H, A=[H|G], D=<B, G=[B|E], D>F, E=[F|C]},
     lists2_1(C,D).

p_start(A,B):-
     { B>F, A=[F|E], D=<B, E=[B|C], D=0, C=[]},
     true.

p_start(A,B):-
     { B=0, A=[]},
     true.

lists2_1(A,B):-
     { B=0},
     true.

lists2_1(A,B):-
     { B>D},
     lists2_1(C,B).

lists2_1(A,B):-
     { D=<B},
     lists2_1(C,D).