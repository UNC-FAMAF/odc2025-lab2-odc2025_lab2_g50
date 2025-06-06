	// Framebuffer y pantalla
	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	// Colore ARGB
	.equ CELESTE,  0x00C0FFFF       // cielo: azul claro
	.equ VERDE_BOSQUE, 0x00008000   // pasto: verde
	.equ AMARILLO, 0x00FFFF00       // sol: amarillo

    // Colores básicos
    .equ NEGRO,             0x00000000
    .equ BLANCO,            0xFFFFFFFF
    .equ ROJO,              0x00FF0000
    .equ VERDE,             0x0000FF00
    .equ AZUL,              0x000000FF
    .equ ROSA,              0x00FF00FF
    .equ GRIS,              0x00808080
    .equ NARANJA,           0x00FFA500
    .equ VIOLETA,           0x00800080
    .equ VERDE_MEDIO,       0x0000A000
    .equ MARRON,            0x008B4513
    .equ VERDE_CLARO,       0x0090EE90
    .equ BORDEAUX,          0x00800040
    .equ VERDE_OSCURO,      0x00006400
    .equ AZUL_OSCURO,       0x00000080
    .equ CELESTE_OSCURO,    0x0080C0D0 
    .equ VIDRIO,            0x00FFFFCC

	// ---------------------------------

	// Dibujar un pixel en (x1, y2), color en x3, framebuffer en x0

dibujar_pixel:
    mov x10, SCREEN_WIDTH
    mul x4, x2, x10
    add x4, x4, x1
    lsl x4, x4, 2
    add x5, x0, x4
    str w3, [x5]
    ret

	// ----------------------------

// Dibujar rectángulo en (x1, y2) de tamaño (x3 ancho, x4 alto), color x5

dibujar_rectangulo:
	stp x19, x20, [sp, -16]!
	stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!  
    stp x25, x30, [sp, -16]!

	mov x19, x0                 // x19 = framebuffer_base
    mov x20, x1                 // x20 = x_inicio
    mov x21, x2                 // x21 = y_inicio
    mov x22, x3                 // x22 = ancho
    mov x23, x4                 // x23 = alto
    mov x24, x5                 // x24 = color

	mov x25, x21 // x25 es nuestro contador. Lo inicializamos con y_inicio
loop_rect_y:
	add x26, x21, x23           // x26 = y_inicio + alto 
    cmp x25, x26                // Compara: ¿y_actual (x25) >= y_inicio + alto (x26)?
    bge end_rect_y              // Si sí salta al final del bucle Y.

    mov x27, x20                // x27 es nuestro contador 'x_actual'.

loop_rect_x:

    add x28, x20, x22           // x28 = x_inicio + ancho 
    cmp x27, x28                // ¿x_actual (x27) >= x_inicio + ancho (x28)?
    bge end_rect_x              // Si sí, salta al final del bucle X.

    //pintamos pixel
    mov x0, x19                 //framebuffer_base 
    mov x1, x27                 //x_actual (la X de nuestro píxel actual)
    mov x2, x25                 //y_actual (la Y de nuestro píxel actual)
    mov x3, x24                 //color (que lo tenemos guardado en x24)
    bl dibujar_pixel            
	
    add x27, x27, 1             // (x_actual = x_actual + 1)
    b loop_rect_x               

end_rect_x:                     
    
    add x25, x25, 1             //y_actual = y_actual + 1.
    b loop_rect_y               

end_rect_y:                     

    //restauraramos los registros

    ldp x25, x30, [sp], 16   // Restaura x25 y x30 (lr)
    ldp x23, x24, [sp], 16   // Restaura x23 y x24
    ldp x21, x22, [sp], 16   // Restaura x21 y x22
    ldp x19, x20, [sp], 16   // Restaura x19 y x20
    ret                      // Regresa al punto del código que llamó a dibujar_rectangulo.

// ----------------------------------------

dibujar_circulo:
    //guardamos registros 
	stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

	//mover los argumentos a registros 
    mov x19, x0     // x19 = framebuffer_base
    mov x20, x1     // x20 = cx (centro x)
    mov x21, x2     // x21 = cy (centro y)
    mov x22, x3     // x22 = radio
    mov x23, x4     // x23 = color

    //Calculo radio al cuadrado
    mul x24, x22, x22 // x24 = radio * radio (radio^2)

    // Este bucle va desde (cy - radio) hasta (cy + radio).
    sub x25, x21, x22   // y_start = cy - radio 
    mov x26, x25        // x26 es nuestro contador 'y_actual'. 

