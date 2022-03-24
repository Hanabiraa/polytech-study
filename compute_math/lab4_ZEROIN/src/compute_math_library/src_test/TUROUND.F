C     ИЛЛЮCTPИPУЮЩAЯ ПPOГPAMMA ДЛЯ URAND
C
      IY=0
      DO 10 I=1,10
         Z=URAND(IY)
         PRINT 1,Z
   1  FORMAT('    Z=',F10.7)
  10  CONTINUE
      STOP
      END
