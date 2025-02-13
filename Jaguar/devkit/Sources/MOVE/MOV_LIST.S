;
; Jaguar Example Source Code
; Jaguar Workshop Series #2
; Copyright (c)1994 Atari Corp.
; ALL RIGHTS RESERVED
;
; Program: move.cof	- Moving bitmap object example
;  Module: mov_list.s	- Object List Refresh and Initialization
;
; Revision History:
; 6/15/94  - SDS: Copied from mou_list.s
;                 Added x_pos and y_pos bitmap tracking variables
;
; 6/27/94  - SDS: Updated mov_list.s from mou_list.s
;		   UpdateList now updates XPOS and YPOS cause we change 'em

		.include	"jaguar.inc"
		.include	"move.inc"

; Globals
		.globl		InitLister
		.globl		UpdateList
; Externals
		.extern		a_vde
		.extern	 	a_vdb
		.extern		a_hdb
		.extern		a_hde
		.extern		width
		.extern		height
		.extern		x_pos
		.extern		y_pos
		.extern		jagbits

		.extern		MoveBitmap

		.text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; InitLister: Initialize Object List Processor List
;
;    Returns: Pre-word-swapped address of current object list in d0.l
;
;  Registers: d1.l/d0.l - Phrase being built
;             d2.l      - Address of STOP object in destination buffer
;	       d3.l      - Calculation register
;	       d4.l      - Width of image in phrases
;	       d5.l      - Height of image in scanlines
;             a0.l      - Roving object list pointer
		
InitLister:
		movem.l	d1-d5/a0,-(sp)			; Save registers
			
		lea	main_obj_list,a0
		move.l	a0,d2				; Copy

		add.l	#(LISTSIZE-1)*8,d2		; Address of STOP object

; Write first BRANCH object (branch if YPOS > a_vde )

		clr.l	d1
		move.l	#(BRANCHOBJ|O_BRLT),d0	; $4000 = VC < YPOS
		jsr	format_link		; Stuff in our LINK address
						
		move.w	a_vde,d3		; for YPOS
		lsl.w	#3,d3			; Make it bits 13-3
		or.w	d3,d0

		move.l	d1,(a0)+				
		move.l	d0,(a0)+		; First OBJ is done.

; Write second branch object (branch if YPOS < a_vdb)	
; Note: LINK address is the same so preserve it

		andi.l	#$FF000007,d0		; Mask off CC and YPOS
		ori.l	#O_BRGT,d0		; $8000 = YPOS < VC
		move.w	a_vdb,d3		; for YPOS
		lsl.w	#3,d3			; Make it bits 13-3
		or.w	d3,d0

		move.l	d1,(a0)+		; Second OBJ is done
		move.l	d0,(a0)+	

; Write a standard BITMAP object
		clr.l	d1
		clr.l	d0			; Type = BITOBJ
			
		jsr	format_link

		move.l	#BMP_HEIGHT,d5		; Height of image
		move.w	d5,bmp_height		; Store for later update

		lsl.l	#8,d5			; HEIGHT
		lsl.l	#6,d5
		or.l	d5,d0

		move.w	height,d3		; Center bitmap vertically
		sub.w	#BMP_HEIGHT,d3
		add.w	a_vdb,d3
		andi.w	#$FFFE,d3		; Must be even

		move.w	d3,y_pos		; For mov_move.s

		lsl.w	#3,d3
		or.w	d3,d0			; Stuff YPOS in low phrase

		move.l	#jagbits,d3
		andi.l	#$FFFFF0,d3
		lsl.l	#8,d3			; Shift bitmap_addr into position
		or.l	d3,d1
     
		move.l	d1,(a0)+
		move.l	d1,bmp_highl
		move.l	d0,(a0)+
		move.l	d0,bmp_lowl

		move.l	#O_TRANS,d1		; PHRASE 2 of BITOBJ (TRANSPARENT)
		move.l	#O_DEPTH16|O_NOGAP,d0	; Bit Depth = 16-bit, Contiguous data

		clr.l	d3			; Determine Width of Screen
		move.w	width,d3
		lsr.w	#2,d3			; /4 Pixel Divisor
		sub.w	#BMP_WIDTH,d3
		lsr.w	#1,d3

		move.w	d3,x_pos		; For mov_move.s
		or.w	d3,d0

		move.l	#BMP_PHRASES,d4	
		move.l	d4,d3			; Copy for below

		lsl.l	#8,d4			; DWIDTH
		lsl.l	#8,d4
		lsl.l	#2,d4
		or.l	d4,d0

		lsl.l	#8,d4			; IWIDTH Bits 28-31
		lsl.l	#2,d4
		or.l	d4,d0

		lsr.l	#4,d3			; IWIDTH Bits 37-32
		or.l	d3,d1

		move.l	d1,(a0)+		; Write second PHRASE of BITOBJ
		move.l	d0,(a0)+

