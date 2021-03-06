%
% 
%
%


p_start(IV3,IV4,IV5,R) :- {OV0 = 0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
    					px(OV0,OV1,OV2,OV3,OV4,OV5,R).
px(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV1 = 0, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p2(OV0,OV1,OV2,OV3,OV4,OV5,R).
p2(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {IV3 < IV4, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p9(OV0,OV1,OV2,OV3,OV4,OV5,R).
p2(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {IV3 >= IV4, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p4(OV0,OV1,OV2,OV3,OV4,OV5,R).
p4(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV1 = IV3, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p5(OV0,OV1,OV2,OV3,OV4,OV5,R).
p5(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {IV1 < IV5, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p11(OV0,OV1,OV2,OV3,OV4,OV5,R).
p5(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {IV1 >= IV5, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p7(OV0,OV1,OV2,OV3,OV4,OV5,R).
p7(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV0 = IV1, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p8(OV0,OV1,OV2,OV3,OV4,OV5,R).
p8(IV0,IV1,IV2,IV3,IV4,IV5,IV0) :- {}.
p9(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV1 = IV4, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p10(OV0,OV1,OV2,OV3,OV4,OV5,R).
p10(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p5(OV0,OV1,OV2,OV3,OV4,OV5,R).
p11(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV0 = IV5, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p12(OV0,OV1,OV2,OV3,OV4,OV5,R).
p12(IV0,IV1,IV2,IV3,IV4,IV5,R) :- {OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
					p8(OV0,OV1,OV2,OV3,OV4,OV5,R).

