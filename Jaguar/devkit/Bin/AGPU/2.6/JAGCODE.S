;GCC for Atari Jaguar GPU/DSP (Jun 12 1995) (C)1994-95 Brainstorm
	MACRO	_RTS
	load	(ST),TMP
	jump	T,(TMP)
	addqt	#4,ST	;rts
	ENDM
_jagcode_start::
	.GPU
	.ORG	$F03000
ST	.REGEQU	r18
FP	.REGEQU	r17
TMP	.REGEQU	r16
GT	.CCDEF	$15
gcc2_compiled_for_madmac:
	;(.DATA)
	.LONG
_byte_line::
	.DC.L	320
	;(.TEXT)
	.EVEN
_start::
	subqt	#4,ST
	store	FP,(ST)
	move	ST,FP	;link
	subqt	#4,ST
	store	r19,(ST)
	movei	#_video_buffer,r0	;movsi	#_video_buffer->r0
	movei	#1703936,r5	;movsi	#1703936->r5
	store	r5,(r0)	;movsi	r5->(r0)
	moveta	ST,R0	;movsi	ST->R0
	movei	#64,r0	;movsi	#64->r0
	movei	#67,r1	;movsi	#67->r1
	movei	#65,r2	;movsi	#65->r2
	movei	#66,r3	;movsi	#66->r3
	movei	#69,r4	;movsi	#69->r4
	movei	#_Box,r19	;movsi	#_Box->r19
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r19)
	store	TMP,(ST)	;call	r19
	moveta	ST,R0	;movsi	ST->R0
	movei	#128,r0	;movsi	#128->r0
	movei	#119,r1	;movsi	#119->r1
	moveq	#31,r2	;movsi	#31->r2
	addqt	#19,r2	;iaddqtsi3	#19+r2->r2
	movei	#77,r3	;movsi	#77->r3
	movei	#_Draw_Circle,r19	;movsi	#_Draw_Circle->r19
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r19)
	store	TMP,(ST)	;call	r19
	moveta	ST,R0	;movsi	ST->R0
	movei	#64,r0	;movsi	#64->r0
	movei	#64,r1	;movsi	#64->r1
	movei	#319,r2	;movsi	#319->r2
	movei	#239,r3	;movsi	#239->r3
	movei	#-124,r4	;movsi	#-124->r4
	movei	#_Draw_Line,r19	;movsi	#_Draw_Line->r19
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r19)
	store	TMP,(ST)	;call	r19
	moveta	ST,R0	;movsi	ST->R0
	movei	#120,r0	;movsi	#120->r0
	movei	#130,r1	;movsi	#130->r1
	movei	#104,r2	;movsi	#104->r2
	movei	#_Plot_Pixel_Fast,r19	;movsi	#_Plot_Pixel_Fast->r19
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r19)
	store	TMP,(ST)	;call	r19
L1:
	load	(ST),r19
	move	FP,ST
	load	(ST),FP
	addqt	#4,ST	;unlk
	_RTS
	.EVEN
_Box::
	subqt	#4,ST
	store	FP,(ST)
	move	ST,FP	;link
	movei	#132,TMP
	sub	TMP,ST
	move	ST,r14
	store	r19,(ST)
	store	r20,(r14+1)
	store	r21,(r14+2)
	store	r22,(r14+3)
	store	r23,(r14+4)
	store	r24,(r14+5)
	store	r25,(r14+6)
	store	r26,(r14+7)
	store	r27,(r14+8)
	store	r28,(r14+9)
	store	r29,(r14+10)
	move	FP,r19	;movsi	FP->r19
	move	FP,r20	;movsi	FP->r20
	subqt	#4,r20	;isubqtsi3	r20-#4->r20
	move	r20,r21	;movsi	r20->r21
	store	r0,(r21)	;movsi	r0->(r21)
	move	FP,r22	;movsi	FP->r22
	move	FP,r23	;movsi	FP->r23
	subqt	#8,r23	;isubqtsi3	r23-#8->r23
	move	r23,r24	;movsi	r23->r24
	store	r1,(r24)	;movsi	r1->(r24)
	move	FP,r25	;movsi	FP->r25
	move	FP,r26	;movsi	FP->r26
	subqt	#12,r26	;isubqtsi3	r26-#12->r26
	move	r26,r27	;movsi	r26->r27
	store	r2,(r27)	;movsi	r2->(r27)
	move	FP,r28	;movsi	FP->r28
	move	FP,r29	;movsi	FP->r29
	subqt	#16,r29	;isubqtsi3	r29-#16->r29
	moveq	#0,r6	;movsi	#0->r6
	subqt	#28,r6	;iaddqtsi3	#-28+r6->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r29,(r6)	;movsi	r29->(r6)
	moveq	#0,r5	;movsi	#0->r5
	subqt	#28,r5	;iaddqtsi3	#-28+r5->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r6	;movsi	(r5)->r6
	store	r3,(r6)	;movsi	r3->(r6)
	movei	#-36,r5	;movsi	#-36->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	FP,(r5)	;movsi	FP->(r5)
	move	FP,r5	;movsi	FP->r5
	subqt	#20,r5	;isubqtsi3	r5-#20->r5
	movei	#-44,r6	;movsi	#-44->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-44,r6	;movsi	#-44->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r5	;movsi	(r6)->r5
	movei	#-52,r6	;movsi	#-52->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-52,r6	;movsi	#-52->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r5	;movsi	(r6)->r5
	store	r4,(r5)	;movsi	r4->(r5)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r6	;movsi	(r2)->r6
	store	r6,(r0)	;movsi	r6->(r0)
