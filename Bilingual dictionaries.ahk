#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;------------------------------------------------------------------------------
;Scripts de AutoHotkey para Búsquedas masivas, por Pablo Siredey
;------------------------------------------------------------------------------
#IfWinActive ahk_exe firefox.exe

DictionaryLookup(Path, url)
{
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
            url := url+element
            resultado := "K:\Mi unidad\Dictionaries-results\Collins\" . element
            resultado2 := resultado . ".htm"
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
            ; UrlDownloadToFile, %url%, %path%
            
            ; FileSelectFile, resultado2, s, ,
            MsgBox El procesamiento ha terminado.
            break
        }
    }

    Sleep , 8000
    Send , !d
    Sleep , 400
    Send , {Blind}{Text}https://colab.research.google.com/drive/1xF0O5RIQQSfhLq3FrQ0wyuzcvB5Y7m-1#scrollTo=01gcEN1akb8d

    
}
;------------------------------------------------------------------------------
;Buscar términos de un arreglo (Array) en Collins Dictionary y descargar código htm para pasar a Colab
;------------------------------------------------------------------------------

::Collins:: ;Abre el archivo que le indiquemos y lo pasa a una función que busca los textos en la página de Collins del archivo por línea en varias iteraciones
    ; Lo que hace es que va guardando versiones en formato "htm" que se guardan automáticamente en el Drive, los cuales podemos rescatar para pasarlos a Google Colab
    ; Dado que estos diccionarios no permiten usar get.requests(), hay que conseguir los archivos de manera manual (con programación)
    url := "https://www.collinsdictionary.com/search/?dictCode=english-spanish&q="
    FileSelectFile, Path, 1, Open a file, Text Documents (*.txt; *.doc)
    MsgBox La ruta del archivo es %Path%.
    DictionaryLookup(Path, url)
    
#IfWinActive
    Return

;------------------------------------------------------------------------------
;Buscar términos de un arreglo (Array) en Cambridge Dictionary y descargar código htm para pasar a Colab
;------------------------------------------------------------------------------
::Cambridge:: ;Abre el archivo especificado y lo pasa a un arreglo que va buscando texto
    Path := "C:\Users\pablo\Downloads\CTPBA-Congreso 2023\Prueba.txt"
    url:= "dictionary.cambridge.org/search/english-spanish/direct/?=english-spanish&q="
    FileSelectFile, Path, 1, , Open a file, Text Documents (*.txt; *.doc)
    MsgBox La ruta del archivo es %Path%.
    

Return


