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


;Run Outlook scripts

;Start outlook

CheckOutlook(){
Process, Exist, Outlook.exe
If Not ErrorLevel
{
	Run, Outlook.exe	; You may need to specify the full path here.
	WinWaitActive, ahk_exe Outlook.exe
	sleep 2000
	Msgbox, Wacht tot als Outlook is opgestart
}
}


;Compose Mail

CompMail(mailsubject, mailbody, ccmail, tomail, frommail){
olMailItem := 0
MailItem := ComObjActive("Outlook.Application").CreateItem(olMailItem)
MailItem.BodyFormat := 2 ; olFormatHTML
MailItem.SentOnBehalfOfName := frommail
MailItem.TO := tomail
MailItem.CC := ccmail
MailItem.Subject := mailsubject
MailItem.HTMLBody := mailbody
MailItem.Display
return
}


; Hoofdmenu

OriginTicket()
{
Gui, Destroy
Gui, Add, Text,, Welk scriptje wil je starten?
Gui, Add, Button, gItTicket, IT tickets
Gui, Add, Button, gCaseTemplate, SC template
Gui, Add, Button, gSms, SMS templates
Gui, Add, Button, gMultiMail, Mail templates
Gui, Add, Button, gFwVraag, Vragen Floorwalker
Gui, Add, Button, gTrunkBox, Trunkboxen
Gui, Add, Button, gMultiNP, NP
Gui, Add, Button, gVadeSpam, Spamcause zoeken in Putty
Gui, Show
}


; putty script