L3:
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	addqt	#1,r1	;iaddqtsi3	#1+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#12,r2	;isubqtsi3	r2-#12->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	load	(r0),r0	;movsi	(r0)->r0
	cmp	r1,r0	;cmpsi	r1,r0
	movei	#L6,TMP
	jump	MI,(TMP)
	nop		;jlt	L6
	movei	#L4,TMP
	jump	T,(TMP)
	nop		;jt	L4
	.EVEN
L6:
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r1),r1	;movsi	(r1)->r1
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r6	;movsi	#_Plot_Pixel_Fast->r6
	movei	#-60,r5	;movsi	#-60->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	r6,(r5)	;movsi	r6->(r5)
	movei	#-60,r5	;movsi	#-60->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r5	;movsi	(r5)->r5
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r5)
	store	TMP,(ST)	;call	r5
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#16,r2	;isubqtsi3	r2-#16->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r5	;movsi	#_Plot_Pixel_Fast->r5
	movei	#-68,r6	;movsi	#-68->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-68,r6	;movsi	#-68->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
L5:
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r0	;movsi	FP->r0
	subqt	#24,r0	;isubqtsi3	r0-#24->r0
	moveta	r0,R0	;movsi	r0->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	addqt	#1,r1	;iaddqtsi3	#1+r1->r1
	move	r1,r2	;movsi	r1->r2
	store	r2,(r0)	;movsi	r2->(r0)
	movei	#L3,TMP
	jump	T,(TMP)
	nop		;jt	L3
	.EVEN
L4:
	nop
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#8,r1	;isubqtsi3	r1-#8->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r5	;movsi	(r2)->r5
	store	r5,(r0)	;movsi	r5->(r0)
L7:
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#8,r1	;isubqtsi3	r1-#8->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	addqt	#1,r1	;iaddqtsi3	#1+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#16,r2	;isubqtsi3	r2-#16->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	load	(r0),r0	;movsi	(r0)->r0
	cmp	r1,r0	;cmpsi	r1,r0
	movei	#L10,TMP
	jump	MI,(TMP)
	nop		;jlt	L10
	movei	#L8,TMP
	jump	T,(TMP)
	nop		;jt	L8
	.EVEN
L10:
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#24,r2	;isubqtsi3	r2-#24->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r1),r1	;movsi	(r1)->r1
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r5	;movsi	#_Plot_Pixel_Fast->r5
	movei	#-76,r6	;movsi	#-76->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-76,r6	;movsi	#-76->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r2	;movsi	r1->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#24,r2	;isubqtsi3	r2-#24->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r1),r1	;movsi	(r1)->r1
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r6	;movsi	#_Plot_Pixel_Fast->r6
	movei	#-84,r5	;movsi	#-84->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	r6,(r5)	;movsi	r6->(r5)
	movei	#-84,r5	;movsi	#-84->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r5	;movsi	(r5)->r5
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r5)
	store	TMP,(ST)	;call	r5
L9:
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r0	;movsi	FP->r0
	subqt	#24,r0	;isubqtsi3	r0-#24->r0
	moveta	r0,R0	;movsi	r0->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	addqt	#1,r1	;iaddqtsi3	#1+r1->r1
	move	r1,r2	;movsi	r1->r2
	store	r2,(r0)	;movsi	r2->(r0)
	movei	#L7,TMP
	jump	T,(TMP)
	nop		;jt	L7
	.EVEN
L8:
L2:
	move	ST,r14
	load	(ST),r19
	load	(r14+1),r20
	load	(r14+2),r21
	load	(r14+3),r22
	load	(r14+4),r23
	load	(r14+5),r24
	load	(r14+6),r25
	load	(r14+7),r26
	load	(r14+8),r27
	load	(r14+9),r28
	load	(r14+10),r29
	move	FP,ST
	load	(ST),FP
	addqt	#4,ST	;unlk
	_RTS
	.EVEN
