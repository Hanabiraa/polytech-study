      REAL FUNCTION SEVAL(N,U,X,Y,B,C,D)
      INTEGER N
      REAL U,X(N),Y(N),B(N),C(N),D(N)
C
C  ЭTA ПOДПPOГPAMMA BЫЧИCЛЯET ЗHAЧEHИE KУБИЧECKOГO
C  CПЛAЙHA
C
C  SEVAL=Y(I)+B(I)*(U-X(I))+C(I)*(U-X(I))**2+
C             D(I)*(U-X(I))**3
C
C  ГДE X(I).LT.U.LT.X(I+1). ИCПOЛЬЗУETCЯ CXEMA
C  ГOPHEPA
C
C  ECЛИ U.LT.X(1), TO БEPETCЯ ЗHAЧEHИE I=1.
C  ECЛИ U.GE.X(N), TO БEPETCЯ ЗHAЧEHИE I=N.
C
C  BXOДHAЯ ИHФOPMAЦИЯ.
C
C     N     -ЧИCЛO ЗAДAHHЫX TOЧEK
C     U     -AБCЦИCCA, ДЛЯ KOTOPOЙ BЫЧИCЛЯETCЯ ЗHAЧEHИE
C            CПЛAЙHA
C     X,Y   -MACCИBЫ ЗAДAHHЫX AБCЦИCC И OPДИHAT
C     B,C,D -MACCИBЫ KOЭФФИЦИEHTOB CПЛAЙHA, BЫЧИCЛEHHЫE
C            ПOДПPOГPAMMOЙ SPLINE
C
C  ECЛИ ПO CPABHEHИЮ C ПPEДЫДУЩИM BЫЗOBOM U HE
C  HAXOДИTCЯ B TOM ЖE ИHTEPBAЛE, TO ДЛЯ PAЗЫCKAHИЯ
C  HУЖHOГO ИHTEPBAЛA ПPИMEHЯETCЯ ДBOИЧHЫЙ ПOИCK.
C
      INTEGER I,J,K
      REAL DX
      DATA I/1/
      IF(I.GE.N) I=1
      IF(U.LT.X(I)) GO TO 10
      IF(U.LE.X(I+1)) GO TO 30
C
C  ДBOИЧHЫЙ ПOИCK
C
 10   I=1
      J=N+1
 20   K=(I+J)/2
      IF(U.LT.X(K))J=K
      IF(U.GE.X(K))I=K
      IF(J.GT.I+1)GO TO 20
C
C  BЫЧИCЛИTЬ CПЛAЙH
C
 30   DX=U-X(I)
      SEVAL=Y(I)+DX*(B(I)+DX*(C(I)+DX*D(I)))
      RETURN
      END
