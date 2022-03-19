#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#MaxThreadsPerHotkey 3
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
setmousedelay -1
setbatchlines -1


msgbox, Como usar? `n1º) Posicione a tela do jogo e depois pressione`n `n F9 para identificar posição das setas (deve utilizar somente quando não tiver ninguem sobre as setas) `n`n Depois de configurado usar teclas de seta do teclado! `n`n`n`n F3 -> Encerrar programa `n`n`n`n Criado por https://github.com/gabm8/ `n Versão: 1.0.3
return


;Comando de clicar ao teclar setas
Up::
	Click, %FoundX3%, %FoundY3% Left, 1
return

Down::
	Click, %FoundX4%, %FoundY4% Left, 1
return

Left::
	Click, %FoundX1%, %FoundY1% Left, 1
return

Right::
	Click, %FoundX2%, %FoundY2% Left, 1
return


;Calibrar posicao setas
F9::

CoordMode, Pixel, Window


Loop, 10
{
	ImageSearch, FoundX1, FoundY1, 0, 0, 1920, 1080, %A_ScriptDir%\seta_(1).png
	CenterImgSrchCoords("%A_ScriptDir%\seta_(1).png", FoundX1, FoundY1)
}
Until ErrorLevel = 0

Loop, 10
{
	ImageSearch, FoundX2, FoundY2, 0, 0, 1920, 1080, %A_ScriptDir%\seta_(2).png
	CenterImgSrchCoords("%A_ScriptDir%\seta_(2).png", FoundX2, FoundY2)
}
Until ErrorLevel = 0

Loop, 10
{
	ImageSearch, FoundX3, FoundY3, 0, 0, 1920, 1080, %A_ScriptDir%\seta_(3).png
	CenterImgSrchCoords("%A_ScriptDir%\seta_(3).png", FoundX3, FoundY3)
}
Until ErrorLevel = 0

Loop, 10
{
	ImageSearch, FoundX4, FoundY4, 0, 0, 1920, 1080, %A_ScriptDir%\seta_(4).png
	CenterImgSrchCoords("%A_ScriptDir%\seta_(4).png", FoundX4, FoundY4)
}
Until ErrorLevel = 0

msgbox,,, Posição das setas automaticamente configurado para: `n %FoundX1%, %FoundY1% `n %FoundX2%, %FoundY2% `n %FoundX3%, %FoundY3% `n %FoundX4%, %FoundY4%

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
