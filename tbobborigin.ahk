#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force	
#NoTrayIcon	
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Hotstring C R

; start Gui

::+op::
Originticket()
return


; Stop Gui

Close()
{
Gui, Destroy
Return
}


; Hoofdmenu

Originticket()
{
Gui, Destroy
Gui, Add, Text,, Welk scriptje wil je starten?
Gui, Add, Button, gItTicket, IT tickets
;Gui, Add, Button, gCaseTemplate, SC template
Gui, Show
}


; It Ticket script

ItTicket()
{
global
Gui, Destroy
Gui, Add, Checkbox, vCoos, COOS?
Gui, Add, Text,, Telenet of BASE?
Gui, Add, DropDownList, vTelbase, TELENET||BASE
Gui, Add, Text,, Welke Service?
Gui, Add, DropDownList, vService, ALL||INT|FIXED TEL|DTV|MOBILE
Gui, Add, Text,, Probleem?
Gui, Add, Edit, vProblemshort
Gui, Add, Text,, Klantennummer?
Gui, Add, Edit, vKlantennummer
Gui, Add, Text,,Klantenlink BSS?
Gui, Add, Edit, vLinkBSS
Gui, Add, Text,, Link Taak?
Gui, Add, Edit, vTasklink
Gui, Add, Text,, SC id?
Gui, Add, Edit, vScid
Gui, Add, Text,, Error?
Gui, Add, Edit, vError
Gui, Add, Text,, Uitgebreide probleembeschrijving/Stappen?
Gui, Add, Edit, r10 w380 vExtdescr, 
Gui, Add, Button, gCopyTicket, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyTicket()
{
global

Gui, Submit, Nohide


if (Coos = 1)
{ 
Coos := "/COOS"
}
else
{
Coos := ""
}

Stringmob =
(
Origin%Coos%/%Telbase% %Service%/Non-Billing/%Klantennummer%/%Scid%/%Problemshort%

- Regarding customer: %Klantennummer%
- customerlink BSS: %LinkBss%
- Problem: %Problemshort%
- link of the task: %Tasklink%
- error: %Error%
- Description or Steps:
%Extdescr%

Can You solve this please?
If TBO could have done this please provide us with the steps.
Thank you!
)
clipboard := Stringmob
return
}