_Draw_Circle::
	subqt	#4,ST
	store	FP,(ST)
	move	ST,FP	;link
	movei	#100,TMP
	sub	TMP,ST
	move	ST,r14
	store	r19,(ST)
	store	r20,(r14+1)
	store	r21,(r14+2)
	store	r22,(r14+3)
	store	r23,(r14+4)
	store	r24,(r14+5)
	store	r25,(r14+6)
	store	r26,(r14+7)
	store	r27,(r14+8)
	store	r28,(r14+9)
	store	r29,(r14+10)
	move	FP,r19	;movsi	FP->r19
	move	FP,r20	;movsi	FP->r20
	subqt	#4,r20	;isubqtsi3	r20-#4->r20
	move	r20,r21	;movsi	r20->r21
	store	r0,(r21)	;movsi	r0->(r21)
	move	FP,r22	;movsi	FP->r22
	move	FP,r23	;movsi	FP->r23
	subqt	#8,r23	;isubqtsi3	r23-#8->r23
	move	r23,r24	;movsi	r23->r24
	store	r1,(r24)	;movsi	r1->(r24)
	move	FP,r25	;movsi	FP->r25
	move	FP,r26	;movsi	FP->r26
	subqt	#12,r26	;isubqtsi3	r26-#12->r26
	move	r26,r27	;movsi	r26->r27
	store	r2,(r27)	;movsi	r2->(r27)
	move	FP,r28	;movsi	FP->r28
	move	FP,r29	;movsi	FP->r29
	subqt	#16,r29	;isubqtsi3	r29-#16->r29
	movei	#-44,r7	;movsi	#-44->r7
	add	FP,r7	;iaddsi3	FP+r7->r7
	store	r29,(r7)	;movsi	r29->(r7)
	movei	#-44,r6	;movsi	#-44->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r7	;movsi	(r6)->r7
	store	r3,(r7)	;movsi	r3->(r7)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#20,r1	;isubqtsi3	r1-#20->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r6	;movsi	(r2)->r6
	store	r6,(r0)	;movsi	r6->(r0)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r0	;movsi	FP->r0
	subqt	#24,r0	;isubqtsi3	r0-#24->r0
	move	r0,r1	;movsi	r0->r1
	moveq	#0,r7	;movsi	#0->r7
	store	r7,(r1)	;movsi	r7->(r1)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#28,r1	;isubqtsi3	r1-#28->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#20,r1	;isubqtsi3	r1-#20->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	addqt	#1,r1	;iaddqtsi3	#1+r1->r1
	move	r1,r2	;movsi	r1->r2
	move	r2,r1	;movsi	r2->r1
	shlq	#1,r1	;iashlsi3	r1<<#1->r1
	move	r1,r2	;movsi	r1->r2
	neg	r2	;negsi2	r2->r2
	store	r2,(r0)	;movsi	r2->(r0)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r0	;movsi	FP->r0
	subqt	#32,r0	;isubqtsi3	r0-#32->r0
	move	r0,r1	;movsi	r0->r1
	moveq	#1,r6	;movsi	#1->r6
	store	r6,(r1)	;movsi	r6->(r1)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r0	;movsi	FP->r0
	subqt	#32,r0	;isubqtsi3	r0-#32->r0
	subqt	#4,r0	;isubqtsi3	r0-#4->r0
	move	r0,r1	;movsi	r0->r1
	moveq	#0,r7	;movsi	#0->r7
	store	r7,(r1)	;movsi	r7->(r1)
L12:
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#32,r1	;isubqtsi3	r1-#32->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#28,r1	;isubqtsi3	r1-#28->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	neg	r1	;negsi2	r1->r1
	load	(r0),r0	;movsi	(r0)->r0
	cmp	r0,r1	;rcmpsi	r0,r1
	movei	#L14,TMP
	jump	GT,(TMP)
	nop		;jgt	L14
	movei	#L13,TMP
	jump	T,(TMP)
	nop		;jt	L13
	.EVEN
L14:
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r4	;movsi	FP->r4
	subqt	#24,r4	;isubqtsi3	r4-#24->r4
	move	r4,r3	;movsi	r4->r3
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r5	;movsi	FP->r5
	subqt	#16,r5	;isubqtsi3	r5-#16->r5
	move	r5,r4	;movsi	r5->r4
	load	(r0),r0	;movsi	(r0)->r0
	load	(r1),r1	;movsi	(r1)->r1
	load	(r2),r2	;movsi	(r2)->r2
	load	(r3),r3	;movsi	(r3)->r3
	load	(r4),r4	;movsi	(r4)->r4
	movei	#_Plot_8,r7	;movsi	#_Plot_8->r7
	movei	#-52,r6	;movsi	#-52->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r7,(r6)	;movsi	r7->(r6)
	movei	#-52,r6	;movsi	#-52->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#24,r1	;isubqtsi3	r1-#24->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	move	r1,r2	;movsi	r1->r2
	addqt	#1,r2	;iaddqtsi3	#1+r2->r2
	store	r2,(r0)	;movsi	r2->(r0)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#32,r1	;isubqtsi3	r1-#32->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#32,r2	;isubqtsi3	r2-#32->r2
	subqt	#4,r2	;isubqtsi3	r2-#4->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#32,r2	;isubqtsi3	r2-#32->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	store	r1,(r0)	;movsi	r1->(r0)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#32,r1	;isubqtsi3	r1-#32->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r2	;movsi	r1->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r1	;movsi	(r2)->r1
	cmp	r0,r1	;rcmpsi	r0,r1
	movei	#L15,TMP
	jump	GT,(TMP)
	nop		;jgt	L15
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#32,r1	;isubqtsi3	r1-#32->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#32,r2	;isubqtsi3	r2-#32->r2
	subqt	#4,r2	;isubqtsi3	r2-#4->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#28,r2	;isubqtsi3	r2-#28->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	store	r1,(r0)	;movsi	r1->(r0)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#28,r1	;isubqtsi3	r1-#28->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#28,r1	;isubqtsi3	r1-#28->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	move	r1,r2	;movsi	r1->r2
	addqt	#2,r2	;iaddqtsi3	#2+r2->r2
	store	r2,(r0)	;movsi	r2->(r0)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#20,r1	;isubqtsi3	r1-#20->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#20,r1	;isubqtsi3	r1-#20->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	move	r1,r2	;movsi	r1->r2
	subqt	#1,r2	;isubqtsi3	r2-#1->r2
	store	r2,(r0)	;movsi	r2->(r0)
L15:
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#32,r1	;isubqtsi3	r1-#32->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#32,r1	;isubqtsi3	r1-#32->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	move	r1,r2	;movsi	r1->r2
	addqt	#2,r2	;iaddqtsi3	#2+r2->r2
	store	r2,(r0)	;movsi	r2->(r0)
	movei	#L12,TMP
	jump	T,(TMP)
	nop		;jt	L12
	.EVEN
