      REAL FUNCTION ZEROIN(AX,BX,F,TOL)
      REAL AX,BX,F,TOL
C
C     HУЛЬ ФУHKЦИИ F(X) BЫЧИCЛЯETCЯ B ИHTEPBAЛE AX,BX
C
C     BXOДHAЯ ИHФOPMAЦИЯ..
C
C     AX     ЛEBЫЙ KOHEЦ ИCXOДHOГO ИHTEPBAЛA
C     BX     ПPABЫЙ KOHEЦ ИCXOДHOГO ИHTEPBAЛA
C     F      ПOДПPOГPAMMA-ФУHKЦИЯ, KOTOPAЯ BЫЧИCЛЯET F(X)
C            ДЛЯ ЛЮБOГO X B ИHTEPBAЛE AX BX
C     TOL    ЖEЛAEMAЯ ДЛИHA ИHTEPBAЛA HEOПPEДEЛEHHOCTИ
C            KOHEЧHOГO PEЗУЛЬTATA
C
C     BЫXOДHAЯ ИHФOPMAЦИЯ...
C
C     ZEROIN AБCЦИCCA, AППPOKCИMИPУЮЩAЯ HУЛЬ ФУHKЦИИ F B
C            ИHTEPBAЛE AX, BX
C
C        БEЗ ПPOBEPKИ ПPEДПOЛAГAETCЯ, ЧTO F(AX) И F(BX) ИMEЮT
C     ПPOTИBOПOЛOЖHЫE ЗHAKИ.
C        ZEROIN BЫЧИCЛЯET HУЛЬ X B ЗAДAHHOM ИHTEPBAЛE AX, BX
C     B ПPEДEЛAX ДOПУCKA HA OШИБKУ  4*MACHEPS*ABS(X) + TOL,
C     ГДE MACHEPS-OTHOCИTEЛЬHAЯ MAШИHHAЯ TOЧHOCTЬ.
C        ЭTA ПOДПPOГPAMMA-ФУHKЦИЯ ПPEДCTABЛЯET COБOЙ CЛEГKA
C     MOДИФИЦИPOBAHHУЮ TPAHCЛЯЦИЮ AЛГOЛ 60-ПPOЦEДУPЫ ZERO,
C     ПPИBEДEHHOЙ B KHИГE RICHARD BRENT, ALGORITHMS FOR
C     MINIMIZATION WITHOUT DERIVATIVES,PRENTICE HALL,INC.(1973).
C
      REAL A,B,C,D,E,EPS,FA,FB,FC,TOL1,XM,P,Q,R,S
C
C     BЫЧИCЛИTЬ EPS,OTHOCИTEЛЬHУЮ MAШИHHУЮ TOЧHOCTЬ
C
      EPS=1.0
   10 EPS=EPS/2.0
      TOL1=1.0+EPS
      IF(TOL1.GT.1.0) GO TO 10
C
C     ПPИCBOEHИE HAЧAЛЬHЫX ЗHAЧEHИЙ
C
      A=AX
      B=BX
      FA=F(A)
      FB=F(B)
C
C     HAЧATЬ ШAГ
C
   20 C=A
      FC=FA
      D=B-A
      E=D
   30 IF(ABS(FC).GE.ABS(FB)) GO TO 40
      A=B
      B=C
      C=A
      FA=FB
      FB=FC
      FC=FA
C
C     ПPOBEPKA CXOДИMOCTИ
C
   40 TOL1=2.0*EPS*ABS(B)+0.5*TOL
      XM=0.5*(C-B)
      IF(ABS(XM).LE.TOL1) GO TO 90
C
C     HEOБXOДИMA ЛИ БИCEKЦИЯ
C
      IF(FB.EQ.0.0) GO TO 90
      IF(ABS(E).LT.TOL1) GO TO 70
      IF(ABS(FA).LE.ABS(FB)) GO TO 70
C
C     BOЗMOЖHA ЛИ KBAДPATИЧHAЯ ИHTEPПOЛЯЦИЯ
C
      IF(A.NE.C)GO TO 50
C
C     ЛИHEЙHAЯ ИHTEPПOЛЯЦИЯ
C
      S=FB/FA
      P=2.0*XM*S
      Q=1.0-S
      GO TO 60
C
C     OБPATHAЯ KBAДPATИЧHAЯ ИHTEPПOЛЯЦИЯ
C
   50 Q=FA/FC
      R=FB/FC
      S=FB/FA
       P=S*(2.0*XM*Q*(Q-R)-(B-A)*(R-1.0))
      Q=(Q-1.0)*(R-1.0)*(S-1.0)
C
C     BЫБPATЬ ЗHAKИ
C
   60 IF(P.GT.0.0) Q=-Q
      P=ABS(P)
C
C     ПPИEMЛEMA ЛИ ИHTEPПOЛЯЦИЯ
C
      IF((2.0*P).GE.(3.0*XM*Q-ABS(TOL1*Q))) GO TO 70
      IF(P.GE.ABS(0.5*E*Q)) GO TO 70
      E=D
      D=P/Q
      GO TO 80
C
C     БИCEKЦИЯ
C
   70 D=XM
      E=D
C
C     ЗABEPШИTЬ ШAГ
C
   80 A=B
      FA=FB
      IF(ABS(D).GT.TOL1) B=B+D
      IF(ABS(D).LE.TOL1) B=B+SIGN(TOL1,XM)
      FB=F(B)
      IF((FB*(FC/ABS(FC))).GT.0.0) GO TO 20
      GO TO 30
C
C     KOHЧEHO
C
   90 ZEROIN=B
      RETURN
      END
