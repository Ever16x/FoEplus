;---------------------------------------------------------------------------;
; FoEplus - FoE essential enhancements                                      ;
; Helps save the most valuable resource in-game and in RL - time            ;
;                                                                           ;
; Copyright(c) Ever16/Xyr, v0.2.0                                           ;
; License: GNU GPLv3                                                        ;
;                                                                           ;
; Ctrl-Alt-A: aid all, Esc: stop                                            ;
; Ctrl-Alt-S: sit all, Esc: stop                                            ;
; Ctrl-Alt-G: GB hunt, Esc: stop                                            ;
; Ctrl-Alt-R: RQ loop, Esc: stop                                            ;
; Ctrl-Alt-U: UBQ loop, Esc: stop                                           ;
; Ctrl-Alt-W: map watch                                                     ;
; Ctrl-Alt-F: GB forge                                                      ;
; Ctrl-Alt-D: left-click                                                    ;
; Ctrl-Alt-K: keep clicking, Esc: stop                                      ;
; Ctrl-Alt-P: plus panel on/off                                             ;
; Ctrl-Alt-O: opacity on/off                                                ;
; Ctrl-Alt-L: reload FoEplus                                                ;
; Ctrl-Alt-Shift-P: exit                                                    ;
;                                                                           ;
; Make sure to reload after making a change (right-click icon in systray or ;
; Ctrl-Alt-L)                                                               ;
;---------------------------------------------------------------------------;



hotkeys =
(
Ctrl-Alt-A: aid all, Esc: stop
Ctrl-Alt-S: sit all, Esc: stop
Ctrl-Alt-G: GB hunt, Esc: stop
Ctrl-Alt-R: RQ loop, Esc: stop
Ctrl-Alt-U: UBQ loop, Esc: stop
Ctrl-Alt-W: map watch
Ctrl-Alt-F: GB forge
Ctrl-Alt-D: left-click
Ctrl-Alt-K: keep clicking, Esc: stop
Ctrl-Alt-P: plus panel on/off
Ctrl-Alt-O: opacity on/off
Ctrl-Alt-L: reload FoEplus
Ctrl-Alt-Shift-P: exit
)
version = 0.2.0
editor = %A_ScriptName% - Notepad
script = FoEplus
GoSub, Systray
MsgBox(0, "", script " started`r`n`r`nSystray icon active`r`nPress Ctrl-Alt-P in-game")

global yY, wW, hH, xdpi, zoom, z100
global esc, act, delay, title, winId
global shade, color, red, green, blue
global numCur, nBttns, ownId, guiId
autoBattle = 1
maxDamage = 2
shade = 24
numCur = 0
ownId = % {}
guiId = % {}
mcLog = % {}

#NoEnv
#WinActivateForce
#SingleInstance force
#Include %A_ScriptDir%
#Include settings.txt
#Include lib\Gdip_All.ahk

Gdip_Startup()
CoordMode, Mouse, Client
CoordMode, Pixel, Client
CoordMode, ToolTip, Client
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 1
WinActivate, % title
GoSub, ChkOCR

InitTab:
clrChkX   :=   12 * zoom
clrChkY   :=   15 * zoom
clrClkX   :=    2 * zoom
clrClkY   :=    4 * zoom
msgTipX   :=  295 * zoom
lstTabX   :=  278 * zoom
lstTabY   :=   16 * zoom
neiTabX   :=  740 * zoom
guiTabX   :=  804 * zoom
friTabX   :=  868 * zoom
ngfTabY   :=  145 * zoom
lStopX    :=  245 * zoom
lStopY    :=   31 * zoom
rStopX    :=  913 * zoom
rStopY    :=   31 * zoom
rFiveX    :=  913 * zoom
rFiveY    :=   64 * zoom
ttOffX    :=   12 * zoom
ttOffY    :=   10 * zoom
aidBttnX  :=  312 * zoom
aidBttnY  :=   12 * zoom
sitBttnX  :=  350 * zoom
sitBttnY  :=   35 * zoom
aidChkX   :=  350 * zoom
aidChkY   :=   12 * zoom
sitChkX   :=  353 * zoom
sitChkY   :=   39 * zoom
gbhBttnX  :=  350 * zoom
gbhBttnY  :=   60 * zoom
gbhBttnW  :=   28 * zoom
asgStepX  :=  107 * zoom
gbStatX   :=  305 * zoom
gbStatY   :=  126 * zoom
gbStatW   :=   93 * zoom
gbScrlX   :=  691 * zoom
gbScrlW   :=   16 * zoom
gbStepY   :=   29 * zoom
gbPadY    :=    2 * zoom
;format   := [1:image, 2:sX1, 3:sY1, 4:sX2, 5:sY2, 6:osX, 7:osY, 8:ocX, 9:ocY]
xyAnchor  := ["xyAnchor.png", 0, 0, wW / 2, hH / 2]
mcGuild   := ["mcGuild.png", 0, 0, wW / 2, hH,,, 318 * zoom, -33 * zoom]
mcEnter   := ["mcEnter.png", 0, hH / 2, wW / 2, hH,,, 312 * zoom, 55 * zoom]
mcSend    := ["mcEnter.png", 0, hH / 2, wW / 2, hH,,, 407 * zoom, 121 * zoom]
payDmd    := ["payDiamond.png", wW / 3, hH / 3, wW * 2/3, hH,,, 142 * zoom, 73 * zoom]
tbRstop0  := ["tbRstop0.png", 0, hH - 160 * zoom, wW, hH]
tbRstop1  := ["tbRstop1.png", 0, hH - 160 * zoom, wW, hH]
lstTxt    := [691 * zoom, hH - 111 * zoom, 29 * zoom, 11 * zoom]
return

