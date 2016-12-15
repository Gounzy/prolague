%METHOD:main([Ljava/lang/String;)V
%   0: iconst_5[8](1)
p1_1_0(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{VALUE = 5,SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX = SP_INDEX + 1},
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_1(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R).
%   1: istore_1[60](1)
p1_1_1(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{INDEX_1 = SP_INDEX,VALUE = VALUE_1 ,WRITE_INDEX = 1},
read_1(INDEX_1,IV1,IV2,IV3,IV4,IV5,VALUE_1),
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_2(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R).
%   2: bipush[16](2) 10
p1_1_2(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{VALUE = 10,SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX = SP_INDEX + 1},
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_3(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R).
%   4: istore_2[61](1)
p1_1_3(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{INDEX_1 = SP_INDEX,VALUE = VALUE_1 ,WRITE_INDEX = 2},
read_1(INDEX_1,IV1,IV2,IV3,IV4,IV5,VALUE_1),
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_4(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R).
%   5: iload_1[27](1)
p1_1_4(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{INDEX_1 =1, VALUE = VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX = SP_INDEX + 1},
read_1(INDEX_1,IV1,IV2,IV3,IV4,IV5,VALUE_1),
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_5(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R). 
%   6: iload_2[28](1)
p1_1_5(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{INDEX_1 =2, VALUE = VALUE_1, SP_INDEX_NEW = SP_INDEX + 1, WRITE_INDEX = SP_INDEX + 1},
read_1(INDEX_1,IV1,IV2,IV3,IV4,IV5,VALUE_1),
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_6(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R) .
%   7: iadd[96](1)
p1_1_6(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{INDEX_1 = SP_INDEX, INDEX_2 = SP_INDEX - 1, VALUE = VALUE_1 + VALUE_2, SP_INDEX_NEW = SP_INDEX -1, WRITE_INDEX = SP_INDEX -1},
read_1(INDEX_1,IV1,IV2,IV3,IV4,IV5,VALUE_1),
read_1(INDEX_2,IV1,IV2,IV3,IV4,IV5,VALUE_2),
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_7(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R) .
%   8: istore_3[62](1)
p1_1_7(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{INDEX_1 = SP_INDEX,VALUE = VALUE_1 ,WRITE_INDEX = 3},
read_1(INDEX_1,IV1,IV2,IV3,IV4,IV5,VALUE_1),
write_1(WRITE_INDEX,IV1,IV2,IV3,IV4,IV5,W1,W2,W3,W4,W5,VALUE),
p1_1_8(W0,W1,W2,W3,W4,W5,IM,OM,SP_INDEX_NEW,R) .
%   9: return[177](1)
p1_1_8(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,SP_INDEX,R) :-
{}.

%READ AND WRITE PREDICATES OF:main([Ljava/lang/String;)V
read_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV0) :- {SP = 0}.
read_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV1) :- {SP = 1}.
read_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV2) :- {SP = 2}.
read_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV3) :- {SP = 3}.
read_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV4) :- {SP = 4}.
read_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,IV5) :- {SP = 5}.
write_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 0,W0=VAL,W1=IV1,W2=IV2,W3=IV3,W4=IV4,W5=IV5}.
write_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 1,W0=IV0,W1=VAL,W2=IV2,W3=IV3,W4=IV4,W5=IV5}.
write_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 2,W0=IV0,W1=IV1,W2=VAL,W3=IV3,W4=IV4,W5=IV5}.
write_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 3,W0=IV0,W1=IV1,W2=IV2,W3=VAL,W4=IV4,W5=IV5}.
write_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 4,W0=IV0,W1=IV1,W2=IV2,W3=IV3,W4=VAL,W5=IV5}.
write_1(SP,IV0,IV1,IV2,IV3,IV4,IV5,W0,W1,W2,W3,W4,W5,VAL) :- {SP = 5,W0=IV0,W1=IV1,W2=IV2,W3=IV3,W4=IV4,W5=VAL}.
%END OF METHOD:main([Ljava/lang/String;)V



