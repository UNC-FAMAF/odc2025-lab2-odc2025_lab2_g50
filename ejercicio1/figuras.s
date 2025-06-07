// figuras.s
	// Framebuffer y pantalla
	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

// Colores ------------------------
    .equ NEGRO,             0x00000000
    .equ BLANCO,            0xFFFFFFFF

	// ---------------------------------

.globl dibujar_pixel
.globl dibujar_rectangulo
.globl dibujar_circulo
.globl dibujar_triangulo_normal
.globl dibujar_arbol_redondo
.globl dibujar_arbol_triangular
.globl dibujar_nube

// -------------------------
dibujar_pixel:
    mov x10, SCREEN_WIDTH
    mul x4, x2, x10
    add x4, x4, x1
    lsl x4, x4, 2
    add x5, x0, x4
    str w3, [x5]
    ret

// -------------------------
dibujar_rectangulo:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5

    mov x25, x21
1:
    add x26, x21, x23
    cmp x25, x26
    bge 3f

    mov x27, x20
2:
    add x28, x20, x22
    cmp x27, x28
    bge 4f

    mov x0, x19
    mov x1, x27
    mov x2, x25
    mov x3, x24
    bl dibujar_pixel
    add x27, x27, 1
    b 2b

4:
    add x25, x25, 1
    b 1b

3:
    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

// -------------------------
dibujar_circulo:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mul x24, x22, x22

    sub x25, x21, x22
    mov x26, x25
1:
    add x27, x21, x22
    cmp x26, x27
    bgt 3f

    sub x28, x20, x22
    mov x29, x28
2:
    add x30, x20, x22
    cmp x29, x30
    bgt 4f

    sub x5, x29, x20
    mul x5, x5, x5
    sub x6, x26, x21
    mul x6, x6, x6
    add x7, x5, x6
    cmp x7, x24
    bgt 5f

    mov x0, x19
    mov x1, x29
    mov x2, x26
    mov x3, x23
    bl dibujar_pixel
5:
    add x29, x29, 1
    b 2b

4:
    add x26, x26, 1
    b 1b

3:
    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

// -------------------------
dibujar_triangulo_normal:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5

    mov x25, 0
1:
    cmp x25, x23
    bge 3f

    lsl x26, x25, 1
    add x26, x26, 1
    sub x27, x20, x25
    add x28, x21, x25

    mov x0, x19
    mov x1, x27
    mov x2, x28
    mov x3, x26
    mov x4, 1
    mov x5, x24
    bl dibujar_rectangulo

    add x25, x25, 1
    b 1b

3:
    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

// -------------------------
dibujar_arbol_redondo:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5

    mov x25, 25
    lsr x26, x22, 1
    mov x27, x20
    lsr x28, x25, 1
    sub x27, x27, x28
    sub x29, x21, x26

    mov x0, x19
    mov x1, x27
    mov x2, x29
    mov x3, x25
    mov x4, x26
    mov x5, x24
    bl dibujar_rectangulo

    mov x0, x19
    mov x1, x20
    sub x2, x29, 10
    mov x3, 50
    mov x4, x23
    bl dibujar_circulo

    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

// -------------------------
dibujar_arbol_triangular:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x30, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5

    mov x25, 27
    lsr x26, x22, 1
    sub x27, x20, x25, lsr #1
    sub x28, x21, x26

    mov x0, x19
    mov x1, x27
    mov x2, x28
    mov x3, x25
    mov x4, x26
    mov x5, x24
    bl dibujar_rectangulo

    mov x0, x19
    mov x1, x20
    sub x2, x28, -170
    mov x3, 400
    mov x4, 70
    mov x5, x23
    bl dibujar_triangulo_normal

    ldp x25, x30, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x19, x20, [sp], 16
    ret

// -------------------------
dibujar_nube:
    stp x19, x20, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x23, x30, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2

    movz x22, 0xFFFF, lsl 0
    movk x22, 0xFFFF, lsl 16

    mov x0, x19
    sub x1, x20, 20
    add x2, x21, 10
    mov x3, 15
    mov x4, x22
    bl dibujar_circulo

    mov x0, x19
    mov x1, x20
    mov x2, x21
    mov x3, 20
    mov x4, x22
    bl dibujar_circulo

    mov x0, x19
    add x1, x20, 20
    add x2, x21, 10
    mov x3, 15
    mov x4, x22
    bl dibujar_circulo

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




.animar_nubes:
    // x19 = dirección framebuffer (como x20), ya debería estar inicializado

    mov x19, x20        // x19 = framebuffer

    mov x21, 0          // contador / offset horizontal

loop_nube:
    // Redibujar fondo celeste solo en la zona de la nube (para borrar la nube anterior)
    mov x0, x19         // framebuffer
    mov x1, 0           // x
    mov x2, 60          // y
    mov x3, 640         // ancho
    mov x4, 90          // alto
    movz x5, 0xC0D0, lsl 0
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

    // Dibujar nube en x = 100 + offset (x21)
    mov x0, x19
    mov x1, x21         // centro x variable
    mov x2, 100         // centro y fijo
    bl dibujar_nube

    // Delay (muy simple)
    mov x0, 0x40000     // Podés ajustar este valor
delay_loop:
    subs x0, x0, 1
    bne delay_loop

    // Incrementar x21
    add x21, x21, 4     // Mueve 4 píxeles por frame

    // Volver a empezar si no se pasó del borde derecho
    cmp x21, #640
    blt loop_nube

    ret