InitRQ:
rqPaneW   :=  640 * zoom
rqPaneH   :=  560 * zoom
rqTopY    :=   70 * zoom
rqUpay2X  :=  464 * zoom
rqUpay2Y  :=  113 * zoom
rqUstepY  :=   69 * zoom
rqCheck0  := ["rqCheck.png", 0, yY + 128 * zoom, 128 * zoom, yY + 200 * zoom]
rqCheck1  := ["rqCheck.png", 696 * zoom, yY + 128 * zoom, 824 * zoom, yY + 200 * zoom]
rqCllct   := ["rqCollect.png", 0, yY + rqTopY, rqPaneW, yY + rqTopY + rqPaneH]
rqAbort   := ["rqAbort.png", 0, yY + rqTopY + rqPaneH/2, rqPaneW, yY + rqTopY + rqPaneH]
rqAnchor  := ["rqAnchor.png", 0, -rqPaneH/2, rqPaneW, 0]
rqUpay0   := ["xyAnchor.png", 0, 0, wW / 2, hH / 2,,, 193 * zoom, 169 * zoom]
rqTxt     := [0, 0, 400 * zoom, 26 * zoom]
rqCllct.8 := 51 * zoom
rqAbort.8 := 84 * zoom
rqRecur   := "(Recu"
rqUbq     := "day P"
rqCount   := 20
rqShade   := 210
return

InitMW:
mwMsgX    :=  150 * zoom
mwMsgY    :=  112 * zoom
mwSecW    :=  200 * zoom
mwSecH    :=  150 * zoom
mwRed     := ["mwRed.png", 0, 0, wW, hH,,,, mwSecH / 2 * zoom]
mwGreen   := ["mwGreen.png", 0, 0, wW, hH,,,, mwSecH / 2 * zoom]
mwUnder   := ["mwUnder.png", -300 * zoom, -300 * zoom, 300 * zoom, 300 * zoom]
mwEnter   := ["mwEnter.png", -mwSecW * zoom, 0, (mwSecW + 48) * zoom, mwSecH * zoom]
mwTxt0    := [wW / 2 - 80 * zoom, 6 * zoom, 160 * zoom, 20 * zoom]
mwTxt1    := [-102 * zoom, -114 * zoom, 281 * zoom, 23 * zoom]
mwTxt2    := [-64 * zoom, 74 * zoom, 238 * zoom, 24 * zoom]
return

InitBtl:
hpAutoX   :=   76 * zoom
hpAutoY   :=  235 * zoom
hpDoneX   :=   52 * zoom
hpDoneY   :=   73 * zoom
hpAstepX  :=   67 * zoom
hpAstepY  :=   69 * zoom
hpDstepX  :=  160 * zoom
hpDstepY  :=   52 * zoom
hpHealX   :=  114 * zoom
hpHealY   :=   54 * zoom
hpTickW   :=    5 * zoom
ttAutoX   :=   18 * zoom
ttAutoY   :=  136 * zoom
ttDoneX   :=    2 * zoom
ttDoneY   :=    3 * zoom
btlAutoX  :=  287 * zoom
btlAutoY  :=  570 * zoom
btlDoneX  :=  274 * zoom
btlDoneY  :=  252 * zoom
btlAchkX  :=  350 * zoom
brAnchor  := ["brAnchor.png", 0, 200 * zoom, 80 * zoom, 400 * zoom]
return

$^!a::
if !MyKey()
    return
act = aid
GoSub, PrepTab
if aidNeighbors
    Tab("Neighbors")
Tab("Guildies")
Tab("Friends")
GoSub, EndTab
return

$^!s::
if !MyKey()
    return
act = sit
GoSub, PrepTab
Tab("Friends")
GoSub, EndTab
return

$^!g::
if !MyKey()
    return
if gbhNow
if gbhTxt
{
    Clipboard =
    msg = % gbhExt gbhEsc gbhNow "`r`nCopied to clipboard"
    Clipboard = % gbhTxt gbhEsc gbhNow
} else
    msg = % gbhEsc "0 GBs found`r`n" gbhNow
if gbhNow
{
    SetTimer, BttnGBH, 50
    MsgBox(0x101, "GB hunt", msg)
}
if gbhNow
IfMsgBox, Cancel
    return
gbhX =
gbhY =
gbhTxt =
act = gbh
GoSub, PrepTab
Tab("Neighbors")
if huntGuildies
    Tab("Guildies")
Tab("Friends")
GoSub, EndTab
gbhNow = % GetTime()
gbhEsc = % esc? "[Esc]`r`n" : ""
gbhExt = % RegExReplace(gbhTxt, "`t\d+`r`n#", ", #")
gbhExt = % RegExReplace(gbhExt, "`t\d+", "`r`n")
GoSub, %A_ThisLabel%
return

$^!r::
$^!u::
if !MyKey()
    return
rqText = 1
rqReady =
rqFound =
act = rql
GoSub, LoopRQ
act =
if esc
    return
rubq = % A_ThisLabel = "$^!u"? "a UBQ" : "an RQ"
if !rqText
    MsgBox(0x30, "RQ loop", "OCR error")
else if !rqReady
    MsgBox(0, "RQ loop", "Please have " rubq " ready to collect")
else if !rqFound
    MsgBox(0x30, "RQ loop", "Loop error")
else if !InStr(rqText, rqUbq)
    ClearD(2 * zoom, yY + rqTopY / 2)
else if (A_ThisLabel = "$^!u")
{
    GoSub, DoUBQ
    GoSub, %A_ThisLabel%
}
return

