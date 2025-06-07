.global main
.globl dibujar_escena_estatica

.equ SCREEN_WIDTH, 640
.equ SCREEN_HEIGH, 480

bl dibujar_escena_estatica   // fondo, pasto, sol, etc.

main:
    mov x20, x0      // framebuffer base
    bl dibujar_escena_estatica

    // Nubes fijas
    mov x0, x20
    mov x1, 300
    mov x2, 100
    bl dibujar_nube

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

    ret

dibujar_escena_estatica:
 // Fondo celeste
    mov x0, x20
    mov x1, 0
    mov x2, 0
    mov x3, SCREEN_WIDTH
    mov x4, SCREEN_HEIGH
    movz x5, 0xC0D0, lsl 0
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

 // Pasto verde
    mov x0, x20
    mov x1, 0
    mov x2, 350
    mov x3, SCREEN_WIDTH
    mov x4, 130
    movz x5, 0xFF00, lsl 0
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // Sol amarillo
    mov x0, x20
    mov x1, 70
    mov x2, 75
    mov x3, 50
    movz x4, 0xFF00, lsl 0
    movk x4, 0x00FF, lsl 16
    bl dibujar_circulo

    // Sol interior naranja
    mov x0, x20
    mov x1, 70
    mov x2, 75
    mov x3, 35
    movz x4, 0xA500, lsl 0
    movk x4, 0x00FF, lsl 16
    bl dibujar_circulo

    // Nubes -------------------------------
    mov x0, x20
    mov x1, 300
    mov x2, 100
    bl dibujar_nube


    // Casa rosa
    mov x0, x20
    mov x1, 300
    mov x2, 40
    mov x3, 200
    mov x4, 320
    movz x5, 0x00FF, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

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
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    // Fila 2---------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 110
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    // Fila 3 ------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 160
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    // Fila 4 ------------------------------
    mov x0, x20
    mov x1, 315
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 345
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo     

    mov x0, x20
    mov x1, 375
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 405
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 435
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 465
    mov x2, 210
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    // Marco Cartel Casa Roja ---------------------------------------
    mov x0, x20
    mov x1, 425
    mov x2, 90
    mov x3, 190
    mov x4, 95
    movz x5, 0x0000, lsl 0         // NEGRO
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 480
    mov x2, 170
    mov x3, 15
    mov x4, 40
    movz x5, 0x0000, lsl 0
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 550
    mov x2, 170 
    mov x3, 15
    mov x4, 40
    movz x5, 0x0000, lsl 0
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // Cartel Casa ROJA ---------------------------------------
    mov x0, x20
    mov x1, 435
    mov x2, 100
    mov x3, 170
    mov x4, 70
    movz x5, 0xFFFF, lsl 0         // BLANCO
    movk x5, 0xFFFF, lsl 16
    bl dibujar_rectangulo


    // Ventanas casa rosa
    mov x0, x20
    mov x1, 315
    mov x2, 60
    mov x3, 20
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    // Calle horizontal
    mov x0, x20
    mov x1, 0
    mov x2, 370
    mov x3, SCREEN_WIDTH
    mov x4, 40
    movz x5, 0x8080, lsl 0
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

    // Calle vertical
    mov x0, x20
    mov x1, 350
    mov x2, 400
    mov x3, 70
    mov x4, 100
    movz x5, 0x8080, lsl 0
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

   // Marco Cartel Casa azul ---------------------------------------
    mov x0, x20
    mov x1, 75
    mov x2, 110
    mov x3, 190
    mov x4, 95
    movz x5, 0x8080, lsl 0         // GRIS
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 90
    mov x2, 200
    mov x3, 20
    mov x4, 40
    movz x5, 0x8080, lsl 0         // GRIS
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 230
    mov x2, 200
    mov x3, 20
    mov x4, 40
    movz x5, 0x8080, lsl 0         // GRIS
    movk x5, 0x0080, lsl 16
    bl dibujar_rectangulo

    // Cartel Casa AZUL ---------------------------------------
    mov x0, x20
    mov x1, 85
    mov x2, 120
    mov x3, 170
    mov x4, 75
    movz x5, 0xFFCC, lsl 0         // VIDRIO
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    // Casa azul oscuro
    mov x0, x20
    mov x1, 70
    mov x2, 215
    mov x3, 200
    mov x4, 150
    movz x5, 0x00FF, lsl 0
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

