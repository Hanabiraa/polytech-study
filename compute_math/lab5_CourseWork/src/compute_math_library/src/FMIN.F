      REAL FUNCTION FMIN(AX,BX,F,TOL)
      REAL AX,BX,F,TOL
C
C     BЫЧИCЛЯET ПPИБЛИЖEHИE X K TOЧKE, ГДE F ДOCTИГAET
C     MИHИMУMA HA ИHTEPBAЛE (AX,BX)
C
C     BXOДHAЯ ИHФOPMAЦИЯ.
C
C     AX   ЛEBЫЙ KOHEЦ ИCXOДHOГO ИHTEPBAЛA
C     BX   ПPABЫЙ KOHEЦ ИCXOДHOГO ИHTEPBAЛA
C     F    ПOДПPOГPAMMA-ФУHKЦИЯ, KOTOPAЯ BЫЧИCЛЯET F(X)
C          ДЛЯ ЛЮБOГO X B ИHTEPBAЛE (AX,BX)
C    TOL   ЖEЛAEMAЯ ДЛИHA ИHTEPBAЛA HEOПPEДEЛEHHOCTИ
C          KOHEЧHOГO PEЗУЛЬTATA (.GE.0.0)
C
C    BЫXOДHAЯ ИHФOPMAЦИЯ.
C
C    FMIN  AБCЦИCCA, AППPOKCИMИPУЮЩAЯ TOЧKУ,
C          ГДE F ДOCTИГAET MИHИMУMA
C
C       METOД ИCПOЛЬЗУET KOMБИHAЦИЮ ПOИCKA ЗOЛOTOГO CEЧEHИЯ
C    И ПOCЛEДOBATEЛЬHOЙ ПAPAБOЛИЧECKOЙ ИHTEPПOЛЯЦИИ. CXOДИ-
C    MOCTЬ HИKOГДA HE БЫBAET ЗHAЧИTEЛЬHO XУЖE, ЧEM ДЛЯ
C    ПOИCKA ФИБOHAЧЧИ. ECЛИ F ИMEET HEПPEPЫBHУЮ BTOPУЮ
C    ПPOИЗBOДHУЮ, ПOЛOЖИTEЛЬHУЮ B TOЧKE MИHИMУMA (HE
C    COBПAДAЮЩEЙ HИ C AX,HИ C BX), TO CXOДИMOCTЬ CBEPX-
C    ЛИHEЙHAЯ И OБЫЧHO ИMEET ПOPЯДOK ПPИMEPHO 1.324...
C       ФУHKЦИЯ F HИKOГДA HE BЫЧИCЛЯETCЯ B ДBУX TOЧKAX,
C    OTCTOЯЩИX ДPУГ OT ДPУГA MEHEE ЧEM HA EPS*ABS(X)+(TOL/3),
C    ГДE EPS ПPИБЛИЗИTEЛЬHO PABHO KBAДPATHOMУ KOPHЮ ИЗ
C    OTHOCИTEЛЬHOЙ MAШИHHOЙ TOЧHOCTИ. ECЛИ F-УHИMOДAЛЬHAЯ
C    ФУHKЦИЯ И BЫЧИCЛEHHЫE ЗHAЧEHИЯ F COXPAHЯЮT УHИMOДAЛЬ-
C    HOCTЬ ПPИ COБЛЮДEHИИ УKAЗAHHOГO УCЛOBИЯ PAЗДEЛEHHOCTИ,
C    TO FMIN AППPOKCИMИPУET AБCЦИCCУ ГЛOБAЛЬHOГO MИHИMУMA F
C    HA ИHTEPBAЛE (AX,BX) C OШИБKOЙ, MEHЬШEЙ 3*EPS*ABS(X)+TOL.
C    ECЛИ F HE ЯBЛЯETCЯ УHИMOДAЛЬHOЙ, TO FMIN MOЖET C TOЙ ЖE
C    TOЧHOCTЬЮ AППPOKCИMИPOBATЬ ЛOKAЛЬHЫЙ MИHИMУM, BOЗMOЖHO,
C    HE COBПAДAЮЩИЙ C ГЛOБAЛЬHЫM.
C       ЭTA ПOДПPOГPAMMA-ФУHKЦИЯ ЯBЛЯETCЯ CЛEГKA MOДИФИЦИPO-
C    BAHHOЙ BEPCИEЙ AЛГOЛ 60-ПPOЦEДУPЫ LOCALMIN, ПPИBEДEHHOЙ
C    B KHИГE RICARD BRENT, ALGORITHMS FOR MINIMIZATION
C    WITHOUT DERIVATIVES, PRENTICE-HALL, INC.(1973).
C
      REAL A,B,C,D,E,EPS,XM,P,Q,R,TOL1,TOL2,U,V,W
      REAL FU,FV,FW,FX,X,ABS,SIGN
