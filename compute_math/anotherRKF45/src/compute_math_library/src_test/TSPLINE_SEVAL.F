C     ИЛЛЮCTPИPУЮЩAЯ ПPOГPAMMA ДЛЯ SEVAL
C
      INTEGER N,I
      REAL X(10),Y(10),B(10),C(10),D(10)
      N=10
      DO 10 I=1,N
        X(I)=I
        Y(I)=X(I)**3
   10 CONTINUE
C
      CALL SPLINE (N,X,Y,B,C,D)
C
      U=2.5
      S=SEVAL(N,U,X,Y,B,C,D)
C
      PRINT 102,U,S
      STOP
  102 FORMAT(14X,'U=',F3.1,5X,'S=',F10.7)
      END
