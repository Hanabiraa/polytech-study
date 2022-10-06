      SUBROUTINE DECOMP(NDIM,N,A,COND,IPVT,WORK)
C
      INTEGER NDIM,N
      REAL A(NDIM,N),COND,WORK(N)
      INTEGER IPVT(N)

C     ПPOГPAMMA BЫЧИCЛЯET PAЗЛOЖEHИE BEЩECTBEHHOЙ MATPИЦЫ
C     ПOCPEДCTBOM ГAУCCOBA ИCKЛЮЧEHИЯ И OЦEHИBAET
C     OБУCЛOBЛEHHOCTЬ  MATPИЦЫ.
C
C     OHA ИCПOЛЬЗУETCЯ ДЛЯ BЫЧИCЛEHИЯ PEШEHИЙ
C     ЛИHEЙHЫX CИCTEM.
C
C     BXOДHAЯ ИHФOPMAЦИЯ.
C
C     NDIM -ЗAЯBЛEHHAЯ CTPOЧHAЯ PAЗMEPHOCTЬ MACCИBA,
C           COДEPЖAЩEГO A.
C
C     N    -ПOPЯДOK MATPИЦЫ.
C
C     A    -MATPИЦA,KOTOPУЮ HУЖHO PAЗЛOЖИTЬ.
C
C     BЫXOДHAЯ ИHФOPMAЦИЯ.
C
C     A     COДEPЖИT BEPXHЮЮ TPEУГOЛЬHУЮ MATPИЦУ U
C           И УЧИTЫBAЮЩУЮ ПEPECTAHOBKИ BEPCИЮ
C           HИЖHEЙ TPEУГOЛЬHOЙ MATPИЦЫ I-L,TAKИE,
C           ЧTO (MATPИЦA  ПEPECTAHOBOK) *A=L*U
C
C     COND -OЦEHKA OБУCЛOBЛEHHOCTИ A.
C           ДЛЯ ЛИHEЙHOЙ CИCTEMЫ A*X=B ИЗMEHEHИЯ B A И B
C           MOГУT BЫЗBATЬ  ИЗMEHEHИЯ B X,БOЛЬШИE B COND PAЗ.
C           ECЛИ COND+1.0.EQ.COND, TO  A B ПPEДEЛAX MAШИHHOЙ
C           TOЧHOCTИ ЯBЛЯETCЯ BЫPOЖДEHHOЙ MATPИЦEЙ. COND
C           ПOЛAГAETCЯ PABHЫM 1.0E+32,ECЛИ OБHAPУЖEHA TOЧHAЯ
C           BЫPOЖДEHHOCTЬ.
C
C     IPVT -BEKTOP BEДУЩИX ЭЛEMEHTOB.
C           IPVT(K)=ИHДEKC K-Й BEДУЩEЙ CTPOKИ
C           IPVT(N)=(-1)**(ЧИCЛO ПEPECTAHOBOK)
C
C     PAБOЧEE ПOЛE. BEKTOP WORK ДOЛЖEH БЫTЬ OПИCAH И
C             BKЛЮЧEH B BЫЗOB. EГO BXOДHOE COДEPЖAHИE OБЫЧHO
C             HE ДAET BAЖHOЙ ИHФOPMAЦИИ.
C
C     OПPEДEЛИTEЛЬ MATPИЦЫ A MOЖET БЫTЬ ПOЛУЧEH HA BЫXOДE
C     ПO ФOPMУЛE:
C          DET(A)=IPVT(N)*A(1,1)*A(2,2)*...*A(N,N).
C
      REAL EK,T,ANORM,YNORM,ZNORM
      INTEGER NM1,I,J,K,KP1,KB,KM1,M
C
      IPVT(N)=1
      IF(N.EQ.1)GO TO 80
      NM1=N-1
C
C     BЫЧИCЛИTЬ 1-HOPMУ MATPИЦЫ A
C
      ANORM=0.0
      DO 10 J=1,N
        T=0.0
        DO 5 I=1,N
          T=T+ABS(A(I,J))
    5   CONTINUE
        IF(T.GT.ANORM) ANORM=T
   10 CONTINUE
C
C     ГAУCCOBO ИCKЛЮЧEHИE C ЧACTИЧHЫM BЫБOPOM
C     BEДУЩEГO ЭЛEMEHTA
C
      DO 35 K=1,NM1
        KP1=K+1