// Ventana Casa AZUL ---------------------------------------

    mov x0, x20
    mov x1, 95
    mov x2, 240
    mov x3, 30
    mov x4, 90
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 140
    mov x2, 240
    mov x3, 30
    mov x4, 90
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 185
    mov x2, 240
    mov x3, 30
    mov x4, 90
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

 // Taxi
    mov x0, x20        // framebuffer
    mov x1, 260        // x (posición horizontal)
    mov x2, 355        // y (posición vertical)
    mov x3, 60         // ancho
    mov x4, 25         // alto
    movz x5, 0xA500, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 265        // x (posición horizontal)
    mov x2, 345        // y (posición vertical)
    mov x3, 40         // ancho
    mov x4, 30         // alto
    movz x5, 0xA500, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

  // VIDRIO Auto
    mov x0, x20        // framebuffer
    mov x1, 303        // x (posición horizontal)
    mov x2, 347        // y (posición vertical)
    mov x3, 2         // ancho
    mov x4, 8         // alto
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 285        // x (posición horizontal)
    mov x2, 347        // y (posición vertical)
    mov x3, 15        // ancho
    mov x4, 8         // alto
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 270        // x (posición horizontal)
    mov x2, 347        // y (posición vertical)
    mov x3, 11         // ancho
    mov x4, 8         // alto
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 260        // x (posición horizontal)
    mov x2, 360        // y (posición vertical)
    mov x3, 60        // ancho
    mov x4, 5         // alto
    movz x5, 0x0000, lsl 0
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo


    // Rueda trasera
    mov x0, x20
    mov x1, 275       // centro x
    mov x2, 380       // centro y
    mov x3, 10        // radio
    movz x4, 0x0000, lsl 0
    movk x4, 0x0000, lsl 16     // negro
    bl dibujar_circulo

    // Rueda delantera
    mov x0, x20
    mov x1, 305       // centro x
    mov x2, 380       // centro y
    mov x3, 10        // radio
    movz x4, 0x0000, lsl 0
    movk x4, 0x0000, lsl 16     // negro
    bl dibujar_circulo

    // LLanta trasera
    mov x0, x20
    mov x1, 275       // centro x
    mov x2, 380       // centro y
    mov x3, 5        // radio
    movz x4, 0xFFFF, lsl 0
    movk x4, 0xFFFF, lsl 16     // negro
    bl dibujar_circulo

    // LLanta delantera
    mov x0, x20
    mov x1, 305       // centro x
    mov x2, 380       // centro y
    mov x3, 5        // radio
    movz x4, 0xFFFF, lsl 0
    movk x4, 0xFFFF, lsl 16     // negro
    bl dibujar_circulo

// Auto rojo
    mov x0, x20        // framebuffer
    mov x1, 400        // x (posición horizontal)
    mov x2, 375        // y (posición vertical)
    mov x3, 60         // ancho
    mov x4, 25         // alto
    movz x5, 0x0000, lsl 0      // parte baja del color
    movk x5, 0x00FF, lsl 16     // parte alta del color: rojo brillante 
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 415        // x (posición horizontal)
    mov x2, 360        // y (posición vertical)
    mov x3, 40         // ancho
    mov x4, 30         // alto
    movz x5, 0x0000, lsl 0      // parte baja del color
    movk x5, 0x00FF, lsl 16     // parte alta del color: rojo brillante
    bl dibujar_rectangulo

  // VIDRIO Auto
    mov x0, x20        // framebuffer
    mov x1, 415        // x (posición horizontal)
    mov x2, 362        // y (posición vertical)
    mov x3, 2         // ancho
    mov x4, 8         // alto
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 420        // x (posición horizontal)
    mov x2, 362        // y (posición vertical)
    mov x3, 15        // ancho
    mov x4, 8         // alto
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 440        // x (posición horizontal)
    mov x2, 362        // y (posición vertical)
    mov x3, 11         // ancho
    mov x4, 8         // alto
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    mov x0, x20        // framebuffer
    mov x1, 260        // x (posición horizontal)
    mov x2, 360        // y (posición vertical)
    mov x3, 60        // ancho
    mov x4, 5         // alto
    movz x5, 0x0000, lsl 0
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo


    // Rueda trasera
    mov x0, x20
    mov x1, 455       // centro x
    mov x2, 400       // centro y
    mov x3, 10        // radio
    movz x4, 0x0000, lsl 0
    movk x4, 0x0000, lsl 16     // negro
    bl dibujar_circulo

    // Rueda delantera
    mov x0, x20
    mov x1, 420       // centro x
    mov x2, 400       // centro y
    mov x3, 10        // radio
    movz x4, 0x0000, lsl 0
    movk x4, 0x0000, lsl 16     // negro
    bl dibujar_circulo
    
    // LLanta trasera
    mov x0, x20
    mov x1, 420       // centro x
    mov x2, 400       // centro y
    mov x3, 5        // radio
    movz x4, 0xFFFF, lsl 0
    movk x4, 0xFFFF, lsl 16     // negro
    bl dibujar_circulo

    // LLanta delantera
    mov x0, x20
    mov x1, 455       // centro x
    mov x2, 400       // centro y
    mov x3, 5        // radio
    movz x4, 0xFFFF, lsl 0
    movk x4, 0xFFFF, lsl 16     // negro
    bl dibujar_circulo

