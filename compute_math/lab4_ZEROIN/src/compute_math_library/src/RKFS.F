      SUBROUTINE RKFS(F,NEQN,Y,T,TOUT,RELERR,ABSERR,IFLAG,
     *                YP,H,F1,F2,F3,F4,F5,SAVRE,SAVAE,
     *                NFE,KOP,INIT,JFLAG,KFLAG)
C
C     METOД PУHГE-KУTTA-ФEЛЬБEPГA ЧETBEPTOГO-ПЯTOГO ПOPЯДKA
C     RKFS ИHTEГPИPУET CИCTEMУ OБЫKHOBEHHЫX ДИФФE-
C     PEHЦИAЛЬHЫX УPABHEHИЙ ПEPBOГO ПOPЯДKA(CM. KOM-
C     MEHTAPИЙ K RKF45). MACCИBЫ YP,F1,F2,F3,F4 И F5
C     (PAЗMEPHOCTИ ПO KPAЙHEЙ MEPE NEQN) И ПEPEMEH-
C     HЫE H,SAVRE,SAVAE,NFE,KOP,INIT,JFLAG И KFLAG
C     ИCПOЛЬЗУЮTCЯ BHУTPИ ПPOГPAMMЫ И BЫHECEHЫ B
C     CПИCOK BЫЗOBA,ЧTOБЫ COXPAHИTЬ ИX OПPEДEЛEH-
C     HOCTЬ ПPИ ПOBTOPHOM OБPAЩEHИИ.ПOЭTOMУ ИX ЗHA-
C     ЧEHИЯ HE ДOЛЖHЫ  ИЗMEHЯTЬCЯ  ПOЛЬЗOBATEЛEM.
C     BOЗMOЖHЫЙ ИHTEPEC ПPEДCTABЛЯЮT ПAPAMETPЫ
C     YP  -ПPOИЗBOДHAЯ BEKTOPA PEШEHИЯ B TOЧKE T
C     H   -ПPEДПOЛAГAEMЫЙ PAЗMEP ШAГA ДЛЯ OЧEPEДHOГO ЭTAПA
C     NFE -CЧETЧИK ЧИCЛA BЫЧИCЛEHИЙ ФУHKЦИИ
C
      LOGICAL HFAILD,OUTPUT
C
      INTEGER NEQN,IFLAG,NFE,KOP,INIT,JFLAG,KFLAG
      REAL Y(NEQN),T,TOUT,RELERR,ABSERR,H,YP(NEQN),
     *     F1(NEQN),F2(NEQN),F3(NEQN),F4(NEQN),F5(NEQN),
     *     SAVRE,SAVAE
C
      EXTERNAL F
C
      REAL A,AE,DT,EE,EEOET,ESTTOL,ET,HMIN,REMIN,
     *     RER,S,SCALE,TOL,TOLN,U26,EPSP1,EPS,YPK
C
      INTEGER K,MAXNFE,MFLAG
C
      REAL AMAX1,AMIN1
C
C     REMIN-ЭTO MИHИMAЛЬHOE ДOПУCTИMOE ЗHAЧEHИE ДЛЯ
C     RELERR.ПOПЫTKИ ПOЛУЧИTЬ ПO ЭTOЙ ПOДПPOГPAMME
C     БOЛEE BЫCOKУЮ TOЧHOCTЬ OБЫЧHO CTOЯT OЧEHЬ
C     ДOPOГO И ЗAЧACTУЮ БEЗУCПEШHЫ.
C
      SAVE ALL
      DATA REMIN/1.E-12/
C
C     CTOИMOCTЬ CЧETA KOHTPOЛИPУETCЯ TPEБOBAHИEM,
C     ЧTOБЫ KOЛИЧECTBO BЫЧИCЛEHИЙ ФУHKЦИИ БЫЛO OГ-
C     PAHИЧEHO BEЛИЧИHOЙ,ПPИБЛИЗИTEЛЬHO PABHOЙ ЗHA-
C     ЧEHИЮ ПAPAMETPA MAXNFE.ПPИHЯTOE ЗДECЬ ЗHAЧE-
C     HИE ПPИMEPHO COOTBETCTBУET 500 ШAГAM.
C
      DATA MAXNFE/3000/
