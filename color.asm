    processor 6502
    include vcs.h
    include macro.h

    SEG
    ORG $F000

Reset
    LDX #0
    LDA #0

CLEAR
    STA 0,X
    INX
    BNE CLEAR


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

HEADER
    STA WSYNC
    INX
    CPX #36
    BNE HEADER         
   
    LDX #0
    LDY #0

Picture
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inx 
    stx COLUBK 
    nop 
    nop 
    nop 
    dey 
    sty COLUBK 
    sta WSYNC 
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

    ORG $FFFA
    .word Reset          ; NMI
    .word Reset          ; RESET
    .word Reset          ; IRQ
    END