L13:
L11:
	move	ST,r14
	load	(ST),r19
	load	(r14+1),r20
	load	(r14+2),r21
	load	(r14+3),r22
	load	(r14+4),r23
	load	(r14+5),r24
	load	(r14+6),r25
	load	(r14+7),r26
	load	(r14+8),r27
	load	(r14+9),r28
	load	(r14+10),r29
	move	FP,ST
	load	(ST),FP
	addqt	#4,ST	;unlk
	_RTS
	.EVEN
_Draw_Line::
	subqt	#4,ST
	store	FP,(ST)
	move	ST,FP	;link
	subqt	#32,ST
	subqt	#20,ST
	store	r19,(ST)
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r5	;movsi	FP->r5
	subqt	#4,r5	;isubqtsi3	r5-#4->r5
	move	r5,r6	;movsi	r5->r6
	store	r0,(r6)	;movsi	r0->(r6)
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r0	;movsi	FP->r0
	subqt	#8,r0	;isubqtsi3	r0-#8->r0
	move	r0,r7	;movsi	r0->r7
	store	r1,(r7)	;movsi	r1->(r7)
	moveta	FP,R2	;movsi	FP->R2
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r8	;movsi	r1->r8
	store	r2,(r8)	;movsi	r2->(r8)
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r2	;movsi	FP->r2
	subqt	#16,r2	;isubqtsi3	r2-#16->r2
	move	r2,r9	;movsi	r2->r9
	store	r3,(r9)	;movsi	r3->(r9)
	move	r4,r3	;movsi	r4->r3
	moveta	FP,R4	;movsi	FP->R4
	move	FP,r4	;movsi	FP->r4
	subqt	#17,r4	;isubqtsi3	r4-#17->r4
	move	r4,r10	;movsi	r4->r10
	storeb	r3,(r10)	;movqi	r3,(r10)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#8,r11	;isubqtsi3	r11-#8->r11
	move	r11,r12	;movsi	r11->r12
	moveq	#0,r19	;movsi	#0->r19
	store	r19,(r12)	;movsi	r19->(r12)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#16,r11	;isubqtsi3	r11-#16->r11
	move	r11,r12	;movsi	r11->r12
	movei	#_video_buffer,r11	;movsi	#_video_buffer->r11
	load	(r11),r19	;movsi	(r11)->r19
	store	r19,(r12)	;movsi	r19->(r12)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#16,r12	;isubqtsi3	r12-#16->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#16,r13	;isubqtsi3	r13-#16->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r14	;movsi	r13->r14
	load	(r14),r15	;movsi	(r14)->r15
	move	r15,r13	;movsi	r15->r13
	shlq	#6,r13	;iashlsi3	r13<<#6->r13
	load	(r12),r14	;movsi	(r12)->r14
	move	r13,r12	;movsi	r13->r12
	add	r14,r12	;iaddsi3	r14+r12->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r14	;movsi	r13->r14
	load	(r14),r15	;movsi	(r14)->r15
	move	r15,r13	;movsi	r15->r13
	shlq	#8,r13	;iashlsi3	r13<<#8->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#4,r13	;isubqtsi3	r13-#4->r13
	move	r13,r14	;movsi	r13->r14
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#24,r12	;isubqtsi3	r12-#24->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#12,r13	;isubqtsi3	r13-#12->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#4,r13	;isubqtsi3	r13-#4->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	sub	r13,r12	;isubsi3	r12-r13->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#28,r12	;isubqtsi3	r12-#28->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#16,r13	;isubqtsi3	r13-#16->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	sub	r13,r12	;isubsi3	r12-r13->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#24,r11	;isubqtsi3	r11-#24->r11
	move	r11,r12	;movsi	r11->r12
	load	(r12),r11	;movsi	(r12)->r11
	cmpq	#0,r11	;tstsi	r11
	movei	#L17,TMP
	jump	MI,(TMP)
	nop		;jlt	L17
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	move	r11,r12	;movsi	r11->r12
	moveq	#1,r19	;movsi	#1->r19
	store	r19,(r12)	;movsi	r19->(r12)
	movei	#L18,TMP
	jump	T,(TMP)
	nop		;jt	L18
	.EVEN
L17:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	move	r11,r12	;movsi	r11->r12
	movei	#-1,r19	;movsi	#-1->r19
	store	r19,(r12)	;movsi	r19->(r12)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#24,r12	;isubqtsi3	r12-#24->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#24,r12	;isubqtsi3	r12-#24->r12
	move	r12,r13	;movsi	r12->r13
	load	(r13),r12	;movsi	(r13)->r12
	move	r12,r13	;movsi	r12->r13
	neg	r13	;negsi2	r13->r13
	store	r13,(r11)	;movsi	r13->(r11)
L18:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#28,r11	;isubqtsi3	r11-#28->r11
	move	r11,r12	;movsi	r11->r12
	load	(r12),r11	;movsi	(r12)->r11
	cmpq	#0,r11	;tstsi	r11
	movei	#L19,TMP
	jump	MI,(TMP)
	nop		;jlt	L19
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#4,r11	;isubqtsi3	r11-#4->r11
	move	r11,r12	;movsi	r11->r12
	movei	#_byte_line,r11	;movsi	#_byte_line->r11
	load	(r11),r19	;movsi	(r11)->r19
	store	r19,(r12)	;movsi	r19->(r12)
	movei	#L20,TMP
	jump	T,(TMP)
	nop		;jt	L20
	.EVEN
