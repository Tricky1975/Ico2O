Rem
        Parameters.bmx
	(c) 2011, 2016 Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.
        Version: 16.03.11
End Rem



Import brl.retro

Private

Global PPDOS



Public



Function PR$(AA$,A)

Local AK,Ct

Local PP$

Local Ret$

Ret=""

PP=""

Ct=0'

PPDOS=0'

For Ak=1 To Len(AA)

    If (AK>Len(AA)) Then CT=CT+1

    If Mid(AA,AK,1)=" " Then CT=CT+1

    If CT=A Then

       If (AK>1) Then If (Mid(AA,AK-1,1)=" ") Then PPDOS=AK'

       PP=PP+Mid(AA,Ak,1)

       EndIf

    Next

'If PP(1)=' ' Then Delete(PP,1,1)'

PP = Trim(PP)

'PR:=PP'

Return PP

End Function



Function PRPos(A$,PrNr)

PR A,PrNr

Return PPDOS

End Function



Function PrCounter(AA$)

Local Ak

Ak=0

While Pr(AA,Ak+1)<>"" 	

	Ak = Ak + 1

	Wend

'PrCounter:=Ak'

Return Ak

End Function 



Function PrRest$(A$,P)

Local Ret$=""

Local Ak

For Ak=P To PrCounter(A)

	Ret = Ret + " "+Pr(A,Ak)

	Next

Return Trim(Ret)

End Function

