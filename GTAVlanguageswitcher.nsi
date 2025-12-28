; GreenSoupDev was here.
Unicode true													; Using Unicode stuff
SetCompressor /SOLID lzma 										;Set compressor

; --------- Includes ----------
!include nsDialogs.nsh
!include MUI2.nsh
!include FileFunc.nsh
!include LogicLib.nsh
!include nsProcess.nsh
!include WordFunc.nsh
!include "Includes\Translations.nsh"

; --------- Installer Info -------
!define MUI_ICON 			"Images\GTAV.ico"																	; Installer Icon
!define regMAINKEY 			"Software\Rockstar Games\Grand Theft Auto V\"
!define regMAINKEYLS		"Software\Rockstar Games\GTAV Language Switcher\"
!define regMAINKEYSTEAM		"Software\Rockstar Games\Grand Theft Auto V Steam\"
!define regLAUNCHERKEY		"InstallFolder"
!define regLANGUAGEKEY		"Language"
!define regVERSIONKEY		"Version"
!define nonSteamLauncher	"GTAVLauncher.exe"
!define steamLauncher		"GTAVLauncher.exe"
!define vSteamLoad			0  ; 0 = non-steam version / 1 = steam version

; Version Info
VIProductVersion "1.0.0.3"
VIAddVersionKey /LANG=1033 "ProductName" "GTA V Language Select"
VIAddVersionKey /LANG=1033 "Comments" "GTA V Language Select (CRACKED)"
VIAddVersionKey /LANG=1033 "CompanyName" "Rockstar Games."
VIAddVersionKey /LANG=1033 "LegalTrademarks" "(C) Rockstar Games. All rights reserved"
VIAddVersionKey /LANG=1033 "LegalCopyright" "(C) Rockstar Games. All rights reserved"
VIAddVersionKey /LANG=1033 "FileDescription" "GTA V Language Select"
VIAddVersionKey /LANG=1033 "FileVersion" "1.0.0.3"

Name "GTAVLanguageSelect"									; Set name of the installer
OutFile "GTAVLanguageSelect.exe"						; Set build folder and name 
RequestExecutionLevel admin										; Request application privileges for Windows Vista




; --------- Variables ---------
Var hPageDialog
Var txtConfirm
Var cmbLangSelect
Var btnCancel
Var btnUpdateAndClose
Var btnUpdateAndRun
Var vGameInstallFolder
Var vBootLanguage
Var vSelectedLanguage
Var vSelectedLanguageCode
Var vSteamLanguage


; Language Codes
!define lcEnglish 			"en-US"
!define lcGerman			"de-DE"
!define lcFrench			"fr-FR"
!define lcItalian			"it-IT"
!define lcSpanish			"es-ES"
!define lcSpanishMex		"es-MX"
!define lcJapanese			"ja-JP"
!define lcChineseTrad		"zh-CHT"
!define lcChineseSimp		"zh-CHS"
!define lcRussian			"ru-RU"
!define lcPolish			"pl-PL"
!define lcPortuguese		"pt-BR"	
!define lcKorean			"ko-KR"



; Visuals
!define fHeaderSize 		16		
!define fSubHeaderSize 		14
!define fStandardSize		12
!define fSmallSize			10
!define fFont 				"HelveticaNeueW02-55"
!define fBold 				700
!define fStandard 			400
!define cTransparent 		Transparent
!define cAcceptButtonBG 	0xFCBE43
!define cWhite 				0xFFFFFF
!define cBlack 				0x000000
!define cRed 				0xff0000
!define cGreen 				0x00aa00
!define cGrey				0xaaaaaa
!define cCancelButtonFont 	0x504B45
!define SWP_NOSIZE 			0x0001
!define SWP_NOMOVE 			0x0002 
!define MAX_STRLENGTH		200
!define MAX_STRLENGTHLIB	180

; Overwrite some stuff. 
!define MUI_CUSTOMFUNCTION_GUIINIT MyGUIInit


; -------- Languages -------- ; Note: For some fucked reason adding this removes borders from buttons. This system is mental!
!insertmacro MUI_LANGUAGE "English"

; Change UI to use the custom one we've built. 
ChangeUI all "${NSISDIR}\Contrib\UIs\langselect.exe"

; PAGES
Page custom languageSelect
Page custom closeSelect

; ------ MACROS -------

