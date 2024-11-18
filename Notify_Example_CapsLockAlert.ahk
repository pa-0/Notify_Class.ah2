#Requires AutoHotkey v2.0
#SingleInstance
#include <v2\Notify\Notify>

if (!A_IsCompiled && !InStr(A_AhkPath, "_UIA")) {
    Run("*uiAccess " A_ScriptFullPath)
    ExitApp
}

;==============================================

~*CapsLock:: 
~*NumLock:: 
~*ScrollLock::
~*Insert::	
{
	static m := Map(
        'CapsLock',   Map('hwnd', 0), 
        'NumLock',    Map('hwnd', 0),
        'ScrollLock', Map('hwnd', 0),
        'Insert',     Map('hwnd', 0)
    )
	
    Sleep(10)  
	thisHotkey := SubStr(A_ThisHotkey, 3)
	Notify.Destroy(m[thisHotkey]['hwnd'])

	if (GetKeyState(thisHotkey, 'T'))
		m[thisHotkey]['hwnd'] := Notify.Show(thisHotkey ' ON',,,,, 'pos=bl dur=3 ts=20 tfo=italic bc=00A22B dgc=0')['hwnd']
	else
		m[thisHotkey]['hwnd'] := Notify.Show(thisHotkey ' OFF',,,,, 'pos=bl dur=3 ts=20 tfo=italic bc=F09800 dgc=0')['hwnd']    
}