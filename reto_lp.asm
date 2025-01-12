.model small ; se asigna el tamano de memoria
.stack ; modelo de pila
.data  ; inicio de datos   

.code; inicio del codigo
main proc; inicia procedimiento principal 
    mov cx,9    ; Inicializa CX con el n?mero de iteraciones (9)
    mov dl,1    ; Inicializa DL con el valor 1 (primer n?mero a imprimir)

ciclo:

    mov ah,02h  ; Funci?n para imprimir un car?cter
    add dl,30h  ; Convierte el valor num?rico a su representaci?n ASCII
    int 21h     ; Llama a la interrupci?n para imprimir en pantalla
    sub dl,30h  ; Regresa el valor de DL a su estado num?rico original
    inc dl      ; Incrementa DL para que en la pr?xima iteraci?n imprima el siguiente n?mero

    loop ciclo  ; Decrementa CX y repite el ciclo si CX no es 0

    mov ax,4c00h; Salir del programa
    int 21h
main endp; termina el procedimiento
end main