; Write a STOP object at end of list
		clr.l	d1
		move.l	#(STOPOBJ|O_STOPINTS),d0

		move.l	d1,(a0)+		
		move.l	d0,(a0)+

; Now do an initial copy to store our list			
		move.l	#main_obj_list,d0
		swap	d0

		movem.l	(sp)+,d1-d5/a0
		rts
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Procedure: format_link
;
;    Inputs: d1.l/d0.l is a 64-bit phrase
;            d2.l contains the LINK address to put into bits 42-24 of phrase
;
;   Returns: Updated phrase in d1.l/d0.l

format_link:
		movem.l	d2-d3,-(sp)

		andi.l	#$3FFFF8,d2		; Ensure alignment/valid address
		move.l	d2,d3			; Make a copy

		swap	d2			; Put bits 10-3 in bits 31-24
		clr.w	d2
		lsl.l	#5,d2
		or.l	d2,d0

		lsr.l	#8,d3			; Put bits 21-11 in bits 42-32
		lsr.l	#3,d3
		or.l	d3,d1

		movem.l	(sp)+,d2-d3		; Restore regs
		rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UpdateList: Update list fields destroyed by the object processor.
;
;  Registers:	d1.l/d0.l - Phrase storage area
;              a0.l      - Pointer into object list

UpdateList:
		movem.l	d0-d1/a0,-(sp)

		jsr	MoveBitmap		; Update movement variables

		move.l	#main_obj_list+BITMAP_OFF,a0
		
		move.l	bmp_highl,(a0)		; Store old high long because no fields changed
		move.l	bmp_lowl,d0		; Grab low longword of phrase to change YPOS

; !!!New!!! Now that our MoveBitmap routine is altering the bitmap position
;           those fields must also be updated (though they aren't actually
;           changed by the OP).

		andi.l	#$FFFFC007,d0		; Strip old YPOS

		move.w	y_pos,d1		; Update YPOS from internal var
		lsl.w	#3,d1			; Shift into bits 13-3
		or.w	d1,d0

		move.l	d0,4(a0)		; Store low longword of phrase 1

		move.l	12(a0),d0		; Low Phrase 2 -> d0.l
		andi.l	#$FFFFF000,d0		; Extract XPOS

		move.w	x_pos,d1		; Grab new XPOS and
		or.w	d1,d0			; store it.

		move.l	d0,12(a0)		; d0.l -> Low Phrase 2

		move.w	#$101,INT1
		move.w	#$0,INT2

		movem.l	(sp)+,d0-d1/a0
		rte

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Storage space for our object lists

		.bss
		.dphrase
		
main_obj_list:
		.ds.l		LISTSIZE*2	       
bmp_height:
		.ds.w		1
bmp_highl:
		.ds.l		1		
bmp_lowl:
		.ds.l		1

		.end