C
C     ПPOBEPИTЬ BXOДHЫE ПAPAMETPЫ
C
      IF(NEQN.LT.1)GO TO 10
      IF((RELERR.LT.0.0).OR.(ABSERR.LT.0.0))GO TO 10
      MFLAG=IABS(IFLAG)
      IF((MFLAG.EQ.0).OR.(MFLAG.GT.8))GO TO 10
      IF(MFLAG.NE.1)GO TO 20
C
C     ПEPBЫЙ BЫЗOB,BЫЧИCЛИTЬ MAШИHHOE ЭПCИЛOH
C
      EPS=1.0
    5 EPS=EPS/2.0
      EPSP1=EPS+1.
      IF(EPSP1.GT.1.)GO TO 5
      U26=26.*EPS
      GO TO 50
C
C     OШИБKA BXOДHOЙ ИHФOPMAЦИИ
C
   10 IFLAG=8
      RETURN
C
C     ПPOBEPИTЬ BOЗMOЖHOCTИ ПPOДOЛЖEHИЯ
C
   20 IF((T.EQ.TOUT).AND.(KFLAG.NE.3))GO TO 10
      IF(MFLAG.NE.2)GO TO 25
C
C     IFLAG=+2 ИЛИ -2
C
      IF((KFLAG.EQ.3).OR.(INIT.EQ.0))GO TO 45
      IF(KFLAG.EQ.4)GO TO 40
      IF((KFLAG.EQ.5).AND.(ABSERR.EQ.0.0))GO TO 30
      IF((KFLAG.EQ.6).AND.(RELERR.LE.SAVRE).AND.
     *(ABSERR.LE.SAVAE))GO TO 30
      GO TO 50
C
C     IFLAG=3,4,5,6,7 ИЛИ 8
C
   25 IF(IFLAG.EQ.3)GO TO 45
      IF(IFLAG.EQ.4)GO TO 40
      IF((IFLAG.EQ.5).AND.(ABSERR.GT.0.0))GO TO 45
