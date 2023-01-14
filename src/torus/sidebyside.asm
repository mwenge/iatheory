;-----------------------------------------                      ;------------------------------------------
; PlayTitleScreenMusic                                          ; PlayTitleScreenMusic
; (TORUS:TAURUS)                                                ; (IRIDIS ALPHA)
;-----------------------------------------                      ;------------------------------------------
PlayTitleScreenMusic                                            PlayTitleScreenMusic
                                                                        DEC baseNoteDuration
                                                                        BEQ MaybeStartNewTune
                                                                        RTS

                                                                MaybeStartNewTune   
                                                                        LDA previousBaseNoteDuration
                                                                        STA baseNoteDuration
                                   
         DEC numberOfNotesToPlayInTune                                  DEC numberOfNotesToPlayInTune
         BNE MaybePlayVoice1                                            BNE MaybePlayVoice1
                                                                                                 
         JSR SelectNewNotesToPlay        

         ; Set up a new tune.                                           ; Set up a new tune.
         LDA #$C0                                                       LDA #$C0
         STA numberOfNotesToPlayInTune                                  STA numberOfNotesToPlayInTune
                                                                 
                                                                        ; This is what will eventually time us out of
                                                                        ; the title music and enter attract mode.
                                                                        INC f7PressedOrTimedOutToAttractMode
           
         LDX notesPlayedSinceLastKeyChange                              LDX notesPlayedSinceLastKeyChange
         LDA titleMusicNoteArray,X                                      LDA titleMusicNoteArray,X
         STA offsetForNextVoice1Note                                    STA offsetForNextVoice1Note
                                                                 
         ; We'll only select a new tune when we've reached the          ; We'll only select a new tune when we've reached
         ; beginning of a new 16 bar structure.                         ; the beginning of a new 16 bar structure.
         INX                                                            INX
         TXA                                                            TXA
         AND #$03                                                       AND #$03
         STA notesPlayedSinceLastKeyChange                              STA notesPlayedSinceLastKeyChange
                                                                        BNE MaybePlayVoice1
                                                                 
                                                                        JSR SelectNewNotesToPlay
 
 MaybePlayVoice1                                                MaybePlayVoice1   
         DEC voice1NoteDuration                                         DEC voice1NoteDuration
         BNE MaybePlayVoice2                                            BNE MaybePlayVoice2
                                                                
         LDA #$30                                                       LDA #$30
         STA voice1NoteDuration                                         STA voice1NoteDuration
                                                                
         LDX voice1IndexToMusicNoteArray                                LDX voice1IndexToMusicNoteArray
         LDA titleMusicNoteArray,X                                      LDA titleMusicNoteArray,X
         CLC                                                            CLC
         ADC offsetForNextVoice1Note                                    ADC offsetForNextVoice1Note
         TAY                                                            TAY
         STY offsetForNextVoice2Note                                    STY offsetForNextVoice2Note
                                                                
         JSR PlayVoice1                                                 JSR PlayNoteVoice1
                                                                
         INX                                                            INX
         TXA                                                            TXA
         AND #$03                                                       AND #$03
         STA voice1IndexToMusicNoteArray                                STA voice1IndexToMusicNoteArray
                                                                
 MaybePlayVoice2                                                MaybePlayVoice2   
         DEC voice2NoteDuration                                         DEC voice2NoteDuration
         BNE MaybePlayVoice3                                            BNE MaybePlayVoice3
                                                                
         LDA #$0C                                                       LDA #$0C
         STA voice2NoteDuration                                         STA voice2NoteDuration
         LDX voice2IndexToMusicNoteArray                                LDX voice2IndexToMusicNoteArray
         LDA titleMusicNoteArray,X                                      LDA titleMusicNoteArray,X
         CLC                                                            CLC
         ADC offsetForNextVoice2Note                                    ADC offsetForNextVoice2Note
                                                                
         ; Use this new value to change the key of the next four        ; Use this new value to change the key of the next four
         ; notes played by voice 3.                                     ; notes played by voice 3. 
         STA offsetForNextVoice3Note                                    STA offsetForNextVoice3Note
                                                                
         TAY                                                            TAY
         JSR PlayVoice2                                                 JSR PlayNoteVoice2
         INX                                                            INX
         TXA                                                            TXA
         AND #$03                                                       AND #$03
         STA voice2IndexToMusicNoteArray                                STA voice2IndexToMusicNoteArray
                                                                
 MaybePlayVoice3                                                MaybePlayVoice3   
         DEC voice3NoteDuration                                         DEC voice3NoteDuration
         BNE ReturnFromTitleScreenMusic                                 BNE ReturnFromTitleScreenMusic
                                                                
         LDA #$03                                                       LDA #$03
         STA voice3NoteDuration                                         STA voice3NoteDuration
                                                                
         ; Play the note currently pointed to by                        ; Play the note currently pointed to by 
         ; voice3IndexToMusicNoteArray in titleMusicNoteArray.          ; voice3IndexToMusicNoteArray in titleMusicNoteArray.
         LDX voice3IndexToMusicNoteArray                                LDX voice3IndexToMusicNoteArray
         LDA titleMusicNoteArray,X                                      LDA titleMusicNoteArray,X
         CLC                                                            CLC
         ADC offsetForNextVoice3Note                                    ADC offsetForNextVoice3Note
         TAY                                                            TAY
         JSR PlayVoice3                                                 JSR PlayNoteVoice3
                                                                                                                               
        ; Move voice3IndexToMusicNoteArray to the next                 ; Move voice3IndexToMusicNoteArray to the next
         ; position in titleMusicNoteArray.                            ; position in titleMusicNoteArray.
         INX                                                           INX
         TXA                                                           TXA
         ; Since it's only 4 bytes long ensure we wrap                 ; Since it's only 4 bytes long ensure we wrap
         ; back to 0 if it's greater than 3.                           ; back to 0 if it's greater than 3.
         AND #$03                                                      AND #$03
         STA voice3IndexToMusicNoteArray                               STA voice3IndexToMusicNoteArray
                                                                                     
 ReturnFromTitleScreenMusic                                     ReturnFromTitleScreenMusic   
         RTS                                                           RTS
