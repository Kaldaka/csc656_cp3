my_dgemv(int, double*, double*, double*):
        test    edi, edi
        jle     .L14
        mov     r8, rcx
        lea     ecx, [rdi-1]
        push    rbp
        movsx   r9, edi
        mov     r10, rcx
        lea     r11, [r8+8+rcx*8]
        mov     ecx, edi
        mov     rax, rsi
        shr     ecx, 2
        mov     esi, edi
        mov     rbp, rsp
        sal     r9, 3
        dec     ecx
        push    rbx
        and     esi, -4
        vxorpd  xmm4, xmm4, xmm4
        inc     rcx
        sal     rcx, 5
.L7:
        xor     ebx, ebx
        vmovsd  xmm0, xmm4, xmm4
        cmp     r10d, 2
        jbe     .L6
.L4:
        vmovupd ymm5, YMMWORD PTR [rax+rbx]
        vmulpd  ymm1, ymm5, YMMWORD PTR [rdx+rbx]
        add     rbx, 32
        vaddsd  xmm0, xmm0, xmm1
        vunpckhpd       xmm2, xmm1, xmm1
        vextractf128    xmm1, ymm1, 0x1
        vaddsd  xmm0, xmm0, xmm2
        vaddsd  xmm0, xmm0, xmm1
        vunpckhpd       xmm1, xmm1, xmm1
        vaddsd  xmm0, xmm0, xmm1
        cmp     rbx, rcx
        jne     .L4
        cmp     edi, esi
        je      .L5
        movsx   rbx, esi
.L6:
        vmovsd  xmm1, QWORD PTR [rdx+rbx*8]
        vmulsd  xmm1, xmm1, QWORD PTR [rax+rbx*8]
        inc     rbx
        vaddsd  xmm0, xmm0, xmm1
        cmp     edi, ebx
        jg      .L6
.L5:
        vaddsd  xmm0, xmm0, QWORD PTR [r8]
        add     r8, 8
        add     rax, r9
        vmovsd  QWORD PTR [r8-8], xmm0
        cmp     r8, r11
        jne     .L7
        vzeroupper
        mov     rbx, QWORD PTR [rbp-8]
        leave
        ret
.L14:
        ret