loop_circle_y:

    add x27, x21, x22   // y_end = cy + radio 
    cmp x26, x27        //y_actual (x26) > y_end (x27)?
    bgt end_circle_y    //si sí, salta al final del bucle Y

    // Este bucle va desde (cx - radio) hasta (cx + radio).
    sub x28, x20, x22   // x_start = cx - radio 
    mov x29, x28        // x29 es nuestro contador 'x_actual'

loop_circle_x:

    add x30, x20, x22   // x_end = cx + radio
    cmp x29, x30        //x_actual (x29) > x_end (x30)?
    bgt end_circle_x    //si sí (mayor), salta al final del bucle X.

    // Calcular (x_actual - cx)^2
    sub x5, x29, x20   // x5 = x_actual - cx 
    mul x5, x5, x5     // x5 = x5 * x5 

    // Calcular (y_actual - cy)^2
    sub x6, x26, x21   // x6 = y_actual - cy 
    mul x6, x6, x6     // x6 = x6 * x6 

    // Calcular la distancia al cuadrado desde el centro: (x-cx)^2 + (y-cy)^2
    add x7, x5, x6     // x7 = (x-cx)^2 + (y-cy)^2


    cmp x7, x24        //distancia_cuadrada (x7) <= radio^2 (x24)?
    ble draw_circle_pixel //si sí, salta a pintar el píxel

    b skip_draw_circle_pixel 

draw_circle_pixel:       //etiqueta para cuando el píxel está dentro del círculo

    // Pasamos los argumentos a 'dibujar_pixel' en los registros que espera (x0, x1, x2, x3).
    mov x0, x19     //framebuffer_base 
    mov x1, x29     //x_actual 
    mov x2, x26     //y_actual
    mov x3, x23     //color
    bl dibujar_pixel 

skip_draw_circle_pixel:  

    add x29, x29, 1 //x_actual = x_actual + 1.
    b loop_circle_x 

end_circle_x:

    add x26, x26, 1 //y_actual = y_actual + 1
    b loop_circle_y 

end_circle_y:

    //restauramos los valores originales de los registros
    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

//------------------------------------------------------

dibujar_triangulo_normal:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0      // framebuffer
    mov x20, x1      // x centro
    mov x21, x2      // y vértice
    mov x22, x3      // base (ancho máximo)
    mov x23, x4      // alto
    mov x24, x5      // color

    mov x25, 0       // fila actual

.loop_triangulo:
    cmp x25, x23
    bge .fin_triangulo

    // ancho actual = 1 + 2*fila
    lsl x26, x25, 1
    add x26, x26, 1

    // x_inicio = x_centro - fila
    sub x27, x20, x25

    // y = y_vértice + fila
    add x28, x21, x25

    mov x0, x19
    mov x1, x27
    mov x2, x28
    mov x3, x26
    mov x4, 1
    mov x5, x24
    bl dibujar_rectangulo

    add x25, x25, 1
    b .loop_triangulo

.fin_triangulo:
    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

//------------------------------------------------------

.globl dibujar_arbol_redondo
dibujar_arbol_redondo:

    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0  // framebuffer
    mov x20, x1  // centro x
    mov x21, x2  // y base
    mov x22, x3  // alto total
    mov x23, x4  // color copa
    mov x24, x5  // color tronco

    // --- Tronco ---
    mov x25, 25                  // ancho del tronco
    lsr x26, x22, 1             // alto tronco = alto / 2
    mov x27, x20
    lsr x28, x25, 1
    sub x27, x27, x28           // x_inicio = centro_x - ancho/2
    sub x29, x21, x26           // y_inicio = base_y - alto_tronco

    mov x0, x19                 // framebuffer
    mov x1, x27                 // x
    mov x2, x29                 // y
    mov x3, x25                 // ancho
    mov x4, x26                 // alto
    mov x5, x24                 // color tronco
    bl dibujar_rectangulo

    // --- Copa (círculo) ---
    mov x0, x19
    mov x1, x20                 // centro x
    sub x2, x29, 10             // centro y (arriba del tronco)
    mov x3, 50                  // radio
    mov x4, x23                 // color copa
    bl dibujar_circulo

    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

//------------------------------------------------------