; Setup Font Settings and Text in Custom Control
!macro ApplyTextAndFontToControl CONTROL FONT SIZE WEIGHT TEXTCOLOR BACKCOLOR TEXT
	CreateFont $R1 "${FONT}" ${SIZE} ${WEIGHT}
	SendMessage ${CONTROL} ${WM_SETFONT} $R1 0
	SendMessage ${CONTROL} ${WM_SETTEXT} 0 "STR:${TEXT}"
	SetCtlColors ${CONTROL} ${TEXTCOLOR} ${BACKCOLOR}
!macroend

; Setup Font Settings in Custom Control
!macro ApplyFontToControl CONTROL FONT SIZE WEIGHT TEXTCOLOR BACKCOLOR
	CreateFont $R1 "${FONT}" ${SIZE} ${WEIGHT}
	SendMessage ${CONTROL} ${WM_SETFONT} $R1 0
	SetCtlColors ${CONTROL} ${TEXTCOLOR} ${BACKCOLOR}
!macroend

; Setup Font setings in custom control with italics
!macro ApplyFontToControlItalic CONTROL FONT SIZE WEIGHT TEXTCOLOR BACKCOLOR
	CreateFont $R1 "${FONT}" ${SIZE} ${WEIGHT} /ITALIC
	SendMessage ${CONTROL} ${WM_SETFONT} $R1 0
	SetCtlColors ${CONTROL} ${TEXTCOLOR} ${BACKCOLOR}
!macroend

!macro GET_STRING_TOKEN INPUT PART
  Push $R0
  Push $R1
  Push $R2
 
; R0 = indice di scorrimento stringa
; R0 = index of current position in the string
  StrCpy 	$R0 -1
; R1 = indice del carattere " da trovare
; R1 = index of '"' character to be found
  IntOp  	$R1 ${PART} * 2
  IntOp  	$R1 $R1 - 1
 
; cerco il " che indica l'inizio della sottostringa di interesse
; searching '"' character beginning the sub-string
findStart_loop_${PART}:						
 
  IntOp  	$R0 $R0 + 1 					; i++
  StrCpy	$R2 ${INPUT} 1 $R0				; getting next character
  StrCmp 	$R2 "" error_${PART}
  StrCmp 	$R2 '"' 0 findStart_loop_${PART}
 
  IntOp 	$R1 $R1 - 1
  IntCmp 	$R1 0 0 0 findStart_loop_${PART}		
 
; salvo in R1 l'indice di inizio della sottostringa di interesse
; storing in R1 the index beginning the sub-string
  IntOp 	$R1 $R0 + 1
 
; cerco il " successivo, che indica la fine della stringa di interesse
; searching '"' character ending the sub-string
findEnd_loop_${PART}:						
  IntOp  	$R0 $R0 + 1 					; i++
  StrCpy	$R2 ${INPUT} 1 $R0				; getting next character
  StrCmp 	$R2 "" error_${PART}
  StrCmp 	$R2 '"' 0 findEnd_loop_${PART}
 
; R0 = indice di fine della sottostringa di interesse
; R0 = the index ending the sub-string
  IntOp 	$R0 $R0 - $R1					
; salvo in R0 la lunghezza della sottostringa di interesse
; storing in R0 the sub-string's length
  StrCpy 	$R0 ${INPUT} $R0 $R1
  Goto 		done_${PART}
 
 
error_${PART}:
  StrCpy 	$R0 error
 
 
done_${PART}:
  Pop 		$R2
  Pop 		$R1
  Exch 		$R0
!macroend

; Open link
Function openLinkNewWindow
  Push $3
  Exch
  Push $2
  Exch
  Push $1
  Exch
  Push $0
  Exch
 
  ReadRegStr $0 HKCR "http\shell\open\command" ""
# Get browser path
    DetailPrint $0
  StrCpy $2 '"'
  StrCpy $1 $0 1
  StrCmp $1 $2 +2 # if path is not enclosed in " look for space as final char
    StrCpy $2 ' '
  StrCpy $3 1
  loop:
    StrCpy $1 $0 1 $3
    DetailPrint $1
    StrCmp $1 $2 found
    StrCmp $1 "" found
    IntOp $3 $3 + 1
    Goto loop
 
  found:
    StrCpy $1 $0 $3
    StrCmp $2 " " +2
      StrCpy $1 '$1"'
 
  Pop $0
  Exec '$1 $0'
  Pop $0
  Pop $1
  Pop $2
  Pop $3
FunctionEnd
 
!macro _OpenURL URL
Push "${URL}"
Call openLinkNewWindow
!macroend
 
