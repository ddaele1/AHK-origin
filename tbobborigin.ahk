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

OriginTicket()
{
Gui, Destroy
Gui, Add, Text,, Welk scriptje wil je starten?
Gui, Add, Button, gItTicket, IT tickets
Gui, Add, Button, gCaseTemplate, SC template
Gui, Add, Button, gSms, SMS templates
Gui, Show
}


; It Ticket script

ItTicket()
{
global
Gui, Destroy
Gui, Add, Checkbox, vCoos, COOS?
Gui, Add, Checkbox, vSheet, Sheet?
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

if (Sheet = 1)
{
	if (Coos = "/COOS"){
	Sheet := " sheet"
	}
	else{
	Sheet := "/sheet"
	}
}
else
{
Sheet:= ""
}

Stringmob =
(
Origin%Coos%%Sheet%/%Telbase% %Service%/Non-Billing/%Klantennummer%/%Scid%/%Problemshort%

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


; Service case script

CaseTemplate()
{
global
Gui, Destroy
Gui, Font, s12
Gui, add, Text,, Technical issue
Gui, Add, Edit, r10 w380 vTissue, 
Gui, add, Text,, Steps taken :
Gui, Add, Edit, r10 w380 vStaken,
Gui, add, Text,, Conclusion : 
Gui, Add, Edit, r10 w380 vConclusionCase, 
Gui, Add, Button, gCopyCaseTemplate, COPY
Gui, Add, Button, gClear, CLEAR
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

Clear()
{
global
GuiControl, ,Tissue
GuiControl, ,Staken
GuiControl, ,ConclusionCase
Return
}

CopyCaseTemplate()
{
global
Gui, Submit, NoHide

stringCaseTemplate = 
(
Technical issue : 
%Tissue%

Steps taken :  
%Staken%

Conclusion / communication :
%ConclusionCase% 
)
clipboard := stringCaseTemplate
return
}


; SMS Hoofdmenu

Sms()
{
Gui, Destroy
Gui, add, Text,, Alle SMS:
Gui, Add, Button, gSmsAlgemeen, Algemeen 
Gui, Add, Button, gSmsInternet, Internet 
Gui, Add, Button, gSmsDtv, DTV
Gui, Add, Button, gSmsTelefonie, Vaste telefoon 
Gui, Add, Button, gOriginTicket, Ga terug
Gui, Show
}


; sms Algemeen

SmsAlgemeen()
{
Gui, Destroy
Gui, add, Text,, Alle algemene sms:
Gui, Add, Button, gCallBack, callback sms
Gui, Add, Button, gModemActivate, modem geactiveerd
Gui, Add, Button, gPakketAanpassing, pakketwijziging
Gui, Add, Button, gItTicketSms, IT ticket
Gui, Add, Button, gRepairCallback, callback repair.
Gui, Add, Button, gLoginOk, Aanmelden terug ok
Gui, Add, Button, gSms, Ga terug
Gui, Show
}


; Algemeen scripts


; callback

CallBack()
{
global
Gui, Destroy
Gui, add, Text,, SC id:
Gui, Add, Edit, vCaseid, 
Gui, Add, Button, gCopyCallback, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyCallback()
{
global
Gui, Submit, NoHide
Stringmob = 
(
Beste klant,

Kan u ons contacteren op 015/666666 in verband met uw openstaand dossier %Caseid%

Mvg,
Telenet
)
clipboard := Stringmob
return
}


; modemactivate

ModemActivate(){
global
Gui, Destroy
Gui, add, Text,, Modemmac:
Gui, Add, Edit, vModemmac, 
Gui, Add, Button, gCopymodemActivate, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopymodemActivate()
{
global
Gui, Submit, NoHide ;betere manier dan control get
Stringmodem = 
(
Beste klant, 

Uw nieuwe modem %Modemmac% werd geactiveerd. Binnen 30 minuten kan u gebruik maken van uw diensten

Mvg, 
Telenet
)
clipboard := Stringmodem
return
}


; pakketaanpassing

PakketAanpassing(){
global
Gui, Destroy
Gui, add, Text,, Welk nieuw pakket (One/Klik/...):
Gui, Add, Edit, vPakket, 
Gui, Add, Button, gCopyPakketaanpassing, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyPakketaanpassing()
{
global
Gui, Submit, NoHide
stringpkkt = 
(
Beste klant,
 
Uw pakket is succesvol aangepast naar %Pakket%.
 
Mvg,
Telenet
)
clipboard = %stringpkkt%
return
}


; IT ticket sms

ItTicketSms(){
Gui, Destroy
Gui, Add, Button, gCopyIt, IT Ticket
Gui, Add, Button, gCopyItUpdate, Update
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyIt()
{
Stringit =
(
Telenet info:
Beste klant,

We hebben je dossier doorgestuurd naar onze IT-dienst. We houden je op de hoogte. Bedankt voor uw geduld

Mvg,
Telenet
)
clipboard := Stringit
return
}

CopyItUpdate()
{
Stringitupdate =
(
Telenet info:
Beste klant,

Momenteel hebben we nog geen oplossing voor uw dossier. We werken eraan. Bedankt voor uw geduld

Mvg,
Telenet
)
clipboard := Stringitupdate
return
}


; Repaircallback SMS

repaircallback(){
global
Gui, Destroy
Gui, add, Text,, Dienst(Internet,TV,..) mag ook leeg gelaten worden:
Gui, Add, Edit, vRepdienst, 
Gui, Add, Button, gRepCopyCallback, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

RepCopyCallback()
{
global
Gui, Submit, NoHide
Stringrepcall = 
(
Beste klant,

Gelieve ons te contacteren op het nr 015/666666 voor een repair afspraak ivm uw %Repdienst% diensten.

Mvg,
Telenet
)
clipboard := Stringrepcall
return
}


; Login OK script

LoginOk(){
global
Gui, Destroy
Gui, Add, Text,, Welke Service?(mijn telenet, Yelo Tv, webmail...)
Gui, Add, Edit, vService,
Gui, Add, Button, gCopyLogin, Copy
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyLogin()
{
global
Gui, Submit, NoHide
Stringlog =
(
Beste klant,

U kan vanf nu weer aanmelden op %Service%.

Mvg,
Telenet
)
clipboard := Stringlog
return
}

; sms Internet

SmsInternet(){
Gui, Destroy
Gui, add, Text,, Alle internet sms:
Gui, Add, Button, gReset, Wachtwoord reset
Gui, Add, Button, gEmailProgramma, Verdwenen mails door mailprogramma
Gui, Add, Button, gSms, Ga terug
Gui, Show
}


; Internet scripts

; ww reset

Reset(){
global
Gui, Destroy
Gui, add, Text,, Wachtwoord:
Gui, Add, Edit, vWachtwoord,
Gui, Add, Button, gCopyReset, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyReset()
{
global
Gui, Submit, NoHide
Stringresetwachtwoord = 
(
Beste klant,

Uw nieuw wachtwoord is: %Wachtwoord%

Mvg,
Telenet

)
clipboard := Stringresetwachtwoord
return
}


; email mailprogramma issue 

EmailProgramma(){
Gui, Destroy
Gui, Add, Button, gCopyEmailProgramma, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyEmailProgramma()
{
Gui, Submit, NoHide
Stringemailprogrammas = 
(
Beste,

We kunnen geen fout vaststellen op Webmail. Gelieve de instellingen van uw mailclient te controleren. meer info:
https://tinyurl.com/y239bd2s

Telenet
)

clipboard := Stringemailprogrammas
return
}


; sms DTV

SmsDTV(){
Gui, Destroy
Gui, add, Text,, Alle DTV sms:
Gui, Add, Button, gZenderPakketActivatie, zenderpakket geactiveerd
Gui, Add, Button, gSms, Ga terug
Gui, Show
}


; DTV scripts

; zenderpakket activatie

ZenderPakketActivatie(){
global
Gui, Destroy
Gui, add, Text,, Zenderpakket:
Gui, Add, Edit, vZenderpakket, 
Gui, Add, Button, gCopyZenderPakketActivatie, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyZenderPakketActivatie()
{
global
Gui, Submit, NoHide
Stringzndrpakket = 
(
Beste klant,
 
Uw zenderpakket %Zenderpakket% is succesvol geactiveerd.
Dit is gebruiksklaar binnen 60 minuten
 
Mvg,
Telenet


)
clipboard := Stringzndrpakket
return
}


; sms Telenfonie

SmsTelefonie(){
Gui, Destroy
Gui, add, Text,, Alle Telefonie sms:
Gui, Add, Button, gTelefoonActief, nieuwe telefoonlijn geactiveerd
Gui, Add, Button, gTelefoonOvername, overname documenten voor vaste lijn
Gui, Add, Button, gSms, Ga terug
Gui, Show
}

; Telefonie scripts

; Telefoon actief

TelefoonActief(){
global
Gui, Destroy
Gui, add, Text,, Telefoonnummer:
Gui, Add, Edit, vTelefoonnummer, 
Gui, Add, Button, gCopyTelefoonActief, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyTelefoonActief()
{
global
Gui, Submit, NoHide
Stringtelefoonnr = 
(
Beste klant, 

Uw vaste lijn %Telefoonnummer% is succesvol geactiveerd. U kan deze gebruiken binnen de 30 minuten.
 
Mvg,
Telenet

)
clipboard := Stringtelefoonnr
return
}


; Telefoon Overname

telefoonovername(){
global
Gui, Destroy
Gui, add, Text,, telefoonnummer overname:
Gui, Add, Edit, vTelefoonnummerov, 
Gui, Add, Button, gCopyTelefoonOvername, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyTelefoonOvername()
{
global
Gui, Submit, NoHide
Stringtelov = 
(
Beste klant,
 
Gelieve ons overname documenten te bezorgen om de activatie van uw vaste lijn %Telefoonnummerov% te kunnen voltooien.
 
Mvg,
Telenet

)
clipboard := Stringtelov
return
}

