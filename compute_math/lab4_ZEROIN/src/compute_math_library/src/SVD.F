      SUBROUTINE SVD(NM,M,N,A,W,MATU,U,MATV,V,IERR,RV1)
C
      INTEGER I,J,K,L,M,N,II,I1,KK,K1,LL,L1,MN,NM,ITS,IERR
      REAL A(NM,N),W(N),U(NM,N),V(NM,N),RV1(N)
C
      REAL C,F,G,H,S,X,Y,Z,SCALE,ANORM
      LOGICAL MATU,MATV
C
C     ЭTA ПOДПPOГPAMMA ECTЬ TPAHCЛЯЦИЯ AЛГOЛ-ПPOЦEДУPЫ SVD,
C     OПУБЛИKOBAHHOЙ ГOЛУБOM И PAЙHШEM B ЖУPHAЛE NUMERISCHE
C     MATHEMATIK, 14, 403-420(1970), A TAKЖE B KHИГE
C     HANDBOOK FOR AUTOMATIC COMPUTATION  VOL.II-LINEAR
C     ALGEBRA, 134-151 (1971).
C
C     ЭTA ПOДПPOГPAMMA BЫЧИCЛЯET CИHГУЛЯPHOE PAЗЛOЖEHИE
C          T
C     A=USV  ДEЙCTBИTEЛЬHOЙ ПPЯMOУГOЛЬHOЙ MATPИЦЫ A C PAЗME-
C     PAMИ M И N. ПPИ ЭTOM ИCПOЛЬЗУЮTCЯ ДBУXДИAГOHAЛИЗAЦИЯ
C     ПOCPEДCTBOM XAУCXOЛДEPOBЫX OTPAЖEHИЙ  И BAPИAHT
C     QR-AЛГOPИTMA.
C
C     HA BXOДE.
C
C     NM   CЛEДУET ПOЛOЖИTЬ PABHЫM CTPOЧHOЙ PAЗMEPHOCTИ
C          ДBУXMEPHЫX MACCИBOB ,ЗAЯBЛEHHOЙ B OПEPATOPE PAЗ-
C          MEPHOCTИ BЫЗЫBAЮЩEЙ ПPOГPAMMЫ. ЗAMETИM, ЧTO NM
C          ДOЛЖHO БЫTЬ H  MEHЬШE,ЧEM MAKCИMУM ИЗ M И N.
C
C     M    ЧИCЛO CTPOK A (И U).
C
C     N    ЧИCЛO CTOЛБЦOB A (И U) И ПOPЯДOK V.
C
C     A    COДEPЖИT ПPЯMOУГOЛЬHУЮ BXOДHУЮ MATPИЦУ, ДЛЯ
C          KOTOPOЙ HAXOДИTCЯ  PAЗЛOЖEHИE.
C
C     MATU ДOЛЖEH ИMETЬ ЗHAЧEHИE .TRUE., ECЛИ HУЖHO
C          BЫЧИCЛЯTЬ MATPИЦУ U ИЗ PAЗЛOЖEHИЯ, И ЗHAЧEHИE
C          .FALSE. B ПPOTИBHOM CЛУЧAE.
C
C     MATV ДOЛЖEH ИMETЬ ЗHAЧEHИE .TRUE., ECЛИ HУЖHO
C          BЫЧИCЛЯTЬ MATPИЦУ V ИЗ PAЗЛOЖEHИЯ, И ЗHAЧEHИE
C          .FALSE. B ПPOTИBHOM CЛУЧAE.
C
C     HA BЫXOДE.
C
C     A    HE ИЗMEHЯETCЯ (ECЛИ HA EE MECTE HE ЗAПИCЫBAЮTCЯ
C          U ЛИБO V).
C
C     W    COДEPЖИT N (HEOTPИЦATEЛЬHЫX) CИHГУЛЯPHЫX ЧИCEЛ
C          A (ДИAГOHAЛЬHЫX ЭЛEMEHTOB S). OHИ HE УПOPЯДOЧEHЫ.
C          ECЛИ ПPOИCXOДИT BЫXOД ПO OШИБKE, TO ДЛЯ ЗHAЧEHИЙ
C          IERR+1, IERR+2,...,N CИHГУ ЛЯPHЫE ЧИCЛA ДOЛЖHЫ
C          БЫTЬ BEPHЫ.
C
C     U    COДEPЖИT MATPИЦУ U (C OPTOГOHAЛЬHЫMИ CTOЛБЦAMИ)
C          ИЗ PAЗЛOЖEHИЯ, ECЛИ ДЛЯ ПAPAMETPA MATU БЫЛO
C          ЗAДAHO ЗHAЧEHИE .TRUE. B ПPOTИBHOM CЛУЧAE HA U
C          ИCПOЛЬЗУETCЯ KAK BPEMEHHЫЙ MACCИB. U TAKЖE MOЖET
C          COBПAДATЬ C A. ECЛИ ПPOИCXOДИT BЫXOД
C          ПO OШИБKE, TO CTOЛБЦЫ U, COOTBETCTBУЮЩИE ИHДEKCAM
C          BEPHЫX CИHГУЛЯPHЫX ЧИCEЛ, ДOЛЖHЫ БЫTЬ TAKЖE BEPHЫ.
C
C     V    COДEPЖИT MATPИЦУ V (OPTOГOHAЛЬHУЮ) ИЗ PAЗЛOЖEHИЯ,
C          ECЛИ ДЛЯ ПAPAMETPA MATV БЫЛO ЗAДAHO ЗHAЧEHИE
C          .TRUE. B ПPOTИBHOM CЛУЧAE HA V HE ПPOИЗBOДИTCЯ
C          CCЫЛOK. V TAKЖE MOЖET COBПAДATЬ C  A, ECЛИ U HE
C          BЫЧИCЛЯETCЯ. ECЛИ ПPOИCXOДИT BЫXOД ПO OШИБKE,
C          TO CTOЛБЦЫ V, COOTBETCTBУЮЩИE ИHДEKCAM BEPHЫX
C          CИHГУЛЯPHЫX ЧИCEЛ, ДOЛЖHЫ БЫTЬ TAKЖE BEPHЫ.
C
C     IERR PABHO
C            0,  ECЛИ ПPOИCXOДИT HOPMAЛЬHЫЙ BЫXOД ИЗ ПOДПPOГ-
C                PAMMЫ,
C            K,  ECЛИ K-E CИHГУЛЯPHOE ЧИCЛO HE БЫЛO OПPEДE-
C                ЛEHO ПOCЛE 30 ИTEPAЦИЙ.
C
C     RV1  ЭTO MACCИB ПPOMEЖУTOЧHOГO XPAHEHИЯ.
C
C     BOПPOCЫ И KOMMEHTAPИИ HУЖHO HAПPABЛЯTЬ ПO AДPECУ
C     B.S.GARBOW, APPLIED MATEMATICS DIVISION, ARGONNE
C     NATIONAL LABORATORY
C
C     ПOДПPOГPAMMA MOДИФИЦИPOBAHA C ЦEЛЬЮ ИCKЛЮЧИTЬ
C     ПEPEMEHHYЮ MACHEP
C
      IERR=0
      DO 100 I=1,M
      DO 100 J=1,N
      U(I,J)=A(I,J)
  100 CONTINUE
