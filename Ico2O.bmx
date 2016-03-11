Rem
	Ico2O
	Converts Windows Icons into .o files for further compilation with the help of MINGW
	
	
	
	(c) Jeroen P. Broks, 2011, 2016, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
Version: 16.03.11
End Rem



Strict

Framework BRL.System
Import maxgui.drivers
Import BRL.Retro
Import BRL.EventQueue


Import "Parameters.bmx"
?Win32
Import "AziellaForWindowsIcon.o"
?

?MACOS
Notify "This file was not meant to be compiled with MACOS X"
End
?Linux
Notify "This file was not meant to be compiled with Linux"
End
?

Global Window:TGadget = CreateWindow("ICO2O - By: Tricky",100,100,100,100,Null,Window_TitleBar|Window_Clientcoords|WINDOW_ACCEPTFILES)
CreateLabel "Drag an icon into me to start converting",0,0,100,100,Window
Global File$


Function Ini$(I$)
Local Ret$=""
Local BT:TStream = ReadStream("Ico2O.ini")
Local L$
While Not(Eof(BT))
	L$ = Trim(ReadLine(BT))
	If L<>""
		Print "****"
		Print "L = "+L
		Print "I = "+PR(L,0)
		Print "P = "+PrRest(L,1)
		If Upper(PR(L,0))=Upper(I) Then Ret=PrRest(L,1)
		Print "R = "+Ret
		Print "****"
		EndIf
	Wend
Return Ret
End Function

Global MINGW$ = Ini("MINGWBIN"); If Right(MINGW,1)<>"\" MINGW:+"\"
Global Temp$  = Ini("TEMP");     If Right(TEMP,1) <>"\" TEMP:+"\"

Function Action()
If Upper(Right(File,4))<>".ICO"
	Notify "That file is no icon"
	Return
	EndIf
HideGadget window	
Local T$ = Ini("TEMP")+"ICO2O.RC";
Local BT:TStream = WriteStream(T)
WriteLine BT,"101 ICON "+File
CloseStream BT
Local OFile$ = Left(File,Len(file)-4)+".o"
BT = WriteStream(Temp+"GO.Bat");
WriteLine BT,MINGW+"WindRes.exe -i "+T+" -o "+OFile
WriteLine BT,"Pause"
CloseStream BT
'Print "Executing: "+MINGW+"WindRes -i "+T+" -o "+OFile
'system_ MINGW+"WindRes.exe -i "+T+" -o "+OFile
system_ Temp+"Go.bat"
If FileType(OFile)
	Notify "File saved as: "+OFile
	Else
	Notify "Saving the .o file must have failed!"
	endif
ShowGadget window
End Function


If FileType(MINGW+"windres.EXE")
	Print "windres.EXE located succesfully"
	Else
	Print MINGW+"windres.exe not found"
	Notify "windres.EXE could not be located.~nCheck if MINGW is installed or if the INI file directs to the MINGW Bin directory correctly"
	End
	EndIf
	

Repeat
WaitEvent
Select EventID()
	Case event_windowClose,Event_appterminate
		End
	Case EVENT_WINDOWACCEPT
		File = EventText()
		Print "File dragged in: "+File
		Action 
	EndSelect
Forever