!define OpenURL '!insertmacro "_OpenURL"'

; ------- Functions --------

; StrContains
Var STR_HAYSTACK
Var STR_NEEDLE
Var STR_CONTAINS_VAR_1
Var STR_CONTAINS_VAR_2
Var STR_CONTAINS_VAR_3
Var STR_CONTAINS_VAR_4
Var STR_RETURN_VAR
 
Function StrContains
  Exch $STR_NEEDLE
  Exch 1
  Exch $STR_HAYSTACK
  ; Uncomment to debug
  ;MessageBox MB_OK 'STR_NEEDLE = $STR_NEEDLE STR_HAYSTACK = $STR_HAYSTACK '
    StrCpy $STR_RETURN_VAR ""
    StrCpy $STR_CONTAINS_VAR_1 -1
    StrLen $STR_CONTAINS_VAR_2 $STR_NEEDLE
    StrLen $STR_CONTAINS_VAR_4 $STR_HAYSTACK
    loop:
      IntOp $STR_CONTAINS_VAR_1 $STR_CONTAINS_VAR_1 + 1
      StrCpy $STR_CONTAINS_VAR_3 $STR_HAYSTACK $STR_CONTAINS_VAR_2 $STR_CONTAINS_VAR_1
      StrCmp $STR_CONTAINS_VAR_3 $STR_NEEDLE found
      StrCmp $STR_CONTAINS_VAR_1 $STR_CONTAINS_VAR_4 done
      Goto loop
    found:
      StrCpy $STR_RETURN_VAR $STR_NEEDLE
      Goto done
    done:
   Pop $STR_NEEDLE ;Prevent "invalid opcode" errors and keep the
   Exch $STR_RETURN_VAR  
FunctionEnd
 
!macro _StrContainsConstructor OUT NEEDLE HAYSTACK
  Push `${HAYSTACK}`
  Push `${NEEDLE}`
  Call StrContains
  Pop `${OUT}`
!macroend
 
!define StrContains '!insertmacro "_StrContainsConstructor"'

; Cancel Process
Function LangChangeCancel
	SendMessage $HwndParent ${WM_CLOSE} 0 0
FunctionEnd

; Update and close
Function LangChangeUpdateAndClose
	Call SetupSelectedLanguageSelect
	Call SaveLanguageInfo
	SendMessage $HwndParent ${WM_CLOSE} 0 0
FunctionEnd

; Update and Run
Function LangChangeUpdateAndRunGame
	Call SetupSelectedLanguageSelect
	Call SaveLanguageInfo
	Call RunProgram
	SendMessage $HwndParent ${WM_CLOSE} 0 0
FunctionEnd

; Read a line from file
Function ReadLineFromFile
Exch $0 ;file
Exch
Exch $1 ;line number
Push $2
Push $3
 
  FileOpen $2 $0 r
 StrCpy $3 0
 
Loop:
 IntOp $3 $3 + 1
  ClearErrors
  FileRead $2 $0
  IfErrors +2
 StrCmp $3 $1 0 loop
  FileClose $2
 
Pop $3
Pop $2
Pop $1
Exch $0
FunctionEnd

; Get Parent
Function GetParent
 
  Exch $R0
  Push $R1
  Push $R2
  Push $R3
 
  StrCpy $R1 0
  StrLen $R2 $R0
 
  loop:
    IntOp $R1 $R1 + 1
    IntCmp $R1 $R2 get 0 get
    StrCpy $R3 $R0 1 -$R1
    StrCmp $R3 "\" get
  Goto loop
 
  get:
    StrCpy $R0 $R0 -$R1
 
    Pop $R3
    Pop $R2
    Pop $R1
    Exch $R0
 
FunctionEnd

; Run Program
Function RunProgram
	${if} ${vSteamLoad} == 1
		Exec '"Explorer" steam://rungameid/271590'
	${else}
		Exec '"${nonSteamLauncher}"'
	${endif}
FunctionEnd

; Save languge info
Function SaveLanguageInfo
	${if} ${vSteamLoad} == 1
		${if} $vSelectedLanguage != $tSteamDefault
			WriteRegStr HKLM "${regMAINKEYSTEAM}" "${regLANGUAGEKEY}" "$vSelectedLanguageCode"
		${else}
			DeleteRegValue HKLM "${regMAINKEYSTEAM}" "${regLANGUAGEKEY}"
		${endif}
	${else}
		WriteRegStr HKLM "${regMAINKEYLS}" "${regLANGUAGEKEY}" "$vSelectedLanguageCode" ; Save the backup language info for this. 
		WriteRegStr HKLM "${regMAINKEY}" "${regLANGUAGEKEY}" "$vSelectedLanguageCode"
	${endif}
