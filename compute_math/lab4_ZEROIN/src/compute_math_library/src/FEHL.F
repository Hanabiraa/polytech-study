      SUBROUTINE FEHL(F,NEQN,Y,T,H,YP,F1,F2,F3,F4,F5,S)
C
C     METOД PУHГE-KУTTA-ФEЛЬБEPГA ЧETBEPTOГO-ПЯTOГO ПOPЯДKA
C
C     ПOДПPOГPAMMA FEHL ИHTEГPИPУET CИCTEMУ ИЗ NEQN
C     OБЫKHOBEHHЫX ДИФФEPEHЦИAЛЬHЫX УPABHEHИЙ ПEPBOГO
C     ПOPЯДKA CЛEДУЮЩEГO BИДA
C
C          DY(I)/DT=F(T,Y(1),...Y(NEQN)),
C
C     ГДE HAЧAЛЬHЫE ЗHAЧEHИЯ Y(I) И HAЧAЛЬHЫE ПPOИЗBOДHЫE
C     YP(I) ЗAДAHЫ B HAЧAЛЬHOЙ TOЧKE T. FEHL ПPOДOЛЖAET
C     PEШEHИE HA ФИKCИPOBAHHЫЙ ШAГ H И ПOMEЩAET B MACCИB
C     S(I) ПPИБЛИЖEHИE K PEШEHИЮ B TOЧKE T+H, ИMEЮЩEE ПЯTЫЙ
C     ПOPЯДOK TOЧHOCTИ (ЛOKAЛЬHЫЙ ПOPЯДOK PABEH ШECTИ).
C     F1,...F5-MACCИBЫ PAЗMEPHOCTИ NEQN,HEOБXOДИMЫE BHУTPИ
C     ПPOГPAMMЫ.
C          B ФOPMУЛAX ПPOИЗBEДEHA ГPУППИPOBKA C ЦEЛЬЮ
C     УMEHЬШИTЬ ПOTEPЮ BEPHЫX ЗHAKOB.
C          ЧTOБЫ MOЖHO БЫЛO PAЗЛИЧATЬ PAЗHЫE HEЗABИCИMЫE
C     APГУMEHTЫ, ПPИ OБPAЩEHИИ K FEHL HE CЛEДУET ЗAДABATЬ
C     ДЛЯ H ЗHAЧEHИE,MEHЬШEE УMHOЖEHHHOЙ HA 13 OШИБKИ
C     OKPУГЛEHИЯ B T.
C
      INTEGER NEQN
      REAL Y(NEQN),YP(NEQN),F1(NEQN),F2(NEQN),
     *     F3(NEQN),F4(NEQN),F5(NEQN),S(NEQN)
      REAL CH
      INTEGER K
C
      CH=H/4.0
      DO 221 K=1,NEQN
  221 F5(K)=Y(K)+CH*YP(K)
C
      CALL F(T+CH,F5,F1)
      CH=3.0*H/32.0
      DO 222 K=1,NEQN
  222 F5(K)=Y(K)+CH*(YP(K)+3.0*F1(K))
      CALL F(T+3.0*H/8.0,F5,F2)
C
      CH=H/2197.0
      DO 223 K=1,NEQN
  223 F5(K)=Y(K)+CH*(1932.0*YP(K)+(7296.0*F2(K)-7200.0*F1(K)))
      CALL F(T+12.0*H/13.0,F5,F3)
C
      CH=H/4104.0
      DO 224 K=1,NEQN
  224 F5(K)=Y(K)+CH*((8341.0*YP(K)-845.0*F3(K))+
     *      (29440.0*F2(K)-32832.0*F1(K)))
      CALL F(T+H,F5,F4)
C
      CH=H/20520.0
      DO 225 K=1,NEQN
  225 F1(K)=Y(K)+CH*((-6080.0*YP(K)+(9295.0*F3(K)-
     *      5643.0*F4(K)))+(41040.0*F1(K)-28352.0*F2(K)))
      CALL F(T+H/2.0,F1,F5)
C
C     BЫЧИCЛИTЬ ПPИБЛИЖEHHOE PEШEHИE B TOЧKE T+H
C
      CH=H/7618050.0
      DO 230 K=1,NEQN
  230 S(K)=Y(K)+CH*((902880.0*YP(K)+(3855735.0*F3(K)-
     *     1371249.0*F4(K)))+(3953664.0*F2(K)+277020.0*F5(K)))
C
      RETURN
      END
