#NoEnv
#SingleInstance force
#Include lib\Gdip.ahk
Gdip_Startup()

MsgBox, Test: top left portion of the screen will appear in a 640x480 window
rqHbmp = % ImgHBM(0, 0, 640, 480, "")
Gui, Destroy
Gui, Add, Pic, x0 y0, HBITMAP:%rqHbmp%
Gui, Show

ImgHBM(x, y, w, h, hwnd)
{
;   AbsPos(x, y, hwnd)
    pbm = % Gdip_BitmapFromScreen()
    pbn = % Gdip_CreateBitmap(w, h)
    Gdip_DrawImage(Gdip_GraphicsFromImage(pbn), pbm, 0, 0, w, h, x, y, w, h)
    hbm = % Gdip_CreateHBITMAPFromBitmap(pbn)
    Gdip_DisposeImage(pbm)
    Gdip_DisposeImage(pbn)
    return hbm
}
