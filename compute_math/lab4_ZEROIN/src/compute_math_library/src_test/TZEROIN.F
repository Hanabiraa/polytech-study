      REAL FUNCTION F(X)
      REAL X
      F=X*(X*X-2.0)-5.0
      RETURN
      END
C
      EXTERNAL F
      REAL F,A,B,Z,TOL,ZEROIN
      A=2.0
      B=3.0
      TOL=1.0E-7
      Z=ZEROIN(A,B,F,TOL)
      PRINT 1,Z
    1 FORMAT('   Z=',F10.7)
      STOP
      END
