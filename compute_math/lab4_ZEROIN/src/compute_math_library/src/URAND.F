      REAL FUNCTION URAND(IY)
      INTEGER IY
C
C       URAND-ЭTO ДATЧИK PABHOMEPHO PACПPEДEЛEHHЫX CЛУЧAЙHЫX
C     ЧИCEЛ, OCHOBAHHЫЙ HA TEOPИИ И ПPEДЛOЖEHИЯX, COДEPЖAЩИXCЯ
C     B KHИГE KHУT (1969),TOM 2.
C       ПEPEД ПEPBЫM OБPAЩEHИEM K URAND ЦEЛOЙ ПEPEMEHHOЙ IY
C     CЛEДУET ПPИCBOИTЬ ПPOИЗBOЛЬHOE ЦEЛOЧИCЛEHHOE HAЧAЛЬ-
C     HOE ЗHAЧEHИE. BЫЗЫBAЮЩAЯ ПPOГPAMMA HE ДOЛЖHA ИЗMEHЯTЬ
C     ЗHAЧEHИE IY MEЖДУ ПOCЛEДOBATEЛЬHЫMИ BЫЗOBAMИ. ЗHAЧEHИЯ
C     ФУHKЦИИ URAND ЯBЛЯЮTCЯ ЧИCЛAMИ ИЗ ИHTEPBAЛA (0,1).
C
      INTEGER IA,IC,ITWO,M2,M,MIC
      DOUBLE PRECISION HALFM
      REAL S
      DOUBLE PRECISION DATAN,DSQRT
      DATA M2/0/,ITWO/2/
      IF(M2.NE.0) GOTO 20
C
C     ECЛИ ЭTO ПEPBЫЙ BXOД, TO BЫЧИCЛИTЬ ДЛИHУ
C     ЦEЛOЧИCЛEHHOГO MAШИHHOГO CЛOBA
C
      M=1
   10 M2=M
      M=ITWO*M2
      IF(M .GT. M2) GO TO 10
      HALFM=M2
C
C     BЫЧИCЛИTЬ MHOЖИTEЛЬ И ПPИPAЩEHИE ЛИHEЙHOГO
C     KOHГPУЭHTHOГO METOДA
C
      IA=8*IDINT(HALFM*DATAN(1.D0)/8.D0)+5
      IC=2*IDINT(HALFM*(0.5D0-DSQRT(3.D0)/6.D0))+1
      MIC=(M2-IC)+M2
C
C     S-MACШTAБИPУЮЩИЙ MHOЖИTEЛЬ ДЛЯ ПPEOБPAЗOBAHИЯ B ЧИCЛO
C     C ПЛABAЮЩEЙ TOЧKOЙ
C
      S=0.5/HALFM
C
C     BЫЧИCЛИTЬ CЛEДУЮЩEE CЛУЧAЙHOE ЧИCЛO
C
   20 IY=IY*IA
C
C     CЛEДУЮЩИЙ OПEPATOP-ДЛЯ MAШИH,KOTOPЫE HE ДOПУCKAЮT
C     ПEPEПOЛHEHИЯ ЦEЛЫX ЧИCEЛ ПPИ CЛOЖEHИИ
C
      IF(IY.GT.MIC) IY=(IY-M2)-M2
      IY=IY+IC
C
C     CЛEДУЮЩИЙ OПEPATOP - ДЛЯ MAШИH, У KOTOPЫX ДЛИHA CЛOBA
C     ДЛЯ CЛOЖEHИЯ БOЛЬШE, ЧEM ДЛЯ УMHOЖEHИЯ
C
      IF(IY/2.GT.M2) IY=(IY-M2)-M2
C
C     CЛEДУЮЩИЙ OПEPATOP - ДЛЯ MAШИH, У KOTOPЫX ПEPEПOЛHEHИE
C     ЦEЛOГO ЧИCЛA BЛИЯET HA ЗHAKOBЫЙ PAЗPЯД
C
      IF(IY.LT.0) IY=(IY+M2)+M2
      URAND=FLOAT(IY)*S
      RETURN
      END
