p_start(IV0,IV1,R) :-
         {IHS = 0},
         p1_2_0(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R).
p_startD(IV0,IV1,NV0,NV1,R) :-
         {IHS = 0},
         p1_2_0(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R).
p0_0_0(A,0,0,0,0,IHS,OHS,0) :- {OHS = IHS}.
readMemory(OBJECTREF,FIELD,VALUE) :- {}, object(OBJECTREF,FIELD,VALUE).
readMemory(_,_,0) :- {}.
writeMemory(OBJECTREF,FIELD,VALUE) :- {}, retract(object(OBJECTREF,FIELD,X)), assert(object(OBJECTREF,FIELD,VALUE)).
writeMemory(OBJECTREF,FIELD,VALUE) :- {}, assert(object(OBJECTREF,FIELD,VALUE)).
%CLASSFILE:EXP
%METHOD:<init>()V
%   0: aload_0[42](1)
p1_0_0(IV0,IV1,NV0,NV1,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {SP_INDEX = 0,IV1 = 0,IM=0,OM=0,R=0,READ_INDEX_1 =0, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
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
         p0_0_0(WRITE_VALUE_1,_,IM,OM,SP_INDEX_CALL,IHS,OHS_CALL,R_NEW),
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
         {IV0= NV0,OHS = IHS,SP_INDEX = 0,IV0 = 0,IM=0,OM=0,R=0}.
%READ AND WRITE PREDICATES OF:main([Ljava/lang/String;)V
read_1(SP,IV0,IV0) :- {SP = 0}.
write_1(SP,IV0,W0,VAL) :- {SP = 0,W0=VAL}.
%END OF METHOD:main([Ljava/lang/String;)V
%METHOD:exponent(II)I
%   0: iload_1[27](1)
p1_2_0(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {SP_INDEX = 1,IV2 = 0,IV3 = 0,IV4 = 0,IV5 = 0,IM=0,OM=0,READ_INDEX_1 =1, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_1(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   1: ifne[154](3) -> 6
p1_2_1(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX,SP_INDEX_NEW = SP_INDEX -1,READ_VALUE_1 = 0},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         p1_2_2(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
p1_2_1(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX,SP_INDEX_NEW = SP_INDEX -1,READ_VALUE_1 \= 0},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         p1_2_4(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   4: iconst_1[4](1)
p1_2_2(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {WRITE_VALUE_1 = 1,SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_3(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   5: ireturn[172](1)
p1_2_3(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {IV0= NV0,IV1= NV1,IV2= NV2,IV3= NV3,IV4= NV4,IV5= NV5,READ_INDEX_1 = SP_INDEX, R = READ_VALUE_1,OHS = IHS},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1).
%   6: iload_0[26](1)
p1_2_4(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 =0, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_5(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   7: iload_0[26](1)
p1_2_5(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 =0, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_6(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   8: iload_1[27](1)
p1_2_6(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 =1, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_7(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%   9: iconst_1[4](1)
p1_2_7(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {WRITE_VALUE_1 = 1,SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_8(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%  10: isub[100](1)
p1_2_8(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX, READ_INDEX_2 = SP_INDEX - 1, WRITE_VALUE_1 = READ_VALUE_2 - READ_VALUE_1, SP_INDEX_NEW = SP_INDEX -1, WRITE_INDEX_1 = SP_INDEX -1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         read_2(READ_INDEX_2,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_2),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_9(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%  11: invokestatic[184](3) 2
p1_2_9(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {WRITE_VALUE_1=READ_VALUE_1,WRITE_VALUE_2=READ_VALUE_2,WRITE_VALUE_3=0,WRITE_VALUE_4=0,WRITE_VALUE_5=0,WRITE_VALUE_6=0
         ,READ_INDEX_1= SP_INDEX-1,READ_INDEX_2= SP_INDEX-0
         ,SP_INDEX_NEW = SP_INDEX -1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         read_2(READ_INDEX_2,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_2)
,
         p1_2_0(WRITE_VALUE_1,WRITE_VALUE_2,WRITE_VALUE_3,WRITE_VALUE_4,WRITE_VALUE_5,WRITE_VALUE_6,_,_,_,_,_,_,IM,OM,SP_INDEX_CALL,IHS,OHS_CALL,R_NEW),
         write_2(SP_INDEX_NEW,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,R_NEW),
         p1_2_10(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,OHS_CALL,OHS,R).
%  14: imul[104](1)
p1_2_10(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX, READ_INDEX_2 = SP_INDEX - 1, WRITE_VALUE_1 = READ_VALUE_2 * READ_VALUE_1, SP_INDEX_NEW = SP_INDEX -1, WRITE_INDEX_1 = SP_INDEX -1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         read_2(READ_INDEX_2,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_2),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_11(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%  15: istore_0[59](1)
p1_2_11(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 = SP_INDEX,WRITE_VALUE_1 = READ_VALUE_1 ,WRITE_INDEX_1 = 0, SP_INDEX_NEW = SP_INDEX -1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_12(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%  16: iload_0[26](1)
p1_2_12(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {READ_INDEX_1 =0, WRITE_VALUE_1 = READ_VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX_1 = SP_INDEX + 1},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1),
         write_2(WRITE_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,OV0,OV1,OV2,OV3,OV4,OV5,WRITE_VALUE_1),
         p1_2_13(OV0,OV1,OV2,OV3,OV4,OV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX_NEW,IHS,OHS,R).
%  17: ireturn[172](1)
p1_2_13(IV0,IV1,IV2,IV3,IV4,IV5,NV0,NV1,NV2,NV3,NV4,NV5,IM,OM,SP_INDEX,IHS,OHS,R) :-
         {IV0= NV0,IV1= NV1,IV2= NV2,IV3= NV3,IV4= NV4,IV5= NV5,READ_INDEX_1 = SP_INDEX, R = READ_VALUE_1,OHS = IHS},
         read_2(READ_INDEX_1,IV0,IV1,IV2,IV3,IV4,IV5,READ_VALUE_1).
%READ AND WRITE PREDICATES OF:exponent(II)I
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV0) :- {SP = 0}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV1) :- {SP = 1}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV2) :- {SP = 2}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV3) :- {SP = 3}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV4) :- {SP = 4}.
read_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV5) :- {SP = 5}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 0,W0=VAL,W1=IV1,W2=IV2,W3=IV3,W4=IV4,W5=IV5}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 1,W0=IV0,W1=VAL,W2=IV2,W3=IV3,W4=IV4,W5=IV5}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 2,W0=IV0,W1=IV1,W2=VAL,W3=IV3,W4=IV4,W5=IV5}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 3,W0=IV0,W1=IV1,W2=IV2,W3=VAL,W4=IV4,W5=IV5}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 4,W0=IV0,W1=IV1,W2=IV2,W3=IV3,W4=VAL,W5=IV5}.
write_2(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 5,W0=IV0,W1=IV1,W2=IV2,W3=IV3,W4=IV4,W5=VAL}.
%END OF METHOD:exponent(II)I



