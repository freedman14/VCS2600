    processor 6502
    include vcs.h
    include macro.h

PATTERN = $80
TIMETOCHANGE = 20
COLOR = $23

    SEG
    ORG $F000

Reset
    LDX #0
    LDA #0

CLEAR
    STA 0,X
    INX
    BNE CLEAR

    LDA #0
    STA PATTERN

    LDA #$44
    STA COLUPF

    LDY #0

StartofFrame

    LDA #0
    STA VBLANK

    LDA #2
    STA VSYNC
    
    REPEAT 3
        STA WSYNC
    REPEND

    LDA #0
    STA VSYNC

    LDX #0

VERTICALBLANK
    STA WSYNC
    INX
    CPX #37
    BNE VERTICALBLANK         
   
    INY
    CPY #TIMETOCHANGE
    BNE NOTYET

    LDY #0

    INC PATTERN

NOTYET
    LDA PATTERN
    LDA #%00000000
    STA PF0
    STA PF1
    STA PF2

    LDX #0

Picture
    STX COLUBK
    STA WSYNC
    INX

    CPX #100
    BNE TurnOn 


TurnOff

    CPX #192
    BNE Picture  

    LDA #%01000010
    STA VBLANK
  
    LDX #0

OVERSCAN
    STA WSYNC
    INX
    CPX #30
    BNE OVERSCAN   
      
    JMP StartofFrame

TurnOn
    LDA COLOR
    STA PF0
    STA PF1
    STA PF2
    JMP TurnOff


    ORG $FFFA



INTERRUPTVECTORS   
    .word Reset          ; NMI
    .word Reset          ; RESET
    .word Reset          ; IRQ



    END