.globl dibujar_arbol_triangular
dibujar_arbol_triangular:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0  // framebuffer
    mov x20, x1  // centro x
    mov x21, x2  // y base
    mov x22, x3  // alto total
    mov x23, x4  // color copa
    mov x24, x5  // color tronco

    // Tronco
    mov x25, 27                   // ancho
    lsr x26, x22, 1             // alto tronco = alto / 2
    sub x27, x20, x25, lsr #1   // x_inicio = centro x - ancho/2
    sub x28, x21, x26           // y_inicio = y_base - alto

    mov x0, x19
    mov x1, x27
    mov x2, x28
    mov x3, x25
    mov x4, x26
    mov x5, x24
    bl dibujar_rectangulo

    // Copa 
    mov x0, x19
    mov x1, x20                 // centro x
    sub x2, x28, -170           // y vértice
    mov x3, 400                 // base
    mov x4, 70                  // alto
    mov x5, x23
    bl dibujar_triangulo_normal

    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret   

//------------------------------------------------------

.globl dibujar_nube
dibujar_nube:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x30, [sp, -16]!

    mov x19, x0        // framebuffer
    mov x20, x1        // centro x
    mov x21, x2        // centro y

    // color blanco
    movz x22, (BLANCO & 0xFFFF), lsl 0
    movk x22, (BLANCO >> 16), lsl 16

    // círculo izquierdo
    mov x0, x19
    sub x1, x20, 20
    add x2, x21, 10
    mov x3, 15
    mov x4, x22
    bl dibujar_circulo

    // círculo central
    mov x0, x19
    mov x1, x20
    mov x2, x21
    mov x3, 20
    mov x4, x22
    bl dibujar_circulo

    // círculo derecho
    mov x0, x19
    add x1, x20, 20
    add x2, x21, 10
    mov x3, 15
    mov x4, x22
    bl dibujar_circulo

    // círculo inferior
    mov x0, x19
    mov x1, x20
    add x2, x21, 15
    mov x3, 18
    mov x4, x22
    bl dibujar_circulo

    ldp x23, x30, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

    //----------------------------------------------

    

//-----------------------------------------------------------------------------------------

