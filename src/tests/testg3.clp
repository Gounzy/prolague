p_start(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {IHS = 0}, p1_2_0(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R).
p0_0_0(A,Z,E,R,T,IHS,OHS,Y) :- {OHS = IHS}.
readMemory(OBJECTREF,FIELD,VALUE) :- {}, object(OBJECTREF,FIELD,VALUE).
%writeMemory(OBJECTREF,FIELD,VALUE) :- {}, retract(object(OBJECTREF,FIELD,X)), assert(object(OBJECTREF,FIELD,VALUE)).
%writeMemory(OBJECTREF,FIELD,VALUE) :- {}, assert(object(OBJECTREF,FIELD,VALUE)).
%CLASSFILE:TEST_1
%METHOD:<init>()V
%   0: aload_0[42](1)
p1_0_0(IV0,IV1,NV0,NV1,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {SP_INDEX = 0,READ_INDEX_1 =0, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_0(READ_INDEX_1,IV0,IV1,READ_VALUE_1),
         write_0(WRITE_INDEX_1,IV0,IV1,OV0,OV1,WRITE_VALUE_1),
         p1_0_1(OV0,OV1,NV0,NV1,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   1: invokespecial[183](3) 1
p1_0_1(IV0,IV1,NV0,NV1,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {WRITE_VALUE_1=READ_VALUE_1
         ,READ_INDEX_1= SP_INDEX-0
         ,SP_INDEX_NEW = SP_INDEX -1},
         read_0(READ_INDEX_1,IV0,IV1,READ_VALUE_1)
,
         p0_0_0(WRITE_VALUE_1,_,IM,OM,SP_INDEX_CALL,IHS,OHS_CALL,R),
         p1_0_2(IV0,IV1,NV0,NV1,IM,OM,SP_INDEX_NEW,OHS_CALL,OHS,R).
%   4: return[177](1)
p1_0_2(IV0,IV1,NV0,NV1,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {IV0= NV0,IV1= NV1,OHS = IHS}.
%READ AND WRITE PREDICATES OF:<init>()V
read_0(SP,IV0,IV1,IV0) :- {SP = 0}.
read_0(SP,IV0,IV1,IV1) :- {SP = 1}.
write_0(SP,IV0,IV1,W0,W1,VAL) :- {SP = 0,W0=VAL,W1=IV1}.
write_0(SP,IV0,IV1,W0,W1,VAL) :- {SP = 1,W0=IV0,W1=VAL}.
%END OF METHOD:<init>()V
%METHOD:main([Ljava/lang/String;)V
%   0: return[177](1)
p1_1_0(IV0,NV0,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {IV0= NV0,OHS = IHS,SP_INDEX = 0}.
%READ AND WRITE PREDICATES OF:main([Ljava/lang/String;)V
read_1(SP,IV0,IV0) :- {SP = 0}.
write_1(SP,IV0,W0,VAL) :- {SP = 0,W0=VAL}.
%END OF METHOD:main([Ljava/lang/String;)V
%METHOD:gounzoum(III)I
%   0: iload_0[26](1)
p1_2_0(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {SP_INDEX = 2,READ_INDEX_1 =0, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,OV0,OV1,OV2,OV3,OV4,WRITE_VALUE_1),
         p1_2_1(OV0,OV1,OV2,OV3,OV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   1: iload_1[27](1)
p1_2_1(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 =1, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,OV0,OV1,OV2,OV3,OV4,WRITE_VALUE_1),
         p1_2_2(OV0,OV1,OV2,OV3,OV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   2: imul[104](1)
p1_2_2(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX, READ_INDEX_2 = SP_INDEX - 1, WRITE_VALUE_1 = READ_VALUE_2 * READ_VALUE_1, SP_INDEX_NEW = SP_INDEX -1, WRITE_INDEX_1 = SP_INDEX -1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,READ_VALUE_1),
         read_2(READ_INDEX_2,IV0,IV1,IV2,IV3,IV4,READ_VALUE_2),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,OV0,OV1,OV2,OV3,OV4,WRITE_VALUE_1),
         p1_2_3(OV0,OV1,OV2,OV3,OV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   3: iload_2[28](1)
p1_2_3(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 =2, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,OV0,OV1,OV2,OV3,OV4,WRITE_VALUE_1),
         p1_2_4(OV0,OV1,OV2,OV3,OV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   4: iadd[96](1)
p1_2_4(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX, READ_INDEX_2 = SP_INDEX - 1, WRITE_VALUE_1 = READ_VALUE_2 + READ_VALUE_1, SP_INDEX_NEW = SP_INDEX -1, WRITE_INDEX_1 = SP_INDEX -1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,READ_VALUE_1),
         read_2(READ_INDEX_2,IV0,IV1,IV2,IV3,IV4,READ_VALUE_2),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,OV0,OV1,OV2,OV3,OV4,WRITE_VALUE_1),
         p1_2_5(OV0,OV1,OV2,OV3,OV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   5: ireturn[172](1)
p1_2_5(IV0,IV1,IV2,IV3,IV4,NV0,NV1,NV2,NV3,NV4,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX, R = READ_VALUE_1,OHS = IHS},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,READ_VALUE_1).
%READ AND WRITE PREDICATES OF:gounzoum(III)I
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV0) :- {SP = 0}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV1) :- {SP = 1}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV2) :- {SP = 2}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV3) :- {SP = 3}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV4) :- {SP = 4}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,W0,W1,W2,W3,W4,VAL) :- {SP = 0,W0=VAL,W1=IV1,W2=IV2,W3=IV3,W4=IV4}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,W0,W1,W2,W3,W4,VAL) :- {SP = 1,W0=IV0,W1=VAL,W2=IV2,W3=IV3,W4=IV4}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,W0,W1,W2,W3,W4,VAL) :- {SP = 2,W0=IV0,W1=IV1,W2=VAL,W3=IV3,W4=IV4}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,W0,W1,W2,W3,W4,VAL) :- {SP = 3,W0=IV0,W1=IV1,W2=IV2,W3=VAL,W4=IV4}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,W0,W1,W2,W3,W4,VAL) :- {SP = 4,W0=IV0,W1=IV1,W2=IV2,W3=IV3,W4=VAL}.
%END OF METHOD:gounzoum(III)I



