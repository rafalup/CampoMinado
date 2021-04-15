.data
.LC2:
        .asciz "SITUACAO DO CAMPO MINADO"
.LC3:
        .ascii " 8 "
.LC4:
        .ascii "%d "
.LC5:
        .string " %d "
.LC6:
        .string ""


.LC0:
        .word 0, 9, 9, 9, 0, 9, 0, 9
        .word 0, 0, 0, 0, 0, 0, 9, 9
        .word 0, 0, 9, 9, 0, 0, 0, 0
        .word 0, 0, 0, 0, 0, 0, 0, 9
        .word 0, 9, 0, 9, 9, 0, 9, 0
        .word 0, 9, 0, 0, 0, 9, 9, 9
        .word 0, 0, 9, 0, 0, 0, 0, 0
        .word 9, 0, 0, 9, 0, 9, 0, 9

.LC1:
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1
        .word  -1, -1, -1, -1, -1, -1, -1, -1


        
.text
mostra_campo:
        addi    sp,sp,-48
        sw      ra,44(sp)
        sw      s0,40(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        sw      a2,-44(s0)
        sw      a3,-48(s0)
        lui     a5,%hi(.LC2)
        addi    a0,a5,%lo(.LC2)
        #ecall    puts
        sw      zero,-20(s0)
        j       .L2
.L8:
        sw      zero,-24(s0)
        j       .L3
.L7:
        lw      a4,-48(s0)
        li      a5,1
        bne     a4,a5,.L4
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,9
        bne     a4,a5,.L4
        lui     a5,%hi(.LC3)
        addi    a0,a5,%lo(.LC3)
       # call    printf
        j       .L5
.L4:
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-40(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,-1
        bne     a4,a5,.L6
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-40(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        mv      a1,a5
        lui     a5,%hi(.LC4)
        addi    a0,a5,%lo(.LC4)
        #call    printf
        j       .L5
.L6:
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-40(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        mv      a1,a5
        lui     a5,%hi(.LC5)
        addi    a0,a5,%lo(.LC5)
        #call    printf
.L5:
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
.L3:
        lw      a4,-24(s0)
        lw      a5,-44(s0)
        blt     a4,a5,.L7
        lui     a5,%hi(.LC6)
        addi    a0,a5,%lo(.LC6)
        #call    puts
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L2:
        lw      a4,-20(s0)
        lw      a5,-44(s0)
        blt     a4,a5,.L8
        nop
        nop
        lw      ra,44(sp)
        lw      s0,40(sp)
        addi    sp,sp,48
        jr      ra
        
calcula_bomba:
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        lw      a5,-40(s0)
        addi    a5,a5,-1
        sw      a5,-32(s0)
        sw      zero,-20(s0)
        j       .L10

.L23:
        sw      zero,-24(s0)
        j       .L11

.L22:
        sw      zero,-28(s0)
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        beq     a4,a5,.L24
        lw      a5,-20(s0)
        beq     a5,zero,.L14
        lw      a5,-24(s0)
        beq     a5,zero,.L14
        lw      a4,-20(s0)
        li      a5,134217728
        addi    a5,a5,-1
        add     a5,a4,a5
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        addi    a5,a5,-1
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L14
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L14:
        lw      a5,-20(s0)
        beq     a5,zero,.L15
        lw      a4,-20(s0)
        li      a5,134217728
        addi    a5,a5,-1
        add     a5,a4,a5
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L15
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L15:
        lw      a5,-20(s0)
        beq     a5,zero,.L16
        lw      a4,-24(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L16
        lw      a4,-20(s0)
        li      a5,134217728
        addi    a5,a5,-1
        add     a5,a4,a5
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        addi    a5,a5,1
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L16
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L16:
        lw      a5,-24(s0)
        beq     a5,zero,.L17
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        addi    a5,a5,-1
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L17
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L17:
        lw      a4,-24(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L18
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        addi    a5,a5,1
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L18
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L18:
        lw      a4,-20(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L19
        lw      a5,-24(s0)
        beq     a5,zero,.L19
        lw      a5,-20(s0)
        addi    a5,a5,1
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        addi    a5,a5,-1
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L19
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L19:
        lw      a4,-20(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L20
        lw      a5,-20(s0)
        addi    a5,a5,1
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L20
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L20:
        lw      a4,-20(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L21
        lw      a4,-24(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L21
        lw      a5,-20(s0)
        addi    a5,a5,1
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        addi    a5,a5,1
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,8
        bne     a4,a5,.L21
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L21:
        lw      a5,-20(s0)
        slli    a5,a5,5
        lw      a4,-36(s0)
        add     a4,a4,a5
        lw      a5,-24(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,-28(s0)
        sw      a4,0(a5)
        j       .L13
.L24:
        nop
.L13:
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
.L11:
        lw      a4,-24(s0)
        lw      a5,-40(s0)
        blt     a4,a5,.L22
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L10:
        lw      a4,-20(s0)
        lw      a5,-40(s0)
        blt     a4,a5,.L23
        nop
        nop
        lw      s0,44(sp)
        addi    sp,sp,48
        jr      ra
#.LC7:
 #       .string "\nDigite as coordenadas do campo minado (coluna)(linha): "
#.LC8:
     #   .string "%d"
#.LC9:
      #  .string "\nA BOMBA EXPLODIU! VOCE PERDEU!"


main:
        addi    sp,sp,-544
        sw      ra,540(sp)
        sw      s0,536(sp)
        addi    s0,sp,544
        lui     a5,%hi(.LC0)
        addi    a4,a5,%lo(.LC0)
        addi    a5,s0,-280
        mv      a3,a4
        li      a4,256
        mv      a2,a4
        mv      a1,a3
        mv      a0,a5
        #call    memcpy
        lui     a5,%hi(.LC1)
        addi    a4,a5,%lo(.LC1)
        addi    a5,s0,-536
        mv      a3,a4
        li      a4,256
        mv      a2,a4
        mv      a1,a3
        mv      a0,a5
       # call    memcpy
        li      a5,8
        sw      a5,-20(s0)
        sw      zero,-24(s0)
        addi    a5,s0,-280
        lw      a1,-20(s0)
        mv      a0,a5
        call    calcula_bomba
.L30:
        addi    a4,s0,-536
        addi    a5,s0,-280
        lw      a3,-24(s0)
        lw      a2,-20(s0)
        mv      a1,a4
        mv      a0,a5
        call    mostra_campo
        #lui     a5,%hi(.LC7)
        #addi    a0,a5,%lo(.LC7)
        #call    puts
        addi    a5,s0,-544
        mv      a1,a5
       # lui     a5,%hi(.LC8)
        #addi    a0,a5,%lo(.LC8)
        #call    scanf
        addi    a5,s0,-540
        mv      a1,a5
        #lui     a5,%hi(.LC8)
        #addi    a0,a5,%lo(.LC8)
        #call    scanf
        lui     a5,%hi(.LC6)
        addi    a0,a5,%lo(.LC6)
        #call    puts
        lw      a5,-544(s0)
        lw      a4,-20(s0)
        blt     a4,a5,.L33
        lw      a5,-540(s0)
        lw      a4,-20(s0)
        blt     a4,a5,.L33
        lw      a5,-540(s0)
        beq     a5,zero,.L33
        lw      a5,-544(s0)
        beq     a5,zero,.L33
        lw      a5,-540(s0)
        addi    a5,a5,-1
        sw      a5,-540(s0)
        lw      a5,-544(s0)
        addi    a5,a5,-1
        sw      a5,-544(s0)
        lw      a4,-540(s0)
        lw      a5,-544(s0)
        lw      a2,-540(s0)
        lw      a3,-544(s0)
        slli    a4,a4,3
        add     a5,a4,a5
        slli    a5,a5,2
        addi    a4,s0,-16
        add     a5,a4,a5
        lw      a4,-264(a5)
        slli    a5,a2,3
        add     a5,a5,a3
        slli    a5,a5,2
        addi    a3,s0,-16
        add     a5,a3,a5
        sw      a4,-520(a5)
        lw      a4,-540(s0)
        lw      a5,-544(s0)
        slli    a4,a4,3
        add     a5,a4,a5
        slli    a5,a5,2
        addi    a4,s0,-16
        add     a5,a4,a5
        lw      a4,-264(a5)
        li      a5,8
        bne     a4,a5,.L30
        li      a5,1
        sw      a5,-24(s0)
      
        #call    puts
        addi    a4,s0,-536
        addi    a5,s0,-280
        lw      a3,-24(s0)
        lw      a2,-20(s0)
        mv      a1,a4
        mv      a0,a5
        call    mostra_campo
        j       .L32
.L33:
        nop
        j       .L30
.L32:
        li      a5,0
        mv      a0,a5
        lw      ra,540(sp)
        lw      s0,536(sp)
        addi    sp,sp,544
        jr      ra