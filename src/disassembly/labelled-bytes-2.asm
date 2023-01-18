StartExecution
        SEI
        ; Tell the C64 to execute the code at MainControlLoop
        ; the next time an interrupt happens.
        LDA #>MainControlLoop
        STA $0319    ;NMI
        LDA #<MainControlLoop
        STA $0318    ;NMI

        ; Turn off the tape deck.
        LDA #$10
        STA $DD04    ;CIA2: Timer A: Low-Byte
        LDA #$00
        STA $DD05    ;CIA2: Timer A: High-Byte
        LDA #$7F
        STA $DD0D    ;CIA2: CIA Interrupt Control Register
        LDA #$81
        STA $DD0D    ;CIA2: CIA Interrupt Control Register
        LDA #$19
        STA $DD0E    ;CIA2: CIA Control Register A
        CLI
LoopUntilExexcutes
        JMP LoopUntilExexcutes