C
C     XAУCXOЛДEPOBO ПPИBEДEHИE K ДBУXДИAГOHAЛЬHOЙ ФOPME
C
      G=0.0
      SCALE=0.0
      ANORM=0.0
C
      DO 300 I=1,N
         L=I+1
         RV1(I)=SCALE*G
         G=0.0
         S=0.0
         SCALE=0.0
         IF(I.GT.M)GO TO 210
C
         DO 120 K=I,M
  120       SCALE=SCALE+ABS(U(K,I))
         IF(SCALE.EQ.0.0)GO TO 210
C
         DO 130 K=I,M
            U(K,I)=U(K,I)/SCALE
            S=S+U(K,I)**2
  130    CONTINUE
C
         F=U(I,I)
         G=-SIGN(SQRT(S),F)
         H=F*G-S
         U(I,I)=F-G
         IF(I.EQ.N)GO TO 190
C
         DO 150 J=L,N
            S=0.0
            DO 140 K=I,M
  140          S=S+U(K,I)*U(K,J)
               F=S/H
            DO 150 K=I,M
               U(K,J)=U(K,J)+F*U(K,I)
  150    CONTINUE
C
  190    DO 200 K=I,M
  200       U(K,I)=SCALE*U(K,I)
  210    W(I)=SCALE*G
         G=0.0
         S=0.0
         SCALE=0.0
         IF(I.GT.M.OR.I.EQ.N)GO TO 290
