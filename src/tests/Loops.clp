%% fexp1(II)I (idx = 0x243b) in class Lcom/algrecognition/loops/MainActivity; (idx = 0x46e)
%% 6 registers
% 0x0: move v1 v4 CEFGHI
p1(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {OV1 = IV4, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_1(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% 0x1: move v0 v5
p1_1(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {OV0 = IV5, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_2(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% 0x2: const/4 v2 0x1
p1_2(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {OV2 = 1, OV0 = IV0, OV1 = IV1, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_3(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% 0x3: if-gt v0 v2 0x6 (offset=0x3)
p1_3(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {IV0 > IV2, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_6(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).


p1_3(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {IV0 =< IV2, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_5(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% 0x5: return v1
p1_5(IV0,IV1,IV2,IV3,IV4,IV5,IM,IM,IV1) :- {}.
% 0x6: add-int/2addr v1 v4
p1_6(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {OV1 = IV1 + IV4, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_7(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% 0x7: add-int/lit8 v0 v0 0xff
p1_7(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {OV0 = IV0 + -1, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_9(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% 0x9: goto 0x2 (offset=0xf9)
p1_9(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- {OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, p1_2(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).

%% fexp2(II)I (idx = 0x243c) in class Lcom/algrecognition/loops/MainActivity; (idx = 0x46e)
%% 5 registers
% 0x0: const/4 v1 0x1
p2_0(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {OV1 = 1, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_1(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
% 0x1: move v0 v4
p2_1(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {OV0 = IV4, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_2(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
% 0x2: if-gtz v0 0x5 (offset=0x3)
p2_2(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {IV0 > 0, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_5(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
p2_2(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {IV0 =< 0, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_4(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
% 0x4: return v1
p2_4(IV0,IV1,IV2,IV3,IV4,IM,IM,IV1) :- {}.
% 0x5: add-int/2addr v1 v3
p2_5(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {OV1 = IV1 + IV3, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_6(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
% 0x6: add-int/lit8 v0 v0 0xff
p2_6(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {OV0 = IV0 + -1, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_8(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
% 0x8: goto 0x2 (offset=0xfa)
p2_8(IV0,IV1,IV2,IV3,IV4,IM,OM,R) :- {OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4}, p2_2(OV0,OV1,OV2,OV3,OV4,IM,OM,R).