L19:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#4,r12	;isubqtsi3	r12-#4->r12
	move	r12,r11	;movsi	r12->r11
	movei	#_byte_line,r12	;movsi	#_byte_line->r12
	load	(r12),r13	;movsi	(r12)->r13
	move	r13,r12	;movsi	r13->r12
	neg	r12	;negsi2	r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#28,r12	;isubqtsi3	r12-#28->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#28,r12	;isubqtsi3	r12-#28->r12
	move	r12,r13	;movsi	r12->r13
	load	(r13),r12	;movsi	(r13)->r12
	move	r12,r13	;movsi	r12->r13
	neg	r13	;negsi2	r13->r13
	store	r13,(r11)	;movsi	r13->(r11)
L20:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#24,r12	;isubqtsi3	r12-#24->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#28,r12	;isubqtsi3	r12-#28->r12
	move	r12,r13	;movsi	r12->r13
	load	(r11),r11	;movsi	(r11)->r11
	load	(r13),r12	;movsi	(r13)->r12
	cmp	r11,r12	;rcmpsi	r11,r12
	movei	#L21,TMP
	jump	GT,(TMP)
	nop		;jgt	L21
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#12,r11	;isubqtsi3	r11-#12->r11
	move	r11,r12	;movsi	r11->r12
	moveq	#0,r19	;movsi	#0->r19
	store	r19,(r12)	;movsi	r19->(r12)
L22:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#12,r12	;isubqtsi3	r12-#12->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#24,r12	;isubqtsi3	r12-#24->r12
	move	r12,r13	;movsi	r12->r13
	load	(r11),r11	;movsi	(r11)->r11
	load	(r13),r12	;movsi	(r13)->r12
	cmp	r11,r12	;rcmpsi	r11,r12
	movei	#L25,TMP
	jump	GT,(TMP)
	nop		;jgt	L25
	movei	#L23,TMP
	jump	T,(TMP)
	nop		;jt	L23
	.EVEN
