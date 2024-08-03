; Retrieve the USERPROFILE environment variable
userProfile := EnvGet("USERPROFILE")

; Set the tray icon to a custom icon file
TraySetIcon userProfile . "\.tools\autohotkey\gather.png"

; Define the zones
zone1 := { x: 0, y: 0, width: 960, height: 704 }
zone2 := { x: 0, y: 704, width: 1920, height: 1408 }
zone3 := { x: 1920, y: 704, width: 1920, height: 1408 }

; Define the program to be opened or moved
gatherPath := userProfile . "\\AppData\\Local\\Programs\\gather-electron\\Gather.exe"
gatherTitle := "Gather Desktop"
regionToSharePath := userProfile . "\Desktop\RegionToShare.lnk"
regionToShareTitlePrefix := "Region to Share"

; Function to move the window to a specified zone
moveWindowToZone(zone) {
    WinMove(zone.x, zone.y, zone.width, zone.height, gatherTitle)
}

; Function to find or run the program
findOrRunProgram() {
    if WinExist(gatherTitle) {
        WinActivate(gatherTitle)
        return true
    } else {
        Run(gatherPath)
        return false
    }
}

closeRegionToShare() {
    WinKill(regionToShareTitlePrefix)
    WinKill(regionToShareTitlePrefix)
}

; Function to detect the current zone
detectCurrentZone() {
    WinGetPos &winX, &winY, &winWidth, &winHeight, gatherTitle
    ; Assuming zone detection based on width and height
    if (winWidth == zone1.width and winHeight == zone1.height and winX == zone1.x and winY == zone1.y) {
        return 1
    } else {
        return 0 ; Unknown or new zone
    }
}

; Define the hotkey
^+g:: {
    static lastZone := 1
    if findOrRunProgram() {
        ; Detect the current zone
        currentZone := detectCurrentZone()

        ; Toggle between zones
        if (currentZone == 1) {

            moveWindowToZone(zone2)
            Run(regionToSharePath)

            Sleep 100
            Click 100, 800

        } else {

            WinActivate(gatherTitle)
            Sleep 100
            Send "^d"
            Sleep 100
            moveWindowToZone(zone1)

            MouseGetPos &xpos, &ypos
            Sleep 500
            Click 610, 20
            Sleep 100
            Click 630, 20
            Sleep 100
            Click 700, 20
            Sleep 100
            MouseMove xpos, ypos

            ; Deactivate the active window by activating the taskbar
            WinActivate("ahk_class Shell_TrayWnd")

            try {
                closeRegionToShare()
            } catch Error as e {
                ; Ignore Error
            }
        }
    } else {
        ; Move to zone 1 if newly opened
        WinWaitActive(gatherTitle)
        moveWindowToZone(zone1)
        lastZone := 1
    }
}