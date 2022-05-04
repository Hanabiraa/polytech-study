      SUBROUTINE QUANC8(FUN,A,B,ABSERR,RELERR,RESULT,
     *                  ERREST,NOFUN,FLAG)
C
      REAL FUN,A,B,ABSERR,RELERR,RESULT,ERREST,FLAG
      INTEGER NOFUN
C
C     OЦEHИTЬ ИHTEГPAЛ ДЛЯ FUN(X) OT A ДO B C ЗAДAHHOЙ
C     ПOЛЬЗOBATEЛEM TOЧHOCTЬЮ
C     ABTOMATИЧECKAЯ AДAПTИBHAЯ ПPOГPAMMA, OCHOBAHHAЯ HA
C     ФOPMУЛE HЬЮTOHA-KOTEЦA 8-OГO ПOPЯДKA
C
C     BXOДHAЯ ИHФOPMAЦИЯ
C
C    FUN    -ИMЯ BHEШHEЙ ФУHKЦИИ,PEAЛИЗУЮЩEЙ
C            BЫЧИCЛEHИE ПOДИHTEГPAЛЬHOЙ ФУHKЦИИ
C
C    A      -HИЖHИЙ  ПPEДEЛ ИHTEГPИPOBAHИЯ
C
C    B      -BEPXHИЙ ПPEДEЛ ИHTEГPИPOBAHИЯ (B MOЖET
C            БЫTЬ MEHЬШE, ЧEM  A)
C
C    RELERR -OTHOCИTEЛЬHAЯ ЖEЛAEMAЯ ПOГPEШHOCTЬ
C
C    ABSERR -AБCOЛЮTHAЯ ЖEЛAEMAЯ  ПOГPEШHOCTЬ
C
C    BЫXOДHAЯ ИHФOPMAЦИЯ
C
C    RESULT -ПPИБЛИЖEHHOE ЗHAЧEHИE ИHTEГPAЛA
C
C    ERREST -OЦEHKA BEЛИЧИHЫ ДEЙCTBИTEЛЬHOЙ OШИБKИ
C
C    NOFUN  -ЧИCЛO ЗHAЧEHИЙ ФУHKЦИИ,ИCПOЛЬЗOBAHHЫX
C            ПPИ BЫЧИCЛEHИИ ИHTEГPAЛA.
C
C    FLAG   -ИHДИKATOP HAДEЖHOCTИ. ECЛИ FLAG PABEH HУЛЮ,
C            TO RESULT УДOBЛETBOPЯET ЗAДAHHOЙ ГPAHИЦE
C            ПOГPEШHOCTИ. ECЛИ FLAG=XXX.YYY, TO  XXX-ЧИCЛO
C            ИHTEPBAЛOB ДЛЯ KOTOPЫX HE БЫЛO CXOДИMOCTИ,
C            A 0.YYY-ДOЛЯ OCHOBHOГO ИHTEPBAЛA, OCTABШAЯCЯ
C            ДЛЯ OБPAБOTKИ B TOT MOMEHT,KOГДA ПOДПPOГPAMMA
C            ПPИБЛИЗИЛACЬ K ПPEДEЛЬHOMУ ЧИCЛУ ДЛЯ NOFUN.
C
      REAL W0,W1,W2,W3,W4,AREA,X0,F0,STONE,STEP,COR11,TEMP
      REAL QPREV,QNOW,QDIFF,QLEFT,ESTERR,TOLERR
      REAL QRIGHT(31),F(16),X(16),FSAVE(8,30),XSAVE(8,30)
C
C     *** ЭTAП1 *** ПPИCBOEHИE HAЧAЛЬHЫX ЗHAЧEHИЙ
C     ПEPEMEHHЫM, HE ЗABИCЯЩИM OT ИHTEPBAЛA.
C     ГEHEPИPOBAHИE KOHCTAHT.
C
      INTEGER LEVMIN,LEVMAX,LEVOUT,NOMAX,NOFIN,LEV,NIM,I,J
      LEVMIN=1
      LEVMAX=30
      LEVOUT=6
      NOMAX=5000
      NOFIN=NOMAX-8*(LEVMAX-LEVOUT+2**(LEVOUT+1))
C
C     ECЛИ NOFUN ДOCTИГAET ЗHAЧEHИЯ NOFIN, TO TPEBOГA
C
      W0=3956.0/14175.0
      W1=23552.0/14175.0
      W2=-3712.0/14175.0
      W3=41984.0/14175.0
      W4=-18160.0/14175.0
C
C     ПPИCBOИTЬ HУЛEBЫE ЗHAЧEHИЯ ПEPEMEHHЫM CУMMAM
C
      FLAG=0.0
      RESULT=0.0
      COR11=0.0
      ERREST=0.0
      AREA=0.0
      NOFUN=0
      IF(A.EQ.B)RETURN
C
C     *** ЭTAП 2 *** ПPИCBOEHИE HAЧAЛЬHЫX ЗHAЧEHИЙ
C     ПEPEMEHHЫM, ЗABИCЯЩИM OT ИHTEPBAЛA, B
C     COOTBETCTBИИ C ПEPBЫM ИHTEPBAЛOM
C
      LEV=0
      NIM=1
      X0=A
      X(16)=B
      QPREV=0.0
      F0=FUN(X0)
      STONE=(B-A)/16.0
      X(8)=(X0+X(16))/2.0
      X(4)=(X0+X(8))/2.0
      X(12)=(X(8)+X(16))/2.0
      X(2)=(X0+X(4))/2.0
      X(6)=(X(4)+X(8))/2.0
      X(10)=(X(8)+X(12))/2.0
      X(14)=(X(12)+X(16))/2.0
      DO 25 J=2,16,2
      F(J)=FUN(X(J))
   25 CONTINUE
      NOFUN=9
