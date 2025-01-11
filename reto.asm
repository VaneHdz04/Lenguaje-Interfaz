.model small             ; Define el modelo de memoria como "small", lo que permite que el c?digo y los datos se almacenen en un ?nico segmento.
.stack                   ; Define el segmento de pila.
.data                    ; Inicia la secci?n de datos donde se almacenan variables y mensajes.
    num1 db 0            ; Define un byte para almacenar el primer n?mero.
    num2 db 0            ; Define un byte para almacenar el segundo n?mero.
    resultado db 0       ; Define un byte para almacenar el resultado de la suma.
    mensaje db 10, 13, "Primer numero (dos digitos): $"  ; Mensaje que se muestra para solicitar el primer n?mero.
    mensaje2 db 10, 13, "Segundo numero (dos digitos): $" ; Mensaje que se muestra para solicitar el segundo n?mero.
    mensaje3 db 10, 13, "La suma es: $"                   ; Mensaje que se muestra antes del resultado de la suma.
    nueva_linea db 10, 13, "$"                            ; Car?cter de nueva l?nea (10 = LF, 13 = CR).

.code                    ; Inicia la secci?n de c?digo.
main proc                ; Inicio del procedimiento principal.
    mov ax, @data        ; Cargar la direcci?n del segmento de datos en AX.
    mov ds, ax           ; Mover AX al registro DS para establecer el segmento de datos.

    ; Solicitar primer n?mero de dos d?gitos
    mov ah, 09h          ; Funci?n DOS para mostrar una cadena.
    lea dx, mensaje      ; Cargar la direcci?n del mensaje en DX.
    int 21h              ; Interrupci?n DOS para mostrar el mensaje.

    ; Leer el primer d?gito del primer n?mero
    mov ah, 01h          ; Funci?n DOS para leer un car?cter de entrada.
    int 21h              ; Interrupci?n DOS para leer el primer car?cter.
    sub al, 30h          ; Convertir el car?cter ASCII a su valor num?rico restando 30h (ASCII de '0').
    mov bl, al           ; Guardar el primer d?gito en BL.

    ; Leer el segundo d?gito del primer n?mero
    mov ah, 01h          ; Funci?n DOS para leer un car?cter.
    int 21h              ; Leer el segundo car?cter.
    sub al, 30h          ; Convertir el car?cter ASCII a valor num?rico.
    mov bh, al           ; Guardar el segundo d?gito en BH.

    ; Calcular num1 = (primer_digito * 10) + segundo_digito
    mov al, bl           ; Mover el primer d?gito (BL) a AL.
    mov ah, 0            ; Limpiar AH.
    mov cl, 10           ; Cargar 10 en CL.
    mul cl               ; Multiplicar AL por 10.
    add al, bh           ; Sumar el segundo d?gito al resultado.
    mov num1, al         ; Guardar el n?mero completo en num1.

    ; Solicitar segundo n?mero de dos d?gitos
    mov ah, 09h          ; Funci?n DOS para mostrar un mensaje.
    lea dx, mensaje2     ; Cargar la direcci?n del mensaje2 en DX.
    int 21h              ; Interrupci?n DOS para mostrar el mensaje.

    ; Leer el primer d?gito del segundo n?mero
    mov ah, 01h          ; Funci?n DOS para leer un car?cter.
    int 21h              ; Leer el primer car?cter.
    sub al, 30h          ; Convertir el car?cter ASCII a valor num?rico.
    mov bl, al           ; Guardar el primer d?gito en BL.

    ; Leer el segundo d?gito del segundo n?mero
    mov ah, 01h          ; Funci?n DOS para leer un car?cter.
    int 21h              ; Leer el segundo car?cter.
    sub al, 30h          ; Convertir el car?cter ASCII a valor num?rico.
    mov bh, al           ; Guardar el segundo d?gito en BH.

    ; Calcular num2 = (primer_digito * 10) + segundo_digito
    mov al, bl           ; Mover el primer d?gito (BL) a AL.
    mov ah, 0            ; Limpiar AH.
    mul cl               ; Multiplicar AL por 10.
    add al, bh           ; Sumar el segundo d?gito.
    mov num2, al         ; Guardar el n?mero completo en num2.

    ; Sumar num1 y num2
    mov al, num1         ; Cargar num1 en AL.
    add al, num2         ; Sumar num2.
    mov resultado, al    ; Guardar la suma en resultado.

    ; Mostrar el mensaje de la suma
    mov ah, 09h          ; Funci?n DOS para mostrar un mensaje.
    lea dx, mensaje3     ; Cargar la direcci?n del mensaje3 en DX.
    int 21h              ; Interrupci?n DOS para mostrar el mensaje.

    ; Preparar para mostrar el resultado
    mov al, resultado    ; Cargar el resultado en AL.
    xor ah, ah           ; Limpiar AH (poner a cero).
    cmp al, 0            ; Comparar el resultado con 0.
    je mostrar_cero      ; Si es cero, saltar a la rutina para mostrar "0".

    ; Convertir a caracteres ASCII
    mov bx, 10           ; Preparar el divisor (10 para convertir a base decimal).
    xor cx, cx           ; Limpiar CX, que se usar? como contador de d?gitos.

convertir:
    xor dx, dx           ; Limpiar DX antes de dividir.
    div bx               ; Dividir AX entre 10, el residuo quedar? en DX.
    push dx              ; Guardar el residuo (d?gito) en la pila.
    inc cx               ; Incrementar el contador de d?gitos.
    test ax, ax          ; Comprobar si el cociente es 0.
    jnz convertir        ; Si no es 0, repetir el proceso.

    ; Mostrar los d?gitos en orden inverso
mostrar_digitos:
    pop dx               ; Obtener el d?gito de la pila.
    add dl, 30h          ; Convertir a ASCII.
    mov ah, 02h          ; Funci?n DOS para mostrar un car?cter.
    int 21h              ; Interrupci?n DOS para mostrar el car?cter.
    loop mostrar_digitos ; Repetir hasta mostrar todos los d?gitos.

    jmp fin              ; Saltar al final.

mostrar_cero:
    ; Mostrar el n?mero cero
    mov dl, '0'          ; Cargar el car?cter '0' en DL.
    mov ah, 02h          ; Funci?n DOS para mostrar un car?cter.
    int 21h              ; Interrupci?n DOS para mostrar "0".

fin:
    ; Mostrar una nueva l?nea
    mov ah, 09h          ; Funci?n DOS para mostrar una cadena.
    lea dx, nueva_linea  ; Cargar la direcci?n de nueva_linea en DX.
    int 21h              ; Interrupci?n DOS para mostrar la nueva l?nea.

    ; Terminar el programa
    mov ax, 4C00h        ; Funci?n DOS para terminar el programa.
    int 21h              ; Interrupci?n DOS para salir del programa.

main endp               ; Fin del procedimiento principal.
end main                ; Fin del programa.
