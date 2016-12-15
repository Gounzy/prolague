 %--------------- 
 %BUBBLESORT :
p_start(E,F,G,H,E,F,G,H):-
     { F=<G, E=<F, G=<H},
     true.

p_start(F,E,G,H,E,F,G,H):-
     { F=<G, G=<H, F>E},
     true.

p_start(E,G,F,H,E,F,G,H):-
     { E=<F, G=<H, G>F},
     true.

p_start(G,E,F,H,E,F,G,H):-
     { E=<F, G=<H, G>F, G>E},
     true.

p_start(E,F,H,G,E,F,G,H):-
     { F=<G, E=<F, H>G, F=<H},
     true.

p_start(F,E,H,G,E,F,G,H):-
     { F=<G, H>G, F=<H, F>E},
     true.

p_start(E,H,F,G,E,F,G,H):-
     { F=<G, E=<F, H>G, H>F, E=<H},
     true.

p_start(H,E,F,G,E,F,G,H):-
     { F=<G, E=<F, H>G, H>F, H>E},
     true.

p_start(F,G,E,H,E,F,G,H):-
     { F=<G, F>E, G=<H, G>E},
     true.

p_start(G,F,E,H,E,F,G,H):-
     { F>E, G=<H, G>F},
     true.

p_start(F,H,E,G,E,F,G,H):-
     { F=<G, F>E, H>G, H>E, F=<H},
     true.

p_start(H,F,E,G,E,F,G,H):-
     { F=<G, F>E, H>G, H>F},
     true.

p_start(E,G,H,F,E,F,G,H):-
     { G>F, E=<G, H>F, G=<H, E=<F},
     true.

p_start(F,G,H,E,E,F,G,H):-
     { G>E, F=<G, H>E, G=<H, F>E},
     true.

p_start(G,E,H,F,E,F,G,H):-
     { G>F, H>F, G=<H, E=<F, G>E},
     true.

p_start(G,F,H,E,E,F,G,H):-
     { H>E, G=<H, F>E, G>F},
     true.

p_start(E,H,G,F,E,F,G,H):-
     { G>F, E=<G, H>G, E=<F, E=<H},
     true.

p_start(F,H,G,E,E,F,G,H):-
     { G>E, F=<G, H>G, F>E, F=<H},
     true.

p_start(H,E,G,F,E,F,G,H):-
     { G>F, E=<G, H>G, E=<F, H>E},
     true.

p_start(H,F,G,E,E,F,G,H):-
     { G>E, F=<G, H>G, F>E, H>F},
     true.

p_start(G,H,E,F,E,F,G,H):-
     { G>F, G>E, H>F, H>E, E=<F, G=<H},
     true.

p_start(G,H,F,E,E,F,G,H):-
     { G>F, H>F, F>E, G=<H},
     true.

p_start(H,G,E,F,E,F,G,H):-
     { G>F, G>E, E=<F, H>G},
     true.

p_start(H,G,F,E,E,F,G,H):-
     { G>F, F>E, H>G},
     true.


 % --------------- 
 % MERGESORT :
p_start2(G,F,H,E,E,F,G,H):-
     { E=<H, G<H, E=<F, F<G},
     true.

p_start2(G,G,H,E,E,G,G,H):-
     { E=<H, G<H, E=<G},
     true.

p_start2(H,F,G,E,E,F,G,H):-
     { E=<G, G=<H, E=<F, F<H},
     true.

p_start2(H,H,G,E,E,H,G,H):-
     { E=<G, G=<H},
     true.

p_start2(F,G,H,E,E,F,G,H):-
     { E=<H, F<G, G<H, E=<F},
     true.

p_start2(F,H,G,E,E,F,G,H):-
     { E=<G, F<H, G=<H, E=<F},
     true.

p_start2(G,F,E,H,E,F,G,H):-
     { E<H, G<H, E=<F, F<G},
     true.

p_start2(G,G,E,H,E,G,G,H):-
     { E<H, G<H, E=<G},
     true.

p_start2(H,F,E,G,E,F,G,H):-
     { E<G, G=<H, E=<F, F<H},
     true.

p_start2(H,H,E,G,E,H,G,H):-
     { E<G, G=<H, E=<H},
     true.

p_start2(F,G,E,H,E,F,G,H):-
     { E<H, F<G, G<H, E=<F},
     true.

p_start2(F,H,E,G,E,F,G,H):-
     { E<G, F<H, G=<H, E=<F},
     true.

p_start2(G,E,H,F,E,F,G,H):-
     { F=<H, E=<G, G<H, E<F, F<G},
     true.

p_start2(G,F,H,F,F,F,G,H):-
     { F=<H, G<H, F<G},
     true.

p_start2(F,E,H,G,E,F,G,H):-
     { E=<F, G<H, E<G, F=<G},
     true.

p_start2(G,G,H,G,G,G,G,H):-
     { G<H},
     true.

p_start2(H,E,G,F,E,F,G,H):-
     { F=<G, E=<H, G=<H, E<F, F<H},
     true.

p_start2(H,F,G,F,F,F,G,H):-
     { F=<G, G=<H, F<H},
     true.

p_start2(F,E,H,H,E,F,H,H):-
     { E=<F, E<H, F=<H},
     true.

p_start2(H,H,H,H,H,H,H,H):-
     { },
     true.

p_start2(E,G,H,F,E,F,G,H):-
     { F=<H, G<H, E<F, F<G},
     true.

p_start2(F,G,H,F,F,F,G,H):-
     { F=<H, F<G, G<H},
     true.

p_start2(E,F,H,G,E,F,G,H):-
     { E<F, G<H, E<G, F=<G},
     true.

p_start2(E,H,G,F,E,F,G,H):-
     { F=<G, G=<H, E<F, F<H},
     true.

p_start2(F,H,G,F,F,F,G,H):-
     { F=<G, F<H, G=<H},
     true.

p_start2(E,F,H,H,E,F,H,H):-
     { E<F, E<H, F=<H},
     true.

p_start2(G,E,F,H,E,F,G,H):-
     { E=<G, G<H, E<F, F<G},
     true.

p_start2(G,F,F,H,F,F,G,H):-
     { G<H, F<G},
     true.

p_start2(F,E,G,H,E,F,G,H):-
     { G<H, E=<F, E<G, F=<G},
     true.

p_start2(G,G,G,H,G,G,G,H):-
     { G<H},
     true.

p_start2(H,E,F,G,E,F,G,H):-
     { F<G, E=<H, G=<H, E<F, F<H},
     true.

p_start2(H,F,F,G,F,F,G,H):-
     { F<G, G=<H, F<H},
     true.

p_start2(E,G,F,H,E,F,G,H):-
     { G<H, E<F, F<G},
     true.

p_start2(F,G,F,H,F,F,G,H):-
     { F<G, G<H},
     true.

p_start2(E,F,G,H,E,F,G,H):-
     { G<H, E<F, E<G, F=<G},
     true.

p_start2(E,H,F,G,E,F,G,H):-
     { F<G, G=<H, E<F, F<H},
     true.

p_start2(F,H,F,G,F,F,G,H):-
     { F<G, F<H, G=<H},
     true.