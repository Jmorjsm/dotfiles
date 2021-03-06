; Autohotkey Capslock Remapping Script 
; Danik
; More info at http://danikgames.com/blog/?p=714
; danikgames.com
; 
; Functionality:
; - Deactivates capslock for normal (accidental) use.
; - Hold Capslock and drag anywhere in a window to move it (not just the title bar).
; - Access the following functions when pressing Capslock: 
;     Cursor keys           - J, K, L, I
;     Enter                 - Space
;     Home, PgDn, PgUp, End - U, O, Y, H
;     Backspace and Del     - N, M
;
;     Insert                - B
;     Select all            - A
;     Cut, copy, paste      - S, D, F
;     Close tab, window     - W, E
;     Esc                   - R
;     Next, previous tab    - Tab, Q
;     Undo, redo            - , and .
; - Numpad at the right hand resting position when holding Ctrl+Shift+Alt (using keys m,.jkluio and spacebar)
;  
; To use capslock as you normally would, you can press WinKey + Capslock


; This script is mostly assembled from modified versions of the following awesome scripts:
;
; # Home Row Computing by Gustavo Duarte: http://duartes.org/gustavo/blog/post/home-row-computing for 
; Changes: 
; - Does not need register remapping of AppsKey using SharpKeys.
; - Uses normal cursor key layout 
; - Added more hotkeys for insert, undo, redo etc.
;
; # Get the Linux Alt+Window Drag Functionality in Windows: http://www.howtogeek.com/howto/windows-vista/get-the-linux-altwindow-drag-functionality-in-windows/
; Changes: The only change was using Capslock instead of Alt. This 
; also removes problems in certain applications.

#Persistent
SetCapsLockState, AlwaysOff

; Capslock + hjkl (left, up, down, right)

Capslock & h::Send {Blind}{Left DownTemp}
Capslock & h up::Send {Blind}{Left Up}

Capslock & j::Send {Blind}{Down DownTemp}
Capslock & j up::Send {Blind}{Down Up}

Capslock & k::Send {Blind}{Up DownTemp}
Capslock & k up::Send {Blind}{Up Up}

Capslock & l::Send {Blind}{Right DownTemp}
Capslock & l up::Send {Blind}{Right Up}

; Capslock + ; (enter)
Capslock & `;::Send {Blind}{Enter DownTemp}
Capslock & `; up::Send {Blind}{Enter Up}

; Capslock + [] (backspace, delete)
Capslock & [::Send {Blind}{Backspace DownTemp}
Capslock & [ up::Send {Blind}{Backspace Up}

Capslock & ]::Send {Blind}{Delete DownTemp}
Capslock & ] up::Send {Blind}{Delete Up}

; Capslock + uohy (pgdown, pgup, home, end)

; Capslock & u::SendInput {Blind}{Home Down}
; Capslock & u up::SendInput {Blind}{Home Up}

; Capslock & o::SendInput {Blind}{End Down}
; Capslock & o up::SendInput {Blind}{End Up}

; Capslock & y::SendInput {Blind}{PgUp Down}
; Capslock & y up::SendInput {Blind}{PgUp Up}

; ; Capslock & h::SendInput {Blind}{PgDn Down}
; ; Capslock & h up::SendInput {Blind}{PgDn Up}


; ; Capslock + asdf (select all, cut-copy-paste)

; Capslock & a::SendInput {Ctrl Down}{a Down}
; Capslock & a up::SendInput {Ctrl Up}{a Up}

; Capslock & s::SendInput {Ctrl Down}{x Down}
; Capslock & s up::SendInput {Ctrl Up}{x Up}

; Capslock & d::SendInput {Ctrl Down}{c Down}
; Capslock & d up::SendInput {Ctrl Up}{c Up}

; Capslock & f::SendInput {Ctrl Down}{v Down}
; Capslock & f up::SendInput {Ctrl Up}{v Up}


; ; Capslock + wer (close tab or window, press esc)

; Capslock & w::SendInput {Ctrl down}{F4}{Ctrl up}
; Capslock & e::SendInput {Alt down}{F4}{Alt up}
; Capslock & r::SendInput {Blind}{Esc Down}


; ; Capslock + nm (insert, backspace, del)

; Capslock & b::SendInput {Blind}{Insert Down}
; Capslock & m::SendInput {Blind}{Del Down}
; Capslock & n::SendInput {Blind}{BS Down}
; Capslock & BS::SendInput {Blind}{BS Down}


; ; Make Capslock & Enter equivalent to Control+Enter
; Capslock & Enter::SendInput {Ctrl down}{Enter}{Ctrl up}


; ; Make Capslock & Alt Equivalent to Control+Alt
; !Capslock::SendInput {Ctrl down}{Alt Down}
; !Capslock up::SendInput {Ctrl up}{Alt up}


; ; Capslock + TAB/q (forward/back)

Capslock & q::SendInput {XButton2 Down}
Capslock & q up::SendInput {XButton2 Up}
Capslock & Tab::SendInput {XButton1 Down}
Capslock & Tab up::SendInput {XButton1 Up}

; ; Capslock + ,/. (undo/redo)

; Capslock & ,::SendInput {Ctrl Down}{z Down}
; Capslock & , up::SendInput {Ctrl Up}{z Up}
; Capslock & .::SendInput {Ctrl Down}{y Down}
; Capslock & . up::SendInput {Ctrl Up}{y Up}


; ; Make Capslock+Space -> Enter
; Capslock & Space::SendInput {Enter Down}


; ; Numpad using Ctrl+Shift+Alt + m,.jkluio or space
; +^!Space:: SendInput {Numpad0}
; +^!m:: SendInput {Numpad1}
; +^!,:: SendInput {Numpad2}
; +^!.:: SendInput {Numpad3}
; +^!j:: SendInput {Numpad4}
; +^!k:: SendInput {Numpad5}
; +^!l:: SendInput {Numpad6}
; +^!u:: SendInput {Numpad7}
; +^!i:: SendInput {Numpad8}
; +^!o:: SendInput {Numpad9}


; ; Make Win Key + Capslock work like Capslock (in case it's ever needed)
; #Capslock::
; If GetKeyState("CapsLock", "T") = 1
;     SetCapsLockState, AlwaysOff
; Else 
;     SetCapsLockState, AlwaysOn
; Return





; ; Drag windows anywhere
; ;
; ; This script modified from the original: http://www.autohotkey.com/docs/scripts/EasyWindowDrag.htm
; ; by The How-To Geek
; ; http://www.howtogeek.com 

; Capslock LButton::
; CoordMode, Mouse  ; Switch to screen/absolute coordinates.
; MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
; WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
; WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
; if EWD_WinState = 0  ; Only if the window isn't maximized 
;     SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
; return

; EWD_WatchMouse:
; GetKeyState, EWD_LButtonState, LButton, P
; if EWD_LButtonState = U  ; Button has been released, so drag is complete.
; {
;     SetTimer, EWD_WatchMouse, off
;     return
; }
; GetKeyState, EWD_EscapeState, Escape, P
; if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
; {
;     SetTimer, EWD_WatchMouse, off
;     WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
;     return
; }
; ; Otherwise, reposition the window to match the change in mouse coordinates
; ; caused by the user having dragged the mouse:
; CoordMode, Mouse
; MouseGetPos, EWD_MouseX, EWD_MouseY
; WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
; SetWinDelay, -1   ; Makes the below move faster/smoother.
; WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
; EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
; EWD_MouseStartY := EWD_MouseY
; return