VadeSpam(){
global
Gui, Destroy
Gui, add, Text,,ID:
Gui, add, Edit,vId,
Gui, add, Text,,Datum(yyyymmdd):
Gui, add, Edit,vDatum,
Gui, add, Text,,Uur tijdstip(uu):
Gui, add, Edit,vTijd,
Gui, Add, Button, gCopyspam, COPY
Gui, Add, Button, gCopyspam2, COPY FOR MULTI-RECIPIENT
Gui, Add, Button, gMailVade, START SCRIPT VOOR VADE E-MAIL
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

Copyspam()
{
global
Gui, Submit, NoHide ;betere manier dan control get
Stringspam =
(
zgrep id=%Id% */applications-%Datum%%Tijd%00*
)
clipboard = %Stringspam%
return
}

Copyspam2()
{
global
Gui, Submit, NoHide ;betere manier dan control get
Stringspam2 =
(
zgrep id=%Id% */messages-%Datum%%Tijd%00*
)
clipboard = %Stringspam2%
return
}


; TrunkBox scriptµ

TrunkBox(){
Gui, Destroy
Gui, Add, Text,,Operator:
Gui, Add, DropDownList,vOperator,Proximus Fix||Proximus Mob|Orange Mob|Base Mob|Telenet Mob
Gui, Add, Text,,Telefoonnummer:
Gui, Add, Edit,vNummer
Gui, Add, Button, gCopytrunk, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyTrunk()
{
global
Gui, Submit, Nohide
if (Operator = "Proximus Fix")
{
prefix = +329912
}
else if (Operator = "Proximus Mob")
{
prefix = +3299123
}
else if (Operator = "Orange Mob")
{
prefix = +3299122
}
else if (Operator = "Base Mob")
{
prefix = +3299121
}
else if (Operator = "Telenet Mob")
{
prefix = +3299124
}

stringtrunk =
(
%prefix%%Nummer%
)
clipboard = %stringtrunk%
return
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
Gui, Add, Button, gTvBoxActivate, Tv-box Geactiveerd
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


; Tv-box activatie

TvBoxActivate(){
global
Gui, Destroy
Gui, add, Text,, Serienummer:
Gui, Add, Edit, vSerienr, 
Gui, Add, Button, gCopyTvBoxActivate, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyTvBoxActivate()
{
global
Gui, Submit, NoHide ;betere manier dan control get
Stringtvbox = 
(
Beste klant, 

Uw nieuwe Tv-box %Serienr% werd geactiveerd. Binnen 30 minuten kan u gebruik maken van uw diensten

Mvg, 
Telenet
)
clipboard := Stringtvbox
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


; Vragen Floorwalker script

FwVraag(){
global
Gui, Destroy
Gui, Add, Text,, BSS klantenlink?
Gui, Add, Edit, vBsslink
Gui, Add, Text,, OSS error/waiting link?
Gui, Add, Edit, vOsslink
Gui, Add, Text,, Klantennummer?
Gui, Add, Edit, vKlantennummer
Gui, Add, Text,, Beschrijving situatie?
Gui, Add, Edit, r10 w380 vSituatiedescr
Gui, Add, Text,, Reeds uitgecoerde acties?
Gui, Add, Edit, r10 w380 vUitgevacties,
Gui, Add, Text,, Waar zit je vast?
Gui, Add, Edit, r10 w380 vStuckdescr,  
Gui, Add, Button, gCopyFw, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyFw()
{
global
Gui, Submit, Nohide
Stringfw =
(
Bss klantenlink: %Bsslink%

Oss error/waiting link: %Osslink%

Klantennummer: %Klantennummer%

Situatie beschrijving:
%Situatiedescr%

Acties die reeds zijn uitgevoerd.
%Uitgevacties%

Waar zit je vast?
%Stuckdescr%
)
clipboard := Stringfw
return
}


;Mail scripts

MultiMail(){
Gui, Destroy
Gui, add, Text,, Algemeen
Gui, Add, Button, gOloPx, Olo mail proximus
Gui, Add, Button, gMailVade, Mail template voor vade secure
Gui, Add, Button, gMailInfo, Mail template info klant
Gui, Add, Button, gOriginTicket, Ga terug
Gui, Show
}


; OLO px Mail

OloPx(){
global
Gui, Destroy
Gui, Add, Text,, Telefoonnummer?
Gui, Add, Edit, vOlopxtelefoonnummer
Gui, Add, Text,, SC id
Gui, Add, Edit, vOloscid
Gui, Add, Text,, Uw naam?
Gui, Add, Edit, vOlonaam  
Gui, Add, Button, gCopyOloPx, CREATE
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyOloPx()
{
global
Gui, Submit, Nohide
CheckOutlook()

Subolopx = %Olopxtelefoonnumme%___Niet bereikbaar voor Proximus___%Oloscid%
Stringolopx =
(
<p>Beste,</p>
<p>Het nummer %Olopxtelefoonnummer% is niet bereikbaar voor Proximus abonnees.</p>
<p>Kunnen jullie de routering nakijken?</p>
<p>&nbsp;</p>
<p>MVG</p>
<p>%Olonaam%</p>
)
CompMail(Subolopx, Stringolopx, "Telenet_NP@telenetgroup.be", "car_np@proximus.com", "Telenet_NP@telenetgroup.be")
return
}


; Mail vade

MailVade(){
global
Gui, Destroy
Gui, Add, Text,, E-mail adres of domein waar het over gaat?
Gui, Add, Edit, vDomeinmail
Gui, Add, Text,, E-mail adres van de afzender in het voorbeeld?
Gui, Add, Edit, vMailsender
Gui, Add, Text,, E-mail adres van de ontvanger in het voorbeeld?
Gui, Add, Edit, vMailrec
Gui, Add, Text,, Datum en tijdstip van het voorbeeld?
Gui, Add, Edit, vDateandtime
Gui, Add, Text,, Spamcause van het voorbeeld?
Gui, Add, Edit, vSpamcause
Gui, Add, Text,, Uw naaam?
Gui, Add, Edit, vVadenaam
Gui, Add, Button, gCopyVadeMail, CREATE
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyVadeMail()
{
global
Gui, Submit, Nohide
CheckOutlook()

Subvade = Mails sent from %Domeinmail% are incorrectly marked as spam
Stringvade =
(
<p>Hi</p>

<p>Mails sent from the domain/e-mail %Domeinmail% are incorrectly marked as spam. Can you please check and correct this</p>

<p>Example:</p>

<p>Sender: %Mailsender%<br>
Recipient: %Mailrecr%<br>
Date: %Dateandtime%<br>
Spam cause: %Spamcause%</p>

<p>Decrypted:<br>
!!!Plak hier de decrypted spamcause!!!</p>

<p>With kind regards<br>
%Vadenaam%</p>
)
CompMail(Subvade, Stringvade, "", "support@vadesecure.com", "")
return
}


; Mail Info klant

Mailinfo(){
global
Gui, Destroy
Gui, Add, Text,,Welke info:
Gui, Add, DropDownList,vInfo,MAC-adressen modem||Serienummer EOS|Serienummer SPDN|Login
Gui, Add, Text,,Naam Klant:
Gui, Add, Edit, vNaamkl
Gui, Add, Button, gCopyInfoKlantMail, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
return
}

CopyInfoKlantMail()
{
global
Gui, Submit, Nohide

switch Info
{
case "MAC-adressen modem":
	Info := "de MAC-adressen van uw Telenet modem nodig."
	Location := "Deze kan u vinden op de sticker onderaan, de HFC MAC."
	Requestedaction := "Als u een foto neemt en deze toevoegt als bijlage bij het antwoord op deze mail kunnen we uw Telenet diensten activeren."
case "Serienummer EOS":
	Info := "het serienummer van uw TV-Box nodig."
	Location := "Deze kan u vinden op de witte sticker onderaan,  de CA ID."
	Requestedaction := "Als u een foto neemt en deze toevoegt als bijlage bij het antwoord op deze mail kunnen we uw Telenet diensten activeren."
case "Serienummer SPDN":
	Info := "het serienummer van uw decoder nodig."
	Location := "Deze kan u vinden op de witte sticker, achter STB CA serial number."
	Requestedaction := "Als u een foto neemt en deze toevoegt als bijlage bij het antwoord op deze mail kunnen we uw Telenet diensten activeren."
case "Login":
	Info := "Uw Telenet login nodig."
	Location :=""
	Requestedaction := "Als u ons deze bezorgt met het anwoord op de mail kunne we uw Telenet dienst activeren."
}


Stringinfokl =
(
Hallo %Naamkl%

Om je zo goed mogelijk verder te helpen, hebben we nog wat bijkomende informatie nodig. Bezorg het ons zo snel mogelijk.

Om uw diensten te activeren hebben we %Info%
%Location%

%Requestedaction%

Geef ons de gevraagde informatie:
- Als antwoord op deze e-mail.


Vriendelijke groeten,
Telenet-klantendienst
)
clipboard := Stringinfokl
return
}


;NP scripts

MultiNP(){
Gui, Destroy
Gui, add, Text,, Alle NP Templates:
Gui, Add, Button, gRejectGrouping, template reject owv grouping 
Gui, Add, Button, gRejectAdresCheck, template reject owv adrescheck
Gui, add, Text,, duedate templates.
Gui, Add, Button, gDuedateNew, template voor due date cases new
Gui, Add, Button, gDuedateAccept, template voor order status npr/ accept
Gui, Add, Button, gDuedateExec, template voor np opstarten exec verzonden
Gui, add, Text,, LOA mail
Gui, Add, Button, gLoaNl, Letter of agreement NL
Gui, Add, Button, gLoaFr, Letter of agreement FR
Gui, Add, Button, gOriginTicket, Ga terug
Gui, Show
}

RejectGrouping(){
global
Gui, Destroy
Gui, add, Text,, Nummer1
Gui, Add, Edit, vNummer1,
Gui, add, Text,, Nummer2
Gui, Add, Edit, vNummer2,
Gui, Add, Button, gCopyRejectNP, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyRejectNP(){
global
Gui, Submit, NoHide

stringRejectNP =
(

We hebben een weigering ontvangen van Proximus voor het porteren van nummer : %Nummer1%.

Reden van reject (weigering) : Onvolledige reeks.




Klant heeft bij Proximus niet enkel het nummer %Nummer1% (nummer A) actief staan maar ook het nummer : %Nummer2% (nummer B).

MAAR ... Wat moet er gebeuren met het nummer (nummer B) : %Nummer2%? 




1. Mee naar Telenet? >>> Inboeken in Cafe. Laten weten of afwerken install nodig is of niet.

2. Opzeggen bij Proximus? >>> Log info in de case. TBO doet nieuwe aanvraag.

3. Actief houden bij Proximus? >>> Log info in de case. TBO doet nieuwe aanvraag.

 

Let op! Je mag de nummer niet inboeken om achteraf op te zeggen!!! Dit geeft problemen voor in de toekomst.


)
clipboard := stringRejectNP
return
}


; Rejectadrescheck

RejectAdresCheck(){
global
Gui, Destroy
Gui, add, Text,, Telefoonnummer
Gui, Add, Edit, vTelefoonnummeradres,
Gui, add, Text,, naam van de klant Proximus
Gui, Add, Edit, vnaamadres1,
Gui, add, Text,, Adres Proximus
Gui, Add, Edit, vAdres1,
Gui, add, Text,, naam van de klant Telenet
Gui, Add, Edit, vnaamadres2,
Gui, add, Text,, Adres Telenet
Gui, Add, Edit, vAdres2
Gui, Add, Button, gCopyRejectAdres, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyRejectAdres(){
global
Gui, Submit, NoHide

stringRejectadres =
(

Klant meermaals proberen te bereiken ivm nummerportering : Telefoonnummer : %Telefoonnummeradres%

Indien de klant binnen belt, dient er een controle te gebeuren van naam + adres!!!

Voor de nummerportering te kunnen voltooien, hebben wij onderstaande gegevens nodig van de klant :

 

Gegevens bij Proximus :
Naam : %naamadres1%
Adres : %Adres1%

 

Gegevens bij ons :
Naam : %naamadres2%
Adres : %Adres2%

 

!!! Vraag aan klant --> Kent onze klant bovenstaande klant? (gegevens van Proximus)

Bijvoorbeeld:
Dit kan de echtgenote zijn
Heeft de klant eventueel een verhuis gehad?

 

Gelieve dit zeker na te vragen aan de klant! Zonder deze info zal de nummerportering niet kunnen verder gezet worden.

Heb je de case geaccepteerd? Geen nood! Je mag de case opnieuw dispatchen naar : TBO FNP ACK !!!

Indien we nog steeds geen duidelijk info hierover ontvangen, zullen wij de klant een nieuw nummer geven + hiervan op de hoogte brengen per brief.

 

Wij proberen de klant opnieuw te contacteren op (datum). Indien we de klant nog steeds niet kunnen bereiken, zullen wij de klant een nieuw nummer geven + hiervan op de hoogte brengen per mail.



)
clipboard := stringRejectadres
return
}

; Duedatenew

DuedateNew(){
global
Gui, Destroy
Gui, add, Text,, Telefoonnummer
Gui, Add, Edit, vTelefoonnummerddnew,
Gui, add, Text,, due date
Gui, Add, Edit, vDuedatenew,
Gui, Add, Button, gCopyDdNew, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyDdNew(){
global
Gui, Submit, NoHide

Stringddnew =
(

De nummerportering van het nummer %Telefoonnummerddnew% staat momenteel nog open.

Nummerportering wordt aangevraagd door TBO

Due Date = %Duedatenew%

=> Dit is de opstartdatum van de nummeroverdracht. (indien we een accept ontvangen)

=> PAS VANAF DEZE DATUM ZAL DE KLANT BEREIKBAAR ZIJN VOOR ALLE OPERATOREN OP DE AANSLUITING VAN TELENET!
)
clipboard := Stringddnew
return
}


; Duedateaccept

DuedateAccept(){
global
Gui, Destroy
Gui, add, Text,, Telefoonnummer
Gui, Add, Edit, vTelefoonnummerddaccept,
Gui, add, Text,, np status
Gui, Add, Edit, vnpstatusaccept
Gui, add, Text,, due date
Gui, Add, Edit, vDuedateaccept,
Gui, Add, Button, gCopyDdAccept, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyDdAccept(){
global
Gui, Submit, NoHide

Stringddaccept =
(
De nummerportering van het nummer %Telefoonnummerddaccept% staat momenteel nog open.

Status order = %npstatusaccept%

Due Date = %Duedateaccept%

=> Dit is de opstartdatum van de nummeroverdracht. (indien we een accept ontvangen)

=> PAS VANAF DEZE DATUM ZAL DE KLANT BEREIKBAAR ZIJN VOOR ALLE OPERATOREN OP DE AANSLUITING VAN TELENET!
)
clipboard := Stringddaccept
return
}

; Duedateexec

DuedateExec(){
Gui, Destroy
Gui, Add, Button, gCopyDdExec, COPY
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyDdExec(){

Stringddexec =
(

Exec verzonden, hierdoor wordt de nummerportering naar Telenet opgestart.

Van zodra de status op RFS sent staat, is de nummerportering volledig afgehandeld.

=> PAS VANAF DAN ZAL DE KLANT BEREIKBAAR ZIJN VOOR ALLE OPERATOREN OP DE AANSLUITING VAN TELENET!

)
clipboard := Stringddexec
return
}


; LOANL

LoaNl(){
global
Gui, Destroy
Gui, Add, Text,, Telefooonnummer?
Gui, Add, Edit, vTelefoonnummer
Gui, Add, Text,, Operator?
Gui, Add, Edit, vOperator
Gui, Add, Text,, Uw naam?
Gui, Add, Edit, vNaam
Gui, Add, Button, gCopyLoaNl, CREATE
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyLoaNl(){
global
Gui, Submit, Nohide
CheckOutlook()

Subloanl = Nummeroverdracht___ %Telefoonnummer%___Letter of agreement
Stringloanl = 
(
<p>Beste mevrouw, mijnheer,</p>
<p>&nbsp;</p>
<p>U nam contact met ons op omdat u graag gebruik zou maken van de diensten van Telenet.</p>
<p>&nbsp;</p>
<p>Bij het nakijken van uw contract zijn wij tot de vaststelling gekomen dat de aanvraag van&nbsp;het nummer dat u ons doorgaf, %Telefoonnummer%, werd geweigerd door %Operator%. Om de nummer overdracht te kunnen voltooien dient u ons het document in bijlage, ingevuld terug te bezorgen.</p>
<p>Als dit niet uw nummer is, vragen wij u zo snel mogelijk contact met ons op te nemen op het nummer 015 66 66 66.</p>
<p>&nbsp;</p>
<p>Wij hopen dat wij u hiermee voldoende informatie hebben gegeven.</p>
<p>&nbsp;</p>
<p>Hebt u nog vragen? Neem alvast een kijkje op <a class="external-link" href="http://www.telenet.be/klantenservice" rel="nofollow">www.telenet.be/klantenservice</a>.</p>
<p>U kunt er 24 uur op 24 informatie opzoeken of contact met ons opnemen via een webformulier op <a class="external-link" href="http://www.contact.telenet.be/" rel="nofollow">www.contact.telenet.be</a>.</p>
<p>&nbsp;</p>
<p>Met vriendelijke groeten,</p>
<p>&nbsp;</p>
<p>%Naam%</p>
<p>Telenet Klantendienst</p>
</div>
)
CompMail(Subloanl, Stringloanl, "technischehulp@telenetgroup.be", "", "technischehulp@telenetgroup.be")
return
}


; LOAFR

LoaFr(){
global
Gui, Destroy
Gui, Add, Text,, Telefooonnummer?
Gui, Add, Edit, vTelefoonnummer
Gui, Add, Text,, Operator?
Gui, Add, Edit, vOperator
Gui, Add, Text,, Uw naam?
Gui, Add, Edit, vNaam
Gui, Add, Button, gCopyLoaFr, CREATE
Gui, Add, Button, gClose, CLOSE
Gui, Show
}

CopyLoaFr(){
global
Gui, Submit, Nohide
CheckOutlook()

Subloafr = portage du num&eacute;ro___ %Telefoonnummer%___Letter of agreement
Stringloafr = 
(
<p>Ch&egrave;re Madame, Monsieur,</p>
<p>&nbsp;</p>
<p>Vous avez pris contact avec nous car vous souhaitez utiliser les services de telenet.</p>
<p>&nbsp;</p>
<p>En examinant votre contrat, nous avons constat&eacute;s que la demande pour le num&eacute;ro que vous avez communiqu&eacute;,%Telefoonnummer%, a &eacute;t&eacute; refus&eacute;e par %Operator%. Afin de compl&eacute;ter la portabilit&eacute; de num&eacute;ro, merci de remplir le document en annexe et de le nous retourner.</p>
<p>&nbsp;</p>
<p>Si ceci n&rsquo;est pas votre num&eacute;ro, nous vous demandons de nous contacter au plus vite possible au 015 66 66 66.</p>
<p>&nbsp;</p>
<p>Nous esp&eacute;rons de vous avoir fourni tous les informations n&eacute;cessaires.</p>
<p>&nbsp;</p>
<p>Encore des questions ? Nous vous invitons de visiter <a class="external-link" href="https://www2.telenet.be/fr/serviceclient" rel="nofollow">https://www2.telenet.be/fr/serviceclient</a></p>
<p>&nbsp;</p>
<p>Vous y trouverez des renseignement 24 heures sur 24. Alternativement, vous pouvez nous contacter utilisant le formulaire web sur <a class="external-link" href="http://www.contact.telenet.be/" rel="nofollow">www.contact.telenet.be</a>.</p>
<p>&nbsp;</p>
<p>Bien &agrave; vous,</p>
<p>&nbsp;</p>
<p>%Naam%</p>
<p>Service Client Telenet</p>
)
CompMail(Subloafr, Stringloafr, "technischehulp@telenetgroup.be", "", "technischehulp@telenetgroup.be")
return
}