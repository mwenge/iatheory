SEI
LDA #$40
STA $0319    ;Non-Maskable Interrupt
LDA #$00
STA $0318    ;Non-Maskable Interrupt
LDA #$10
STA $DD04    ;CIA2: Timer A: Low-Byte
LDA #$00
STA $DD05    ;CIA2: Timer A: High-Byte
LDA #$7F
STA $DD0D    ;CIA2: CIA Interrupt Register
LDA #$81
STA $DD0D    ;CIA2: CIA Interrupt Register
LDA #$19
STA $DD0E    ;CIA2: CIA Control Register A
CLI
JMP $0835    ;Jump to address $0835