C
C     ИHTEГPИPOBAHИE HEЛЬЗЯ ПPOДOЛЖATЬ,ПOCKOЛЬKУ ПOЛЬ-
C     ЗOBATEЛЬ HE BЫПOЛHИЛ ИHCTPУKЦИЙ,COOTBETCTBУЮЩИX
C     ЗHAЧEHИЯM IFLAG=5,6,7 ИЛИ 8
C
   30 PRINT 35
   35 FORMAT("/20X,48HИHTEГPИPOBAHИE ПPEPBAHO, ПOCKOЛЬKУ ПOЛЬЗOBATEЛЬ ,
     *11HHE BЫПOЛHИЛ/20X,34HИHCTPУKЦИЙ RKF45, COOTBETCTBУЮЩИX ,
     *27HЗHAЧEHИЯM IFLAG=5,6,7 ИЛИ 8")
      STOP
C
C     ПEPEOПPEДEЛИTЬ CЧETЧИK ЧИCЛA BЫЧИCЛEHИЙ ФУHKЦИИ
C
   40 NFE=0
      IF(MFLAG.EQ.2)GO TO 50
C
C     ПEPEOПPEДEЛИTЬ ЗHAЧEHИE FLAG,УCTAHOBЛEHHOE
C     ПPИ ПPEДЫДУЩEM OБPAЩEHИИ
C
   45 IFLAG=JFLAG
      IF(KFLAG.EQ.3)MFLAG=IABS(IFLAG)
C
C     COXPAHИTЬ BXOДHOE ЗHAЧEHИE IFLAG И УCTAHOBИTЬ
C     ЗHAЧEHИE FLAG, COOTBETCTBУЮЩEE ПPOДOЛЖEHИЮ,
C     ДЛЯ БУДУЩEЙ ПPOBEPKИ
C
   50 JFLAG=IFLAG
      KFLAG=0
C
C     COXPAHИTЬ ЗHAЧEHИЯ RELERR И ABSERR ДЛЯ BXOДHOЙ
C     ПPOBEPKИ ПPИ ПOCЛEДУЮЩИX OБPAЩEHИЯX
C
      SAVRE=RELERR
      SAVAE=ABSERR
C
C     УCTAHOBИTЬ ЗHAЧEHИE ГPAHИЦЫ ДЛЯ OTHOCИTEЛЬ-
C     HOЙ ПOГPEШHOCTИ,PABHOE KAK MИHИMУM 2*EPS+
C     REMIN,ЧTOБЫ ИЗБEЖATЬ TPУДHOCTEЙ,CBЯЗAHHЫX
C     C TPEБOBAHИEM HEДOCTИЖИMOЙ TOЧHOCTИ
C
      RER=2.*EPS+REMIN
      IF(RELERR.GE.RER)GO TO 55
C
C     ЗAДAHHAЯ ГPAHИЦA OTHOCИTEЛЬHOЙ ПOГPEШHOCTИ
C     CЛИШKOM MAЛA
C
      RELERR=RER
      IFLAG=3
      KFLAG=3
      RETURN
C
   55 DT=TOUT-T
C
      IF(MFLAG.EQ.1)GO TO 60
      IF(INIT.EQ.0)GO TO 65
      GO TO 80
C
C     ПPИCBOEHИE HAЧAЛЬHЫX ЗHAЧEHИЙ (ИHИЦИИPOBA-
C             HИE)-УCTAHOBИTЬ ЗHAЧEHИE УKAЗATEЛЯ
C             OKOHЧAHИЯ ИHИЦИИPOBAHИЯ,INIT
C             УCTAHOBИTЬ ЗHAЧEHИE УKAЗATEЛЯ CЛИШ-
C             KOM БOЛЬШOГO ЗATPEБOBAHHOГO ЧИCЛA BЫ-
C             XOДHЫX TOЧEK,KOP
C             BЫЧИCЛИTЬ HAЧAЛЬHЫE ПPOИЗBOДHЫE
C             УCTAHOBИTЬ ЗHAЧEHИE CЧETЧИKA ЧИCЛA
C             BЫЧИCЛEHИЙ ФУHKЦИИ,NFE
C             OЦEHИTЬ HAЧEЛЬHУЮ BEЛИЧИHУ ШAГA
C
   60 INIT=0
      KOP=0
C
      A=T
      CALL F(A,Y,YP)
      NFE=1
      IF(T.NE.TOUT)GO TO 65
      IFLAG=2
      RETURN
C
   65 INIT=1
      H=ABS(DT)
      TOLN=0.
      DO 70 K=1,NEQN
      TOL=RELERR*ABS(Y(K))+ABSERR
      IF(TOL.LE.0)GO TO 70
      TOLN=TOL
      YPK=ABS(YP(K))
      IF(YPK*H**5.GT.TOL)H=(TOL/YPK)**0.2
   70 CONTINUE
      IF(TOLN.LE.0.0)H=0.0
      H=AMAX1(H,U26*AMAX1(ABS(T),ABS(DT)))
      JFLAG=ISIGN(2,IFLAG)
C
C     ПPИCBOИTЬ BEЛИЧИHE ШAГA ЗHAK,COOTBETCTBУЮЩИЙ
C     ИHTEГPИPOBAHИЮ B HAПPABЛEHИИ OT T K TOUT
C
   80 H=SIGN(H,DT)
C
C     ПPOBEPKA, HACKOЛЬKO CEPЬEЗHO BЛИЯHИE HA RKF45
C     CЛИШKOM БOЛЬШOГO ЗATPEБOBAHHOГO ЧИCЛA BЫXOД-
C     HЫX TOЧEK
C
      IF(ABS(H).GE.2.0*ABS(DT))KOP=KOP+1
      IF(KOP.NE.100)GO TO 85
C
C     ЧPEЗMEPHAЯ ЧACTOTA BЫXOДOB
C
      KOP=0
      IFLAG=7
      RETURN
C
   85 IF(ABS(DT).GT.U26*ABS(T))GO TO 95
C
C     ECЛИ OЧEHЬ БЛИЗKO K TOЧKE BЫXOДA,ПPOЭKCTPAПO-
C     ЛИPOBATЬ И BEPHУTЬCЯ ПO MECTУ BЫЗOBA
C
      DO 90 K=1,NEQN
   90 Y(K)=Y(K)+DT*YP(K)
      A=TOUT
      CALL F(A,Y,YP)
      NFE=NFE+1
      GO TO 300
C
C     ПPИCBOИTЬ HAЧAЛЬHOE ЗHAЧEHИE ИHДИKATOPУ TOЧKИ
C     BЫXOДA
C
   95 OUTPUT=.FALSE.
C
C     ЧTOБЫ ИЗБEЖATЬ HEOПPABДAHHOГO MAШИHHOГO HУЛЯ
C     ПPИ BЫЧИCЛEHИИ ФУHKЦИИ OT ГPAHИЦ ПOГPEШHO-
C     CTEЙ,ПPOMACШTAБИPOBATЬ ЭTИ ГPAHИЦЫ
C
      SCALE=2./RELERR
      AE=SCALE*ABSERR
C
C     ПOШAГOBOE ИHTEГPИPOBAHИE
C
  100 HFAILD=.FALSE.
C
C     УCTAHOBИTЬ HAИMEHЬШУЮ ДOПУCTИMУЮ BEЛИЧИHУ ШAГA
C
      HMIN=U26*ABS(T)
C
C     ИCПPABИTЬ ПPИ HEOБXOДИMOCTИ BEЛИЧИHУ ШAГA,
C     ЧTOБЫ ДOCTИГHУTЬ TOЧKИ BЫXOДA. PACCЧИTATЬ HA
C     ДBA ШAГA BПEPEД,ЧTOБЫ ИЗБEЖATЬ CЛИШKOM PEЗKИX
C     ИЗMEHEHИЙ B BEЛИЧИHE ШAГA И TEM CAMЫM УMEHЬ-
C     ШИTЬ BЛИЯHИE BЫXOДHЫX TOЧEK HA ПPOГPAMMУ.
C
      DT=TOUT-T
      IF(ABS(DT).GE.2.*ABS(H))GO TO 200
      IF(ABS(DT).GT.ABS(H))GO TO 150
C
C     CЛEДУЮЩИЙ УCПEШHЫЙ ШAГ ЗABEPШИT ИHTEГPИPO-
C     BAHИE ДO УKAЗAHHOЙ TOЧKИ BЫXOДA
C
      OUTPUT=.TRUE.
      H=DT
      GO TO 200
C
  150 H=0.5*DT
C
C
C
C     BHУTPEHHИЙ OДHOШAГOBЫЙ ИHTEГPATOP
C
C     ГPAHИЦЫ ПOГPEШHOCTEЙ БЫЛИ ПPOMACШTAБИPOBAHЫ,
C     ЧTOБЫ ИЗБEЖATЬ HEOПPABДAHHOГO MAШИHHOГO HУЛЯ
C     ПPИ BЫЧИCЛEHИИ ФУHKЦИИ OT HИX.
C     ЧTOБЫ ИЗБEЖATЬ OБPAЩEHИЯ B HУЛЬ ЗHAMEHATEЛЯ
C     B TECTE,OTHOCИTEЛЬHAЯ OШИБKA ИЗMEPЯETCЯ  ПO
C     OTHOШEHИЮ K CPEДHEMУ  ИЗ BEЛИЧИH PEШEHИЯ
C     B HAЧAЛE И KOHЦE ШAГA.
C     B ФOPMУЛE,OЦEHИBAЮЩEЙ OШИБKУ,ПPOИЗBEДEHA
C     ГPУППИPOBKA CЛAГAEMЫX,УMEHЬШAЮЩAЯ ПOTEPЮ
C     BEPHЫX ЗHAKOB.
C     ЧTOБЫ PAЗЛИЧATЬ MEЖДУ COБOЙ PAЗHЫE APГУMEHTЫ,
C     ДЛЯ H HE ДOПУCKAЮTCЯ ЗHAЧEHИЯ,MEHЬШИE УMHO-
C     ЖEHHOЙ HA 26 OШИБKИ OKPУГЛEHИЯ B T.
C     BBEДEHЫ ПPAKTИЧECKИE OГPAHИЧEHИЯ HA CKOPOCTЬ
C     ИЗMEHEHИЯ BEЛИЧИHЫ ШAГA,ЧTOБЫ CГЛAДИTЬ ПPO-
C     ЦECC BЫБOPA ЭTOЙ BEЛИЧИHЫ И ИЗБEЖATЬ ЧPEЗMEP-
C     HOГO EE PAЗБPOCA B ЗAДAЧAX C HAPУШEHИEM HEПPE-
C     PЫBHOCTИ.
C     ИЗ ПPEДOCTOPOЖHOCTИ ПPOГPAMMA БEPET 9/10 OT TOЙ
C     BEЛИЧИHЫ ШAГA,KOTOPAЯ HУЖHA ПO EE OЦEHKE.
C     ECЛИHA ДAHHOM ШAГE БЫЛA HEУДAЧHAЯ ПOПЫTKA
C     TO ПPИ ПЛAHИPOBAHИИ CЛEДУЮЩEГO УBEЛИЧEHИE
C     ДЛИHЫ ШAГA HE ДOПУCKAETCЯ. ЭTO ПOBЫШAET ЭФФEK-
C     TИBHOCTЬ ПPOГPAMMЫ ДЛЯ ЗAДAЧ C PAЗPЫBAMИ И
C     B OБЩEM CЛУЧAE,ПOCKOЛЬKУ ИCПOЛЬЗУETCЯ ЛOKAЛЬ-
C     HAЯ ЭKCTPAПOЛЯЦИЯ И ДOПOЛHИTEЛЬHAЯ ПPEДOCTO-
C     POЖHOCTЬ KAЖETCЯ OПPABДAHHOЙ.
C
C
C     ПPOBEPИTЬ ЧИCЛO BЫЧИCЛEHИЙ ПPOИЗBOДHЫX.ECЛИ
C     OHO HE ПPEBЫШAET УCTAHOBЛEHHOГO ПPEДEЛA,ПO-
C     ПPOБOBATЬ ПPOДOЛЖИTЬ ИHTEГPИPOBAHИE C T ДO T+H
C
  200 IF(NFE.LE.MAXNFE)GO TO 220
C
C     CЛИШKOM БOЛЬШAЯ PAБOTA
C
      IFLAG=4
      KFLAG=4
      RETURN
C
C     ПPOДOЛЖИTЬ ПPИБЛИЖEHHOE PEШEHИE HA OДИH ШAГ ДЛИHЫ H
C
  220 CALL FEHL(F,NEQN,Y,T,H,YP,F1,F2,F3,F4,F5,F1)
      NFE=NFE+5
C
C     BЫЧИCЛИTЬ И CPABHИTЬ ДOПУCTИMЫE ГPAHИЦЫ И
C     OЦEHKИ ЛOKAЛЬHOЙ OШИБ,A ЗATEM CHЯTЬ MACШTA-
C     БИPOBAHИE ГPAHИЦ.ЗAMETЬTE,ЧTO OTHOCИTEЛЬHAЯ
C     OШИБKA ИЗMEPЯETCЯ ПO OTHOШEHИЮ K CPEДHEMУ ИЗ
C     BEЛИЧИH PEШEHИЯ B HAЧAЛE И KOHЦE ШAГA.
C
      EEOET=0.
      DO 250 K=1,NEQN
      ET=ABS(Y(K))+ABS(F1(K))+AE
      IF(ET.GT.0.)GO TO 240
C
C     HEПPABИЛЬHAЯ ГPAHИЦA ПOГPEШHOCTИ
C
      IFLAG=5
      KFLAG=5
      RETURN
C
  240 EE=ABS((-2090.*YP(K)+(21970.*F3(K)-15048.*F4(K)))
     *  +(22528.*F2(K)-27360.*F5(K)))
  250 EEOET=AMAX1(EEOET,EE/ET)
C
      ESTTOL=ABS(H)*EEOET*SCALE/752400.
C
      IF(ESTTOL.LE.1.0)GO TO 260
C
C
C     HEУДAЧHЫЙ ШAГ
C            УMEHЬШИTЬ BEЛИЧИHУ ШAГA И CHOBA ПO-
C            ПPOБOBATЬ
C            УMEHЬШEHИE OГPAHИЧИBAETCЯ CHИЗУ MHO-
C            ЖИTEЛEM 1/10
C
      HFAILD=.TRUE.
      OUTPUT=.FALSE.
      S=0.1
      IF(ESTTOL.LT.59049.)S=0.9/ESTTOL**0.2
      H=S*H
      IF(ABS(H).GT.HMIN)GO TO 200
C
C     ЗAДAHHAЯ ГPAHИЦA OШИБKИ HEДOCTИЖИMA ДAЖE ПPИ
C     HAИMEHЬШEЙ ДOПУCTИMOЙ BEЛИЧИHE ШAГA
C
      IFLAG=6
      KFLAG=6
      RETURN
C
C
C     УCПEШHЫЙ ШAГ
C            ПOMECTИTЬ B MACCИB Y PEШEHИE B TOЧKE
C            T+H И BЫЧИCЛИTЬ ПPOИЗBOДHЫE B ЭTOЙ
C            TOЧKE
C
  260 T=T+H
      DO 270 K=1,NEQN
  270 Y(K)=F1(K)
      A=T
      CALL F(A,Y,YP)
      NFE=NFE+1
C
C
C     BЫБPATЬ BEЛИЧИHУ CЛEДУЮЩEГO ШAГA
C     УBEЛИЧEHИE OГPAHИЧEHO MHOЖИTEЛEM 5
C     ECЛИ HA ДAHHOM ШAГE БЫЛA HEУДAЧHAЯ
C     ПOПЫTKA,TO ДЛЯ CЛEДУЮЩEГO HE ДOПУ-
C     CKAETCЯ BЫБOP БOЛЬШEЙ BEЛИЧИHЫ ШAГA
C
      S=5.
      IF(ESTTOL.GT.1.889568E-4)S=0.9/ESTTOL**0.2
      IF(HFAILD)S=AMIN1(S,1.0)
      H=SIGN(AMAX1(S*ABS(H),HMIN),H)
C
C     KOHEЦ OДHOШAГOBOГO ИHTEГPATOPA
C
C
C     HУЖHO ЛИ ДEЛATЬ OЧEPEДHOЙ ШAГ
C
      IF(OUTPUT)GO TO 300
      IF(IFLAG.GT.0)GO TO 100
C
C
C     ИHTEГPИPOBAHИE УCПEШHO ЗABEPШEHO
C
C     PEЖИM OДHOШAГOBOГO ИHTEГPИPOBAHИЯ
C
      IFLAG=-2
      RETURN
C
C     PEЖИM ИHTEГPИPOBAHИЯ HA ИHTEPBAЛE
C
  300 T=TOUT
      IFLAG=2
      RETURN
C
      END
