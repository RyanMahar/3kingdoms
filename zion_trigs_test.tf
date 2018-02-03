;HP:2541/2541/64 ST:77.28% PP:100.00% 37[40.13%] E[] 2/25% N AGDH

; basically hp/maxhp/sp stamina protoplasm
;      bioplast[showskill] e[opponent] relinquish/flux force
;      status
/set hyperproliferate 0
/set per 0
/set flux 0
/set diss 0
;
;
; Parsing powers through regex 
;/while ((_c:=substr(_arg, ++_i, 1)) !~ "" ) \
;
;/elseif (_c =~ "/")\
;      /test _c2 := substr(_arg, ++_i)%;\
;    /elseif (regmatch("[ZCFHPMLSVbdeghiprsuwx]", _c)) \
;      /if (_c =~ "Z") /let _c=home 182%; /endif%;\
;      /if (_c =~ "C") /let _c=chaos%; /endif%;\
;


;confighp HP[$CHP/$MHP] SP[$CSP/$MSP] ST[$STA] PP[$PPM] CF[$CFX] FF[$FAM] E[$MON] BP[$BPL] G2N:$SKP Coh:$COH $STS
;HP[2465/2465] SP[41/92] ST[100.00%] PP[100.00%] CF[3/87%] FF[88.32%] E[] BP[6] G2N:74.20% Coh:strong N DBH

