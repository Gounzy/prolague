%--------------- 
% BUBBLESORT :
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
mergesort(G,E,H,F,E,F,G,H):-
     { F=<H, E=<G, G<H, E<F, F<G},
     true.

mergesort(G,F,H,E,E,F,G,H):-
     { E=<H, G<H, E=<F, F<G},
     true.

mergesort(F,E,H,G,E,F,G,H):-
     { E=<F, G<H, E<G, F=<G},
     true.

mergesort(G,G,H,E,E,G,G,H):-
     { E=<H, G<H, E=<G},
     true.

mergesort(H,E,G,F,E,F,G,H):-
     { F=<G, E=<H, G=<H, E<F, F<H},
     true.

mergesort(H,F,G,E,E,F,G,H):-
     { E=<G, G=<H, E=<F, F<H},
     true.

mergesort(F,E,H,H,E,F,H,H):-
     { E=<F, E<H, F=<H},
     true.

mergesort(H,H,G,E,E,H,G,H):-
     { E=<G, G=<H},
     true.

mergesort(E,G,H,F,E,F,G,H):-
     { F=<H, G<H, E<F, F<G},
     true.

mergesort(F,G,H,E,E,F,G,H):-
     { E=<H, F<G, G<H, E=<F},
     true.

mergesort(E,F,H,G,E,F,G,H):-
     { E<F, G<H, E<G, F=<G},
     true.

mergesort(E,H,G,F,E,F,G,H):-
     { F=<G, G=<H, E<F, F<H},
     true.

mergesort(F,H,G,E,E,F,G,H):-
     { E=<G, F<H, G=<H, E=<F},
     true.

mergesort(E,F,H,H,E,F,H,H):-
     { E<F, E<H, F=<H},
     true.

mergesort(G,E,F,H,E,F,G,H):-
     { E=<G, G<H, E<F, F<G},
     true.

mergesort(G,F,E,H,E,F,G,H):-
     { E<H, G<H, E=<F, F<G},
     true.

mergesort(F,E,G,H,E,F,G,H):-
     { G<H, E=<F, E<G, F=<G},
     true.

mergesort(G,G,E,H,E,G,G,H):-
     { E<H, G<H, E=<G},
     true.

mergesort(H,E,F,G,E,F,G,H):-
     { F<G, E=<H, G=<H, E<F, F<H},
     true.

mergesort(H,F,E,G,E,F,G,H):-
     { E<G, G=<H, E=<F, F<H},
     true.

mergesort(H,H,E,G,E,H,G,H):-
     { E<G, G=<H, E=<H},
     true.

mergesort(E,G,F,H,E,F,G,H):-
     { G<H, E<F, F<G},
     true.

mergesort(F,G,E,H,E,F,G,H):-
     { E<H, F<G, G<H, E=<F},
     true.

mergesort(E,F,G,H,E,F,G,H):-
     { G<H, E<F, E<G, F=<G},
     true.

mergesort(E,H,F,G,E,F,G,H):-
     { F<G, G=<H, E<F, F<H},
     true.

mergesort(F,H,E,G,E,F,G,H):-
     { E<G, F<H, G=<H, E=<F},
     true.