$^!w::
if !MyKey()
    return
msg =
(
Checklist:

1. Province map selected
2. Area of interest in view
3. Army of the era ready

Auto battle red/green siege
)
if !gui2Y
    MsgBox(0, "Map watch", msg)
act =
payLimit += 0
payCount += 0
GoSub, LoopMW
return

$^!f::
if !MyKey()
    return
MsgBox(0, "GB forge", "Coming soon")
return

$^!d::
if !MyKey()
    return
Click
Sleep, delay
return

$^!k::
if !MyKey()
    return
Loop
{
    if esc
        break
    Click
    Sleep, delay
}
return

$^!o::
if !MyKey()
    return
GoSub, Opac50
return

$^!p::
if !MyKey()
    return
if (ownId[1] != winId)
    QuitGui(1)
GoSub, Panel
return

MyKey()
{
    GoSub, InitWin
    if !WinActive(title)
        Send, % SubStr(A_ThisHotkey, 2)
    else return 1
}

SendD(key, delay)
{
    if esc
        return
    Send, % key
    Sleep, Abs(delay)
}

ClickD(curX, curY, delay)
{
    if esc
        return
;   Click, %curX%, %curY%
    MouseMove, curX, curY
    if (delay > 0)
    {
        Click, Down
        Sleep, 50
        Click, Up
    }
    Sleep, Abs(delay)
}

GetTime()
{
    FormatTime, date,, ddd M/d
    FormatTime, time,, h:mm tt
    StringLower, time, time
    return date ", " time
}

GetRGB(curX, curY)
{
    PixelGetColor, color, curX, curY, RGB
    red = % (color & 0xFF0000) >> 16
    green = % (color & 0xFF00) >> 8
    blue = % color & 0xFF
}

AbsCur(ByRef curX, ByRef curY)
{
    MouseGetPos, tmpX, tmpY
    MouseMove, curX, curY
    CoordMode, Mouse, Screen
    MouseGetPos, curX, curY
    CoordMode, Mouse, Client
    MouseMove, tmpX, tmpY
}

AbsPos(ByRef curX, ByRef curY, hwnd)
{
    VarSetCapacity(tmp, 8)
    NumPut(curX, &tmp, 0)
    NumPut(curY, &tmp, 4)
    DllCall("ClientToScreen", uint, hwnd, uint, &tmp)
    curX = % NumGet(tmp, 0, "int")
    curY = % NumGet(tmp, 4, "int")
}

ImgHBM(x, y, w, h, hwnd)
{
    AbsPos(x, y, hwnd)
    pbm = % Gdip_BitmapFromScreen()
    pbn = % Gdip_CreateBitmap(w, h)
    Gdip_DrawImage(Gdip_GraphicsFromImage(pbn), pbm, 0, 0, w, h, x, y, w, h)
    hbm = % Gdip_CreateHBITMAPFromBitmap(pbn)
    Gdip_DisposeImage(pbm)
    Gdip_DisposeImage(pbn)
    return hbm
}

ImgWH(ByRef imgW, ByRef imgH, img)
{
    pbm = % Gdip_CreateBitmapFromFile(img)
    Gdip_GetImageDimensions(pbm, imgW, imgH)
    Gdip_DisposeImage(pbm)
}

ClickImg(a, curX, curY, delay)
{
    img = % "img\" z100 "\" a.1
    ImgWH(imgW, imgH, img)
    offX = % a.8? a.8 : imgW / 2
    offY = % a.9? a.9 : imgH / 2
    ClickD(curX + offX, curY + offY, delay)
}

ImgFnd(a, ByRef aX=0, ByRef aY=0, delay=0)
{
    img = % "img\" z100 "\" a.1
    offX = % a.6? a.6 : 0
    offY = % a.7? a.7 : 0
    ImageSearch, aX, aY, a.2 + offX, a.3 + offY, a.4 + offX, a.5 + offY, *%shade% %img%
    if (!ErrorLevel && delay)
        ClickImg(a, aX, aY, delay)
    return ErrorLevel? "" : a
}

GetYY(top="")
{
    For i, top in top? [top] : ["yyTop", "rqTop", "yzTop"]
    {
        img = *TransBlack *%shade% img\%z100%\%top%.png
        ImageSearch, xX, yY, 0, 0, A_ScreenWidth, A_ScreenHeight / 4, %img%
        if !ErrorLevel
            return top
    }
    return ""
}

WinWH(hwnd)
{
    global
    VarSetCapacity(tmp, 16)
    DllCall("GetClientRect", uint, hwnd, uint, &tmp)
    wW = % NumGet(tmp, 8, "int")
    h0 = % NumGet(tmp, 12, "int")
    offY = 0
    WinGetTitle, ixplr, % title
    if InStr(ixplr, "Internet Explorer")
    {
        GetRGB(2, h0 - 4)
        if (red > 0x40 && green > 0x40 && blue > 0x40)
            offY = 23
    }
    hH = % h0 - offY
    WinGetPos, winX, winY,,, % "ahk_id" hwnd
    if (winX = 0 && winY = 0 && wW = A_ScreenWidth && hH = A_ScreenHeight)
        fscrn = 1
    else
        fscrn = 0
    wW -= offsetX * (1 - fscrn)
    hH -= offsetY * (1 - fscrn)
    xdpi = % A_ScreenDPI / 96
}

