#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#MaxThreadsPerHotkey 10
#Persistent
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
setmousedelay -1
setbatchlines -1

	; Testar arquivos
	IfNotExist, %A_ScriptDir%\seta_(1).png
	{
		MsgBox, Erro: Aquivos seta(1).png não encontrado na pasta!
		exitapp
	}
	IfNotExist, %A_ScriptDir%\seta_(2).png
	{
		MsgBox, Erro: Aquivos seta(2).png não encontrado na pasta!
		exitapp
	}
	IfNotExist, %A_ScriptDir%\seta_(3).png
	{
		MsgBox, Erro: Aquivos seta(3).png não encontrado na pasta!
		exitapp
	}
	IfNotExist, %A_ScriptDir%\seta_(4).png
	{
		MsgBox, Erro: Aquivos seta(4).png não encontrado na pasta!
		exitapp
	}

	Screen_X = %A_ScreenWidth%
    Screen_Y = %A_ScreenHeight%
	
	if ((Screen_X=0) or (Screen_Y=0)){
		msgbox, Erro: Não foi possivel determinar resolução da tela!.
		exitapp
	}


	erro=-1

	goto, GuiOpen
return


;Comando de clicar ao teclar setas
Up::
	if erro=0
		Click, %FoundX3%, %FoundY3% Left, 1
	Else
		msgbox,,, Primeiro calibre apertando F9!,3
return

Down::
	if erro=0
		Click, %FoundX4%, %FoundY4% Left, 1
	Else
		msgbox,,, Primeiro calibre apertando F9!,3
return

Left::
	if erro=0
		Click, %FoundX1%, %FoundY1% Left, 1
	Else
		msgbox,,, Primeiro calibre apertando F9!,3
return

Right::
	if erro=0
		Click, %FoundX2%, %FoundY2% Left, 1
	Else
		msgbox,,, Primeiro calibre apertando F9!,3
return


;Calibrar posicao setas
F9::

	CoordMode, Pixel, Window
	Loop, 2
	{
		ImageSearch, FoundX1, FoundY1, 0, 0, Screen_X, Screen_Y, %A_ScriptDir%\seta_(1).png
		CenterImgSrchCoords("%A_ScriptDir%\seta_(1).png", FoundX1, FoundY1)
	}
	Until ErrorLevel = 0

	Loop, 2
	{
		ImageSearch, FoundX2, FoundY2, 0, 0, Screen_X, Screen_Y, %A_ScriptDir%\seta_(2).png
		CenterImgSrchCoords("%A_ScriptDir%\seta_(2).png", FoundX2, FoundY2)
	}
	Until ErrorLevel = 0

	Loop, 2
	{
		ImageSearch, FoundX3, FoundY3, 0, 0, Screen_X, Screen_Y, %A_ScriptDir%\seta_(3).png
		CenterImgSrchCoords("%A_ScriptDir%\seta_(3).png", FoundX3, FoundY3)
	}
	Until ErrorLevel = 0

	Loop, 2
	{
		ImageSearch, FoundX4, FoundY4, 0, 0, Screen_X, Screen_Y, %A_ScriptDir%\seta_(4).png
		CenterImgSrchCoords("%A_ScriptDir%\seta_(4).png", FoundX4, FoundY4)
		FoundX4:= FoundX4+28
	}
	Until ErrorLevel = 0


	if (FoundX1=0 or FoundY1=0 or FoundX2=0 or FoundY2=0 or FoundX3=0 or FoundY3=0 or FoundX4=0 or FoundY4=0)
	{
		erro=1
		msgbox, Erro: não foi possivel localizar seta vazia na tela! Apertar F9 apenas quando não tiver ninguem jogando!`n`n`n Posições encontradas ou não: `n %FoundX1%, %FoundY1% `n %FoundX2%, %FoundY2% `n %FoundX3%, %FoundY3% `n %FoundX4%, %FoundY4%
	}
	else
	{
		erro=0
		msgbox,,, Posição das setas automaticamente configurado para: `n %FoundX1%, %FoundY1% `n %FoundX2%, %FoundY2% `n %FoundX3%, %FoundY3% `n %FoundX4%, %FoundY4%
	}


return


;Finalizar app
F3::
exitapp


CenterImgSrchCoords(File, ByRef CoordX, ByRef CoordY)
{
	static LoadedPic
	LastEL := ErrorLevel

	Gui, Pict:Add, Pic, vLoadedPic, % RegExReplace(File, "^(\*\w+\s)+")
	GuiControlGet, LoadedPic, Pict:Pos
	Gui, Pict:Destroy
	CoordX += LoadedPicW // 2
	CoordY += LoadedPicH // 2
	ErrorLevel := LastEL
}


GuiOpen:
	Gui, Add, Text, x32 y49 w410 h270 , Como usar? `n1º) Posicione a tela do jogo e depois pressione`n `n F9 para identificar posição das setas (deve utilizar somente quando não tiver ninguem sobre as setas) `n`n Depois de configurado`, usar teclas de seta do teclado! `n`n------------------------------`n          >>> EM FUNCIONAMENTO <<<`n`nPara encerrar programa aperte F3 ou feche esta janela`n------------------------------`n`n`n Criado por https://github.com/gabm8/ `n Versão: 1.0.7`n`nResolução do monitor: %Screen_X%x%Screen_Y%
	; Generated using SmartGUI Creator 4.0
	Gui, Show, x186 y127 h379 w479, Macro para Snake Habbo
Return

GuiClose:
	ExitApp
return