p_start(S0, S1, R) :- {}, exposant(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1).

exposant(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1) :- {}, hornix1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1).
hornix1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1) :- {}, hornix2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, RET).
hornix2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2) :- {}, hornix3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, EBP).
hornix3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3) :- {TMP = ESP}, hornix4(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3).
hornix4(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3) :- {}, hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, NULL, NULL, NULL, NULL).
hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {S0 \= 0}, l1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {S0 = 0}, hornix6(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix6(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = 1}, hornix7(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix7(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, l3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).

l1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix8(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix8(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = 1}, hornix9(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, TMP, S5, S6, S7).
hornix9(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = 1}, hornix10(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, TMP, S6, S7).
hornix10(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, l2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).

l4(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix11(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix11(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S4}, hornix12(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix12(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = EAX * S1}, hornix13(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix13(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = EAX}, hornix14(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, TMP, S5, S6, S7).
hornix14(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S5 + 1}, hornix15(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, TMP, S6, S7).

l2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix15(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix15(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S5}, hornix16(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix16(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {EAX =< S0}, l4(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix16(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {EAX > S0}, hornix17(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix17(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S4}, hornix18(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).

l3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix18(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix18(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S7}, hornix19(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix19(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {R = EAX}.

main(EAX, EBX, ECX, EDX, EBP, ESP, R) :- {}, hornix20(EAX, EBX, ECX, EDX, EBP, ESP, R).
hornix20(EAX, EBX, ECX, EDX, EBP, ESP, R) :- {}, hornix21(EAX, EBX, ECX, EDX, EBP, ESP, R, EBP).
hornix21(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- {TMP = ESP}, hornix22(EAX, EBX, ECX, EDX, TMP, ESP, R, S0).
hornix22(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- {}, hornix23(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, NULL, NULL, NULL, NULL).
hornix23(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- {TMP = 3}, hornix24(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, TMP, S2, S3, S4).
hornix24(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- {TMP = 5}, hornix25(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, TMP, S3, S4).
hornix25(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- {}, hornix26(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S2).
hornix26(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5) :- {}, hornix27(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S1).
hornix27(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {}, exposant(EAX, EBX, ECX, EDX, EBP, ESP, TMP, S5, S6), hornix28(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix28(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = S6}, hornix29(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3, S4, S5).
hornix29(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5) :- {R = EAX}.
