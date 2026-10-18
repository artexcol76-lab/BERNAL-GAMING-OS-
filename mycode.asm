org 100h

start:
    ; 1. ACTIVAR MODO GRÁFICO (320x200 píxeles, 256 colores)
    mov ah, 00h
    mov al, 13h          
    int 10h

    ; 2. PINTAR EL FONDO OSCURO CYBERPUNK
    mov al, 0            ; Color 0 = Negro absoluto
    mov cx, 0            
    mov dx, 0            
dibujar_fondo:
    mov ah, 0ch          
    int 10h
    inc cx               
    cmp cx, 320          
    jne dibujar_fondo
    mov cx, 0            
    inc dx               
    cmp dx, 200          
    jne dibujar_fondo

    ; 3. DIBUJAR LÍNEA ROJA GAMER SUPERIOR
    mov al, 4            ; Color 4 = Rojo
    mov cx, 0
    mov dx, 12
dibujar_rgb:
    mov ah, 0ch
    int 10h
    inc cx
    cmp cx, 320
    jne dibujar_rgb

    ; 4. IMPRIMIR LOS TEXTOS DEL SISTEMA GAMER
    ; Título principal en la parte superior
    mov ah, 02h
    mov bh, 0
    mov dh, 0            ; Fila 0
    mov dl, 1            ; Columna 1
    int 10h
    mov si, offset txt_sistema
    call imprimir_rojo

    ; Lista del Lanzador de Juegos (Launcher)
    mov ah, 02h
    mov dl, 2            ; Columna izquierda
    
    mov dh, 3            ; Fila 3
    int 10h
    mov si, offset txt_launcher
    call imprimir_blanco

    mov dh, 5            ; Fila 5
    int 10h
    mov si, offset txt_game1
    call imprimir_verde

    mov dh, 7            ; Fila 7
    int 10h
    mov si, offset txt_game2
    call imprimir_verde

    mov dh, 9            ; Fila 9
    int 10h
    mov si, offset txt_game3
    call imprimir_verde

    ; Sección del Navegador Web integrado
    mov dh, 12           ; Fila 12
    mov dl, 2
    int 10h
    mov si, offset txt_nav
    call imprimir_blanco

    ; Telemetría e info de rendimiento (FPS y Temp) en la parte inferior
    mov ah, 02h
    mov dh, 23           ; Fila de abajo
    mov dl, 1            
    int 10h
    mov si, offset txt_stats
    call imprimir_verde

bucle_sistema:
    jmp bucle_sistema    ; Mantiene el sistema encendido

; === FUNCIONES DE COLORES (CON INT 10H / AH=0EH) ===
imprimir_rojo:
    mov ah, 0eh
.b1:lodsb
    cmp al, 0
    je .f1
    mov bl, 4            ; Código de color rojo
    int 10h
    jmp .b1
.f1:ret

imprimir_blanco:
    mov ah, 0eh
.b2:lodsb
    cmp al, 0
    je .f2
    mov bl, 15           ; Código de color blanco
    int 10h
    jmp .b2
.f2:ret

imprimir_verde:
    mov ah, 0eh
.b3:lodsb
    cmp al, 0
    je .f3
    mov bl, 10           ; Código de color verde neón
    int 10h
    jmp .b3
.f3:ret

; === SECCIÓN DE TEXTOS DE BERNALOS ===
txt_sistema  db "BERNAL GAMING OS v3.0 (Linux Gaming Core)", 0
txt_launcher db "=== STEAM LAUNCHER ===", 0
txt_game1    db "[1] Carrera de Autos (Retro Arcade)", 0
txt_game2    db "[2] Doom Edition 1993", 0
txt_game3    db "[3] Counter Strike Source", 0
txt_nav      db "Navegador Web: http://google.com", 0
txt_stats    db "GPU: 58 C | CPU: 50 C | FPS: 240+ | VULKAN: ON", 0



