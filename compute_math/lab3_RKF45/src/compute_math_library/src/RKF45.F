      SUBROUTINE RKF45(F,NEQN,Y,T,TOUT,RELERR,ABSERR,
     *                 IFLAG,WORK,IWORK)
C
C     METOД PУHГE-KУTTA ФEЛЬБEPГA ЧETBEPTOГO-ПЯTOГO ПOPЯДKA
C
C     COCTABИTEЛИ ПPOГPAMMЫ-H.A.WATTS,L.F.SHAMPINE
C                SANDIA LABORATORIES
C              ALBUQUERQUE, NEW MEXICO
C
C     RKF45 ПPEДHAЗHAЧEHA ГЛABHЫM OБPAЗOM ДЛЯ PEШEHИЯ
C     HEЖECTKИX И CЛAБO ЖECTKИX ДИФФEPEHЦИAЛЬHЫX УPABHEHИЙ,
C     KOГДA BЫЧИCЛEHИE ПPOИЗBOДHЫX HE CЛИШKOM ДOPOГOCTOЯЩEE.
C     RKF45, BOOБЩE ГOBOPЯ,HE CЛEДУET ИCПOЛЬЗOBATЬ
C     ECЛИ ПOЛЬЗOBATEЛЮ TPEБУETCЯ BЫCOKAЯ TOЧHOCTЬ
C
C     PEЗЮME
C
C     ПOДПPOГPAMMA RKF45 ИHTEГPИPУET CИCTEMУ ИЗ NEQN
C     OБЫKHOBEHHЫX ДИФФEPEHЦИAЛЬHЫX УPABHEHИЙ ПEPBOГO
C     ПOPЯДKA CЛEДУЮЩEГO BИДA:
C
C            DY(I)/DT=F(T,Y(1),Y(2),...,Y(NEQN),
C
C     ГДE Y(I) ЗAДAHЫ B T.
C     OБЫЧHO ПOДПPOГPAMMУ ПPИMEHЯЮT ДЛЯ ИHTEГPИPOBAHИЯ
C     OT T ДO TOUT, OДHAKO EE MOЖHO ИCПOЛЬЗOBATЬ И KAK
C     OДHOШAГOBЫЙ ИHTEГPATOP,ЧTOБЫ ПPOДOЛЖИTЬ PEШEHИE HA
C     OДИH ШAГ B HAПPABЛEHИИ TOUT.HA BЫXOДE ПAPAMETPAM,
C     ФИГУPИPУЮЩИM B CПИCKE BЫЗOBA, ПPИCBAИBAЮTCЯ ЗHAЧEHИЯ,
C     HEOБXOДИMЫE ДЛЯ ПPOДOЛЖEHИЯ ИHTEГPИPOBAHИЯ. ПOЛЬЗO-
C     BATEЛЮ HУЖHO ЛИШЬ EЩE PAЗ OБPATИTЬCЯ K RKF45
C     (И,BOЗMOЖHO,OПPEДEЛИTЬ HOBOE ЗHAЧEHИE ДЛЯ TOUT).
C     B ДEЙCTBИTEЛЬHOCTИ RKF45-ЭTO ПPOГPAMMA ИHTEPФEЙCA,
C     KOTOPAЯ BЫЗЫBAET ПOДПPOГPAMMУ RKFS, OCУЩECTBЛЯЮЩУЮ
C     ПPOЦECC PEШEHИЯ.RKFS B CBOЮ OЧEPEДЬ BЫЗЫBAET ПOДПPOГ-
C     PAMMУ FEHL, KOTOPAЯ BЫЧИCЛЯET ПPИБЛИЖEHHOE PEШEHИE
C     HA OДИH ШAГ.
C
C     RKF45 ИCПOЛЬЗУET METOД PУHГE-KУTTA-ФEЛЬБEPГA, OПИCAHHЫЙ
C     B CЛEДУЮЩEЙ ПУБЛИKAЦИИ:E.FEHLBERG,LOW-ORDER CLASSICAL
C     RUNGE-KUTTA FORMULAS WITH STEPSIZE CONTROL,NASA TR R-315
C
C     CTИЛЬ PAБOTЫ ПPOГPAMMЫ RKF45 ИЛЛЮCTPИPУETCЯ B CЛEДУЮЩИX
C     ПУБЛИKAЦИЯX:L.F.SHAMPINE,H.A.WATTS,S.DAVENPORT, SOLVING
C     NON-STIFF ORDINARY DIFFERENTIAL EQUATIONS-THE STAT OF
C     THE ART,SANDIA LABORATORIES REPORT SAND75-0182,SIAM
C     REVIEW,18(1976), N3,376-411.
C
C     ПAPAMETPЫ ПPOГPAMMЫ:
C
C     F       -ПOДПPOГPAMMA F(T,Y,YP) ДЛЯ BЫЧИCЛEHИЯ
C              ПPOИЗBOДHЫX YP(I)=DY(I)/DT
C     NEQN    -ЧИCЛO ИHTEГPИPУEMЫX УPABHEHИЙ
C     Y(*)    -PEШEHИE B TOЧKE T
C     T       -HEЗABИCИMAЯ ПEPEMEHHAЯ
C     TOUT    -TOЧKA BЫXOДA,B KOTOPOЙ HУЖHO OПPEДEЛИTЬ
C              ЗHAЧEHИE PEШEHИЯ
C     RELERR  -ГPAHИЦA OTHOCИTEЛЬHOЙ ПOГPEШHOCTИ
C              ДЛЯ TECTA ЛOKAЛЬHOЙ OШИБKИ.
C     ABSERR  -ГPAHИЦA ABCOЛЮTHOЙ ПOГPEШHOCTИ
C              ДЛЯ TECTA ЛOKAЛЬHOЙ OШИБKИ.
C              HA KAЖДOM ШAГE ПPOГPAMMA TPEБУET BЫПOЛHEHИЯ УCЛOBИЯ
C              ABS(LOCAL ERROR).LE.RELERR*ABS(Y)+ABSERR
C              ДЛЯ KAЖДOЙ KOMПOHEHTЫ BEKTOPOB ЛOKAЛЬHOЙ
C              OШИБKИ И PEШEHИЯ
C     IFLAG   -УKAЗATEЛЬ PEЖИMA ИHTEГPИPOBAHИЯ.
C     WORK(*) -MACCИB,COДEPЖAЩИЙ ИHФOPMAЦИЮ,BHУTPEHHЮЮ ДЛЯ RKF45,
C              KOTOPAЯ HEOБXOДИMA ПPИ ПOCЛEДУЮЩИX BЫЗOBAX.EГO
C              PAЗMEPHOCTЬ ДOЛЖHA БЫTЬ HE MEHЬШE 3+6*NEQN
C     IWORK(*)-ЦEЛЫЙ MACCИB,COДEPЖAЩИЙ ИHФOPMAЦИЮ,BHУTPEHHЮЮ ДЛЯ
C              RKF45,KOTOPAЯ HEOБXOДИMA ПPИ ПOCЛEДУЮЩИX BЫЗOBAX.
C              EГO PAЗMEPHOCTЬ ДOЛЖHA БЫTЬ HE MEHЬШE 5.
C
C     ПEPBOE OБPAЩEHИE K RKF45
C
C     ПOЛЬЗOBATEЛЬ ДOЛЖEH ПPEДУCMOTPETЬ B CBOEЙ BЫЗЫBAЮЩEЙ
C     ПPOГPAMME ПAMЯTЬ ДЛЯ CЛEДУЮЩИX MACCИBOB, ФИГУPИPУЮЩИX
C     B CПИCKE BЫЗOBA- Y(NEQN), WORK(3+6*NEQN), IWORK(5);
C     KPOME TOГO, OH ДOЛЖEH OБ'ЯBИTЬ F B OПEPATOPE EXTERNAL,
C     ПOДГOTOBИTЬ ПOДПPOГPAMMУ F(T,Y,YP) И ПPИCBOИTЬ HAЧAЛЬ-
C     HЫE ЗHAЧEHИЯ ПAPAMETPAM-
C
C     NEQN  -ЧИCЛO ИHTEГPИPУEMЫX УPABHEHИЙ (NEQN.GE.1)
C     Y(*)  -BEKTOP HAЧAЛЬHЫX УCЛOBИЙ
C     T     -HAЧAЛЬHAЯ TOЧKA ИHTEГPИPOBAHИЯ,
C            T ДOЛЖHO БЫTЬ ПEPEMEHHOЙ.
C     TOUT  -TOЧKA BЫXOДA,B KOTOPOЙ HУЖHO HAЙTИ ЗHAЧEHИE
C            PEШEHИЯ. T=TOUT BOЗMOЖHO ЛИШЬ ПPИ ПEPBOM
C            OБPAЩEHИИ.B ЭTOM CЛУЧAE BЫXOД ИЗ RKF45 ПPOИ-
C            CXOДИT CO ЗHAЧEHИEM ПAPAMETPA IFLAG=2,ECЛИ
C            MOЖHO ПPOДOЛЖATЬ ИHTEГPИPOBAHИE.
C     RELERR-ГPAHИЦA ДЛЯ OTHOCИTEЛЬHOЙ ЛOKAЛЬHЫЙ ПOГPEШHOCTEИ.
C     ABSERR-ГPAHИЦA ДЛЯ AБCOЛЮTHOЙ    ЛOKAЛЬHЫЙ ПOГPEШHOCTEИ.
C            ЭTИ ГPAHИЦЫ ДOЛЖHЫ БЫTЬ HEOTPИЦATEЛЬHЫ.
C            RELERR ДOЛЖHA БЫTЬ ПEPEMEHHOЙ,A ABSERR MOЖET
C            БЫTЬ И KOHCTAHTOЙ.ПPOГPAMME, BOOБЩE ГOBOPЯ
C            HE CЛEДУET ЗAДABATЬ ГPAHИЦУ ДЛЯ OTHOCИTEЛЬHOЙ
C            OШИБKИ,MEHЬШУЮ, ЧEM ПPИMEPHO 1.E-7. ДAБЫ ИЗБEЖATЬ
C            TPУДHOCTEЙ ,CBЯЗAHHЫX C OЧEHЬ BЫCOKИMИ ЗAПPOCAMИ
C            K TOЧHOCTИ, ПPOГPAMMA TPEБУET,ЧTOБЫ RELERR
C            БЫЛA БOЛЬШE, ЧEM HEKOTOPЫЙ ПAPAMETP OTHOCИTEЛЬHOЙ
C            OШИБKИ,BЫЧИCЛЯEMЫЙ BHУTPИ EE И ЗABИCЯЩИЙ OT
C            MAШИHЫ.B ЧACTHOCTИ,HE PAЗPEШAETCЯ ЗAДAHИE TOЛЬKO
C            AБCOЛЮTHOЙ OШИБKИ.ECЛИ ЖE ЗAДAHO ЗHAЧEHИE RELERR,
C            MEHЬШEE ДOПУCTИMOГO, TO RKF45 УBEЛИЧИBAET RELERR
C            HAДЛEЖAЩИM OБPAЗOM И BOЗBPAЩAET УПPABЛEHИE ПOЛЬ-
C            ЗOBATEЛЮ, ПPEЖДE ЧEM ПPOДOЛЖATЬ ИHTEГPИPOBAHИE.
C     IFLAG-+1,-1.ЭTO УKAЗATEЛЬ HACTPOЙKИ ПPOГPAMMЫ ДЛЯ KAЖДOЙ
C            HOBOЙ ЗAДAЧИ. HOPMAЛЬHOE BXOДHOE ЗHAЧEHИE PABHO+1.
C            ПOЛЬЗOBATEЛЬ ДOЛЖEH ЗAДABATЬ IFLAG=-1 ЛИШЬ B TOM
C            CЛУЧAE,  KOГДA HEOБXOДИMO УПPABЛEHИE OДHOШAГOBЫM
C            ИHTEГPATOPOM.B ЭTOM CЛУЧAE RKF45 ПЫTAETCЯ ПPOДOЛЖИTЬ
C            PEШEHИE HA OДИH ШAГ B HAПPABЛEHИИ TOUT ПPИ KAЖДOM
C            OЧEPEДHOM BЫЗOBE. ПOCKOЛЬKУ ЭTOT PEЖИM PAБOTЫ
C            BECЬMA HEЭKOHOMИЧEH, EГO CЛEДУET ПPИMEHЯTЬ
C            ЛИШЬ B CЛУЧAE KPAЙHEЙ HEOБXOДИMOCTИ.
C
C     ИHФOPMAЦИЯ HA BЫXOДE
C
C     Y(*)    -PEШEHИE B TOЧKE T
C     T       -ПOCЛEДHЯЯ TOЧKA,ДOCTИГHУTAЯ ПPИ ИHTEГPИPOBAHИИ.
C     IFLAG=2 -ПPИИHTEГPИPOBAHИИ ДOCTИГHУTO TOUT.ЭTO ЗHAЧEHИE
C              ПAPAMETPA УKAЗЫBAET HA УCПEШHЫЙ BЫXOД И
C              ЯBЛЯETCЯ HOPMAЛЬHЫM PEЖИMOM ДЛЯ ПPOДOЛЖEHИЯ
C              ИHTEГPИPOBAHИЯ.
C          =3 -ИHTEГPИPOBAHИE HE БЫЛO ЗAKOHЧEHO ИЗ-ЗA TOГO,
C              ЧTO ЗAДAHHOE ЗHAЧEHИE ГPAHИЦЫ ДЛЯ OTHOCИTEЛЬHOЙ
C              OШИБKИ OKAЗAЛOCЬ CЛИШKOM MAЛO. ДЛЯ ПPOДOЛЖEHИЯ
C              ИHTEГPИPOBAHИЯ RELERR БЫЛO HAДЛEЖAЩИM OБPAЗOM
C              УBEЛИЧEHO.
C          =4 -ИHTEГPИPOBAHИE HE БЫЛO ЗAKOHЧEHO ИЗ-ЗA TOГO,
C              ЧTO ПOTPEБOBAЛOCЬ БOЛEE 3000 BЫЧИCЛEHИЙ ПPO-
C              ИЗBOДHOЙ.ЭTO COOTBETCTBYET ПPИБЛИЗИTEЛЬHO
C              500 ШAГAM.
C          =5 -ИHTEГPИPOBAHИE HE БЫЛO ЗAKOHЧEHO ИЗ-ЗA TOГO,
C              ЧTO PEШEHИE OБPATИЛOCЬ B HYЛЬ,BCЛEДCTBИE ЧEГO
C              TECT TOЛЬKO OTHOCИTEЛЬHOЙ OШИБKИ HE ПPOXOДИT.
C              ДЛЯ ПPOДOЛЖEHИЯ HEOБXOДИMO HEHYЛEBOE ЗHAЧEHИE
C              ПAPAMETPA ABSERR. ИCПOЛЬЗOBAHИE HA OДИH ШAГ
C              PEЖИMA ПOШAГOBOГO ИHTEГPИPOBAHИЯ ЯBЛЯETCЯ
C              PAЗYMHЫM BЫXOДOM ИЗ ПOЛOЖEHИЯ.
C          =6 -ИHTEГPИPOBAHИE  HE БЫЛO ЗAKOHЧEHO ИЗ-ЗA TOГO,
C              ЧTO TPEБYEMAЯ TOЧHOCTЬ HE MOГЛA БЫTЬ ДOCTИГHУTA
C              ДAЖE ПPИ HAИMEHЬШEЙ ДOПУCTИ MOЙ BEЛИЧИHE ШAГA.
C              ПOЛЬЗOBATEЛЬ ДOЛЖEH УBEЛИЧИTЬ ГPAHИЦУ ПOГPEШ-
C              HOCTИ,ПPEЖДE ЧEM MOЖHO БУДET ПOПЫTATЬCЯ
C              ПPOДOЛЖATЬ ИHTEГPИPOBAHИE.
C          =7 -ПO BCEЙ BИДИMOCTИ, RKF45 HEЭФФEKTИBHA ПPИ
C              PEШEHИИ ЭTOЙ ЗAДAЧИ. CЛИШKOM БOЛЬШOE ЧИCЛO
C              TPEБУEMЫX BЫXOДHЫX TOЧEK ПPEПЯTCTBУET BЫБOPУ
C              ECTECTBEHHOЙ BEЛИЧИHЫ ШAГA.CЛEДУET ИCПOЛЬЗOBATЬ
C              PEЖИM ПOШAГOBOГO ИHTEГPИPOBAHИЯ.
C          =8 -HEПPABИЛЬHOE ЗAДAHИE BXOДHЫX ПAPAMETPOB.ЭTO
C              ЗHAЧEHИE ПOЯBЛЯETCЯ,ECЛИ ДOПУЩEHA OДHA ИЗ
C              CЛEДУЮЩИX OШИБOK-
C                              NEQN.LE.0
C                  T=TOUT  И  IFLAG.NE.+1  ИЛИ -1
C                  RELERR  ИЛИ  ABSERR.LT.0
C                  IFLAG.EQ.0  ИЛИ .LT.-2  ИЛИ .GT.8
C     WORK(*) -ИHФOPMAЦИЯ, KOTOPAЯ OБЫЧHO HE ПPEДCTABЛЯET ИHTE-
C              PECA ДЛЯ ПOЛЬЗOBATEЛЯ, HO HEOБXOДИMA ПPИ ПOCЛE-
C              ДУЮЩИX BЫЗOBAX. WORK(1),...,WORK(NEQN) COДEPЖAT
C              ПEPBЫE ПPOИЗBOДHЫE BEKTOPA PEШEHИЯ Y B TOЧKE T.
C              WORK(NEQN+1) XPAHИT BEЛИЧИHУ ШAГA H,C KOTOPOЙ
C              MOЖHO ПOПЫTATЬCЯ ПPOBECTИ CЛEДУЮЩИЙ ШAГ.
C     IWORK(*) -ИHФOPMAЦИЯ, KOTOPAЯ OБЫЧHO HE ПPEДCTABЛЯET ИHTE-
C               PECA ДЛЯ ПOЛЬЗOBATEЛЯ, HO HEOБXOДИMA ПPИ ПOCЛE-
C               ДУЮЩИX BЫЗOBAX. B IWORK(1) COДEPЖИTCЯ
C               CЧETЧИK ЧИCЛA BЫЧИCЛEHИЙ ПPOИЗBOДHЫX.
C
C     ПOCЛEДУЮЩИE OБPAЩEHИЯ K RKF45
C
C          HA BЫXOДE ПOДПPOГPAMMЫ RKF45 ИMEETCЯ BCЯ ИHФOPMAЦИЯ,
C     HEOБXOДИMAЯ  ДЛЯ ПPOДOЛЖEHИЯ ИHTEГPИPOBAHИЯ.ECЛИ ПPИ
C     ИHTEГPИPOBAHИИ ДOCTИГHУTO TOUT,TO ПOЛЬЗOBATEЛЮ ДOCTA-
C     TOЧHO OПPEДEЛИTЬ HOBOE ЗHAЧEHИE  TOUT И CHOBA OБPATИTЬ-
C     CЯ K RKF45.
C          B PEЖИME ПOШAГOBOГO ИHTEГPИPOBAHИЯ (IFLAG=-2)
C     ПOЛЬЗOBATEЛЬ ДOЛЖEH ИMETЬ B BИДУ,ЧTO KAЖДЫЙ ШAГ
C     BЫПOЛHЯETCЯ B HAПPABЛEHИИ TEKУЩEГO ЗHAЧEHИЯ TOUT
C     (CИГHAЛИЗИPУEMOM  ИЗMEHEHИEM IFLAG HA 2). ПOЛЬЗOBATEЛЬ
C     ДOЛЖEH ЗAДATЬ HOBOE ЗHAЧEHИE TOUT И ПEPEOПPEДEЛИTЬ
C     IFLAG HA -2, ЧTOБЫ ПPOДOЛЖATЬ B PEЖИME ПOШAГOBOГO
C     ИHTEГPИPOBAHИЯ.
C          ECЛИ ИHTEГPИPOBAHИE HE БЫЛO ЗAKOHЧEHO,HO
C     ПOЛЬЗOBATEЛЬ XOЧET ПPOДOЛЖATЬ (CЛУЧAИ IFLAG=3,4), OH
C     ПOПPOCTУ CHOBA OБPAЩAETCЯ K RKF45.ПPИ IFLAG=3 ПAPA-
C     METP RELERR БЫЛ  ИЗMEHEH HAДЛEЖAЩИM ДЛЯ ПPOДOЛЖEHИЯ
C     ИHTEГPИPOBAHИЯ OБPAЗOM.B CЛУЧAE IFLAG=4 CЧETЧИK
C     ЧИCЛA ЗHAЧEHИЙ ФУHKЦИИ БУДET ПEPEOПPEДEЛEH HA 0, И
C     БУДУT PAЗPEШEHЫ EЩE 3000 BЫЧИCЛEHИЙ ФУHKЦИИ.
C          OДHAKO B CЛУЧAE IFLAG=5, ПPEЖДE ЧEM MOЖHO БУДET
C     ПPOДOЛЖATЬ ИHTEГPИPOBAHИE,ПOЛЬЗOBATEЛЬ ДOЛЖEH CHAЧAЛA
C     ИЗMEHИTЬ KPИTEPИЙ OШИБKИ, ЗAДAB ПOЛOЖИTEЛЬHOE ЗHAЧEHИE
C     ДЛЯ ABSERR. ECЛИ OH HE CДEЛAET ЭTOГO, BЫПOЛHEHИE ПPO-
C     ГPAMMЫ БУДET ПPEKPAЩEHO.
C        TOЧHO TAK ЖE,B CЛУЧAE IFLAG=6,ПPEЖДE ЧEM ПPOДOЛ-
C     ЖATЬ ИHTEГPИPOBAHИE,ПOЛЬЗOBATEЛЮ HEOБXOДИMO ПEPEOПPE-
C     ДEЛИTЬ IFLAG HA 2 (ИЛИ -2, ECЛИ ИCПOЛЬЗУETCЯ PEЖИM
C     ПOШAГOBOГO ИHTEГPИPOBAHИЯ) И УBEЛИЧИTЬ ЗHAЧEHИE ДЛЯ
C     ABSERR ЛИБO RELERR,ЛИБO И ДЛЯ TOГO,И ДЛЯ ДPУГOГO.
C     ECЛИ ЭTO HE БУДET CДEЛAHO,BЫПOЛHEHИE ПPOГPAMMЫ
C     ПPEKPAЩAETCЯ. ПOЯBЛEHИE IFLAG=6 УKAЗЫBAET HA HEPEГУ-
C     ЛЯPHOCTЬ (PEШEHИE БЫCTPO MEHЯETCЯ ИЛИ, BOЗMOЖHO,
C     ИMEETCЯ OCOБEHHOCTЬ),И ЧACTO B ПOДOБHЫX CЛУЧAЯX
C     HE ИMEET CMЫCЛA ПPOДOЛЖATЬ ИHTEГPИPOBAHИE.
C          ECЛИ БУДET ПOЛУЧEHO ЗHAЧEHИE IFLAG=7,TO ПOЛЬЗO-
C     BATEЛЬ ДOЛЖEH ПEPEЙTИ K PEЖИMУ ПOШAГOBOГO ИHTEГPИPO-
C     BAHИЯ C BEЛИЧИHOЙ ШAГA,OПPEДEЛЯEMOЙ ПPOГPAMMOЙ, ИЛИ
C     PACCMOTPETЬ BOЗMOЖHOCTTЬ ПEPEXOДA HA ПPOГPAMMЫ METOДOB
C     AДAMCA.ECЛИ BCE ЖE ПOЛЬЗOBATEЛЬ XOЧET ПPOДOЛЖATЬ
C     ИHTEГPИPOBAHИE ПO ПOДПPOГPAMME RKF45,OH ДOЛЖEH ДO HOBOГO
C     OБPAЩEHИЯ K HEЙ ПEPEOПPEДEЛИTЬ IFLAG HA 2.B ПPOTИBHOM
C     CЛУЧAE BЫПOЛHEHИE ПPOГPAMMЫ БУДET ПPEKPAЩEHO.
C          ECЛИ ПOЛУЧEHO ЗHAЧEHИE IFLAG=8,TO ИHTEГPИPOBAHИE
C     HEЛЬЗЯ ПPOДOЛЖATЬ,ПOKA HE БУДУT ИCПPABЛEHЫ OШИБOЧHЫE
C     BXOДHЫE ПAPAMETPЫ. HУЖHO OTMETИTЬ,ЧTO MACCИBЫ WORK И
C     IWORK COДEPЖAT ИHФOPMAЦИЮ,HEOБXOДИMУЮ ДЛЯ ДAЛЬHEЙШEГO
C     ИHTEГPИPOBAHИЯ.ПOЭTOMУ B ЭTИ MACCИBЫ HEЛЬЗЯ BHOCИTЬ
C     ИЗMEHEHИЙ.
C
      EXTERNAL F
      INTEGER NEQN,IFLAG,IWORK(5)
      REAL Y(NEQN),T,TOUT,RELERR,ABSERR,WORK(1)
C
C     ECЛИ TPAHCЛЯTOP ПPOBEPЯET ИHДEKCЫ, TO ЗAMEHИTЬ
C     WORK(1) HA WORK(3+6*NEQN)
C
      INTEGER K1,K2,K3,K4,K5,K6,K1M
C
C     BЫЧИCЛИTЬ ИHДEKCЫ ДЛЯ PACЩEПЛEHИЯ PAБOЧEГO MACCИBA
C
      K1M=NEQN+1
      K1=K1M+1
      K2=K1+NEQN
      K3=K2+NEQN
      K4=K3+NEQN
      K5=K4+NEQN
      K6=K5+NEQN
C
C     ЭTA ПPOMEЖYTOЧHAЯ ПPOГPAMMA ПPOCTO COKPAЩAET ДЛЯ
C     ПOЛЬЗOBATEЛЯ ДЛИHHЫЙ CПИCOK BЫЗOBA ПYTEM PACЩEПЛEHИЯ
C     ДBYX PAБOЧИX MACCИBOB. ECЛИ ЭTO HE COBMECTИMO C
C     TPAHCЛЯTOPOM,TO OH ДOЛЖEH OБPAЩATЬCЯ HEПOCPEДCTBEHHO
C     K ПOДПPOГPAMME RKFS .
C
      CALL RKFS(F,NEQN,Y,T,TOUT,RELERR,ABSERR,IFLAG,
     *          WORK(1),WORK(K1M),WORK(K1),WORK(K2),
     *          WORK(K3),WORK(K4),WORK(K5),WORK(K6),
     *          WORK(K6+1),IWORK(1),IWORK(2),
     *          IWORK(3),IWORK(4),IWORK(5))
      RETURN
      END
