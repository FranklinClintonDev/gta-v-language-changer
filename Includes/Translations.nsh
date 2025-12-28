; Variables for translations/strings
Var tHeader
Var tMessage
Var bCancel
Var bUpdateClose
Var bUpdateRun
Var tFindError
Var tSteamDefault
Var LSShortcutName

!define tEnglish "English"
!define tFrench "Français (French)"
!define tItalian "Italiano (Italian)"
!define tGerman "Deutsch (German)"
!define tSpanish "Español (Spanish)"
!define tSpanishMex "Español Mexicano (Mexican Spanish)"
!define tPortuguese "Português Brasileiro (Brazilian Portuguese)"
!define tRussian "Русский (Russian)"
!define tPolish "Polski (Polish)"
!define tJapanese "日本語 (Japanese)"
!define tChineseSimp "简体中文 (Simplified Chinese)"
!define tChineseTrad "繁體中文 (Traditional Chinese)"
!define tKorean "한국어 (Korean)"

; Add English Strings
Function AddEnglish
	StrCpy $tHeader "Grand Theft Auto V - Language Select"
	StrCpy $tMessage "Please select the language you would like to use while playing Grand Theft Auto V."
	StrCpy $bCancel "Cancel"
	StrCpy $bUpdateClose "Update and Close"
	StrCpy $bUpdateRun "Update and Run"
	StrCpy $tFindError "Unable to find Grand Theft Auto V install location. Aborting application."
	StrCpy $tSteamDefault "Use language set in Steam"
	StrCpy $LSShortcutName "GTAV Language Switcher"
FunctionEnd

Function un.AddEnglish
FunctionEnd

; Add French Strings
Function AddFrench
	StrCpy $tHeader "Grand Theft Auto V - Sélection de la langue"
	StrCpy $tMessage "Veuillez sélectionner la langue dans laquelle vous souhaitez jouer à Grand Theft Auto V."
	StrCpy $bCancel "Annuler"
	StrCpy $bUpdateClose "Appliquer et fermer"
	StrCpy $bUpdateRun "Appliquer et lancer"
	StrCpy $tFindError "Impossible de trouver l'emplacement d'installation de Grand Theft Auto V. Exécution de l'application annulée."
	StrCpy $tSteamDefault "Utiliser la langue définie dans Steam"
	StrCpy $LSShortcutName "Sélecteur de langue pour GTAV"
FunctionEnd

Function un.AddFrench
FunctionEnd

; Add Italian Strings
Function AddItalian
	StrCpy $tHeader "Grand Theft Auto V - Selezione della lingua"
	StrCpy $tMessage "Seleziona la lingua da usare quando giochi a Grand Theft Auto V."
	StrCpy $bCancel "Annulla"
	StrCpy $bUpdateClose "Aggiorna e chiudi"
	StrCpy $bUpdateRun "Aggiorna e avvia"
	StrCpy $tFindError "Impossibile trovare la cartella di installazione di Grand Theft Auto V. L'applicazione verrà chiusa."
	StrCpy $tSteamDefault "Usa la lingua impostata su Steam"
	StrCpy $LSShortcutName "Selettore lingua GTAV"
FunctionEnd

Function un.AddItalian
FunctionEnd

; Add German Strings
Function AddGerman
	StrCpy $tHeader "Grand Theft Auto V – Sprachauswahl"
	StrCpy $tMessage "Wähle die Sprache, die du in Grand Theft Auto V benutzen möchtest."
	StrCpy $bCancel "Abbrechen"
	StrCpy $bUpdateClose "Aktualisieren und schließen"
	StrCpy $bUpdateRun "Aktualisieren und starten"
	StrCpy $tFindError "Installationsordner für Grand Theft Auto V nicht gefunden. Anwendung wird geschlossen."
	StrCpy $tSteamDefault "In Steam festgelegte Sprache nutzen"
	StrCpy $LSShortcutName "GTAV-Sprachauswahl"
FunctionEnd

Function un.AddGerman
FunctionEnd

; Add Spanish Strings
Function AddSpanish
	StrCpy $tHeader "Grand Theft Auto V - Seleccionar idioma"
	StrCpy $tMessage "Selecciona el idioma que quieras usar mientras juegas a Grand Theft Auto V."
	StrCpy $bCancel "Cancelar"
	StrCpy $bUpdateClose "Actualizar y cerrar"
	StrCpy $bUpdateRun "Actualizar e iniciar"
	StrCpy $tFindError "No se ha podido encontrar la ubicación de la instalación de Grand Theft Auto V. Cancelando aplicación."
	StrCpy $tSteamDefault "Usar idioma utilizado en Steam"
	StrCpy $LSShortcutName "Cambiar idioma en GTA V"
FunctionEnd

Function un.AddSpanish
FunctionEnd

; Add Spanish Mexican Strings
Function AddSpanishMexican
	StrCpy $tHeader "Grand Theft Auto V - Seleccionar idioma"
	StrCpy $tMessage "Selecciona el idioma que quieres usar para jugar Grand Theft Auto V."
	StrCpy $bCancel "Cancelar"
	StrCpy $bUpdateClose "Actualizar y cerrar"
	StrCpy $bUpdateRun "Actualizar y comenzar"
	StrCpy $tFindError "No se pudo localizar la ubicación de la instalación de Grand Theft Auto V. Se cerrará la aplicación."
	StrCpy $tSteamDefault "Usar el idioma utilizado en Steam"
	StrCpy $LSShortcutName "Selector de idioma de GTAV"