FunctionEnd

; Setup the language the user has selected. 
Function SetupSelectedLanguageSelect
	${NSD_GetText} $cmbLangSelect $1
	StrCpy $vSelectedLanguage $1
	
	${if} $vSelectedLanguage == "${tEnglish}"
		StrCpy $vSelectedLanguageCode "${lcEnglish}"
	${ElseIf} $vSelectedLanguage == "${tFrench}"
		StrCpy $vSelectedLanguageCode "${lcFrench}"
	${ElseIf} $vSelectedLanguage == "${tItalian}"
		StrCpy $vSelectedLanguageCode "${lcItalian}"
	${ElseIf} $vSelectedLanguage == "${tSpanish}"
		StrCpy $vSelectedLanguageCode "${lcSpanish}"
	${ElseIf} $vSelectedLanguage == "${tGerman}"
		StrCpy $vSelectedLanguageCode "${lcGerman}"
	${ElseIf} $vSelectedLanguage == "${tJapanese}"
		StrCpy $vSelectedLanguageCode "${lcJapanese}"
	${ElseIf} $vSelectedLanguage == "${tRussian}"
		StrCpy $vSelectedLanguageCode "${lcRussian}"
	${ElseIf} $vSelectedLanguage == "${tPolish}"
		StrCpy $vSelectedLanguageCode "${lcPolish}"
	${ElseIf} $vSelectedLanguage == "${tPortuguese}"
		StrCpy $vSelectedLanguageCode "${lcPortuguese}"
	${ElseIf} $vSelectedLanguage == "${tKorean}"
		StrCpy $vSelectedLanguageCode "${lcKorean}"
	${ElseIf} $vSelectedLanguage == "${tChineseTrad}"
		StrCpy $vSelectedLanguageCode "${lcChineseTrad}"
	${ElseIf} $vSelectedLanguage == "${tChineseSimp}"
		StrCpy $vSelectedLanguageCode "${lcChineseSimp}"
	${ElseIf} $vSelectedLanguage == "${tSpanishMex}"
		StrCpy $vSelectedLanguageCode "${lcSpanishMex}"
	${ElseIf} $vSelectedLanguage == "$tSteamDefault"
		StrCpy $vSelectedLanguageCode "NA"
	${Else}
		StrCpy $vSelectedLanguageCode "${lcEnglish}"
	${EndIf}

FunctionEnd

; Setup Steam language
Function SetupSteamLanguage
	; Set english as default if we can't find or read the steam file.
	StrCpy $LANGUAGE "${lcEnglish}"

	; Get current working dir. 
	System::Call "kernel32::GetCurrentDirectory(i ${NSIS_MAX_STRLEN}, t .r0)"

	; Get location of where the file is stored. 
	Push $0
	Call GetParent
	Pop $1
	Push $1
	Call GetParent
	Pop $2

	; Do file exists check...
	IfFileExists "$2\appmanifest_271590.acf" 0 moveon

	; File Exists, read it in and see what we have on line 19...
	Push 19 ;Line to read
	Push "$2\appmanifest_271590.acf"
	Call ReadLineFromFile
	Pop $vSteamLanguage
	
	; Search the string and see if we have language info
	${StrContains} $0 "language" $vSteamLanguage
	${if} $0 == ""
		Goto moveon
	${EndIf}
	
	; Now get the selected language from the string. 
	!insertmacro GET_STRING_TOKEN $vSteamLanguage 2
	Pop $vSteamLanguage
	
	${if} $vSteamLanguage == "english"
		StrCpy $LANGUAGE "${lcEnglish}"
	${elseif} $vSteamLanguage == "german"
		StrCpy $LANGUAGE "${lcGerman}"
	${elseif} $vSteamLanguage == "french"
		StrCpy $LANGUAGE "${lcFrench}"
	${elseif} $vSteamLanguage == "italian"
		StrCpy $LANGUAGE "${lcItalian}"
	${elseif} $vSteamLanguage == "koreana"
		StrCpy $LANGUAGE "${lcKorean}"
	${elseif} $vSteamLanguage == "spanish"
		StrCpy $LANGUAGE "${lcSpanish}"
	${elseif} $vSteamLanguage == "tchinese"
		StrCpy $LANGUAGE "${lcChineseTrad}"
	${elseif} $vSteamLanguage == "russian"
		StrCpy $LANGUAGE "${lcRussian}"
	${elseif} $vSteamLanguage == "japanese"
		StrCpy $LANGUAGE "${lcJapanese}"
	${elseif} $vSteamLanguage == "polish"
		StrCpy $LANGUAGE "${lcPolish}"
	${elseif} $vSteamLanguage == "brazilian"
		StrCpy $LANGUAGE "${lcPortuguese}"
	${elseif} $vSteamLanguage == "schinese"
		StrCpy $LANGUAGE "${lcChineseSimp}"
	${else}
		StrCpy $LANGUAGE "${lcEnglish}"
	${endif}
		
	moveon:

