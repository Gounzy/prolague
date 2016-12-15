p_start(S2, S3, R) :- {}, exposant(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3).

exposant(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3) :- {}, hornix1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3).
hornix1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3) :- {}, hornix2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, RET).
hornix2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4) :- {}, hornix3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, EBP).
hornix3(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5) :- {TMP = ESP}, hornix4(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3, S4, S5).
hornix4(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5) :- {}, hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, NULL, NULL).
hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {S2 > 0}, l1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix5(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {S2 =< 0}, hornix6(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix6(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = 1}, hornix7(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix7(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, l2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).

l1(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix8(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix8(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S2}, hornix9(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix9(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = EAX - 1}, hornix10(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix10(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix11(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, NULL, NULL).
hornix11(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9) :- {}, hornix12(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, EAX).
hornix12(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10) :- {}, hornix13(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S3).
hornix13(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11) :- {}, exposant(EAX, EBX, ECX, EDX, EBP, ESP, TMP, S8, S9, S10, S11), hornix14(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11).
hornix14(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11) :- {TMP = EAX * S3}, hornix15(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).

l2(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {}, hornix15(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7).
hornix15(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7) :- {TMP = S7}, hornix16(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3, S4, S5, S6).
hornix16(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {R = EAX}.

main(EAX, EBX, ECX, EDX, EBP, ESP, R) :- {}, hornix17(EAX, EBX, ECX, EDX, EBP, ESP, R).
hornix17(EAX, EBX, ECX, EDX, EBP, ESP, R) :- {}, hornix18(EAX, EBX, ECX, EDX, EBP, ESP, R, EBP).
hornix18(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- {TMP = ESP}, hornix19(EAX, EBX, ECX, EDX, TMP, ESP, R, S0).
hornix19(EAX, EBX, ECX, EDX, EBP, ESP, R, S0) :- {}, hornix20(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, ECX).
hornix20(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1) :- {}, hornix21(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, NULL, NULL, NULL, NULL, NULL).
hornix21(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = 3}, hornix22(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, TMP, S4, S5, S6).
hornix22(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {TMP = 2}, hornix23(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, TMP, S5, S6).
hornix23(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6) :- {}, hornix24(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, NULL, NULL).
hornix24(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8) :- {}, hornix25(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S4).
hornix25(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9) :- {}, hornix26(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S3).
hornix26(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10) :- {}, exposant(EAX, EBX, ECX, EDX, EBP, ESP, TMP, S7, S8, S9, S10), hornix27(TMP, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10).
hornix27(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10) :- {TMP = S1}, hornix28(EAX, EBX, TMP, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10).
hornix28(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10) :- {TMP = S10}, hornix29(EAX, EBX, ECX, EDX, TMP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9).
hornix29(EAX, EBX, ECX, EDX, EBP, ESP, R, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9) :- {R = EAX}.