C
C     C ECTЬ BOЗBEДEHHAЯ B KBAДPAT BEЛИЧИHA,
C     OБPATHAЯ K ЗOЛOTOMУ CEЧEHИЮ
C
      C=0.5*(3.0-SQRT(5.0))
C
C     EPS ПPИБЛИЗИTEЛЬHO PABHO KBAДPATHOMУ KOPHЮ ИЗ
C     OTHOCИTEЛЬHOЙ MAШИHHOЙ TOЧHOCTИ
C
      EPS=1.0
   10 EPS=EPS/2.0
      TOL1=1.0+EPS
      IF(TOL1.GT.1.0) GO TO 10
      EPS=SQRT(EPS)
C
C     ПPИCBOEHИE HAЧAЛЬHЫX ЗHAЧEHИЙ
C
      A=AX
      B=BX
      V=A+C*(B-A)
      W=V
      X=V
      E=0.0
      FX=F(X)
      FV=FX
      FW=FX
C
C     ЗДECЬ HAЧИHAETCЯ OCHOBHOЙ ЦИKЛ
C
   20 XM=0.5*(A+B)
      TOL1=EPS*ABS(X)+TOL/3.0
      TOL2=2.0*TOL1
C
C     ПPOBEPИTЬ KPИTEPИЙ OKOHЧAHИЯ
C
      IF(ABS(X-XM).LE.(TOL2-0.5*(B-A))) GO TO 90
C
C     HEOБXOДИMO ЛИ ЗOЛOTOE CEЧEHИE
C
      IF(ABS(E).LE.TOL1) GO TO 40
C
C     ПOCTPOИTЬ ПAPAБOЛУ
C
      R=(X-W)*(FX-FV)
      Q=(X-V)*(FX-FW)
      P=(X-V)*Q-(X-W)*R
      Q=2.0*(Q-R)
      IF(Q.GT.0.0) P=-P
      Q=ABS(Q)
      R=E
      E=D
C
C     ПPИEMЛEMA ЛИ ПAPAБOЛA
C
   30 IF(ABS(P).GE.ABS(0.5*Q*R)) GO TO 40
      IF(P.LE.Q*(A-X)) GO TO 40
      IF(P.GE.Q*(B-X)) GO TO 40
C
C     ШAГ ПAPAБOЛИЧECKOЙ ИHTEPПOЛЯЦИИ
C
      D=P/Q
      U=X+D
C
C     F HE CЛEДУET BЫЧИCЛЯTЬ CЛИШKOM БЛИЗKO K AX ИЛИ BX
C
      IF((U-A).LT.TOL2) D=SIGN(TOL1,XM-X)
      IF((B-U).LT.TOL2) D=SIGN(TOL1,XM-X)
      GO TO 50
C
C     ШAГ ЗOЛOTOГO CEЧEHИЯ
C
   40 IF(X.GE.XM) E=A-X
      IF(X.LT.XM)E=B-X
      D=C*E
C
C     F HE CЛEДУET BЫЧИCЛЯTЬ CЛИШKOM БЛИЗKO K X
C
   50 IF(ABS(D).GE.TOL1) U=X+D
      IF(ABS(D).LT.TOL1) U=X+SIGN(TOL1,D)
      FU=F(U)
C
C     ПPИCBOИTЬ HOBЫE ЗHAЧEHИЯ ПAPAMETPAM A,B,V,W И X
C
      IF(FU.GT.FX) GO TO 60
      IF(U.GE.X) A=X
      IF(U.LT.X) B=X
      V=W
      FV=FW
      W=X
      FW=FX
      X=U
      FX=FU
      GO TO 20
C
   60 IF(U.LT.X) A=U
      IF(U.GE.X) B=U
      IF(FU.LE.FW) GO TO 70
      IF(W.EQ.X) GO TO 70
      IF(FU.LE.FV) GO TO 80
      IF(V.EQ.X) GO TO 80
      IF(V.EQ.W) GO TO 80
      GO TO 20
C
   70 V=W
      FV=FW
      W=U
      FW=FU
      GO TO 20
C
   80 V=U
      FV=FU
      GO TO 20
C
C     KOHEЦ OCHOBHOГO ЦИKЛA
C
   90 FMIN=X
      RETURN
      END
