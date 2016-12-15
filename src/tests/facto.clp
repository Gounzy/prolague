% Program functions :
% factoSimple = l4
% main = l3

p_start(R):- p_start1(EAX, EBX, ECX, EDX, EBP, ESP, R).
p_start1(EAX, EBX, ECX, EDX, EBP, ESP, R) :- l3(EAX, EBX, ECX, EDX, EBP, ESP, R).

l4(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- hornix1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0).
hornix1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- hornix2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, RET).
hornix2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1) :- hornix3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, EBP).
hornix3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2) :- {TMP = ESP}, hornix4(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2).
hornix4(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2) :- hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, NULL, NULL, NULL, NULL).
hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = 1}, hornix6(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, TMP, S4, S5, S6).
hornix6(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = 1}, hornix7(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, TMP, S5, S6).
hornix7(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- l1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).

l2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- hornix8(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix8(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = S3}, hornix9(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix9(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = EAX * S4}, hornix10(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix10(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = EAX}, hornix11(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, TMP, S4, S5, S6).
hornix11(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = S4 + 1}, hornix12(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, TMP, S5, S6).

l1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- hornix12(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix12(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = S4}, hornix13(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix13(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {EAX =< S0}, l2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix13(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {EAX > S0}, hornix14(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix14(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = S3}, hornix15(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix15(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = S6}, hornix16(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3, S4, S5).
hornix16(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5) :- {R = EAX}.

l3(EAX, EBX, ECX, EDX, EBP, ESP, R) :- hornix17(EAX, EBX, ECX, EDX, EBP, ESP, R).
hornix17(EAX, EBX, ECX, EDX, EBP, ESP, R) :- hornix18(EAX, EBX, ECX, EDX, EBP, ESP, R, EBP).
hornix18(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- {TMP = ESP}, hornix19(EAX, EBX, ECX, EDX, TMP, ESP, R, S0).
hornix19(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- hornix20(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, NULL, NULL, NULL, NULL).
hornix20(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- {TMP = 5}, hornix21(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, TMP, S2, S3, S4).
hornix21(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- hornix22(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S1).
hornix22(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5) :- l4(EAX, EBX, ECX, EDX, EBP, ESP, TMP, S5), hornix23(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4).
hornix23(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- {TMP = S4}, hornix24(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3).
hornix24(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3) :- {R = EAX}.