C
         DO 220 K=L,N
  220       SCALE=SCALE+ABS(U(I,K))
C
         IF(SCALE.EQ.0.0)GO TO 290
C
         DO 230 K=L,N
            U(I,K)=U(I,K)/SCALE
            S=S+U(I,K)**2
  230    CONTINUE
C
         F=U(I,L)
         G=-SIGN(SQRT(S),F)
         H=F*G-S
         U(I,L)=F-G
C
         DO 240 K=L,N
  240       RV1(K)=U(I,K)/H
C
         IF(I.EQ.M)GO TO 270
C
         DO 260 J=L,M
            S=0.0
            DO 250 K=L,N
  250          S=S+U(J,K)*U(I,K)
            DO 260 K=L,N
               U(J,K)=U(J,K)+S*RV1(K)
  260    CONTINUE
C
  270    DO 280 K=L,N
  280    U(I,K)=SCALE*U(I,K)
C
  290    ANORM=AMAX1(ANORM,ABS(W(I))+ABS(RV1(I)))
  300 CONTINUE
C
C     HAKOПЛEHИE ПPABOCTOPOHHИX ПPEOБPAЗOBAHИЙ
C
      IF(.NOT.MATV)GO TO 410
C
C     ДЛЯ I=N C ШAГOM -1 ДO 1 BЫПOЛHИTЬ -
C
      DO 400 II=1,N
         I=N+1-II
         IF(I.EQ.N)GO TO 390
         IF(G.EQ.0.0)GO TO 360
C
         DO 320 J=L,N
C
C     ДBOЙHOE ДEЛEHИE OБXOДИT BOЗMOЖHЫЙ MAШИHHЫЙ HYЛЬ
C
  320    V(J,I)=(U(I,J)/U(I,L))/G
C
         DO 350 J=L,N
            S=0.0
            DO 340 K=L,N
  340       S=S+U(I,K)*V(K,J)
            DO 350 K=L,N
            V(K,J)=V(K,J)+S*V(K,I)
  350 CONTINUE
C
  360    DO 380 J=L,N
            V(I,J)=0.0
            V(J,I)=0.0
  380    CONTINUE
C
  390    V(I,I)=1.0
         G=RV1(I)
         L=I
  400 CONTINUE
C
C     HAKOПЛEHИE ЛEBOCTOPOHHИX ПPEOБPAЗOBAHИЙ
C
  410 IF(.NOT.MATU)GO TO 510
C
C     ДЛЯ I=MIN(N,M) C ШAГOM -1 ДO 1 BЫПOЛHИTЬ-
C
      MN=N
      IF(M.LT.N)MN=M
C
      DO 500 II=1,MN
         I=MN+1-II
         L=I+1
         G=W(I)
         IF(I.EQ.N)GO TO 430
C
         DO 420 J=L,N
  420    U(I,J)=0.0
C
  430    IF(G.EQ.0.0)GO TO 475
         IF(I.EQ.MN)GO TO 460
C
         DO 450 J=L,N
            S=0.0
            DO 440 K=L,M
  440       S=S+U(K,I)*U(K,J)
C
C     ДBOЙHOE  ДEЛEHИE OБXOДИT BOЗMOЖHЫЙ MAШИHHЫЙ HYЛЬ
C
            F=(S/U(I,I))/G
C
            DO 450 K=I,M
               U(K,J)=U(K,J)+F*U(K,I)
  450    CONTINUE

  460    DO 470 J=I,M
  470    U(J,I)=U(J,I)/G
C
         GO TO 490
C
  475    DO 480 J=I,M
  480    U(J,I)=0.0
C
  490    U(I,I)=U(I,I)+1.0
  500 CONTINUE
C
C     ДИAГOHAЛИЗAЦИЯ ДBУXДИAГOHAЛЬHOЙ ФOPMЫ ДЛЯ K=N C ШAГOM
C     -1 ДO 1 BЫПOЛHИTЬ
C
  510 DO 700 KK=1,N
         K1=N-KK
         K=K1+1
         ITS=0
C
C     ПPOBEPKA BOЗMOЖHOCTИ PACЩEПЛEHИЯ  ДЛЯ L=K
C     C ШAГOM -1 ДO 1 BЫПOЛHИTЬ
C
  520    DO 530 LL=1,K
            L1=K-LL
            L=L1+1
            IF(ABS(RV1(L))+ANORM.EQ.ANORM)GO TO 565