L25:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#16,r11	;isubqtsi3	r11-#16->r11
	move	r11,r12	;movsi	r11->r12
	load	(r12),r11	;movsi	(r12)->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#17,r12	;isubqtsi3	r12-#17->r12
	move	r12,r13	;movsi	r12->r13
	loadb	(r13),r19	;movqi	(r13),r19
	storeb	r19,(r11)	;movqi	r19,(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#8,r12	;isubqtsi3	r12-#8->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#28,r13	;isubqtsi3	r13-#28->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#8,r12	;isubqtsi3	r12-#8->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#24,r12	;isubqtsi3	r12-#24->r12
	move	r12,r13	;movsi	r12->r13
	load	(r11),r11	;movsi	(r11)->r11
	load	(r13),r12	;movsi	(r13)->r12
	cmp	r11,r12	;rcmpsi	r11,r12
	movei	#L26,TMP
	jump	GT,(TMP)
	nop		;jgt	L26
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#8,r12	;isubqtsi3	r12-#8->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#24,r13	;isubqtsi3	r13-#24->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	sub	r13,r12	;isubsi3	r12-r13->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#16,r12	;isubqtsi3	r12-#16->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#16,r13	;isubqtsi3	r13-#16->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#4,r13	;isubqtsi3	r13-#4->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
L26:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#16,r12	;isubqtsi3	r12-#16->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#16,r13	;isubqtsi3	r13-#16->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
L24:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#12,r11	;isubqtsi3	r11-#12->r11
	moveta	r11,R5	;movsi	r11->R5
	moveta	FP,R6	;movsi	FP->R6
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#12,r12	;isubqtsi3	r12-#12->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#12,r12	;isubqtsi3	r12-#12->r12
	move	r12,r13	;movsi	r12->r13
	load	(r13),r14	;movsi	(r13)->r14
	move	r14,r12	;movsi	r14->r12
	addqt	#1,r12	;iaddqtsi3	#1+r12->r12
	move	r12,r13	;movsi	r12->r13
	store	r13,(r11)	;movsi	r13->(r11)
	movei	#L22,TMP
	jump	T,(TMP)
	nop		;jt	L22
	.EVEN
L23:
	movei	#L27,TMP
	jump	T,(TMP)
	nop		;jt	L27
	.EVEN
L21:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#12,r11	;isubqtsi3	r11-#12->r11
	move	r11,r12	;movsi	r11->r12
	moveq	#0,r19	;movsi	#0->r19
	store	r19,(r12)	;movsi	r19->(r12)
L28:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#12,r12	;isubqtsi3	r12-#12->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#28,r12	;isubqtsi3	r12-#28->r12
	move	r12,r13	;movsi	r12->r13
	load	(r11),r11	;movsi	(r11)->r11
	load	(r13),r12	;movsi	(r13)->r12
	cmp	r11,r12	;rcmpsi	r11,r12
	movei	#L31,TMP
	jump	GT,(TMP)
	nop		;jgt	L31
	movei	#L29,TMP
	jump	T,(TMP)
	nop		;jt	L29
	.EVEN
L31:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#16,r11	;isubqtsi3	r11-#16->r11
	move	r11,r12	;movsi	r11->r12
	load	(r12),r11	;movsi	(r12)->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#17,r12	;isubqtsi3	r12-#17->r12
	move	r12,r13	;movsi	r12->r13
	loadb	(r13),r19	;movqi	(r13),r19
	storeb	r19,(r11)	;movqi	r19,(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#8,r12	;isubqtsi3	r12-#8->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#24,r13	;isubqtsi3	r13-#24->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#8,r11	;isubqtsi3	r11-#8->r11
	move	r11,r12	;movsi	r11->r12
	load	(r12),r11	;movsi	(r12)->r11
	cmpq	#1,r11	;tstlesi	r11
	movei	#L32,TMP
	jump	MI,(TMP)
	nop		;jle2lt	L32
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#8,r12	;isubqtsi3	r12-#8->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#8,r13	;isubqtsi3	r13-#8->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#28,r13	;isubqtsi3	r13-#28->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	sub	r13,r12	;isubsi3	r12-r13->r12
	store	r12,(r11)	;movsi	r12->(r11)
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#16,r12	;isubqtsi3	r12-#16->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#16,r13	;isubqtsi3	r13-#16->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
L32:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#16,r12	;isubqtsi3	r12-#16->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#16,r13	;isubqtsi3	r13-#16->r13
	move	r13,r12	;movsi	r13->r12
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r13	;movsi	FP->r13
	subqt	#32,r13	;isubqtsi3	r13-#32->r13
	subqt	#4,r13	;isubqtsi3	r13-#4->r13
	move	r13,r14	;movsi	r13->r14
	load	(r12),r12	;movsi	(r12)->r12
	load	(r14),r13	;movsi	(r14)->r13
	add	r13,r12	;iaddsi3	r13+r12->r12
	store	r12,(r11)	;movsi	r12->(r11)
L30:
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r11	;movsi	FP->r11
	subqt	#32,r11	;isubqtsi3	r11-#32->r11
	subqt	#12,r11	;isubqtsi3	r11-#12->r11
	moveta	r11,R5	;movsi	r11->R5
	moveta	FP,R6	;movsi	FP->R6
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#12,r12	;isubqtsi3	r12-#12->r12
	move	r12,r11	;movsi	r12->r11
	moveta	FP,R5	;movsi	FP->R5
	move	FP,r12	;movsi	FP->r12
	subqt	#32,r12	;isubqtsi3	r12-#32->r12
	subqt	#12,r12	;isubqtsi3	r12-#12->r12
	move	r12,r13	;movsi	r12->r13
	load	(r13),r14	;movsi	(r13)->r14
	move	r14,r12	;movsi	r14->r12
	addqt	#1,r12	;iaddqtsi3	#1+r12->r12
	move	r12,r13	;movsi	r12->r13
	store	r13,(r11)	;movsi	r13->(r11)
	movei	#L28,TMP
	jump	T,(TMP)
	nop		;jt	L28
	.EVEN
L29:
L27:
L16:
	load	(ST),r19
	move	FP,ST
	load	(ST),FP
	addqt	#4,ST	;unlk
	_RTS
	.EVEN
_Plot_Pixel_Fast::
	subqt	#4,ST
	store	FP,(ST)
	move	ST,FP	;link
	subqt	#16,ST
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#4,r3	;isubqtsi3	r3-#4->r3
	move	r3,r4	;movsi	r3->r4
	store	r0,(r4)	;movsi	r0->(r4)
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r0	;movsi	FP->r0
	subqt	#8,r0	;isubqtsi3	r0-#8->r0
	move	r0,r5	;movsi	r0->r5
	store	r1,(r5)	;movsi	r1->(r5)
	moveta	FP,R2	;movsi	FP->R2
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r6	;movsi	r1->r6
	store	r2,(r6)	;movsi	r2->(r6)
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r7	;movsi	FP->r7
	subqt	#8,r7	;isubqtsi3	r7-#8->r7
	move	r7,r2	;movsi	r7->r2
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r7	;movsi	FP->r7
	subqt	#8,r7	;isubqtsi3	r7-#8->r7
	move	r7,r8	;movsi	r7->r8
	load	(r8),r9	;movsi	(r8)->r9
	move	r9,r7	;movsi	r9->r7
	shlq	#8,r7	;iashlsi3	r7<<#8->r7
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r8	;movsi	FP->r8
	subqt	#8,r8	;isubqtsi3	r8-#8->r8
	move	r8,r9	;movsi	r8->r9
	load	(r9),r10	;movsi	(r9)->r10
	move	r10,r8	;movsi	r10->r8
	shlq	#6,r8	;iashlsi3	r8<<#6->r8
	add	r8,r7	;iaddsi3	r8+r7->r7
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r8	;movsi	FP->r8
	subqt	#4,r8	;isubqtsi3	r8-#4->r8
	move	r8,r9	;movsi	r8->r9
	load	(r9),r8	;movsi	(r9)->r8
	add	r8,r7	;iaddsi3	r8+r7->r7
	store	r7,(r2)	;movsi	r7->(r2)
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r7	;movsi	r2->r7
	load	(r7),r2	;movsi	(r7)->r2
	movei	#76799,r7	;movsi	#76799->r7
	cmp	r7,r2	;cmpsi	r7,r2
	movei	#L35,TMP
	jump	GT,(TMP)
	nop		;jgt	L35
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r7	;movsi	r2->r7
	load	(r7),r2	;movsi	(r7)->r2
	cmpq	#0,r2	;tstsi	r2
	movei	#L35,TMP
	jump	MI,(TMP)
	nop		;jlt	L35
	movei	#L34,TMP
	jump	T,(TMP)
	nop		;jt	L34
	.EVEN
L35:
	movei	#L33,TMP
	jump	T,(TMP)
	nop		;jt	L33
	.EVEN
L34:
	movei	#_video_buffer,r7	;movsi	#_video_buffer->r7
	load	(r7),r2	;movsi	(r7)->r2
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r7	;movsi	FP->r7
	subqt	#8,r7	;isubqtsi3	r7-#8->r7
	move	r7,r9	;movsi	r7->r9
	load	(r9),r8	;movsi	(r9)->r8
	move	r2,r7	;movsi	r2->r7
	add	r8,r7	;iaddsi3	r8+r7->r7
	move	r7,r2	;movsi	r7->r2
	moveta	FP,R3	;movsi	FP->R3
	move	FP,r7	;movsi	FP->r7
	subqt	#12,r7	;isubqtsi3	r7-#12->r7
	move	r7,r8	;movsi	r7->r8
	moveta	r8,R3	;movsi	r8->R3
	move	r8,r7	;movsi	r8->r7
	addqt	#3,r7	;iaddqtsi3	#3+r7->r7
	move	r7,r8	;movsi	r7->r8
	loadb	(r8),r11	;movqi	(r8),r11
	storeb	r11,(r2)	;movqi	r11,(r2)
L33:
	move	FP,ST
	load	(ST),FP
	addqt	#4,ST	;unlk
	_RTS
	.EVEN
_Plot_8::
	subqt	#4,ST
	store	FP,(ST)
	move	ST,FP	;link
	movei	#164,TMP
	sub	TMP,ST
	move	ST,r14
	store	r19,(ST)
	store	r20,(r14+1)
	store	r21,(r14+2)
	store	r22,(r14+3)
	store	r23,(r14+4)
	store	r24,(r14+5)
	store	r25,(r14+6)
	store	r26,(r14+7)
	store	r27,(r14+8)
	store	r28,(r14+9)
	store	r29,(r14+10)
	move	FP,r19	;movsi	FP->r19
	move	FP,r20	;movsi	FP->r20
	subqt	#4,r20	;isubqtsi3	r20-#4->r20
	move	r20,r21	;movsi	r20->r21
	store	r0,(r21)	;movsi	r0->(r21)
	move	FP,r22	;movsi	FP->r22
	move	FP,r23	;movsi	FP->r23
	subqt	#8,r23	;isubqtsi3	r23-#8->r23
	move	r23,r24	;movsi	r23->r24
	store	r1,(r24)	;movsi	r1->(r24)
	move	FP,r25	;movsi	FP->r25
	move	FP,r26	;movsi	FP->r26
	subqt	#12,r26	;isubqtsi3	r26-#12->r26
	move	r26,r27	;movsi	r26->r27
	store	r2,(r27)	;movsi	r2->(r27)
	move	FP,r28	;movsi	FP->r28
	move	FP,r29	;movsi	FP->r29
	subqt	#16,r29	;isubqtsi3	r29-#16->r29
	moveq	#0,r6	;movsi	#0->r6
	subqt	#28,r6	;iaddqtsi3	#-28+r6->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r29,(r6)	;movsi	r29->(r6)
	moveq	#0,r5	;movsi	#0->r5
	subqt	#28,r5	;iaddqtsi3	#-28+r5->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r6	;movsi	(r5)->r6
	store	r3,(r6)	;movsi	r3->(r6)
	movei	#-36,r5	;movsi	#-36->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	FP,(r5)	;movsi	FP->(r5)
	move	FP,r5	;movsi	FP->r5
	subqt	#20,r5	;isubqtsi3	r5-#20->r5
	movei	#-44,r6	;movsi	#-44->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-44,r6	;movsi	#-44->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r5	;movsi	(r6)->r5
	movei	#-52,r6	;movsi	#-52->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-52,r6	;movsi	#-52->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r5	;movsi	(r6)->r5
	store	r4,(r5)	;movsi	r4->(r5)
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#16,r1	;isubqtsi3	r1-#16->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#12,r2	;isubqtsi3	r2-#12->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r5	;movsi	#_Plot_Pixel_Fast->r5
	movei	#-60,r6	;movsi	#-60->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-60,r6	;movsi	#-60->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r0	;movsi	FP->r0
	subqt	#16,r0	;isubqtsi3	r0-#16->r0
	move	r0,r1	;movsi	r0->r1
	load	(r1),r2	;movsi	(r1)->r2
	move	r2,r0	;movsi	r2->r0
	neg	r0	;negsi2	r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#12,r2	;isubqtsi3	r2-#12->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#20,r2	;isubqtsi3	r2-#20->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r4	;movsi	(r3)->r4
	move	r4,r2	;movsi	r4->r2
	addqt	#1,r2	;iaddqtsi3	#1+r2->r2
	movei	#_Plot_Pixel_Fast,r6	;movsi	#_Plot_Pixel_Fast->r6
	movei	#-68,r5	;movsi	#-68->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	r6,(r5)	;movsi	r6->(r5)
	movei	#-68,r5	;movsi	#-68->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r5	;movsi	(r5)->r5
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r5)
	store	TMP,(ST)	;call	r5
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r0	;movsi	FP->r0
	subqt	#16,r0	;isubqtsi3	r0-#16->r0
	move	r0,r1	;movsi	r0->r1
	load	(r1),r2	;movsi	(r1)->r2
	move	r2,r0	;movsi	r2->r0
	neg	r0	;negsi2	r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	neg	r1	;negsi2	r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#20,r2	;isubqtsi3	r2-#20->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r4	;movsi	(r3)->r4
	move	r4,r2	;movsi	r4->r2
	addqt	#2,r2	;iaddqtsi3	#2+r2->r2
	movei	#_Plot_Pixel_Fast,r5	;movsi	#_Plot_Pixel_Fast->r5
	movei	#-76,r6	;movsi	#-76->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-76,r6	;movsi	#-76->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#16,r1	;isubqtsi3	r1-#16->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	neg	r1	;negsi2	r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#20,r2	;isubqtsi3	r2-#20->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r4	;movsi	(r3)->r4
	move	r4,r2	;movsi	r4->r2
	addqt	#3,r2	;iaddqtsi3	#3+r2->r2
	movei	#_Plot_Pixel_Fast,r6	;movsi	#_Plot_Pixel_Fast->r6
	movei	#-84,r5	;movsi	#-84->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	r6,(r5)	;movsi	r6->(r5)
	movei	#-84,r5	;movsi	#-84->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r5	;movsi	(r5)->r5
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r5)
	store	TMP,(ST)	;call	r5
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#16,r1	;isubqtsi3	r1-#16->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	neg	r1	;negsi2	r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r5	;movsi	#_Plot_Pixel_Fast->r5
	movei	#-92,r6	;movsi	#-92->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-92,r6	;movsi	#-92->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r1	;movsi	FP->r1
	subqt	#12,r1	;isubqtsi3	r1-#12->r1
	move	r1,r0	;movsi	r1->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r0),r0	;movsi	(r0)->r0
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#16,r2	;isubqtsi3	r2-#16->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r6	;movsi	#_Plot_Pixel_Fast->r6
	movei	#-100,r5	;movsi	#-100->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	r6,(r5)	;movsi	r6->(r5)
	movei	#-100,r5	;movsi	#-100->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r5	;movsi	(r5)->r5
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r5)
	store	TMP,(ST)	;call	r5
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r0	;movsi	FP->r0
	subqt	#12,r0	;isubqtsi3	r0-#12->r0
	move	r0,r1	;movsi	r0->r1
	load	(r1),r2	;movsi	(r1)->r2
	move	r2,r0	;movsi	r2->r0
	neg	r0	;negsi2	r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#16,r2	;isubqtsi3	r2-#16->r2
	move	r2,r1	;movsi	r2->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r1),r1	;movsi	(r1)->r1
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r5	;movsi	#_Plot_Pixel_Fast->r5
	movei	#-108,r6	;movsi	#-108->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	store	r5,(r6)	;movsi	r5->(r6)
	movei	#-108,r6	;movsi	#-108->r6
	add	FP,r6	;iaddsi3	FP+r6->r6
	load	(r6),r6	;movsi	(r6)->r6
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r6)
	store	TMP,(ST)	;call	r6
	moveta	ST,R0	;movsi	ST->R0
	moveta	FP,R1	;movsi	FP->R1
	move	FP,r0	;movsi	FP->r0
	subqt	#12,r0	;isubqtsi3	r0-#12->r0
	move	r0,r1	;movsi	r0->r1
	load	(r1),r2	;movsi	(r1)->r2
	move	r2,r0	;movsi	r2->r0
	neg	r0	;negsi2	r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#4,r1	;isubqtsi3	r1-#4->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r1	;movsi	(r2)->r1
	add	r1,r0	;iaddsi3	r1+r0->r0
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r1	;movsi	FP->r1
	subqt	#16,r1	;isubqtsi3	r1-#16->r1
	move	r1,r2	;movsi	r1->r2
	load	(r2),r3	;movsi	(r2)->r3
	move	r3,r1	;movsi	r3->r1
	neg	r1	;negsi2	r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r2	;movsi	FP->r2
	subqt	#8,r2	;isubqtsi3	r2-#8->r2
	move	r2,r3	;movsi	r2->r3
	load	(r3),r2	;movsi	(r3)->r2
	add	r2,r1	;iaddsi3	r2+r1->r1
	moveta	FP,R0	;movsi	FP->R0
	move	FP,r3	;movsi	FP->r3
	subqt	#20,r3	;isubqtsi3	r3-#20->r3
	move	r3,r2	;movsi	r3->r2
	load	(r2),r2	;movsi	(r2)->r2
	movei	#_Plot_Pixel_Fast,r6	;movsi	#_Plot_Pixel_Fast->r6
	movei	#-116,r5	;movsi	#-116->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	store	r6,(r5)	;movsi	r6->(r5)
	movei	#-116,r5	;movsi	#-116->r5
	add	FP,r5	;iaddsi3	FP+r5->r5
	load	(r5),r5	;movsi	(r5)->r5
	move	PC,TMP
	subqt	#4,ST
	addqt	#10,TMP
	jump	T,(r5)
	store	TMP,(ST)	;call	r5
L36:
	move	ST,r14
	load	(ST),r19
	load	(r14+1),r20
	load	(r14+2),r21
	load	(r14+3),r22
	load	(r14+4),r23
	load	(r14+5),r24
	load	(r14+6),r25
	load	(r14+7),r26
	load	(r14+8),r27
	load	(r14+9),r28
	load	(r14+10),r29
	move	FP,ST
	load	(ST),FP
	addqt	#4,ST	;unlk
	_RTS
_video_buffer::	.DCB.B	8,0
	.LONG
	.68000
_jagcode_end::
_jagcode_size	.EQU	*-_jagcode_start
	.GLOBL	_jagcode_size
	.IF	_jagcode_size>$1000
	.PRINT	"Code size (",/l/x _jagcode_size,") is over $1000"
	.FAIL
	.ENDIF