// Árbol redondo 1
    mov x0, x20
    mov x1, 200
    mov x2, 420
    mov x3, 145
    movz x4, 0x6400, lsl 0
    movk x4, 0x0000, lsl 16

    movz x5, 0x3300, lsl 0
    movk x5, 0x0066, lsl 16
    bl dibujar_arbol_redondo

    // Árbol redondo 2
    mov x0, x20
    mov x1, 50
    mov x2, 420
    mov x3, 150
    movz x4, 0x8B22, lsl 0
    movk x4, 0x0022, lsl 16
    movz x5, 0x3300, lsl 0
    movk x5, 0x0066, lsl 16
    bl dibujar_arbol_redondo

    // Árbol triangular
    mov x0, x20
    mov x1, 130
    mov x2, 450
    mov x3, 200
    movz x4, 0xBB66, lsl 0
    movk x4, 0x0066, lsl 16
    movz x5, 0x3300, lsl 0
    movk x5, 0x0066, lsl 16
    bl dibujar_arbol_triangular

 // Casa roja
    mov x0, x20
    mov x1, 450
    mov x2, 190
    mov x3, 150
    mov x4, 260
    movz x5, 0x0080, lsl 0
    movk x5, 0x0040, lsl 16
    bl dibujar_rectangulo



 // Ventana Casa Roja ---------------------------------------

    mov x0, x20
    mov x1, 475
    mov x2, 210
    mov x3, 100
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 475
    mov x2, 265
    mov x3, 100
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo 

    mov x0, x20
    mov x1, 475
    mov x2, 320
    mov x3, 100
    mov x4, 40
    movz x5, 0xFFCC, lsl 0
    movk x5, 0x00FF, lsl 16
    bl dibujar_rectangulo

    
// LETRAS ODC 2025 -----------------------------------------
 //O
    // |
    mov x0, x20
    mov x1, 100               
    mov x2, 130          	    
    mov x3, 10               
    mov x4, 50               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo
 
    // _
    mov x0, x20
    mov x1, 100
    mov x2, 175            	    
    mov x3, 40               
    mov x4, 10               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo
 
    // |
    mov x0, x20
    mov x1, 130          
    mov x2, 130            	    
    mov x3, 10               
    mov x4, 50               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo
 
    // -
    mov x0, x20
    mov x1, 100               
    mov x2, 130            	    
    mov x3, 40               
    mov x4, 10               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

  //D

    // -
    mov x0, x20
    mov x1, 150                
    mov x2, 130            	    
    mov x3, 35               
    mov x4, 8               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 150          
    mov x2, 130            	    
    mov x3, 15               
    mov x4, 50               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 185         
    mov x2, 134            	    
    mov x3, 8               
    mov x4, 46               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo
    
    // _
    mov x0, x20
    mov x1, 150                
    mov x2, 175            	    
    mov x3, 35               
    mov x4, 8               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

   //C
    
    // |
    mov x0, x20
    mov x1, 203             
    mov x2, 130  	    
    mov x3, 12               
    mov x4, 50               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    //-
    mov x0, x20
    mov x1, 205           
    mov x2, 130            	    
    mov x3, 35               
    mov x4, 6             
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // _
    mov x0, x20
    mov x1, 205           
    mov x2, 175            	    
    mov x3, 35               
    mov x4, 6             
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    //Numeros en Edificio ROJO

 //2
    // -
    mov x0, x20
    mov x1, 445               
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 5               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 465                
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 15                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // -
    mov x0, x20
    mov x1, 445               
    mov x2, 123           	    
    mov x3, 25               
    mov x4, 7               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 445               
    mov x2, 130            	    
    mov x3, 5                  
    mov x4, 20                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    
    // _
    mov x0, x20
    mov x1, 445               
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

  //0

    // |
    mov x0, x20
    mov x1, 480               
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 45                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 480               
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 500               
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 45                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    mov x0, x20
    mov x1, 480               
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

   //2
    // -
    mov x0, x20
    mov x1, 515               
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 5               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 535           
    mov x2, 110            	    
    mov x3, 5                  
    mov x4, 15                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // -
    mov x0, x20
    mov x1, 515               
    mov x2, 122          	    
    mov x3, 25               
    mov x4, 7               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 515               
    mov x2, 125           	    
    mov x3, 5                  
    mov x4, 20                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // _
    mov x0, x20
    mov x1, 515              
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

   //5
    // -
    mov x0, x20
    mov x1, 550              
    mov x2, 110           	    
    mov x3, 25               
    mov x4, 5               
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 550           
    mov x2, 110            	    
    mov x3, 10                  
    mov x4, 20                  
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // -
    mov x0, x20
    mov x1, 550               
    mov x2, 125        	    
    mov x3, 25               
    mov x4, 5              
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // |
    mov x0, x20
    mov x1, 570              
    mov x2, 125           	    
    mov x3, 5                  
    mov x4, 20                   
    movz x5, 0x0000, lsl 0 
    movk x5, 0x0000, lsl 16
    bl dibujar_rectangulo

    // _
    mov x0, x20
    mov x1, 550              
    mov x2, 145           	    
    mov x3, 25               
    mov x4, 10               
    movz x5, 0x0000, lsl 0
    movk x5, 0x0000, lsl 16

    bl dibujar_rectangulo




    ret