FunctionEnd

Function un.AddSpanishMexican
FunctionEnd

; Add Portuguese Strings
Function AddPortuguese
	StrCpy $tHeader "Grand Theft Auto V - Selecionar Língua"
	StrCpy $tMessage "Selecione a língua que você gostaria de usar ao jogar Grand Theft Auto V."
	StrCpy $bCancel "Cancelar"
	StrCpy $bUpdateClose "Atualizar e Fechar"
	StrCpy $bUpdateRun "Atualizar e Jogar"
	StrCpy $tFindError "Não foi possível encontrar o local de instalação do Grand Theft Auto V. Fechando aplicação."
	StrCpy $tSteamDefault "Usar língua definida pelo Steam"
	StrCpy $LSShortcutName "Seletor de Idioma do GTAV"
FunctionEnd

Function un.AddPortuguese
FunctionEnd

; Add Russian Strings
Function AddRussian
	StrCpy $tHeader "Grand Theft Auto V - выбрать язык"
	StrCpy $tMessage "Выберите язык, на котором вы хотите играть в Grand Theft Auto V."
	StrCpy $bCancel "Отменить"
	StrCpy $bUpdateClose "Обновить и закрыть"
	StrCpy $bUpdateRun "Обновить и запустить"
	StrCpy $tFindError "Место установки Grand Theft Auto V не найдено. Приложение будет закрыто."
	StrCpy $tSteamDefault "Использовать языковые настройки Steam"
	StrCpy $LSShortcutName "Переключатель языка GTA V"
FunctionEnd

Function un.AddRussian
FunctionEnd

; Add Polish Strings
Function AddPolish
	StrCpy $tHeader "Grand Theft Auto - wybór języka"
	StrCpy $tMessage "Wybierz język, którego chcesz używać w Grand Theft Auto V."
	StrCpy $bCancel "Anuluj"
	StrCpy $bUpdateClose "Zaktualizuj i zamknij"
	StrCpy $bUpdateRun "Zaktualizuj i graj"
	StrCpy $tFindError "Nie udało się odnaleźć folderu instalacyjnego Grand Theft Auto V. Wyłączanie aplikacji."
	StrCpy $tSteamDefault "Użyj języka wybranego dla Steam"
	StrCpy $LSShortcutName "Narzędzie wyboru języka GTA V"
FunctionEnd

Function un.AddPolish
FunctionEnd

; Add Japanese Strings
Function AddJapanese
	StrCpy $tHeader "『グランド・セフト・オートV』言語選択"
	StrCpy $tMessage "『グランド・セフト・オートV』で使用する言語を選択してください。"
	StrCpy $bCancel "キャンセルする"
	StrCpy $bUpdateClose "アップデートして閉じる"
	StrCpy $bUpdateRun "アップデートして起動する"
	StrCpy $tFindError "『グランド・セフト・オートV』のインストール場所が見つかりません。適用を中断します。"
	StrCpy $tSteamDefault "Steamでの設定言語を使用する"
	StrCpy $LSShortcutName "「GTA V」言語切り替え"
FunctionEnd

Function un.AddJapanese
FunctionEnd

; Add Chinese Simple Strings
Function AddChineseSimp
	StrCpy $tHeader "Grand Theft Auto V - 语言选项"
	StrCpy $tMessage "请选择您在玩 Grand Theft Auto V 时显示的语言"
	StrCpy $bCancel "取消"
	StrCpy $bUpdateClose "更新及关闭游戏"
	StrCpy $bUpdateRun "更新及运行游戏"
	StrCpy $tFindError "无法找到 Grand Theft Auto V 的安装位置。终止运行。"
	StrCpy $tSteamDefault "使用 Steam 的语言设置"
	StrCpy $LSShortcutName "GTA 5 语言切换器"
FunctionEnd

Function un.AddChineseSimp
FunctionEnd

; Add Chinese Trad Strings
Function AddChineseTrad
	StrCpy $tHeader "Grand Theft Auto V - 選擇語言"
	StrCpy $tMessage "請選擇您想要在遊玩 Grand Theft Auto V 時顯示的語言"
	StrCpy $bCancel "取消"
	StrCpy $bUpdateClose "更新及關閉遊戲"
	StrCpy $bUpdateRun "更新及執行遊戲"
	StrCpy $tFindError "無法找到 Grand Theft Auto V 的安裝位置。執行失敗。"
	StrCpy $tSteamDefault "使用在 Steam 的語言設定"
	StrCpy $LSShortcutName "GTA 5 語言轉換工具"
FunctionEnd

Function un.AddChineseTrad
FunctionEnd

; Add Korean Trad Strings
Function AddKorean
	StrCpy $tHeader "Grand Theft Auto V - 언어 선택"
	StrCpy $tMessage "Grand Theft Auto V를 플레이할 때 사용할 언어를 선택하십시오."
	StrCpy $bCancel "취소"
	StrCpy $bUpdateClose "업데이트 후 닫기"
	StrCpy $bUpdateRun "업데이트 후 시작"
	StrCpy $tFindError "Grand Theft Auto V가 설치된 위치를 찾을 수 없습니다. 응용 프로그램을 중단합니다."
	StrCpy $tSteamDefault "스팀에서 언어 설정하기"
	StrCpy $LSShortcutName "GTAV 언어 변경"
FunctionEnd

Function un.AddKorean
FunctionEnd