C
C     RV1(1) BCEГДA PABHO HУЛЮ. ПOЭTOMУ BЫXOДA
C     ЧEPEЗ KOHEЦ ЦИKЛA HE БУДET
C
            IF(ABS(W(L1))+ANORM.EQ.ANORM)GO TO 540
  530    CONTINUE
C
C      ECЛИ L БOЛЬШE, ЧEM 1, TO RV1(L)
C      ПPИCBAИBAETCЯ HУЛEBOE ЗHAЧEHИE
C
  540    C=0.0
         S=1.0
C
         DO 560 I=L,K
            F=S*RV1(I)
            RV1(I)=C*RV1(I)
            IF(ABS(F)+ANORM.EQ.ANORM)GO TO 565
            G=W(I)
            H=SQRT(F*F+G*G)
            W(I)=H
            C=G/H
            S=-F/H
            IF(.NOT.MATU)GO TO 560
C
            DO 550 J=1,M
               Y=U(J,L1)
               Z=U(J,I)
               U(J,L1)=Y*C+Z*S
               U(J,I)=-Y*S+Z*C
  550       CONTINUE
  560    CONTINUE
C
C     ПPOBEPKA CXOДИMOCTИ
C
  565    Z=W(K)
         IF(L.EQ.K)GO TO 650
C
C     CДBИГ BЫБИPAETCЯ ИЗ HИЖHEГO УГЛOBOГO
C     MИHOPA ПOPЯДKA 2
C
         IF(ITS.EQ.30)GO TO 1000
         ITS=ITS+1
         X=W(L)
         Y=W(K1)
         G=RV1(K1)
         H=RV1(K)
         F=((Y-Z)*(Y+Z)+(G-H)*(G+H))/(2.0*H*Y)
         G=SQRT(F*F+1.0)
         F=((X-Z)*(X+Z)+H*(Y/(F+SIGN(G,F))-H))/X
C
C     CЛEДУЮЩEE QR-ПPEOБPAЗOBAHИE
C
         C=1.0
         S=1.0
C
         DO 600 I1=L,K1
            I=I1+1
            G=RV1(I)
            Y=W(I)
            H=S*G
            G=C*G
            Z=SQRT(F*F+H*H)
            RV1(I1)=Z
            C=F/Z
            S=H/Z
            F=X*C+G*S
            G=-X*S+G*C
            H=Y*S
            Y=Y*C
            IF(.NOT.MATV)GO TO 575
C
            DO 570 J=1,N
               X=V(J,I1)
               Z=V(J,I)
               V(J,I1)=X*C+Z*S
               V(J,I)=-X*S+Z*C
  570       CONTINUE
C
  575       Z=SQRT(F*F+H*H)
            W(I1)=Z
C
C     BPAЩEHИE MOЖET БЫTЬ ПPOИЗBOЛЬHЫM, ECЛИ Z PABHO HУЛЮ
C
            IF(Z.EQ.0.0)GO TO 580
            C=F/Z
            S=H/Z
  580       F=C*G+S*Y
            X=-S*G+C*Y
            IF(.NOT.MATU)GO TO 600
C
            DO 590 J=1,M
               Y=U(J,I1)
               Z=U(J,I)
               U(J,I1)=Y*C+Z*S
               U(J,I)=-Y*S+Z*C
  590       CONTINUE
  600    CONTINUE
         RV1(L)=0.0
         RV1(K)=F
         W(K)=X
         GO TO 520
C
C     CXOДИMOCTЬ
C
  650    IF(Z.GE.0.0)GO TO 700
C
C     W(K) ДEЛAETCЯ HEOTPИЦATEЛЬHЫM
C
         W(K)=-Z
         IF(.NOT.MATV)GO TO 700
C
         DO 690 J=1,N
  690    V(J,K)=-V(J,K)
  700 CONTINUE
      GO TO 1001
C
C     УCTAHOBИTЬ ЗHAЧEHИE ПPИЗHAKA OШИБKИ - ПOCЛE 30
C     ИTEPAЦИЙ HET CXOMOCTИ K CИHГУЛЯPHOMУ ЧИCЛУ
C
 1000 IERR=K
 1001 RETURN
      END
