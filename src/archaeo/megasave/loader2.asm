; This disassembly has been adapted from
; https://www.luigidifraia.com/doku/doku.php?id=commodore:tapes:loaders:mega-save
;
; From: Cauldron 
; Note: Assemble with 64tass
 
; **************
; * CBM Header *
; **************
 
*=$033C

; Cassette I/O Buffer - Header
T033C   .byte $03,$A7,$02,$04,$03,$49,$52,$49,$44,$49,$53,$00,$00,$00,$00,$00
T034C   .byte $00,$00,$00,$00,$00
 
AlignAndSynchronizeLoop   
        SEI           
 
        LDA #$6E      ; Set the read bit timer/counter threshold to 0x0107
        STA $DD06     
 
        LDX #$01      
 
; Byte-align with the incoming stream by shifting bits in until the first pilot byte is read
 
_align  JSR rd_bit    ; Read a bit
 
        ROL $F7       ; Shift each of them into the byte receive register, MSbF
        LDA $F7       
        CMP #$63      ; Until the first occurrence of 0x63 (pilot byte) is received
        BNE _align    
 
        LDY #$64      ; Pre-load the first expected sync byte in Y
 
; Read the whole pilot sequence
 
_pilot  JSR rd_byte   ; Keep reading bytes until the pilot train is over
        CMP #$63      
        BEQ _pilot    
 
; Check that the sync sequence is as expected (Note: $F7 = byte read by means of a call to rd_byte)
 
_sync   CPY $F7       ; Is the currently expected sync byte following?
        BNE _align    ; Start over if not
 
        JSR rd_byte   ; Read byte
 
        INY           ; Bump the expected sync byte value
        BNE _sync     ; Read the whole sync sequence (0x64-0xff inclusive)
 
        CMP #$00      ; In absence of issues A is set to 0x01 here
        BEQ AlignAndSynchronizeLoop     
 
; Read and store file header
 
_header JSR rd_byte   ; Read 10 header bytes
        STA $002B,Y   ; Overwrite BASIC program pointers
        STA $00F9,Y   ; Also store them in RAM where they will be changed
        INY           
        CPY #$0A      
        BNE _header   
 
        LDY #$00      
        STY $90       ; Zero the status flags (not set by this code)
        STY $02       ; Zero the checkbyte register
 
; Read and store data from tape into RAM
 
_data   JSR rd_byte   ; Read a byte
        STA ($F9),Y   ; Store in RAM
 
        EOR $02       ; Update the checkbyte value
        STA $02       
 
        INC $F9       ; Bump the destination pointer
        BNE _check_complete       
        INC $FA       

_check_complete 
        LDA $F9       ; And check if the file is complete
        CMP $2D       ; by comparing the destination pointer
        LDA $FA       ; to its one-past-end value
        SBC $2E       
        BCC _data     
 
        JSR rd_byte   ; Read a byte
 
        INY           
        STY $C0       ; Control motor via software
 
        CLI           
 
        CLC           
 
        LDA #$00      ; Make sure the call to $FC93 does not restore the standard IRQ
        STA $02A0     
        JSR $FC93     ; Disable interrupts, un-blank the screen, and stop cassette motor
 
        JSR $E453     ; Copy BASIC vectors to RAM
 
        LDA $F7       ; Compare saved and computed checkbytes
        EOR $02       
        ORA $90       ; And check that the status flags do not indicate an error
        BEQ *+5       
 
        JMP $FCE2     ; Soft-reset if any of the above checks fails
 
; Code execution after a file is completely loaded in
 
        LDA $31       ; Check flag #1
        BEQ *+5       ; If not set move on
        JMP J02B9     ; Otherwise re-execute the loader
 
        LDA $32       ; Check flag #2
        BEQ *+5       ; If not set move on in order to issue a BASIC RUN command
        JMP ($002F)   ; Otherwise execute a custom routine pointed by the vector $2f/$30
 
        JSR $A533     ; Relink lines of tokenized program text
 
        LDX #$03      ; Set the number of characters in keyboard buffer to 3
        STX $C6       
 
        LDA T02F4-1,X ; And copy R, <shift> + U, <return> into the buffer
        STA $0276,X   
        DEX           
        BNE *-7       
 
        JMP J02E9     
 
; --------------------------------
 
; Read byte: read 8 bits from tape, grouping them MSbF
;
; Returns: the read byte in A
 
rd_byte LDA #$07      ; Prepare for 8 bits
        STA $F8       ; Using $f8 as a counter
 
B03EB   JSR rd_bit    ; Read a bit
 
        ROL $F7       ; Shift each of them into the byte receive register, MSbF
 
        INC $D020     
 
        DEC $F8       ; And loop until 8 bits are received
        BPL B03EB     
 
        LDA $F7       ; Return read byte in A
 
        RTS           
 
        .cerror * > $03FC, "The CBM Header code is too long to fit in the tape buffer!"
 
; --------------------------------
 
        .align $03FC, $00 ; Padding
 
 
; ************
; * CBM Data *
; ************
 
*=$02A7
 
NMIH    LDA #$80      
        ORA $91       
        JMP $F6EF     
 
J02AE   LDA #<NMIH    
 
        SEI           
 
        STA $0328     ; Disable <Run Stop> + <Restore>
        LDA #>NMIH    
        STA $0329     
 
J02B9   CLI           
 
        LDY #$00      
        STY $C6       ; No char in keyboard buffer
        STY $C0       ; Enable tape motor
        STY $02       ; Zero the checkbyte register (also done later on)
 
        LDA $D011     ; Blank the screen
        AND #$EF      
        STA $D011     
 
        DEX           ; Wait a bit
        BNE *-1       
        DEY           
        BNE *-4       
 
        SEI           
 
        JMP AlignAndSynchronizeLoop     ; Execute the main loader code
 
; --------------------------------
 
; Read bit: loops until a falling edge is received on the read line and uses
;           the read bit timer/counter to discriminate the current bit value
;
; Returns: the read bit in the Carry flag
 
rd_bit  LDA $DC0D     ; Loop until a falling edge is detected
        AND #$10      ; on the read line of the tape port
        BEQ rd_bit       
 
        LDA $DD0D     
        STX $DD07     
        LSR           
        LSR           ; Move read bit into the Carry flag
 
        LDA #$19      ; Restart the bit read threshold timer/counter
        STA $DD0F     
 
        RTS           
 
; --------------------------------
 
J02E9   JSR $A68E     ; Reset pointer to current text character to the beginning of program text
 
        LDA #$00      
        TAY           
        STA ($7A),Y   
 
        JMP $A474     ; Print READY
 
; --------------------------------
 
; Characters to be injected in the keyboard buffer, if required
 
T02F4   .byte $52,$D5,$0D ; R, <shift> + U, <return>
 
        .cerror * > $0300, "The CBM Data code is too long to fit in front of the vector table!"
 
; --------------------------------
 
; Overwrite BASIC vectors in RAM
 
        .align $0300, $00 ; Padding
 
T0300   .word $E38B ; Leave IERROR unchanged
        .word J02AE ; Autostart the turbo loader, once loaded, by overwriting IMAIN
