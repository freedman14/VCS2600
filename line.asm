processor 6502
include "vcs.h"
include "macro.h"

SEG

ORG $F000

Reset
StartOfFrame
; Start of vertical blank processing
  lda #0
  sta VBLANK
  lda #2
  sta VSYNC
; 3 scanlines of VSYNCH signal...

  REPEAT 3; scanlines
    sta WSYNC
  REPEND

  lda #0
  sta VSYNC

  ; 37 scanlines of vertical blank...

   REPEAT 37; scanlines
    sta WSYNC
   ; 192 scanlines of picture...
   REPEND

   ldx #0

   REPEAT 192; scanlines
    inx
    stx COLUBK
    sta WSYNC
    
  lda #%01000010

  sta VBLANK                     ; end of screen - enter blanking

 ; 30 scanlines of overscan...
 REPEAT 30; scanlines
  sta WSYNC
  REPEND

jmp StartOfFrame
ORG $FFFA
.word Reset          ; NMI
.word Reset          ; RESET
.word Reset          ; IRQ
END