.globl main
main:
	mov x20, x0		// framebuffer

    // Fondo celeste -------------------------
    mov x0, x20
    mov x1, 0
    mov x2, 0
    mov x3, SCREEN_WIDTH
    mov x4, SCREEN_HEIGH

    movz x5, (CELESTE_OSCURO & 0xFFFF), lsl 0
    movk x5, (CELESTE_OSCURO >> 16), lsl 16
    bl dibujar_rectangulo


    // Pasto verde -------------------------
    mov x0, x20
    mov x1, 0
    mov x2, 350
    mov x3, SCREEN_WIDTH
    mov x4, 200
    movz x5, (VERDE & 0xFFFF), lsl 0
    movk x5, (VERDE >> 16), lsl 16
    bl dibujar_rectangulo


    // Sol amarillo -------------------------
    mov x0, x20
    mov x1, 70       // centro x
    mov x2, 75        // centro y
    mov x3, 50        // radio
    movz x4, (AMARILLO & 0xFFFF), lsl 0
    movk x4, (AMARILLO >> 16), lsl 16
    bl dibujar_circulo


    // Sol interior -------------------------
    mov x0, x20
    mov x1, 70       // centro x
    mov x2, 75        // centro y
    mov x3, 35        // radio
    movz x4, (NARANJA & 0xFFFF), lsl 0
    movk x4, (NARANJA >> 16), lsl 16
    bl dibujar_circulo


    // Nubes -------------------------------
    mov x0, x20
    mov x1, 300    // centro x
    mov x2, 100     // centro y
    bl dibujar_nube


    // Casa 1 rosa -------------------------
    mov x0, x20
    mov x1, 300
    mov x2, 40
    mov x3, 200
    mov x4, 320
    movz x5, (ROSA & 0xFFFF), lsl 0
    movk x5, (ROSA >> 16), lsl 16
    bl dibujar_rectangulo 
    

    // Calle horizontal ---------------------
    mov x0, x20
    mov x1, 0
    mov x2, 370
    mov x3, SCREEN_WIDTH
    mov x4, 40
    movz x5, (GRIS & 0xFFFF), lsl 0
    movk x5, (GRIS >> 16), lsl 16
    bl dibujar_rectangulo    


    // Calle vertical ----------------------
    mov x0, x20         // framebuffer
    mov x1, 350         // x
    mov x2, 400         // y
    mov x3, 70          // ancho
    mov x4, 100          // alto
    movz x5, (GRIS & 0xFFFF), lsl 0
    movk x5, (GRIS >> 16), lsl 16
    bl dibujar_rectangulo


    // Marco Cartel Casa azul ---------------------------------------
    mov x0, x20
    mov x1, 75
    mov x2, 110
    mov x3, 190
    mov x4, 95
    movz x5, (GRIS & 0xFFFF), lsl 0
    movk x5, (GRIS >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 90
    mov x2, 200
    mov x3, 20
    mov x4, 40
    movz x5, (GRIS & 0xFFFF), lsl 0
    movk x5, (GRIS >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 230
    mov x2, 200
    mov x3, 20
    mov x4, 40
    movz x5, (GRIS & 0xFFFF), lsl 0
    movk x5, (GRIS >> 16), lsl 16
    bl dibujar_rectangulo

    // Cartel Casa AZUL ---------------------------------------
    mov x0, x20
    mov x1, 85
    mov x2, 120
    mov x3, 170
    mov x4, 75
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    // Casa 2 AZUL -------------------------------
    mov x0, x20
    mov x1, 70
    mov x2, 215
    mov x3, 200
    mov x4, 150
    movz x5, (AZUL_OSCURO & 0xFFFF), lsl 0
    movk x5, (AZUL_OSCURO >> 16), lsl 16
    bl dibujar_rectangulo 

    // Ventana Casa AZUL ---------------------------------------

    mov x0, x20
    mov x1, 95
    mov x2, 240
    mov x3, 30
    mov x4, 90
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 140
    mov x2, 240
    mov x3, 30
    mov x4, 90
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 185
    mov x2, 240
    mov x3, 30
    mov x4, 90
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    // Árbol redondo 1 ---------------------------
    mov x0, x20        // framebuffer
    mov x1, 200        // x centro
    mov x2, 420        // y base
    mov x3, 145         // alto total

    // Color copa: verde oscuro (0x008000)
   movz x4, (VERDE_BOSQUE & 0xFFFF), lsl 0
    movk x4, (VERDE_BOSQUE >> 16), lsl 16

    // Color tronco: marrón (0x663300)
    movz x5, 0x3300, lsl 0
    movk x5, 0x0066, lsl 16

    bl dibujar_arbol_redondo


    // Árbol redondo 2 ----------------------------
    mov x0, x20        // framebuffer
    mov x1, 50        // x centro
    mov x2, 420        // y base
    mov x3, 150         // alto total

    // Color copa
    movz x4, (VERDE_BOSQUE & 0xFFFF), lsl 0
    movk x4, (VERDE_BOSQUE >> 16), lsl 16 

    // Color tronco
    movz x5, (MARRON & 0xFFFF), lsl 0
    movk x5, (MARRON >> 16), lsl 16

    bl dibujar_arbol_redondo


    // Árbol triangular ----------------------------
    mov x0, x20         // framebuffer
    mov x1, 130         // centro x
    mov x2, 450         // y base
    mov x3, 200         // alto total

    // Copa: verde más claro
    movz x4, (VERDE_MEDIO & 0xFFFF), lsl 0
    movk x4, (VERDE_MEDIO >> 16), lsl 16

    // Tronco: mismo marrón
    movz x5, (MARRON & 0xFFFF), lsl 0
    movk x5, (MARRON >> 16), lsl 16

    bl dibujar_arbol_triangular


    // Nubes --------------------------------------
    mov x0, x20
    mov x1, 500
    mov x2, 20
    bl dibujar_nube

    mov x0, x20
    mov x1, 150
    mov x2, 60
    bl dibujar_nube

    mov x0, x20
    mov x1, 0
    mov x2, 70
    bl dibujar_nube

    // Ventanas ---------------------------------------

    // Fila 1 ---------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    // Fila 2---------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    // Fila 3 ------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    // Fila 4 ------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo
   
    // Marco Cartel Casa Roja ---------------------------------------
    mov x0, x20
    mov x1, 425
    mov x2, 90
    mov x3, 190
    mov x4, 95
    movz x5, (NEGRO & 0xFFFF), lsl 0
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 480
    mov x2, 170
    mov x3, 15
    mov x4, 40
    movz x5, (NEGRO & 0xFFFF), lsl 0
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 550
    mov x2, 170 
    mov x3, 15
    mov x4, 40
    movz x5, (NEGRO & 0xFFFF), lsl 0
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // Cartel Casa ROJa ---------------------------------------
    mov x0, x20
    mov x1, 435
    mov x2, 100
    mov x3, 170
    mov x4, 70
    movz x5, (BLANCO & 0xFFFF), lsl 0
    movk x5, (BLANCO >> 16), lsl 16
    bl dibujar_rectangulo

    // Casa 2 roja -------------------------
    mov x0, x20
    mov x1, 450
    mov x2, 190
    mov x3, 150
    mov x4, 260
    movz x5, (ROJO & 0xFFFF), lsl 0
    movk x5, (ROJO >> 16), lsl 16
    bl dibujar_rectangulo
 

 // Ventana Casa Roja ---------------------------------------

    mov x0, x20
    mov x1, 475
    mov x2, 210
    mov x3, 100
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 475
    mov x2, 265
    mov x3, 100
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 475
    mov x2, 320
    mov x3, 100
    mov x4, 40
    movz x5, (VIDRIO & 0xFFFF), lsl 0
    movk x5, (VIDRIO >> 16), lsl 16
    bl dibujar_rectangulo 




    
// LETRAS ODC 2025 -----------------------------------------
 //O
    // |
    mov x0, x20
    mov x1, 100               
    mov x2, 130          	    
    mov x3, 10               
    mov x4, 50               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo
 
    // _
    mov x0, x20
    mov x1, 100
    mov x2, 175            	    
    mov x3, 40               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo
 
    // |
    mov x0, x20
    mov x1, 130          
    mov x2, 130            	    
    mov x3, 10               
    mov x4, 50               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo
 
    // -
    mov x0, x20
    mov x1, 100               
    mov x2, 130            	    
    mov x3, 40               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

  //D

    // -
    mov x0, x20
    mov x1, 150                
    mov x2, 130            	    
    mov x3, 35               
    mov x4, 8               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 150          
    mov x2, 130            	    
    mov x3, 15               
    mov x4, 50               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 185         
    mov x2, 134            	    
    mov x3, 8               
    mov x4, 46               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo
    
    // _
    mov x0, x20
    mov x1, 150                
    mov x2, 175            	    
    mov x3, 35               
    mov x4, 8               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

   //C
    
    // |
    mov x0, x20
    mov x1, 203             
    mov x2, 130  	    
    mov x3, 12               
    mov x4, 50               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    //-
    mov x0, x20
    mov x1, 205           
    mov x2, 130            	    
    mov x3, 35               
    mov x4, 6             
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // _
    mov x0, x20
    mov x1, 205           
    mov x2, 175            	    
    mov x3, 35               
    mov x4, 6             
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    //Numeros en Edificio ROJO

 //2
    // -
    mov x0, x20
    mov x1, 445               
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 5               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 465                
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 15                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // -
    mov x0, x20
    mov x1, 445               
    mov x2, 123           	    
    mov x3, 25               
    mov x4, 7               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 445               
    mov x2, 130            	    
    mov x3, 5                  
    mov x4, 20                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    
    // _
    mov x0, x20
    mov x1, 445               
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

  //0

    // |
    mov x0, x20
    mov x1, 480               
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 45                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 480               
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 500               
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 45                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 480               
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

   //2
    // -
    mov x0, x20
    mov x1, 515               
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 5               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 535           
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 15                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // -
    mov x0, x20
    mov x1, 515               
    mov x2, 122          	    
    mov x3, 25               
    mov x4, 7               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 515               
    mov x2, 125           	    
    mov x3, 5                  
    mov x4, 20                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // _
    mov x0, x20
    mov x1, 515              
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

   //5
    // -
    mov x0, x20
    mov x1, 550              
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 5               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 550           
    mov x2, 110            	    
    mov x3, 10                  
    mov x4, 20                  
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // -
    mov x0, x20
    mov x1, 550               
    mov x2, 125        	    
    mov x3, 25               
    mov x4, 5              
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 570              
    mov x2, 125           	    
    mov x3, 5                  
    mov x4, 20                   
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo

    // _
    mov x0, x20
    mov x1, 550              
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, (NEGRO & 0x0000FFFF), lsl 0 
    movk x5, (NEGRO >> 16), lsl 16
    bl dibujar_rectangulo


InfLoop:
	b InfLoop