FunctionEnd

; Set the language file
Function SetLanguageStrings
${SWITCH} $LANGUAGE
	${Case} "${lcEnglish}"
		Call AddEnglish   
		StrCpy $vBootLanguage "${tEnglish}"
		${Break}
	${Case} "${lcFrench}"
		Call AddFrench    
		StrCpy $vBootLanguage "${tFrench}" 		
		${Break}
	${Case} "${lcItalian}"
		Call AddItalian   	
		StrCpy $vBootLanguage "${tItalian}" 
		${Break}
	${Case} "${lcSpanish}"
	   Call AddSpanish 
		StrCpy $vBootLanguage "${tSpanish}"   	   
		${Break}
	${Case} "${lcGerman}"
		Call AddGerman 
		StrCpy $vBootLanguage "${tGerman}" 
		${Break}
	${Case} "${lcJapanese}"
		Call AddJapanese 
		StrCpy $vBootLanguage "${tJapanese}" 		
		${Break}
	${Case} "${lcRussian}"
		Call AddRussian  
		StrCpy $vBootLanguage "${tRussian}" 		
		${Break}
	${Case} "${lcPolish}"
		Call AddPolish 
		StrCpy $vBootLanguage "${tPolish}" 		
		${Break}
	${Case} "${lcPortuguese}"
		Call AddPortuguese  
		StrCpy $vBootLanguage "${tPortuguese}" 		
		${Break}
	${Case} "${lcKorean}"
		Call AddKorean  
		StrCpy $vBootLanguage "${tKorean}" 
		${Break}
	${Case} "${lcChineseTrad}"
		Call AddChineseTrad 
		StrCpy $vBootLanguage "${tChineseTrad}" 		
		${Break}
	${Case} "${lcChineseSimp}"
		Call AddChineseSimp 	
		StrCpy $vBootLanguage "${tChineseSimp}" 
		${Break}
	${Case} "${lcSpanishMex}"
		Call AddSpanishMexican 	
		StrCpy $vBootLanguage "${tSpanishMex}" 
		${Break}
	;${Case} "SteamMode"
	;	Call AddEnglish 	
	;	StrCpy $vBootLanguage "$tSteamDefault" 
	;	${Break}
	${Default}
		Call AddEnglish 	
		StrCpy $vBootLanguage "${tEnglish}" 
		${Break}
${EndSwitch}
FunctionEnd

; Get System Language
Function SysLang
  Push $0
 
  System::Alloc "${NSIS_MAX_STRLEN}"
  Pop $0
 
  ;uses LOCALE_SYSTEM_DEFAULT and LOCALE_SLANGUAGE defines
 
  System::Call "Kernel32::GetLocaleInfo(i,i,t,i)i(2048,0x2,.r0,${NSIS_MAX_STRLEN})i"
 
  Exch $0
FunctionEnd