C
C       HAЙTИ BEДУЩИЙ ЭЛEMEHT
C
        M=K
        DO 15 I=KP1,N
          IF(ABS(A(I,K)).GT.ABS(A(M,K))) M=I
   15   CONTINUE
        IPVT(K)=M
        IF(M.NE.K)IPVT(N)=-IPVT(N)
        T=A(M,K)
        A(M,K)=A(K,K)
        A(K,K)=T
C
C       ПPOПУCTИTЬ ЭTOT ШAГ,ECЛИ BEДУЩИЙ ЭЛEMEHT PABEH HУЛЮ
C
        IF(T.EQ.0.0)GO TO 35
C
C       BЫЧИCЛИTЬ MHOЖИTEЛИ
C
        DO 20 I=KP1,N
          A(I,K)=-A(I,K)/T
   20   CONTINUE
C
C       ПEPECTABЛЯTЬ И ИCKЛЮЧATЬ ПO CTOЛБЦAM
C
        DO 30 J=KP1,N
          T=A(M,J)
          A(M,J)=A(K,J)
          A(K,J)=T
          IF(T.EQ.0.0)GO TO 30
          DO 25 I=KP1,N
            A(I,J)=A(I,J)+A(I,K)*T
   25     CONTINUE
   30   CONTINUE
   35 CONTINUE
C
C     COND=(1-HOPMA MATPИЦЫ A)*(OЦEHKA ДЛЯ 1-HOPMЫ MATPИЦЫ,
C     OБPATHOЙ K A)
C     OЦEHKA ПOЛУЧAETCЯ ПOCPEДCTBOM OДHOГO ШAГA METOДA
C     OБPATHЫX ИTEPAЦИЙ ДЛЯ HAИMEHЬШEГO CИHГУЛЯPHOГO
C     BEKTOPA. ЭTO TPEБУET PEШEHИЯ ДBУX CИCTEM УPABHEHИЙ,
C     (TPAHCПOHИPOBAHHAЯ ДЛЯ A) *Y=E И A*Z=Y, ГДE E-BEKTOP
C     ИЗ +1 И -1, BЫБPAHHЫЙ TAK, ЧTOБЫ MAKCИMИЗИPOBATЬ
C     BEЛИЧИHУ Y.
C     ESTIMATE=(1-HOPMA Z)/(1-HOPMA Y)
C
C     PEШИTЬ CИCTEMУ (TPAHCПOHИPOBAHHAЯ ДЛЯ A)*Y=E
C
      DO 50 K=1,N
        T=0.0
        IF(K.EQ.1)GO TO 45
        KM1=K-1
        DO 40 I=1,KM1
          T=T+A(I,K)*WORK(I)
   40   CONTINUE
   45   EK=1.0
        IF(T.LT.0.0)EK=-1.0
        IF(A(K,K).EQ.0.0)GO TO 90
        WORK(K)=-(EK+T)/A(K,K)
   50 CONTINUE
      DO 60 KB=1,NM1
        K=N-KB
        T=WORK(K)
        KP1=K+1
        DO 55 I=KP1,N
          T=T+A(I,K)*WORK(I)
   55   CONTINUE
        WORK(K)=T
        M=IPVT(K)
        IF(M.EQ.K)GO TO 60
        T=WORK(M)
        WORK(M)=WORK(K)
        WORK(K)=T
   60 CONTINUE
C
      YNORM=0.0
      DO 65 I=1,N
        YNORM=YNORM+ABS(WORK(I))
   65 CONTINUE
C
C     PEШИTЬ CИCTEMУ A*Z=Y
C
      CALL SOLVE(NDIM,N,A,WORK,IPVT)
C
      ZNORM=0.0
      DO 70 I=1,N
        ZNORM=ZNORM+ABS(WORK(I))
   70 CONTINUE
C
C     OЦEHИTЬ OБУCЛOBЛEHHOCTЬ
C
      COND=ANORM*ZNORM/YNORM
      IF(COND.LT.1.0)COND=1.0
      RETURN
C
C     CЛУЧAЙ MATPИЦЫ 1*1
C
   80 COND=1.0
      IF(A(1,1).NE.0.0)RETURN
C
C     TOЧHAЯ BЫPOЖДEHHOCTЬ
C
   90 CONTINUE
      COND=1.0E+32
      RETURN
      END
