#SingleInstance IGNORE

#Include Create_button_bmp.ahk

T := A_TickCount
HBITMAP := Create_button_bmp()
H := Bitmap_GetHeight(HBITMAP)
W := Bitmap_GetWidth(HBITMAP)


iniread, ped1, hot.ini, edit, set1, %A_Space%
iniread, ped2, hot.ini, edit, set2, %A_Space%
iniread, ped3, hot.ini, edit, set3, %A_Space%
iniread, ped4, hot.ini, edit, set4, %A_Space%
iniread, ped5, hot.ini, edit, set5, %A_Space%

	Menu, Tray, Click, 1
	Menu, Tray, NoStandard
	Menu, Tray, Add, ACTIVE, DoubleClick
	Menu, Tray, Default, ACTIVE
	Menu, Tray, Add, GITHUB
	Menu, Tray, Add, Exit


Gui, Add, GroupBox, x106 y20 w70 h10 +border 2
Gui, Add, GroupBox, x6 y57 w266 h400 +border 2
Gui,Font, s9 Arial


Gui , Font ,s14 bold, Calibri
Gui , Add , Text ,c117BFF gtext1 vtex1 x37 y80 ,< Save
Gui , Add , Text ,c117BFF gtext2 vtex2 x194 y80 ,Exit >
Gui,Font, s9 Calibri


gui,add,edit,x42 y170 h22 w130 -e512 +border vped1,%ped1%
gui,add,edit,x42 y210 h22 w130 -e512 +border vped2,%ped2%
gui,add,edit,x42 y250 h22 w130 -e512 +border vped3,%ped3%
gui,add,edit,x42 y290 h22 w130 -e512 +border vped4,%ped4%
gui,add,edit,x42 y330 h22 w130 -e512 +border vped5,%ped5%


gui,add,text,x202 y172 h20 w60 ,Alt+1
gui,add,text,x202 y213 h20 w60 ,Alt+2
gui,add,text,x202 y253 h20 w60 ,Alt+3
gui,add,text,x202 y293 h20 w60 ,Alt+4
gui,add,text,x202 y333 h20 w60 ,Alt+5


Gui +LastFound

Gui, Add, Text, vmap gcar x111 y463 hwndHPic1
Bitmap_SetImage(HPic1, HBITMAP)

Gui,Color,FFFFFF

FormatTime, time, , hh:mm
Gui,Font, s9 Arial
time = 로딩중....

Gui,Add, Text, h16 w60 x110 y58 vMyText,%time%
SetTimer, timechange, 100



Gui +LastFound -Caption +0x400000

WinSet, Region, R50-50 W286 H546 0-0
gui,show,w279 h540,QuickType

gui,add,text, cGreen x210 y435 vmain,QuickType
SetTimer, RemoveToolTip, 3000
return


car:
Gui,submit,nohide
GuiControl,move,map,x113 y465
sleep,100
GuiControl,move,map,x111 y463
sleep,400
Winhide,QuickType
return

timechange:
FormatTime, newtime, , tt hh:mm
GuiControl,, MyText,%newtime%
return

text1:
ToolTip, 저장완료
SetTimer, RemoveToolTip, 1000
gui, submit,nohide
Gui, Font, cred s14 bold, Calibri
GuiControl, Font, tex1
iniwrite, %ped1%, hot.ini, edit, set1
iniwrite, %ped2%, hot.ini, edit, set2
iniwrite, %ped3%, hot.ini, edit, set3
iniwrite, %ped4%, hot.ini, edit, set4
iniwrite, %ped5%, hot.ini, edit, set5
iniwrite, %ped6%, hot.ini, edit, name
sleep,100
Gui , Font ,c117BFF s14 bold, Calibri
GuiControl, Font, tex1
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

text2:
Gui, Font, cred s14 bold, Calibri
GuiControl, Font, tex2
sleep,100
Gui , Font ,c117BFF s14 bold, Calibri
GuiControl, Font, tex2
exitapp
return

DoubleClick:

	If RClicked <> Yes
	{
		Gui,submit ,nohide


		Winshow,QuickType
	winactivate,QuickType
	}
return

GITHUB:
	Run, https://github.com/cadinz/AHK_QuickType
return

Exit:
	ExitApp
return

guiclose:
exitapp
return

!1::
GuiControlGet,Edt,,ped1
Message(Edt)
return

!2::
GuiControlGet,Edt,,ped2
Message(Edt)
return

!3::
GuiControlGet,Edt,,ped3
Message(Edt)
return

!4::
GuiControlGet,Edt,,ped4
Message(Edt)
return

!5::
GuiControlGet,Edt,,ped5
Message(Edt)
return

Message(text)
{
ControlGetFocus,con,A
Loop
{
StringLeft,ascii,text,1
StringTrimLeft,text,text,1
if ascii=
break
PostMessage,0x102,% ASC(ascii),0x00000001,%con%,A
}
}

Bitmap_GetWidth(hBitmap) {
   Static Size := (4 * 5) + A_PtrSize + (A_PtrSize - 4)
   VarSetCapacity(BITMAP, Size, 0)
   DllCall("Gdi32.dll\GetObject", "Ptr", hBitmap, "Int", Size, "Ptr", &BITMAP, "Int")
   Return NumGet(BITMAP, 4, "Int")
}

Bitmap_GetHeight(hBitmap) {
   Static Size := (4 * 5) + A_PtrSize + (A_PtrSize - 4)
   VarSetCapacity(BITMAP, Size, 0)
   DllCall("Gdi32.dll\GetObject", "Ptr", hBitmap, "Int", Size, "Ptr", &BITMAP, "Int")
   Return NumGet(BITMAP, 8, "Int")
}

Bitmap_SetImage(hCtrl, hBitmap) {
   ; STM_SETIMAGE = 0x172, IMAGE_BITMAP = 0x00, SS_BITMAP = 0x0E
   WinSet, Style, +0x0E, ahk_id %hCtrl%
   SendMessage, 0x172, 0x00, %hBitmap%, , ahk_id %hCtrl%
   Return ErrorLevel
}