GetOCR(x, y, w, h, hwnd, arg="")
{
    global ocrExe
    if !FileExist(ocrExe)
        return
    AbsPos(x, y, hwnd)
    ocrCap := """" Round(x) " " Round(y) " "
    ocrCap .= Round(x + w) " " Round(y + h) """"
    ocrCmd = %ocrExe% %arg% -s %ocrCap%
    ocrOut = % ComObjCreate("WScript.Shell").Exec(ocrCmd).StdOut.ReadAll()
    ocrOut = % RegExReplace(Trim(ocrOut), "^<Error>\s*$", "")
    return ocrOut
}

ListNum(list)
{
    global
    if !%list%
        return
    x = % lstTxt.1
    y = % lstTxt.2
    w = % lstTxt.3
    h = % lstTxt.4
    GetRGB(aidChkX + asgStepX * 4, hH - aidChkY)
    if (red > 0x80 && green > 0x40 || red < 0x40 && green < 0x28)
        ocrLst = % GetOCR(x, y, w, h, winId, "--whitelist #0123456789")
    else
        ocrLst = 5
    ocrLst = % RegExReplace(ocrLst, "[^\d]", "")
    %list% = % ocrLst? ocrLst : %list%
}

Tab(list)
{
    global
    if (esc || !act)
        return
    tab = % SubStr(list, 1, 3)
    tab = % Format("{:L}", tab)
    actTabX = % %tab%TabX
    ClickD(actTabX, hH - ngfTabY, delay * 5)
    ToolTip, --, msgTipX, hH - ngfTabY - ttOffY, 3
    ClickD(rStopX, hH - rStopY, delay * 5)
    ListNum(list)
    ocrTip = % !%list% || ocrLst? %list% : "OCR error"
    ToolTip, % ocrTip, msgTipX, hH - ngfTabY - ttOffY, 3
    ClickD(lStopX, hH - lStopY, delay * 5)
    gbhOut =
    count = 0
    total = % %list%
    Loop, % Ceil(total / 5)
        GoSub, Loop5
    if gbhOut
        gbhTxt .= list "`r`n" gbhOut
    ToolTip,,,, 5
    ToolTip,,,, 3
}

AlertGC(msg, curX=0, curY=0)
{
    global
    if (mcLog[msg])
    if (mcLog[msg] + alertInterval * 1000 > A_TickCount)
        return
    mcLog[msg] := A_TickCount
    ClearD()
    if (!curX && !curY)
    {
        curX = % clrClkX
        curY = % hH - clrClkY
    }
    MouseMove, curX, curY
    SendD("c", delay * 3)
    Loop, 20
        Sleep, delay
    Until ImgFnd(mcGuild,,, delay)
    Loop, 20
        Sleep, delay
    Until ImgFnd(mcEnter,,, delay)
    if !ErrorLevel
    {
        SendD(msg, delay)
        ImgFnd(mcSend,,, delay)
    }
    ClearD()
}

MsgBox(opt, subj, msg)
{
    global script
    subj = % subj? subj " - " : ""
    MsgBox, % 0x1000 + opt, % subj script, % msg
}

TimerTip(tip, delay, curX=0, curY=0)
{
    SetTimer, BlurTip, % -delay
    if (!curX && !curY)
        ToolTip, % tip
    else
        ToolTip, % tip, curX, curY
}

ClrChk()
{
    global clrChkX, clrChkY
    GetRGB(clrChkX, hH - clrChkY)
    return red + green + blue > 0xCC
}

ClearD(curX=0, curY=0, num=20) {
if (!curX && !curY)
{
    global clrClkX, clrClkY
    curX = % clrClkX
    curY = % hH - clrClkY
}
Loop, % num
{
    if (esc || ClrChk())
        break
    ClickD(curX, curY, delay)
}}

