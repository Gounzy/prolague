% Initialisation des registres (variables locales)
p1(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV0 = 0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p2(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).			
 
p2(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV1 = 0, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p3(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
% if x < y then jump
p3(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{IV3 = IV4, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p9(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% else goto next instruction
p3(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{IV3 = IV4, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p4(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
% max_xy <- x
p4(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV1 = IV3, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p5(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
% if max_xy < z then jump
p5(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{IV1 < IV5, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p11(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
% else goto next instruction
p5(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{IV1 >= IV5, OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p7(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
% return max_xy
p7(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV0 = IV1, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p8(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
p8(IV0,IV1,IV2,IV3,IV4,IV5,IM,IM,IV0) :- {}.

% max_xy <- y
p9(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV1 = IV4, OV0 = IV0, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p10(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).

% retour au test max_xy < z
p10(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p5(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
% return z
p11(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV0 = IV5, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p12(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).
	
p12(IV0,IV1,IV2,IV3,IV4,IV5,IM,OM,R) :- 
	{OV0 = IV0, OV1 = IV1, OV2 = IV2, OV3 = IV3, OV4 = IV4, OV5 = IV5}, 
	p8(OV0,OV1,OV2,OV3,OV4,OV5,IM,OM,R).