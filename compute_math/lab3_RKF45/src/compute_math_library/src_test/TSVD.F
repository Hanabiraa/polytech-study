C     ИЛЛЮCTPИPУЮЩAЯ ПPOГPAMMA ДЛЯ SVD
C
      REAL A(5,3),U(5,3),V(5,3),SIGMA(5),WORK(5)
      INTEGER I,IERR,J,M,N,NM
      NM=5
      M=5
      N=3
      DO 1 I=1,M
      DO 1 J=1,N
        A(I,J)=I+(J-1)*M
   1  CONTINUE
C
      CALL SVD(NM,M,N,A,SIGMA,.TRUE.,U,.TRUE.,V,IERR,WORK)
C
      IF(IERR.NE.0) WRITE (6,2) IERR
   2  FORMAT(' TROUBLE IERR=',I4)
      DO 3 J=1,N
         WRITE (6,6) SIGMA(J)
   3  CONTINUE
      WRITE (6,7)
      DO 4 I=1,M
        WRITE (6,6) (U(I,J),J=1,N)
   4  CONTINUE
      WRITE (6,7)
      DO 5 I=1,N
        WRITE (6,6) (V(I,J),J=1,N)
   5  CONTINUE
   6  FORMAT(3F10.6)
   7  FORMAT(1H )
      STOP
      END