Loop5:
Loop, 5
{
    if esc
        break
    if (count >= total // 5 * 5 && A_Index <= 5 - Mod(total, 5))
        continue
    count += 1
    GetRGB(%act%ChkX + asgStepX * (A_Index - 1), hH - %act%ChkY)
    ToolTip, % count, actTabX - ttOffX, hH - ngfTabY - ttOffY, 5
    if (act = "aid" && red > 0x80 && green > 0x40
     || act = "sit" && red > 0x90 && green > 0x80
     || act = "gbh")
        ClickD(%act%BttnX + asgStepX * (A_Index - 1), hH - %act%BttnY, delay * 3)
    if (act = "gbh")
        GoSub, HuntGB
    offX = % act = "aid"? 0 : gbhBttnW / 2
    if clear
        ClearD()
    else
        ClearD(%act%BttnX + asgStepX * (A_Index - 1) + offX, hH - %act%BttnY)
}
ClickD(rFiveX, hH - rFiveY, delay * 5)
return

HuntGB:
Sleep, delay * 3
if ClrChk()
    return
if !gbhX
    ImgFnd(xyAnchor, gbhX, gbhY)
Loop, 10
{
    GetRGB(gbhX + gbScrlX - gbScrlW,  gbhY + gbStatY - gbPadY)
    if (esc || red > green + blue * 1.5)
        break
    Sleep, delay
}
offX = % gbScrlW
GetRGB(gbhX + gbScrlX,  gbhY + gbStatY - gbPadY)
if (red > green + blue * 1.5)
    offX = 0
gbNum = 0
Loop, % gbCheck
{
    GetRGB(gbhX + gbStatX + gbStatW * gbPercent / 100 - offX
         , gbhY + gbStatY + gbStepY * (A_Index - 1))
    if (green > red + blue)
        gbNum += 1
}
if gbNum
    gbhOut .= "#" count "`t" gbNum "`r`n"
return

InitVars:
WinWH(winId)
barH = 0
Loop, 40
{
    GetRGB(2, hH - A_Index - 16)
    if (scale || red + green + blue > 0x55)
    {
        barH = % A_Index + 15
        break
    }
}
if !barH
    zoom = % xdpi
else if (barH <= 30) ;27x1
    zoom = 1
else if (barH <= 35) ;27x1.25
    zoom = 1.25
else if (barH <= 45) ;27x1.5
    zoom = 1.5
else
    zoom = 2
if scale
    zoom = % scale
z100 = % Floor(zoom * 100)
GoSub, InitTab
return

PrepWin:
if !scale
    SendD("^0", delay)
WinMaximize, % title
WinActivate, % title
ToolTip, Initializing...
SetTimer, BlurGui, % -delay * 5
GoSub, InitVars
return

PrepTab:
GoSub, PrepWin
ClearD()
GetRGB(lstTabX, hH - lstTabY)
if (red > 0xA0 && green > 0xA0 && blue > 0xA0)
    ClickD(lstTabX, hH - lstTabY, delay * 5)
if !ImgFnd(tbRstop1)
if !ImgFnd(tbRstop0)
    act =
ToolTip
return

EndTab:
act =
SetTimer, BlurTip3, % -delay * 11
ToolTip, % esc? "[Esc]" : "", msgTipX, hH - ngfTabY - ttOffY, 3
return

BlurTip3:
ToolTip,,,, 3
return

BlurTip:
ToolTip
return

BttnGBH:
IfWinNotExist, GB hunt
    return
SetTimer,, Off
WinActivate
ControlSetText, Button1, &Rerun
ControlSetText, Button2, &OK
return

LoopRQ:
GoSub, PrepWin
if (GetYY() = "yzTop")
    ClearD()
GoSub, InitRQ
ToolTip
a = % rqAnchor
c = % ClrChk()? rqCheck0 : rqCheck1
if ImgFnd(c, cX, cY, delay)
{
    GoSub, BlurGui
    if (c = rqCheck0)
    {
        MouseMove, rqCheck1.2, 0,, R
        Sleep, delay * 5
    }
    c = % rqCllct
    if ImgFnd(c, cX, cY)
    {
        c.7 := rqPaneH / 2
        if ImgFnd(c, aX, aY)
        {
            cX = % aX
            cY = % aY
        }
    }
    a.7 := cY
    if cY is number
    if ImgFnd(a, aX, aY)
    {
        rqHbmp = % ImgHBM(aX + rqTxt.1, aY + rqTxt.2, rqTxt.3, rqTxt.4, winId)
        rqText = % GetOCR(aX + rqTxt.1, aY + rqTxt.2, rqTxt.3, rqTxt.4, winId)
        rqReady = % InStr(rqText, rqRecur)
    }
    if rqReady
    {
        ClickImg(c, cX, cY, delay)
        MouseMove, 0, rqTopY / 4,, R
        Sleep, delay * 9
    }
}
Loop, % rqCount
{
    if (esc || !rqReady || rqFound)
        break
    GetRGB(clrChkX, hH - clrChkY)
    if (red + green + blue < 0x55)
;   if ImgFnd(xyAnchor)
    {
        ClearD(,, 1)
        Sleep, delay * 5
    }
    c = % rqAbort
    if ImgFnd(c, cX, cY)
    {
        a.7 := cY
        ImgFnd(a, aX, aY)
        x1 = % aX + rqTxt.1 - 2
        y1 = % aY + rqTxt.2 - 2
        x2 = % x1 + rqTxt.3 + 4
        y2 = % y1 + rqTxt.4 + 4
        ImageSearch,,, x1, y1, x2, y2, *%rqShade% HBITMAP:*%rqHbmp%
        rqFound = % !ErrorLevel
    }
    if !rqFound
    {
        ClickImg(c, cX, cY, delay)
        MouseMove, -rqPaneW / 4, 0,, R
        Sleep, delay * 5
    }
}
return

DoUBQ:
Loop, 2
{
    ClickD(aX + rqUpay2X, aY + rqUpay2Y + rqUstepY * (A_Index - 1), delay * 3)
    ImgFnd(rqUpay0,,, delay * 5)
    Sleep, delay
}
return

LoopMW:
GoSub, PrepWin
GoSub, InitMW
GoSub, InitGmw
MouseMove, gmwHomeX, gmwHomeY
ToolTip
Loop
{
    if !guiId[2]
        break
    GuiControlGet, autoBattle
    GuiControlGet, maxDamage
    GuiControlGet, payLimit
    GuiControl,, gmwSpent, Spent: %payCount%
    if (btlCount > 0)
        GuiControl,, btlCount, %btlCount%
    if (maxDamage < 1 || maxDamage > 9)
        GuiControl, Text, maxDamage, 2
    if payLimit is not number
        GuiControl,, payLimit, 0
    Sleep, delay * 5
    WinGet, aid, ID, A
    WinGetTitle, ttl, A
    if (aid != ownId[2] || InStr(ttl, title) != 1)
        continue
    WinMaximize, % title
    if (!a := ImgFnd(mwRed, aX, aY))
    if (!a := ImgFnd(mwGreen, aX, aY))
        continue
    esc =
    if (a = mwRed && GetYY())
        GoSub, RedAlert
    if !autoBattle
        continue
    ClickImg(a, aX, aY, delay / 5)
    MouseMove, gmwHomeX, gmwHomeY
    a = % mwEnter
    a.6 := aX
    a.7 := aY
    Loop, 5
        Sleep, delay
    Until ImgFnd(a,,, delay)
    Loop, 5
        Sleep, delay
    Until ImgFnd(xyAnchor, aX, aY)
    MouseMove, gmwHomeX, gmwHomeY
    if (!esc && aX)
        GoSub AutoBtl
}
return

RedAlert:
mwRedTxt0 = % GetOCR(mwTxt0.1, yY + mwTxt0.2, mwTxt0.3, mwTxt0.4, ownId[2])
mwRedTxt0 = % RegExReplace(mwRedTxt0, "[^\w ]", "")
if mwRedTxt0
if (mwRedLast != mwRedTxt0
 || mwRedTime + alertInterval * 1000 < A_TickCount
 || autoBattle && !Mod(mwRedBtls, 10))
{
    ClickImg(a, aX, aY, -delay / 5)
    MouseGetPos, bX, bY
    b = % mwUnder
    b.6 := bX
    b.7 := bY
    Loop, 10
        Sleep, delay
    Until ImgFnd(b, bX, bY)
    mwRedTxt1 = % GetOCR(bX + mwTxt1.1, bY + mwTxt1.2, mwTxt1.3, mwTxt1.4, ownId[2])
    mwRedTxt2 = % GetOCR(bX + mwTxt2.1, bY + mwTxt2.2, mwTxt2.3, mwTxt2.4, ownId[2])
    mwRedTxt1 = % RegExReplace(mwRedTxt1, "[^\[\]\d,]", "")
    mwRedTxt2 = % RegExReplace(mwRedTxt2, "[^\w ]", "")
    mwRedTxt1 = % bX && mwRedTxt1? " " mwRedTxt1 : ""
    mwRedTxt2 = % bX && mwRedTxt2? " by " mwRedTxt2 : ""
    mwRedLast = % mwRedTxt0
    mwRedTime = % A_TickCount
}
if autoBattle
    mwRedBtls += 1
mwRedTxt0 = % mwRedTxt0? mwRedTxt0 mwRedTxt1 mwRedTxt2 : "<OCR error>"
AlertGC("Under Siege: " mwRedTxt0, mwMsgX, hH - mwMsgY)
return

AutoBtl:
GoSub, InitBtl
GetRGB(aX + btlAchkX, aY + btlAutoY)
if (red > green + blue * 1.5)
For i, ad in ["Auto", "Done"]
{
    if (ad = "Done")
    {
        btlCount += 1
        GoSub, DoneWait
    }
    GoSub, PrepArmy
    if armyDamage
    {
        TimerTip("Paused - damage limit", delay * 11, aX + tt%ad%X, aY + tt%ad%Y)
        break
    }
    ClickD(aX + btl%ad%X, aY + btl%ad%Y, delay)
}
return

PrepArmy:
armyDamage = 0
statX = % {Auto: hpAutoX, Done: hpDoneX}
statY = % {Auto: hpAutoY, Done: hpDoneY}
stepX = % {Auto: hpAstepX, Done: hpDstepX}
stepY = % {Auto: hpAstepY, Done: hpDstepY}
unitCol = % {Auto: 4, Done: 2}
ImgFnd(xyAnchor, aX, aY)
if (ad = "Done")
{
    a = % brAnchor
    a.6 := aX
    a.7 := aY
    ImgFnd(a, aX, aY)
    costCount = 0
    if (payCount < payLimit)
    Loop, 8
    {
        GoSub, PickUnit
        GoSub, CalcCost
        costCount += unitCost
    }
    if (costCount && payCount + costCount <= payLimit)
    Loop, 8
    {
        GoSub, PickUnit
        GoSub, HealUnit
    }
    if (payCount + costCount <= payLimit)
        payCount += costCount
}
Loop, 8
{
    GoSub, PickUnit
    GoSub, TestUnit
}
return

PickUnit:
unitX = % aX + stepX[ad] * Mod(A_Index - 1, unitCol[ad])
unitY = % aY + stepY[ad] * Floor((A_Index - 1) / unitCol[ad])
return

CalcCost:
unitCost = 0
Loop, 10
{
    GetRGB(unitX + statX[ad] - hpTickW * (A_Index - 1), unitY + statY[ad])
    if (red > green && red > blue)
        unitCost += 4
    else
        break
}
if (unitCost = 40)
    unitCost = 45
return

HealUnit:
GetRGB(unitX + hpHealX, unitY + hpHealY)
if (red > green + blue * 1.5)
{
    ClickD(unitX + hpHealX, unitY + hpHealY, delay * 3)
    ImgFnd(payDmd,,, delay)
    GoSub, DoneWait
}
return

TestUnit:
GetRGB(unitX + statX[ad] - hpTickW * (maxDamage - 1), unitY + statY[ad])
if (red > green && red > blue)
    armyDamage += 1
return

DoneWait:
Loop, 20
{
    if (esc || ImgFnd(xyAnchor))
        break
    Sleep, delay
}
return

InitWin:
esc =
myWin =
WinGet, aid, ID, A
For i, uid in guiId
if (aid = uid)
    myWin = 1
if myWin
    WinActivate, % title
WinGet, winId, ID, % title
WinGet, winPid, PID, % title
return

InitGui:
if !WinExist("ahk_id" winId)
    return
gui1X = 325
gui1Y = 63
Gui, 2:New, +Owner%winId% +HWNDtmpId +ToolWindow -Caption -DPIScale +Disabled
Gui, 2:Color, 0x020202
Gui, 2:Add, Pic, x0 y0, img\ppFrame.png
Gui, 1:New, +Owner%tmpId% +HWNDtmpId +ToolWindow -Caption -DPIScale
Gui, 1:Color, 0x020202
Gui, 1:Add, Pic, x0 y0, img\ppFrame.png
GuiBttn("$^!a", "img\ppButton1.png", "Aid all [Ctrl-Alt-A]")
GuiBttn("$^!s", "img\ppButton2.png", "Sit all [Ctrl-Alt-S]")
GuiBttn("$^!g", "img\ppButton3.png", "GB hunt [Ctrl-Alt-G]")
GuiBttn("$^!r", "img\ppButton4.png", "RQ loop [Ctrl-Alt-R] (U for UBQ)")
GuiBttn("$^!w", "img\ppButton5.png", "Map watch [Ctrl-Alt-W]")
ownId[1] := winId
guiId[1] := tmpId
SnapGui(1)
OpacGui(1)
InitHooks(1)
MenuChk("Plus Panel", guiId[1])
return

InitGmw:
if !WinExist("ahk_id" winId)
    return
gmwMgnX = 8
gmwMgnY = 6
gmwTextW = 90
gmwCtrlW = 36
gmwCpadW = % gmwTextW - gmwCtrlW
gui2X = % gmwTextW + gmwMgnX * 2
gui2Y = % 200 + 63 * 2
gmwHomeX = % wW - gui2X + 6
gmwHomeY = % hH - gui2Y + 29
vautoBattle = % autoBattle? "Checked" : ""
vmaxDamage = % StrReplace("1|2|3|4|5|6|7|8|9|", maxDamage, maxDamage "|")
Gui, 22:New, +Owner%winId% +HWNDtmpId +ToolWindow -Caption -DPIScale +Disabled
Gui, 22:Color, 0x020202
Gui, 22:Add, Pic, x0 y0, img\mwFrame.png
Gui, 21:New, +Owner%tmpId% +HWNDtmpId +ToolWindow -Caption -DPIScale
Gui, 21:Color, 0x020202
Gui, 21:Margin, %gmwMgnX%, %gmwMgnY%
Gui, 21:Font, s8 c0xFFCC99 Bold, Arial
Gui, 21:Add,     Text, Center w%gmwTextW% xm6 ym2, Map Watch
Gui, 21:Font, s8 c0xEEEEEE Normal, Microsoft Sans Serif
Gui, 21:Add, Checkbox, Right  w%gmwTextW% xm-1 ym33 vautoBattle %vautoBattle%, Auto battle
Gui, 21:Add,     Text, Center w%gmwTextW% xm2 vbtlCount, --
Gui, 21:Add,     Text, Right  w%gmwTextW% xm0, Unit damage limit
Gui, 21:Add, ComboBox, Right  w%gmwCtrlW% xm%gmwCpadW% vmaxDamage, %vmaxDamage%
Gui, 21:Add,     Text, Right  w%gmwTextW% xm0, Heal diamond limit
Gui, 21:Add,     Edit, Right  w%gmwCtrlW% xm%gmwCpadW% vpayLimit c0x000000 r1 Number, %payLimit%
Gui, 21:Add,     Text, Right  w%gmwTextW% xm-2 vgmwSpent, Spent: 0
Gui, 21:Add, Pic, x7 y7 gQuitGmw, img\mwClose.png
ownId[2] := winId
guiId[2] := tmpId
SnapGui(2)
OpacGui(2)
InitHooks(2)
return

BlurGui:
Loop, % nBttns
    GuiControl, Hide, brdr%A_Index%
ToolTip,,,, 2
return

BlurGmw:
if WinActive("ahk_id" guiId[2])
    WinActivate, % "ahk_id" ownId[2]
return

QuitGmw:
QuitGui(2)
return

Opac50:
opac50 = % !opac50
For i, uid in guiId
    OpacGui(i)
MenuChk("50% Opacity", opac50)
return

Suspend:
Suspend
MenuChk("Suspend Hotkeys", A_IsSuspended)
return

ListKeys:
MsgBox(0, "Hotkeys", hotkeys)
return

Panel:
GoSub, InitWin
if !guiId[1]
{
    GoSub, InitGui
    TrayTip,, % guiId[1]? "" : "FoE inactive"
} else
    QuitGui(1)
return

MenuChk(item, chk)
{
    if chk
        Menu, Tray, Check, % item
    else
        Menu, Tray, Uncheck, % item
}

QuitGui(i)
{
    global
    if (!i || !guiId[i])
        return
    u = % i = 1? "" : i
    WinActivate, % "ahk_id" ownId[i]
    ownId.Delete(i)
    guiId.Delete(i)
;   Gui, %u%1:Destroy
    Gui, %u%2:Destroy
    if (i = 1)
    {
        nBttns =
        GoSub, BlurGui
;       UnhookWinEvent(eventHook)
        MenuChk("Plus Panel", guiId[1])
    }
}

SnapGui(i)
{
    global
    if (!i || !guiId[i])
        return
    u = % i = 1? "" : i
    WinWH(ownId[i])
    curX = % wW - gui%i%X
    curY = % hH - gui%i%Y
    AbsPos(curX, curY, ownId[i])
    Gui, %u%2:Show, x%curX% y%curY% NA
    Gui, %u%1:Show, x%curX% y%curY% NA
}

ShowGui(i)
{
    global
    if (!i || !guiId[i])
        return
    u = % i = 1? "" : i
    Gui, %u%2:Show, NA
    Gui, %u%1:Show, NA
}

HideGui(i)
{
    global
    if (!i || !guiId[i])
        return
    u = % i = 1? "" : i
    Gui, %u%2:Hide
    Gui, %u%1:Hide
}

OpacGui(i)
{
    global
    if (!i || !guiId[i])
        return
    u = % i = 1? "" : i
    op50 = % i = 1? 0x00 : 0x7F
    Gui, %u%2:Color, 0x020202
    Gui, %u%2:+LastFound
    WinSet, TransColor, % "0x020202 " (opac50? op50 : 0xFF)
    Gui, %u%1:Color, 0x020202
    Gui, %u%1:+LastFound
    WinSet, TransColor, % "0x020202 " (opac50? 0x7F : 0xFF)
}

GuiBttn(action, img, tip)
{
    global
    static n
    if !nBttns
        n = 0
    n += 1
    nBttns = % n
    curZ = % 25 + 55 * (n - 1)
    curX = % 31 + 55 * (n - 1)
    Gui, 1:Add, Pic, x%curZ% y6 +BackgroundTrans, img\ppSquare.png
    Gui, 1:Add, Pic, x%curZ% y6 +BackgroundTrans Hidden vbrdr%n%, img\ppBorder.png
    Gui, 1:Add, Pic, x%curX% y12 vbttn%n% g%action%, % img
    guiTip%n% = % tip
}

WinChange(hWinEventHook, event, hwnd, idObject)
{
    if (!ownId.Count() || !hwnd || idObject)
        return
    WinGet, aid, ID, A
    WinGetTitle, ttl, A
    if (InStr(ttl, title) = 1)
    For i, oid in ownId
        SnapGui(aid = oid? i : 0)
}

ShellMsg(wParam, lParam)
{
    if !ownId.Count()
        return
    aid = % lParam
    if (wParam = 0x4 || wParam = 0x8004 || wParam = 0x6)
    {
        WinGetTitle, ttl, A
        if (InStr(ttl, title) = 1)
        For i, oid in ownId
            ShowGui(aid = oid? i : 0)
        else if (wParam = 0x6)
        For i, oid in ownId
            HideGui(aid = oid? i : 0)
    }
    if (wParam = 0x2)
    For i, oid in ownId
        QuitGui(aid = oid? i : 0)
}

SetCursor()
{
    if !Mod(A_DefaultGui, 2)
        numCur = 0
    DllCall("SetCursor", ptr, guiCur%numCur%)
    return 1
}

MouseMove()
{
    numCur = % A_GuiControl? 1 : 0
    static num
    if (!A_GuiControl || A_DefaultGui != 1)
    {
        GoSub, BlurGui
        num =
        return
    }
    old = % num
    num = % StrReplace(A_GuiControl, "bttn", "")
    GuiControl, Show, brdr%num%
    if (num = old)
        return
    SetTimer, BlurGui, % -delay * 21
    BttnTip(num)
}

BttnTip(num)
{
    curX = % 25 + 55 * (num - 1)
    curY = % -20 * xdpi
    AbsPos(curX, curY, guiId[1])
    CoordMode, ToolTip, Screen
    ToolTip, % guiTip%num%, curX, curY, 2
    CoordMode, ToolTip, Client
}

KeyBttnUp()
{
    if WinActive("ahk_id" guiId[1])
        WinActivate, % "ahk_id" ownId[1]
    if WinActive("ahk_id" guiId[2])
        SetTimer, BlurGmw, % -delay * 21
}

SetWinEventHook(eventMin, eventMax, hmodWinEventProc, lpfnWinEventProc, idProcess, idThread, dwFlags)
{
    DllCall("CoInitialize", uint, 0)
    return DllCall("SetWinEventHook", uint, eventMin, uint, eventMax, uint, hmodWinEventProc, uint, lpfnWinEventProc, uint, idProcess, uint, idThread, uint, dwFlags)
}
UnhookWinEvent(hWinEventHook)
{
    DllCall("UnhookWinEvent", uint, hWinEventHook)
    DllCall("CoUninitialize")
}

InitHooks(i)
{
    global
    guiCur0 = % DllCall("LoadCursorFromFile", str, "img\ppCursor0.cur")
    guiCur1 = % DllCall("LoadCursorFromFile", str, "img\ppCursor1.cur")
    eventHook = % SetWinEventHook(0x800B, 0x800B, 0
        , RegisterCallback("WinChange"), winPid, 0, 0)
    DllCall("RegisterShellHookWindow", uint, guiId[i])
    OnMessage(DllCall("RegisterWindowMessage", str, "SHELLHOOK"), "ShellMsg")
    OnMessage(0x20, "SetCursor")
    OnMessage(0x200, "MouseMove")
    OnMessage(0x202, "KeyBttnUp")
    OnMessage(0x101, "KeyBttnUp")
}

Systray:
Menu, Tray, Icon, %script%.exe,, 1
Menu, Tray, Tip, %script%
Menu, Tray, NoStandard
Menu, Tray, Add, Plus Panel, Panel
Menu, Tray, Add, 50`% Opacity, Opac50
Menu, Tray, Add, Suspend Hotkeys, Suspend
Menu, Tray, Add, List Hotkeys, ListKeys
Menu, Tray, Add
Menu, Tray, Add, Reload, ~^!l
Menu, Tray, Add, Exit, ~^!+p
return

ChkOCR:
ocrErr =
ErrorLevel =
if !FileExist(ocrExe)
    ocrErr = Invalid setting: ocrExe = %ocrExe%
else
    RunWait, %ocrExe% -s "0 0 1 1",, Hide
if ErrorLevel
{
    SplitPath, ocrExe, fileName
    ocrErr = % Format("{:#08x}", 0x100000000 + ErrorLevel)
    ocrErr = %fileName% exists, but was unable to start correctly (%ocrErr%)
}
if ocrErr
    MsgBox(0x30, "OCR error", ocrErr)
return

~Esc::
esc = 1
return

~^!+p::
ExitApp
return

~^!l::
reload
return

#If WinActive(editor)
~^s::
reload
return
#If
