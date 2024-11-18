g := Gui('-Caption')
g.SetFont('s30')
g.Add('Text',, 'GUI with rounded corners.')
FrameShadow(g.hwnd)
DrawBorderRound(g.hwnd, '0x00FF00') ; lime
g.Show('NoActivate Hide')

; Fade animation to prevent the entire GUI from flashing lime
DllCall('AnimateWindow', 'Ptr', g.hwnd, 'Int', 125, 'Int', '0x80000') ; AW_BLEND/Fade
; SetTimer((*) => ExitApp(), -8000)

; make it draggable
OnMessage(0x0201, WM_LBUTTONDOWN)
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) => PostMessage(0xA1, 2, , , "A")

;============================================================================================
; FrameShadow by Klark92, XMCQCX (v2 conversion)  https://www.autohotkey.com/boards/viewtopic.php?f=6&t=29117&hilit=FrameShadow
FrameShadow(hwnd)
{
    DllCall("dwmapi.dll\DwmIsCompositionEnabled", "int*", &dwmEnabled:=0)
    
    if !dwmEnabled {
        DllCall("user32.dll\SetClassLongPtr", "ptr", hwnd, "int", -26, "ptr", DllCall("user32.dll\GetClassLongPtr", "ptr", hwnd, "int", -26) | 0x20000)
    }
    else {
        margins := Buffer(16, 0)    
        NumPut("int", 1, "int", 1, "int", 1, "int", 1, margins)
        DllCall("dwmapi.dll\DwmSetWindowAttribute", "ptr", hwnd, "Int", 2, "Int*", 2, "Int", 4)
        DllCall("dwmapi.dll\DwmExtendFrameIntoClientArea", "ptr", hwnd, "ptr", margins)
    }
}

;============================================================================================    
; DrawBorder by ericreeves  https://gist.github.com/ericreeves/fd426cc0457a5a47058e1ad1a29d9bd6
DrawBorderRound(hwnd, color) => DllCall("dwmapi\DwmSetWindowAttribute", "ptr", hwnd, "int", DWMWA_BORDER_COLOR := 34, "int*", color, "int", 4)