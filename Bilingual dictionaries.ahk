#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;------------------------------------------------------------------------------
;Scripts de AutoHotkey para Búsquedas masivas, por Pablo Siredey
;------------------------------------------------------------------------------
#IfWinActive ahk_exe firefox.exe

DictionaryLookup(url)
{
    Array := []
    count := 0
    MsgBox % "Vamos a buscar el termino " . element . " en " . url
    Send , {Enter}
    Sleep , 400
    clipboard := "" ; Se deja vacío el portapapeles
    Send , ^r
    Sleep , 200
    Send , !d
    Sleep , 500
    Send , ^c
    ClipWait  ; Wait for the clipboard to contain text.
    Sleep , 200
    MsgBox Se buscó el término:`n`n%clipboard%
    url := clipboard
    Sleep , 1000
    Send , ^u
    Sleep , 300
    Send , ^s
    Sleep , 8000
    Send , !d
    Sleep , 400
    Send , {Blind}{Text}https://colab.research.google.com/drive/1xF0O5RIQQSfhLq3FrQ0wyuzcvB5Y7m-1#scrollTo=01gcEN1akb8d

    
}
;------------------------------------------------------------------------------
;Buscar términos de un arreglo (Array) en Collins Dictionary y descargar código htm para pasar a Colab
;------------------------------------------------------------------------------

::Collins:: ;Abre el archivo especificado y lo pasa a un arreglo que va buscando texto
    Path := "C:\Users\pablo\Downloads\CTPBA-Congreso 2023\Prueba.txt"
    resultado2 := ""
    

    Loop, Read, %Path%
    {
         Loop, parse, A_LoopReadLine, %A_Tab%
        {
            ; Array.Push(A_LoopReadLine) ; Se anexa cada línea del archivo .txt al arreglo.
            count += 1
            Array[count] := A_LoopReadLine
            element := Array[count]
            url := "https://www.collinsdictionary.com/search/?dictCode=english-spanish&q=" . element
            resultado := "K:\Mi unidad\Dictionaries-results\Collins\" . element
            resultado2 := resultado . ".htm"
           
            ; UrlDownloadToFile, %url%, %path%
            
            ; FileSelectFile, resultado2
            
        }
    }
    Sleep ,500
    MsgBox El procesamiento ha terminado.
#IfWinActive
    Return

;------------------------------------------------------------------------------
;Buscar términos de un arreglo (Array) en Cambridge Dictionary y descargar código htm para pasar a Colab
;------------------------------------------------------------------------------
::Cambridge:: ;Abre el archivo especificado y lo pasa a un arreglo que va buscando texto
#IfWinActive ahk_exe firefox.exe
    Path := "C:\Users\pablo\Downloads\CTPBA-Congreso 2023\Prueba.txt"
    resultado2 := ""
    Array := []
    count := 0
    Loop, Read, %Path%
    {
         Loop, parse, A_LoopReadLine, %A_Tab%
        {
            ; Array.Push(A_LoopReadLine) ; Se anexa cada línea del archivo .txt al arreglo.
            count += 1
            Array[count] := A_LoopReadLine
            element := Array[count]
            resultado := "C:\Users\pablo\Downloads\CTPBA-Congreso 2023\Cambridge\" . element
            resultado2 := resultado . ".htm"
            MsgBox % "Vamos a buscar el termino " . element . " para guardarlo en " . resultado2
            Sleep , 300
            Send , !d
            Sleep , 300
            Send , {Blind}{Text}dictionary.cambridge.org/search/english-spanish/direct/?=english-spanish&q=%element%
            Sleep , 300
            Send , {Enter}
            Sleep , 400
            clipboard := "" ; Se deja vacío el portapapeles
            Send , ^r
            Sleep , 200
            Send , !d
            Sleep , 100
            Send , ^c
            ClipWait  ; Wait for the clipboard to contain text.
            MsgBox Control-C copied the following contents to the clipboard:`n`n%clipboard%
            url := clipboard
            Sleep , 1000
            MsgBox % "La URL es " . url
            Sleep , 300
            ; UrlDownloadToFile, %url%, %path%
            Send , ^u
            Sleep , 300
            Send , ^s
            Sleep , 8000
            ; FileSelectFile, resultado2
            
        }
    }
    Sleep ,500
    MsgBox El procesamiento ha terminado.
#IfWinActive
    Return