/def -p1 -ag -mregexp -t'HP\\[([0-9]+)\\/([0-9]+)\\] SP\\[([0-9]+)\\/([0-9]+)\\] ST\\[([^ ]+)\\%\\] PP\\[([^ ]+)\\%\\] CF\\[([0-9]+)\\/([0-9]+)\\%\\] FF\\[(([0-9]+).([0-9]+)|MAX|_MAX_)*(\\%)*\\] E\\[(.*)\\] BP\\[([0-9]+)\\] G2N\\:([^ ]+)\\% Coh\\:(.*) (D|N|B) ((R:[0-9]+\% )?[GALDTHBVP]+)' morphbar = \
/set hp %P1%;\
/set hpmax %P2%;\
/let hpD $[hp - hpmax]%;\
/set sp %P3%;\
/set spmax %P4%;\
/set st %P5%;\
/set pp %P6%;\
/set cf %P7%;\
/set cfreset %P8%;\
/set ffam %P9%;\
/set enemy %P13%;\
/set bioplasts %P14%;\
/set g2n %P15%;\
/if ((%P16) =~ "strong")/set cohesion 6%;/endif%;\
/if ((%P16) =~ "somewhat strong")/set cohesion 5%;/endif%;\
/if ((%P16) =~ "moderate")/set cohesion 4%;/endif%;\
/if ((%P16) =~ "weakened")/set cohesion 3%;/endif%;\
/if ((%P16) =~ "strained")/set cohesion 2%;/endif%;\
/if ((%P16) =~ "failing")/set cohesion 1%;/endif%;\
/if ((%P16) =~ "non-existant")/set cohesion 0%;/endif%;\
/set forces %P17%;\
/set powers %P18%;\
/if (regmatch("[R:0-9\%]+", powers))/set flux=1%;/endif%;\
/if (regmatch("[A]", powers))/echo COMBAT(adrenalized)%;/set adrenalize=1%;/endif%;\
/if (regmatch("[B]", powers))/set biolight=1%;/else /set biolight=0%;/endif%;\
/if (regmatch("[D]", powers))/set diss=1%;/endif%;\
/if (regmatch("[L]", powers))/echo COMBAT(linked)%;/set link=1%;/endif%;\
/if (regmatch("[H]", powers))/set hyperproliferate=1%;/else /set hyperproliferate 0%;/endif%;\
/if (regmatch("[G]", powers))/set augment=1%;/endif%;\
/if (regmatch("[T]", powers))/echo COMBAT(thermotaxis)%;/set thermotaxis=1%;/endif%;\
/if (regmatch("[P]", powers))/set perform=1%;/endif%;\
/if (regmatch("[V]", powers))/set per=1%;/endif%;\
/status_graph hp hpmax	%;\
/status_graph st mdef	%;\
/status_graph pp mdef	%;\
/status_graph enemy mdef%;\
/if ((hp < hpmax)&(pp > 98))!morph%;/endif%;\
/if ((cf > 0)&(cfreset > 98))!relinquish%;/echo HEAL(CF_UNUSED(%cf@%cfreset\%))\-\>act(!relinquish)%;/endif%;\
/if ((cf > 1)&(cfreset > 67))!relinquish%;/echo HEAL(CF_TIMED(%cf@%cfreset\%))\-\>act(!relinquish)%;/endif%;\
/if ((cf > 2)&(cfreset > 55))!relinquish%;/echo HEAL(CF_TIMED(%cf@%cfreset\%))\-\>act(!relinquish)%;/endif%;\
/if ((!hyperproliferate)&(sp > 9)&(pp < 90))!hyperproliferate on%;/endif%;\
/if ((!per)&((st - 15) > pp))!per on%;/echo COMBAT(balance(%st > %pp)\-\>act(!persistence on)%;/endif%;\
/if ((per=1)&(st < pp))!per off%;/echo COMBAT(balance(%st < %pp)\-\>act(!persistence off)%;/endif%;\
/set status_bar $[pad("HP:",3,hp,4,"/",1,hpmax,4,"/",1,sp,2,"_ST:",4,st,6,"%",1,"_PP:",4,pp,6,"%_",2,bioplasts,3,"[",1,g2n,6,"%]_E[",5,enemy,6,"]_",2,cf,1,"/",1,cfreset,2,"%_",2,forces,1,"_",1,powers,8)]%;\
/set status_bar2 $[pad("HP:",3,hp_graph,10,"_ST:",4,st_graph,10,"_PP:",4,pp_graph,10,"_E:",3,enemy_graph,10)]     %;

/load module_combat.tf
/load module_dog.tf
/load module_changeling.tf


;1 *Adamantite Bracers (wavering) {Slimed} (engulfed).
; 1 *nacho cheese (huge).
; 1 *sour cream (huge).
; 1 An enchanted coffin (0 corpses) [......] [Empty].
; 1 *Party banner of Disorderly Conduct.
; 1 *A long trunk.
; 1 *A Transmuter's Stone (filled with 96 colours).
; 1 *A Crafter's Satchel.
; 1 *A Magician's Top Hat.
; 1 *Acrobat's Bodysuit (worn).
; 1 *long shimmering thread.
; 1 *a sexy black apron (almost lacy).
; 1 *A scavenger hunt item list (item list).
; 1 *fuzzy bunny slippers.
; 1 *Worn leather book.
; 1 A Rainbow Pride Badge (worn).
; 1 *An ID Card.
; 1 *A ring of house keys.
; 1 *An auction line.
; 1 *A GBC Radio.
; 1 *Magic: The Gathering Chatline.
; 1 *Safari Hat.
; 1 *Tactician's Manual.
; 1 *A hand in the game of Euchre.
; 1 *Dundee hunting permit.
; 1 *Clan Symbol of Nightmare Asylum.
;10478 coins (weightless)
;;; STEPPER MACRO

/def bot = /eval /boton%;/stepping %{1}%;/key_f8

/alias dp /eval unwrap all%;/rp 35 b%;bsort%;

;; MOVE TO DOG.TF

/def -t'^Your dog looks up at your expectantly, as if awaiting your command' dog_command_add =\
	/set commands 1			%;
/def -t'^Your dog has begun combat with' dog_combat_start = \
	/if (commands = 1) do_incite = vi%;\
	/endif
/def -t'^Your pet is not ready for another command!' no_incite = \
	/set commands 0			%;

;;                           ;;
;; Hyperproliferating Events ;;
;;                           ;;

/def -t'You are too mentally drained to continue accelerating your regeneration\!' hyperproliferate_off_1 = \
	/set hyperproliferate 0%;
/def -t'You begin to concentrate on accelerating your natural regeneration process\.' hyperproliferate_on1 = \
	/set hyperproliferate 1%;
/def -t'You cease to concentrate on accelerating your regeneration\.' hyperproliferate_off2 = \
	/set hyperproliferate 0%;
/def -t'You resume accelerating your natural regeneration\.' hyperproliferate_on4 = \
        /set hyperproliferate 1%;
/def -t'You are currently using hyperproliferate\.' hyperproliferate_on5 = \
	/set hyperproliferate 1%; 
;;                      ;;
;; Relinquishing Events ;;
;;                      ;;

/def -t'You relinquish yourself to Chaos, and immediately feel the unpredictable' relinquishing_on1 = \
	/set flux 1		%;
/def -t'The chaotic forces seeking control of you begin to wane, your control' relinquishing_off1 = \
	/set flux 0%;
/def -t'returning as the energies cease to course chaotically through you.' relinquishing_off2 = \
	/set flux 0%;
/def -t'Hyperproliferate will be activated when relinquish ends.' hyperproliferate_off3 = \
	/set hyperproliferate 1%;
/def -t'You are not currently using hyperproliferate.' hyperproliferate_off7 = \
	/set hyperproliferate 0%;


;;                     ;;
;; Perseverence Events ;;
;;                     ;;

/def -t'You focus on retaining your shape.' persevering_on1 = \
	/set per 1%;
/def -t'You will no longer persevere.' persevering_off2 = \
	/set per 0%;
/def -t'You are not currently persevering.' perseverance_off4 = \
	/set per 0%;
/def -t'You are currently persevering.' perseverance_on5 = \
	/set per 1%;
/def -t'You are too fatigued to continue to persevere!' perseverance_off5 = \
	/set per 0%;\
	!smuggle remove bioplast	%;\
	!consume bioplast		%;

;;                  ;;
;; Dissipate Events ;;
;;                  ;;
   
/def -t'^You are too fatigued to dissipate any more attacks!' dissipate_off = \
	/set diss 0		%;\
	!smuggle remove bioplast	%;\
	!consume bioplast		%;\
	!dissipate on			%;
/def -t'You are currently dissipating attacks against you.' dissipate_on2 = \
	/set diss  1		%;
/def -t'You will no longer dissipate attacks against you.' dissipate_off2 = \
	/set diss 0		%;
/def -t'You begin to concentrate on turning aside harmful attacks.' dissipate_on = \
	/set diss 1%;

;;                       ;;
;; Changeling Guild Gags ;;
;;                       ;;

/def -ag -t'Zion gives A bioplast \([a-z]+\) to you\.' bsort_gag1
/def -ag -t'You give A bioplast \([a-z]+\) to Zion\.' bsort_gag2