��������������������������������������������������  ��������������������������������������������������������������������������������������������������  ��������������������������������������������������� ������������� ��������������������������������������������������������  �����������������������������������������������������������������������������������������Q׋y���� h���B�x	�bk�ݩSz%<%��]��ZO��ߏs���=����x3������9��bV�I�_�@�_uI�B����/�`9,F�e��:;�:G!M�>�#�pp��Tl�>X���X�Gmwcڦa?L���hč��Ċ�`�	��гp>(3��'G�c���	x���T��x�s�C���7�c�uBJay�v�0�`�@o�ּ�|	\�R���/�j��pR�I ]!]Z��uq�U�ht:��k�u�dɱAO�e$prc�|��ժ�����Ŝ+��U���k\�^Q�J�O�rn�a'�Y��9Gsޅ���h�[z�Ì�LOh8��S����ts��?��oR�s��Zx�91�E62	k�T�����9���e�c˪�e��2׏��d3ޗ�6��"�U�\�);��(ףP6��(��XĞ���?�f@��O���jZ��1��r�5ؤ�UO1��rC$�R1�2P��X�3�|�?�(3�,�Z(zm|��C3�����t�j߆���� ����k�Au�^�F��0Z��\��f�^h���C�����r�cΛ1燆����V]��B�Ћ��y��;�7Ґ��5!���hER�vje�t ���yNc��3����PC3� �nl���4;��a�)
k8*��uM�O�ȏ�E副(�ɣ񔔣�	|��=��|C����[���"�>B���n��SbJo�l�G�OH�)q��ڹ.g��%ę U�O,�K�s8�6蕩z>�<B�k�6�h�=^�q�r���ApX�qh���nbG��]U����ɛ�h3��ty m�F���nk�dy�Z����MC,S�=�@̼E�&�6�R��M��4ּ?'=4ow��ܒ n��qD�܊1�k�E|�3BVV��Oj2�0V�WS�xZ-��aR�4�N!������H�� d�Zٴ����جeD�D���mmEK���q94U�ƊB����ql�{���C�ѫI屫��I�a�e�aeeE.�O�X����8J�µ�U��_�Y�?����8F�,�k�1^���FΥ��UW�\�Y�I��m���Q����SQo
it����/�u]�g6��Zmڨ�8-�G���z��Z�+��t�c�>�X:v�Rs����G2�aM������	)OK��=�]��}X獻�+�+�]���r�8�z���42q4��/X�Y40
lb��i�A.�[��,�VՒM�~)i�I �&9¨�C]]Nq����Y_�=v�%x@
��U~In�3��c����Y0��~��j���2��c�|�#F�I��;�Z�X��6��#&���~�ݒB
�q����ɇ�l�e>�2���rc�<�����+xzj���b�o �xW ��&G�'��z�fO��-���S�j��D�I��ˌ(��ek�۫`'K�;C�`��c��G�˪i�m�|��%�fK*�=��fE�2�^�(��-�*��:�(��������lɹ@��a	PYy�Ƣp����'�$�I0d/�aΣ~�r�$����:j���R����4�IR3�8� �q<zt#���Z���h�xs:�^�X�0�w�dI�&<�0o~�Oe"�]�w��8��/yd�䱜�+Y�w�Ü~��/�U�Yϱ�U�!�*PqײY)��oԃY��=�E�����j���Ր�.���H;�Y�+;��v�[f�~�"<EH�-�0�5�|3�>�"�z�=J�W+��7{�����~�Ϳs��Cﶟq�z�r:��[G�w锧�x�iZȳra���{�=�:�蹅g��ca�9Ig�0g[�A�j�H��6fКeG+�v+َ3W�ya7�"'�yQ�)j_��`���y�98�뜊m.�%�)(5ql�*�=�#F�_�����K�5P ��%{P�Sĭ�:�P��T�S��m叨m����k����mM��1S*�~��dv�U�~@iu�5j��rXλ��8+6�u60��i���g�Ĳ�xzmĴ����z��ރ�����葔_;  �  �   v!  /#  1#  B#  _#  �#  �#  $  :$  B%  D%  ]%  _%  u%  �%  �&  �&  �&  �'  �'  �'  yyyyyyyyyyyyyyyyyyyyyyy     �'  �)  �)  �)  -+  /+  1+  3+  5+  7+  9+  ;+  =+  ?+  A+  V+  a+  �,  �,  �,  ].  _.  j.  �/  yyyyyyyyyyyyyyyyyyyyyyy     �/  �/  0  1  �1  �1  yyyy                                                                                                     �,  �1  d e f    �  h  �  �  ;  �'  �/  �1  g h i j k l m n Times New Roman Univers Cd (W1)                                                                                                                                  l �:L ���G2	�r�  ���                ;  ��	                               ����        ���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� C o m p O b j                                                   ������������                                       E                                                                           ������������                                                                                                                    ������������                                                                                                                    ������������                                                 ��� ��� ��� ��� ��� ���                 GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG              JtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCJ            ��               ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ���                 GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG GGG              JtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCJ            ��                                                                                                                                                                                                            JtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCtCCCCCtCJ            ��                                                                                                                                                                                                            JCtttttCCCtttttCCCtttttCCCtttttCCCtttttCCCtttttCCJ            ��                                                                                                                                                                                                            JJ            ����������������������������������������������������                                                                                                                                                                                                            JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ           (* i�       =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    	 
                                    ./012345                                              <=>?@ABC # $ % & ' ( ) * + , -                                  JKLMNOPQ 6 7 8 9 : ; < = > ? @ A                                  XYZ[\]^ J K L M N O P Q R S T U                                  efghijk ^ _ ` a b c d e f g h i j                                  rstuvw k l m n o p q r s t u v w                                  ~���� y z { | } ~  � � � � � � �                                  ����� � � � � � � � � � � � � � �                                    ���� � � � � � � � � � � � � � �                                      ��� � � � � � � � � � � � �                                             � � � � � � � � � � � � � �                                             � � � � � � � � � � � �                                                 � � � � � � � � � �                                                       � � � � � � � �                                                                                                                                ! "                                                           . / 0 1 2 3 4 5                                                         B C D E F G H I                                                         V W X Y Z [ \ ]                                                                 	 
                                                                                                                   # $ % & ' ( ) * + , -                                                   6 7 8 9 : ; < = > ? @ A                                                 J K L M N O P Q R S T U                                                 ^ _ ` a b c d e f g h i j                                               k l m n o p q r s t u v w                                               y z { | } ~  � � � � � � �                                             � � � � � � � � � � � � � �                                             � � � � � � � � � � � � � �                                             � � � � � � � � � � � �                                                 � � � � � � � � � � � �                                                 � � � � � � � � � �                                                     � � � � � � � �                                                         � � � � � � � �                                                                                                                                ! "                                                           . / 0 1 2 3 4 5                                                         B C D E F G H I                                                         V W X Y Z [ \ ]   
                                                             	 
                                                                                                                   # $ % & ' ( ) * + , -                                                   6 7 8 9 : ; < = > ? @ A                                                 J K L M N O P Q R S T U                                                 ^ _ ` a b c d e f g h i j                                               k l m n o p q r s t u v w                                               y z { | } ~  � � � � � � �                                             � � � � � � � � � � � � � �                                             � � � � � � � � � � � � � �                                             � � � � � � � � � � � �                                                 � � � � � � � � � � � �                                                 � � � � � � � � � �                                                     � � � � � � � �                                                         � � � � � � � �                                                                                                                      � �       ! "                                                       � � . /ix roues

L'ESPACE DE JEU

Il y a en gros trois quartiers distincts:
- le ghetto, rue �troites, cul de sac, routes presque � angle droit
La conduite y est tr�s strat�gique, possibilit� de se placer en embuscade, la voiture � l'arr�t; en mode r�seau, possibilit� de tendre des pi�ges, de rabattre du "gibier"
-la zone industrielle, grands complexes chimiques, grandes art�res, canal d�saffect�, passage encaiss�
la conduite y est plus rapide
-la p�riph�rie, autoroute double sens, �changeurs triple voies multidirectionnels, voies sur�lev�es sur plusieurs niveaux, routes dans tous les sens, conduite ultra-rapide, tr�s instinctive

LES ECRANS

-Animation, pr�sentation de vx

-s�quence de pr�sentation du jeu

-engagement dans l'unit�, les options:
Mode m�l�e ou mission
standard, modem ou null modem
volume sfx et music
tableau avec fiche technique compl�te du v�hicule DOMINATOR

En mode m�l�e: apr�s choix des options, acc�s direct au baston. Pour quitter le mode m�l�e: touche destroy sur le paddle, explosion nucl�aire, le jeu est radicalement "reset�". Retour au premier �cran d'options
En mode mission, apr�s les premiers �crans d'options, vient un �cran qui propose au joueur 4 missions de base avec descriptif complet de la mission.
Entre chaque mission, retour � un �cran de menu qui fait �tat du r�sultat de la mission pr�c�dente, et qui propose:
-Exit
-Magasin d'�quipement
-4 autres missions de difficult� sup�rieure
-Retour au menu principal 

DEGRADATION DU VEHICULE DU JOUEUR
Le v�hicule DOMINATOR peut �tre endommag� de deux fa�ons:
-par accident, collision avec les autres v�hicules ou le d�cor, cela n'entra�ne pas de dommages importants, mais ralentit le joueur.
-les impacts directs de tirs ennemis ou les explosions proches

Le niveau d'�valuation de cette d�gradation se fait de mani�re tr�s visuelle, par des signes tels que pare-brise fissur�, carrosserie froiss�e, manque de maniabilit� de la voiture. Un voyant rouge clignotant s'allume lorsque la voiture est � son seuil limite de r�sistance; il est donc conseill� au joueur de rejoindre le plus rapidement le stand r�paration et d'abandonner le combat.
Le carburant est illimit�, mais les chocs subit peuvent entra�ner des fuites de carburant. Dans ce cas retour au stand...ou alors les warriors joueront au stock-car avec votre voiture arr�t�e.
Les chocs frontaux n'immobilisent jamais le v�hicule. Ils provoquent, � la mani�re d'un "Daytona" un tonneau qui remet la voiture sur le droit chemin, avec neammoins quelques impacts.
Apres accumulation  des impacts et apparition du voyant d'alerte, � l'impact suivant la voiture devient incontr�lable et vient s'�craser dans le d�cor: fin de la mission, retour � �cran interm�diaire, ressayez ou choisissez une autre mission.
Chaque mission r�ussie fait monter le joueur en grade, lui donne des cr�dits suppl�mentaires et lui propose 4 nouvelles missions plus dures.
A la derni�re mission, le combat se d�roule dans le QG du plus grand gang de la ville. R�ussir cette mission signifie �liminer le chef de ce gang et provoquer le chaos qui entra�nera la dislocation de tous les gangs de la ville. Ils s'entretueront rapidement et vous aurez ainsi assaini la "cit� des anges". Bravo! Vous avez gagn�, mais rien ne vous emp�che de choisir le mode m�l�e, le chaos ultime, ARMAGGEDON � 300 km/h, L'APOCALYPSE!!!

Tableau de fin:
Congratulations, highscores
Et surprise!! Le fait de finir le jeu donne acc�s � un cheat mode qui offre des armes et des options de folie pour une ultime partie en mode m�l�e!

REMARQUE:
Pour chaque mission �chou�e le joueur a droit � 4 retry
La musique pendant le jeu peut �tre choisie directement dans l'action. Une touche du paddle permet un choix entre 5 morceaux de styles diff�rents. A l'�cran, une main virtuelle se dirigera vers l'autoradio sur le tableau de bord et changera de musique en direct.

DESCRIPTIF DES MISSIONS

Missions de stade 1:
Mission A
Vous  commencez doucement, pour vous familiariser avec ce monde sauvage, par une petite mission d'interception sur la Highway 53. Un petit gang de punks ayant vol� un v�hicule six roues anti- �meutes, vous devez les �liminer et garder le v�hicule quasiment intact. Prime: 20 000$

Mission B
Petit tour d'echauffement: vous �liminerez une horde de bikers qui s'attaque r�guli�rement au dernier �picier cor�en de la ville. Il vend les meilleurs donuts de toute la c�te ouest, raison de plus pour le d�barrasser de ces morpions sur deux roues! Secteur 5C, ville basse. Prime: 15 000$ et un carton de donuts fourr�s framboise

Mission C
Un escadron de mechwarriors bien �quip�s essaie de forcer la porte de la centrale nucl�aire qui fournit toute la ville en �lectricit�. Emp�chez les d'arriver � leur fin, dans l'int�r�t de la ville et aussi dans votre propre int�r�t si vous ne voulez pas vous retrouver � pied, faisant la circulation au croisement de Violent-death boulevard et de Kill at will Avenue!!! Localisation secteur 8B zone industrielle, nuclear plant. Prime: 20 000$

Mission D
Votre chef de section, qui vous adore, vous donne, pour f�ter votre arriv�e dans le groupe, une petite mission d'escorte de transport de fonds f�d�raux. Serrez les fesses et prot�gez le camion blind� des attaques r�p�t�es de plusieurs gangs rapides s�vissants sur les highways 53 et 22. Menez � bien cette mission si vous voulez �tre pay�! Prime: 25 000$ 










Missions de stade 2
Mission E
Les warriors se sont empar� d'une arme puissante d�velopp�e par l'arm�e et la transportent dans un camion sur la highway 33. Eliminez l'escorte et gardez intact le camion. Attention, les warriors br�lent d'envie d'essayer leur nouveau jouet sur vous. Secteur des autoroutes, votre radar vous guidera sur la cible. Prime: 35 000$

Mission F
Les hautes autorit�s vous confient la mission p�rilleuse de transporter une mallette contenant la recette d'un nouveau carburant ultra-performant jusqu'aux raffineries f�d�rales; les gangs, mis au courant par une taupe infiltr�e dans les services de police, semblent tr�s, tr�s, tr�s int�ress�s. Mettez le turbo et �vitez embuscades et guet apens. Atteignez rapidement la zone industrielle en secteur 8A. Prime: 30 000$

Mission G
Le Mac King Fast Burger o� vous achetiez vos hamburgers pr�f�r�s, a �t� pris d'assaut par une bande de d�cha�n�s: les frites n'�taient pas assez sal�es!! Leur chef menace de faire sauter le quartier tout entier avec une bombe � neutrons!!! Le g�rant vous offre en recompense un abonnement d'un an sur les produits Mac king Fast Burger en plus de la prime de 30 000$.         Fast Food secteur 5B.

Mission H
Un d�tachement motoris� de la plus puissante bande de la ville viens de d�valiser l'agence locale de la Federal City Bank. La formation a �t� localis�e sur la highway 21. Attention: les otages sont transport�s dans un bus scolaire bien escort� et le butin dans un v�hicule blind� qui a pris une d�viation. Soyez rapide, lib�rez  les otages et reprenez le magot. Prime: 40 000$


                                                                                                                                I  a  s  �  �  �  �  �  �    *  8  �  �  �  �      {u{oke_e_e_e_e_e_e      <   �  �  �  �  1#  B#  �#  $  D%  ]%  u%  �%  �&  �&  �'  �'  V+  a+  �,  ysysymysysygygygygy         �,  �,  _.  j.  �1  �1  ysyso                                                                                         I    �  _  a  c  e  �  �  �  �  �  �  �  �  �  �  �	  �	  �	  e
    �  yyyyyyyyyyyyyyyyyyyyyyy     �  �  �  �  �    B  �  �  �    l  �  �  (  *  8  �  �  �     "  S  h  yyyyyyyyyyyyyyyyyyyyyyy     h  z  |  �  �      G  V  m  �  �  �      .  C  b  �  �  �  �  �  �  yyyyyyyyyyyyyyyyyyyyyyy     �  �  �  �  �  �  Q  �  �  
        J  �  ;  �  �  �  �  �  �  �  �  yyyyyyyyyyyyyyyyyyyyyyy     �  �  �  �    5  J  �  �  ]  �  h  o  �  �  �  �  �  /  �  �  �  y  ;  yyyyyyyyyyyyyyyyyyyyyyy     