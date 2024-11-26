#Requires AutoHotkey v2.0
#SingleInstance
#include Notify.ahk


if (!A_IsCompiled && !InStr(A_AhkPath, "_UIA")) {
    Run("*uiAccess " A_ScriptFullPath)
    ExitApp
}

;==============================================

SetCapsLockState('Off')

~*CapsLock:: 
{
	static gHwnd := 0
	Sleep(250)

	if (GetKeyState('CapsLock', 'T')) {
		if !WinExist('ahk_id ' gHwnd)
			gHwnd := Notify.Show('CAPS LOCK ON',,,,, 'dur=0 tc=red ts=18 tfo=italic bc=White dgc=0')['hwnd']
	} else
        Notify.Destroy(gHwnd)
}