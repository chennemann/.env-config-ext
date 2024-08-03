; Set the tray icon to a custom icon file
TraySetIcon "C:\Users\chris\.tools\autohotkey\terminal.png"

SwitchToWindowsTerminal() {
    windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
    windowExistsAlready := windowHandleId > 0

    ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
    if windowExistsAlready {
        activeWindowHandleId := WinExist("A")
        windowIsAlreadyActive := activeWindowHandleId == windowHandleId

        if windowIsAlreadyActive {
            ; Minimize the window.
            WinMinimize("ahk_id " windowHandleId)
        } else {
            ; Put the window in focus.
            WinActivate("ahk_id " windowHandleId)
            WinShow("ahk_id " windowHandleId)
        }
    } else {
        ; Else it's not already open, so launch it.
        Run("wt")
    }
}

; Hotkey to use Ctrl+Alt+End to launch/restore the Windows Terminal.
^!End::SwitchToWindowsTerminal()