; --------- Initilize ---------
Function .onInit

	${if} ${vSteamLoad} == 1	
		; Read in stored language if we have one. 
		ReadRegStr $R7 HKLM "${regMAINKEYSTEAM}" "${regLANGUAGEKEY}"
		${If} $R7 == ""
			StrCpy $LANGUAGE "SteamMode"
			
		${Else}
			StrCpy $LANGUAGE "$R7"
		${EndIf}
	${else}
		; Read in stored language if we have one. 
		ReadRegStr $R7 HKLM "${regMAINKEY}" "${regLANGUAGEKEY}"
		${If} $R7 == ""
			; Can't find GTAV language, so revert to LS language
			ReadRegStr $R8 HKLM "${regMAINKEYLS}" "${regLANGUAGEKEY}"
			${If} $R8 == ""
				; Cant find LS language, revert to english
				StrCpy $LANGUAGE "en-US"
			${Else}
				StrCpy $LANGUAGE "$R8"
			${EndIf}
		${Else}
			StrCpy $LANGUAGE "$R7"
		${EndIf}
	${EndIf}
	
	; If steam version work out what Steam is set to and display in that language.
	${if} $LANGUAGE == "SteamMode"
		Call SetupSteamLanguage
		Call SetLanguageStrings 	; Load strings
		StrCpy $vBootLanguage "$tSteamDefault" 
	${else}
		Call SetLanguageStrings 	; Load strings
	${endif}
	
	; If we've not in Steam mode, check we have the game installed.
	${if} ${vSteamLoad} == 0
		; Read in Launcher install location
		ReadRegStr $R9 HKLM "${regMAINKEY}" "${regLAUNCHERKEY}"
		${If} $R9 == ""
			Call SetLanguageStrings 	; Load strings
			WriteRegStr HKLM "${regMAINKEY}" "${regLANGUAGEKEY}" "$vSelectedLanguageCode"
			WriteRegStr HKLM "${regMAINKEY}" "${regLAUNCHERKEY}" "C:\Program Files\Rockstar Games\Grand Theft Auto V"
			WriteRegStr HKLM "${regMAINKEY}" "${regVERSIONKEY}" "1.0.3274.0"
		    ; tFindError thing here
		${Else}
			StrCpy $vGameInstallFolder "$R9"
		${EndIf}
	${EndIf}

	FunctionEnd

; ------- On GUI Show ---------
Function MyGUIInit
FunctionEnd

; ------- Language Page -------
Function languageSelect
	SendMessage $HWNDPARENT ${WM_SETTEXT} 0 "STR:$tHeader"
	nsDialogs::Create 1018
	Pop $hPageDialog

	; Confirm Button Text
	${NSD_CreateLabel} 10 10 95% 40 "$tMessage"
	Pop $txtConfirm
	!insertmacro ApplyFontToControl $txtConfirm ${fFont} ${fSmallSize} ${fStandard} ${cBlack} ${cTransparent}
	
	${NSD_CreateCombobox} 30 50 85% 20 ""
	Pop $cmbLangSelect
	${if} ${vSteamLoad} == 1
		${NSD_CB_AddString} $cmbLangSelect "$tSteamDefault"
	${endif}
	
	${NSD_CB_AddString} $cmbLangSelect "${tEnglish}"
	${NSD_CB_AddString} $cmbLangSelect "${tFrench}"
	${NSD_CB_AddString} $cmbLangSelect "${tItalian}"
	${NSD_CB_AddString} $cmbLangSelect "${tGerman}"
	${NSD_CB_AddString} $cmbLangSelect "${tSpanish}"
	${NSD_CB_AddString} $cmbLangSelect "${tSpanishMex}"
	${NSD_CB_AddString} $cmbLangSelect "${tPortuguese}"
	${NSD_CB_AddString} $cmbLangSelect "${tRussian}"
	${NSD_CB_AddString} $cmbLangSelect "${tPolish}"
	${NSD_CB_AddString} $cmbLangSelect "${tJapanese}"
	${NSD_CB_AddString} $cmbLangSelect "${tChineseSimp}"
	${NSD_CB_AddString} $cmbLangSelect "${tChineseTrad}"
	${NSD_CB_AddString} $cmbLangSelect "${tKorean}"
	${NSD_CB_SelectString} $cmbLangSelect $vBootLanguage
	;${NSD_OnChange} $cmbLangSelect SelectSelectedLanguage
	
	; Cancel
	${NSD_CreateButton} 10 85 135 22 "$bCancel"
	Pop $btnCancel
	${NSD_OnClick} $btnCancel LangChangeCancel
	
	; Update and Close
	${NSD_CreateButton} 150 85 135 22 "$bUpdateClose"
	Pop $btnUpdateAndClose
	${NSD_OnClick} $btnUpdateAndClose LangChangeUpdateAndClose
	
	; Update and Run
	${NSD_CreateButton} 290 85 135 22 "$bUpdateRun"
	Pop $btnUpdateAndRun
	${NSD_OnClick} $btnUpdateAndRun LangChangeUpdateAndRunGame
	
	nsDialogs::Show

FunctionEnd

; ------- Language Page -------
Function closeSelect
	Abort
FunctionEnd

; Section
Section 

SectionEnd