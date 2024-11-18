#Requires Autohotkey v2.1-alpha.14
#SingleInstance Force
#include <TapHoldManager>
#include <TooltipEx>
#include <Notify>

THM := TapHoldManager()
THM.Add("F11", Layer1)
THM.Add("F13", Layer2)
THM.Add("F12", Layer3)

;/////////////////////////

#HotIf GetKeyState("F11", "P")
{
    WheelUp:: Send("{LControl Down}{Tab}{LControl Up}")
    WheelDown:: Send("{LControl Down}{LShift Down}{Tab}{LShift Up}{LControl Up}")
    Delete:: Send("{BackSpace}")
    ^C:: Send("{LControl Down}{a}{LControl Up}")
    ^V:: Send("{F20}")
    XButton2:: Send("{LControl Down}{y}{LControl Up}")
    XButton1:: Send("{LControl Down}{z}{LControl Up}")
    ^W:: Send("{LControl Down}{LShift Down}{t}{LShift Up}{LControl Up}")

}
#HotIf GetKeyState("F13", "P")
{
    WheelUp:: Send("{LControl Down}{Home}{LControl Up}")
    WheelDown:: Send("{LControl Down}{End}{LControl Up}")
    Delete:: Send("{LControl Down}{Backspace}{LControl Up}")
    ^C:: Send("{Up}")
    ^V:: Send("{LWin Down}{c}{LWin Up}")
    XButton2:: Send("{Left}")
    XButton1:: Send("{F23}")
    ^W:: Send("{LWin Down}{g}{LWin Up}")
}
#HotIf

;/////////////////////////

class Layer {
    static Layers := ["F11", "F13", "F12"]
    static Notify(message) {
        Notify.Show(message, , , , , 'dur=1 pos=bl tag=' message ' ts=10')
    }

    static Hold(layerNumber) {
        key := this.Layers[layerNumber]
        layerVar := "Layer" . layerNumber
        global layerVar
        If (GetKeyState(key, "P")) {
            layerVar := true
            this.Notify("Layer " . layerNumber)
            startTime := A_TickCount
            KeyWait(key)
            elapsedTime := A_TickCount - startTime
            if (elapsedTime >= 250) {
                this.Notify("Layer " . layerNumber)
            }
        }
        layerVar := false
    }

    static HoldLayer() {
        this.Hold(1)
    }
}
;/////////////////////////

Layer1(IsHold, Taps, State) {
    switch {
        case IsHold:
            if (Taps = 2) {
                Layer1h := false
                Send("{LControl Down}{F5}{LControl Up}")
            } Else { 
                if (Taps = 3) {
                    Layer1h := false
                    Layer.Notify("TapTapHold")
                }                
                Layer.Hold(1)
            }
            Layer1h := false
        case Taps = 1:
            if (State = -1)
                Layer.Notify("Tap")
        case Taps = 2:
            Send("{LWin Down}{LShift Down}{Left}{LWin Up}{LShift Up}")
        case Taps = 3:
            Send("{LControl Down}{F5}{LControl Up}")
            SoundBeep(1000, 200)
        case State = 0:
    }
}

Layer2(IsHold, Taps, State) {
    switch {
        case IsHold:
            if (Taps = 2) {
                Send("{LControl Down}{F5}{LControl Up}")
            } Else {
                if (Taps = 3) {
                    Layer.Notify("TapTapHold")
                }
            }
            Layer.Hold(2)
        case Taps = 1:
            if (State = -1)
                Layer.Notify("Tap")
        case Taps = 2:
            Send("{LShift Down}{LWin Down}{Left}{LWin Up}{LShift Up}")
        case Taps = 3:
            Send("{LShift Down}{LWin Down}{s}{LWin Up}{LShift Up}")
        case Taps = 4:
            Send("{LShift Down}{LWin Down}{r}{LWin Up}{LShift Up}")
        case State = 0:
    }
}

Layer3(IsHold, Taps, State) {
    switch {
        case IsHold:
            if (Taps = 2) {
                Layer3h := false
                Layer.Notify('TapHold')
            } Else {
                if (Taps = 3) {
                    Layer3h := false
                    Layer.Notify("TapTapHold")
                }
                Layer.Hold(3)
            }
        case Taps = 1:
            if (State = -1)
                Layer.Notify("Tap")
        case Taps = 2:
            Send("{LShift Down}{F12}{LShift Up}")
            Layer.Notify('DoubleTap')
        case Taps = 3:
            Layer.Notify('TripleTap')
        case State = 0:
    }
}