C
C     *** ЭTAП 3 *** OCHOBHЫE BЫЧИCЛEHИЯ
C     TPEБУЮTCЯ QPREV, X0, X2, X4,...,X16, F0, F2, F4,...
C     ,F16. BЫЧИCЛЯЮTCЯ X1, X3,...,X15, F1, F3,...,F15,
C     QLEFT,QRIGHT,QNOW,QDIF,AREA
C
   30 X(1)=(X0+X(2))/2.0
      F(1)=FUN(X(1))
      DO 35 J=3,15,2
      X(J)=(X(J-1)+X(J+1))/2.0
      F(J)=FUN(X(J))
   35 CONTINUE
      NOFUN=NOFUN+8
      STEP=(X(16)-X0)/16.0
      QLEFT=(W0*(F0+F(8))+W1*(F(1)+F(7))+W2*
     *      (F(2)+F(6))+W3*(F(3)+F(5))+W4*F(4))*STEP
      QRIGHT(LEV+1)=(W0*(F(8)+F(16))+W1*(F(9)+F(15))+
     *       W2*(F(10)+F(14))+W3*(F(11)+F(13))+W4*F(12))*STEP
      QNOW=QLEFT+QRIGHT(LEV+1)
      QDIFF=QNOW-QPREV
      AREA=AREA+QDIFF
C
C     *** ЭTAП 4 *** ПPOBEPKA CXOДИMOCTИ ДЛЯ ИHTEPBAЛA
C
      ESTERR=ABS(QDIFF)/1023.0
      TOLERR=AMAX1(ABSERR,RELERR*ABS(AREA))*(STEP/STONE)
      IF(LEV.LT.LEVMIN)GO TO 50
      IF(LEV.GE.LEVMAX)GO TO 62
      IF(NOFUN.GT.NOFIN)GO TO 60
      IF(ESTERR.LE.TOLERR)GO TO 70
C
C     *** ЭTAП 5 *** CXOДИMOCTИ HET.
C     УCTAHOBИTЬ CЛEДУЮЩИЙ ИHTEPBAЛ
C
   50 NIM=2*NIM
      LEV=LEV+1
C
C     ЗAПOMHИTЬ ЭЛEMEHTЫ, OTHOCЯЩИECЯ K ПPABOЙ ПOЛOBИHE
C     ИHTEPBAЛA, ДЛЯ БУДУЩEГO ИCПOЛЬЗOBAHИЯ.
C
      DO 52 I=1,8
      FSAVE(I,LEV)=F(I+8)
      XSAVE(I,LEV)=X(I+8)
   52 CONTINUE
C
C     COБPATЬ ЭЛEMEHTЫ, OTHOCЯЩИECЯ K ЛEBOЙ ПOЛOBИHE
C     ИHTEPBAЛA ДЛЯ HEMEДЛEHHOГO ИCПOЛЬЗOBAHИЯ
C
      QPREV=QLEFT
      DO 55 I=1,8
      J=-I
      F(2*J+18)=F(J+9)
      X(2*J+18)=X(J+9)
   55 CONTINUE
      GO TO 30
C
C     *** ЭTAП 6 *** "ПOЖAPHЫЙ" PAЗДEЛ
C     ЧИCЛO ЗHAЧEHИЙ ФУHKЦИИ БЛИЗKO K TOMУ, ЧTOБЫ
C     ПPEBЫCИTЬ УCTAHOBЛEHHЫЙ ПPEДEЛ.
C
   60 NOFIN=2*NOFIN
      LEVMAX=LEVOUT
      FLAG=FLAG+(B-X0)/(B-A)
      GO TO 70
C
C     TEKУЩEE ПPEДEЛЬHOE ЗHAЧEHИE ГЛУБИHЫ ДEЛEHИЯ
C     ПOПOЛAM PABHO LEVMAX
C
   62 FLAG=FLAG+1.0
C
C     *** ЭTAП 7 *** CXOДИMOCTЬ ДЛЯ ИHTEPBAЛA ИMEET MECTO
C     ПPИБABИTЬ OЧEPEДHЫE CЛAГAEMЫE K ПEPEMEHHЫM CУMMAM.
C
   70 RESULT=RESULT+QNOW
      ERREST=ERREST+ESTERR
      COR11=COR11+QDIFF/1023.0
C
C     УCTAHOBИTЬ CЛEДУЮЩИЙ ИHTEPBAЛ.
C
   72 IF(NIM.EQ.2*(NIM/2))GO TO 75
      NIM=NIM/2
      LEV=LEV-1
      GO TO 72
   75 NIM=NIM+1
      IF(LEV.LE.0)GO TO 80
C
C     COБPATЬ ЭЛEMEHTЫ, HEOБXOДИMЫE ДЛЯ CЛEДУЮЩEГO ИHTEBAЛA
C
      QPREV=QRIGHT(LEV)
      X0=X(16)
      F0=F(16)
      DO 78 I=1,8
      F(2*I)=FSAVE(I,LEV)
      X(2*I)=XSAVE(I,LEV)
   78 CONTINUE
      GO TO 30
C
C     *** ЭTAП 8 *** ЗAKЛЮЧИTEЛЬHЫE OПEPAЦИИ И BЫXOД
C
   80 RESULT=RESULT+COR11
C
C     OБECПEЧИTЬ, ЧTOБЫ ЗHAЧEHИE ПEPEMEHHOЙ ERREST
C     БЫЛO HE MEHЬШE УPOBHЯ OKPУГЛEHИЙ
C
      IF(ERREST.EQ.0.0)RETURN
   82 TEMP=ABS(RESULT)+ERREST
      IF(TEMP.NE.ABS(RESULT))RETURN
      ERREST=2.0*ERREST
      GO TO 82
      END
