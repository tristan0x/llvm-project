; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s --check-prefix=X86

; Incremental updates of the instruction depths should be enough for this test
; case.
; RUN: llc < %s -mtriple=x86_64-unknown -mcpu=haswell -machine-combiner-inc-threshold=0| FileCheck %s --check-prefix=X64-HSW

; Function Attrs: norecurse nounwind readnone uwtable
define i32 @mult(i32, i32) local_unnamed_addr #0 {
; X86-LABEL: mult:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    cmpl $2, %edx
; X86-NEXT:    movl $1, %eax
; X86-NEXT:    movl $1, %esi
; X86-NEXT:    jge .LBB0_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %edx, %esi
; X86-NEXT:  .LBB0_2:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    testl %edx, %edx
; X86-NEXT:    je .LBB0_4
; X86-NEXT:  # %bb.3:
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:  .LBB0_4:
; X86-NEXT:    decl %ecx
; X86-NEXT:    cmpl $31, %ecx
; X86-NEXT:    ja .LBB0_7
; X86-NEXT:  # %bb.5:
; X86-NEXT:    jmpl *.LJTI0_0(,%ecx,4)
; X86-NEXT:  .LBB0_6:
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_7:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:  .LBB0_8:
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_10:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_12:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    jmp .LBB0_9
; X86-NEXT:  .LBB0_13:
; X86-NEXT:    leal (,%eax,8), %ecx
; X86-NEXT:    jmp .LBB0_42
; X86-NEXT:  .LBB0_14:
; X86-NEXT:    shll $3, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_16:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    jmp .LBB0_11
; X86-NEXT:  .LBB0_17:
; X86-NEXT:    leal (%eax,%eax,4), %ecx
; X86-NEXT:    jmp .LBB0_18
; X86-NEXT:  .LBB0_19:
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    jmp .LBB0_9
; X86-NEXT:  .LBB0_20:
; X86-NEXT:    leal (%eax,%eax,2), %ecx
; X86-NEXT:    jmp .LBB0_21
; X86-NEXT:  .LBB0_22:
; X86-NEXT:    leal (%eax,%eax), %ecx
; X86-NEXT:    shll $4, %eax
; X86-NEXT:    jmp .LBB0_23
; X86-NEXT:  .LBB0_24:
; X86-NEXT:    leal (%eax,%eax,4), %eax
; X86-NEXT:    jmp .LBB0_9
; X86-NEXT:  .LBB0_25:
; X86-NEXT:    shll $4, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_26:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $4, %ecx
; X86-NEXT:    jmp .LBB0_27
; X86-NEXT:  .LBB0_28:
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:  .LBB0_15:
; X86-NEXT:    leal (%eax,%eax,8), %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_29:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    leal (%eax,%eax,8), %ecx
; X86-NEXT:  .LBB0_18:
; X86-NEXT:    leal (%eax,%ecx,2), %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_30:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    jmp .LBB0_11
; X86-NEXT:  .LBB0_31:
; X86-NEXT:    leal (%eax,%eax,4), %ecx
; X86-NEXT:  .LBB0_21:
; X86-NEXT:    leal (%eax,%ecx,4), %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_32:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    leal (%eax,%eax,4), %ecx
; X86-NEXT:    leal (%eax,%ecx,4), %ecx
; X86-NEXT:    jmp .LBB0_27
; X86-NEXT:  .LBB0_33:
; X86-NEXT:    leal (%eax,%eax,2), %ecx
; X86-NEXT:    shll $3, %ecx
; X86-NEXT:    jmp .LBB0_42
; X86-NEXT:  .LBB0_34:
; X86-NEXT:    shll $3, %eax
; X86-NEXT:    jmp .LBB0_9
; X86-NEXT:  .LBB0_35:
; X86-NEXT:    leal (%eax,%eax,4), %eax
; X86-NEXT:  .LBB0_11:
; X86-NEXT:    leal (%eax,%eax,4), %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_36:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    leal (%eax,%eax,4), %ecx
; X86-NEXT:    leal (%ecx,%ecx,4), %ecx
; X86-NEXT:    jmp .LBB0_27
; X86-NEXT:  .LBB0_37:
; X86-NEXT:    leal (%eax,%eax,8), %eax
; X86-NEXT:  .LBB0_9:
; X86-NEXT:    leal (%eax,%eax,2), %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_38:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    leal (%eax,%eax,8), %ecx
; X86-NEXT:    leal (%ecx,%ecx,2), %ecx
; X86-NEXT:    jmp .LBB0_27
; X86-NEXT:  .LBB0_39:
; X86-NEXT:    leal (%eax,%eax,8), %ecx
; X86-NEXT:    leal (%ecx,%ecx,2), %ecx
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:  .LBB0_27:
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_40:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    leal (%eax,%eax), %ecx
; X86-NEXT:    shll $5, %eax
; X86-NEXT:  .LBB0_23:
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_41:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $5, %ecx
; X86-NEXT:  .LBB0_42:
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_43:
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-HSW-LABEL: mult:
; X64-HSW:       # %bb.0:
; X64-HSW-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-HSW-NEXT:    cmpl $2, %esi
; X64-HSW-NEXT:    movl $1, %ecx
; X64-HSW-NEXT:    movl %esi, %eax
; X64-HSW-NEXT:    cmovgel %ecx, %eax
; X64-HSW-NEXT:    testl %esi, %esi
; X64-HSW-NEXT:    cmovel %ecx, %eax
; X64-HSW-NEXT:    decl %edi
; X64-HSW-NEXT:    cmpl $31, %edi
; X64-HSW-NEXT:    ja .LBB0_3
; X64-HSW-NEXT:  # %bb.1:
; X64-HSW-NEXT:    jmpq *.LJTI0_0(,%rdi,8)
; X64-HSW-NEXT:  .LBB0_2:
; X64-HSW-NEXT:    addl %eax, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_3:
; X64-HSW-NEXT:    xorl %eax, %eax
; X64-HSW-NEXT:  .LBB0_4:
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_6:
; X64-HSW-NEXT:    shll $2, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_8:
; X64-HSW-NEXT:    addl %eax, %eax
; X64-HSW-NEXT:  .LBB0_5:
; X64-HSW-NEXT:    leal (%rax,%rax,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_9:
; X64-HSW-NEXT:    leal (,%rax,8), %ecx
; X64-HSW-NEXT:    jmp .LBB0_38
; X64-HSW-NEXT:  .LBB0_10:
; X64-HSW-NEXT:    shll $3, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_12:
; X64-HSW-NEXT:    addl %eax, %eax
; X64-HSW-NEXT:  .LBB0_7:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_13:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %ecx
; X64-HSW-NEXT:    leal (%rax,%rcx,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_15:
; X64-HSW-NEXT:    shll $2, %eax
; X64-HSW-NEXT:    leal (%rax,%rax,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_16:
; X64-HSW-NEXT:    leal (%rax,%rax,2), %ecx
; X64-HSW-NEXT:    leal (%rax,%rcx,4), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_18:
; X64-HSW-NEXT:    leal (%rax,%rax), %ecx
; X64-HSW-NEXT:    shll $4, %eax
; X64-HSW-NEXT:    subl %ecx, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_20:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %eax
; X64-HSW-NEXT:    leal (%rax,%rax,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_21:
; X64-HSW-NEXT:    shll $4, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_22:
; X64-HSW-NEXT:    movl %eax, %ecx
; X64-HSW-NEXT:    shll $4, %ecx
; X64-HSW-NEXT:    jmp .LBB0_34
; X64-HSW-NEXT:  .LBB0_23:
; X64-HSW-NEXT:    addl %eax, %eax
; X64-HSW-NEXT:  .LBB0_11:
; X64-HSW-NEXT:    leal (%rax,%rax,8), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_24:
; X64-HSW-NEXT:    leal (%rax,%rax,8), %ecx
; X64-HSW-NEXT:    leal (%rax,%rcx,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_25:
; X64-HSW-NEXT:    shll $2, %eax
; X64-HSW-NEXT:    leal (%rax,%rax,4), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_26:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %ecx
; X64-HSW-NEXT:    leal (%rax,%rcx,4), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_27:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %ecx
; X64-HSW-NEXT:    leal (%rax,%rcx,4), %ecx
; X64-HSW-NEXT:    jmp .LBB0_34
; X64-HSW-NEXT:  .LBB0_28:
; X64-HSW-NEXT:    leal (%rax,%rax,2), %ecx
; X64-HSW-NEXT:    shll $3, %ecx
; X64-HSW-NEXT:    jmp .LBB0_38
; X64-HSW-NEXT:  .LBB0_29:
; X64-HSW-NEXT:    shll $3, %eax
; X64-HSW-NEXT:    leal (%rax,%rax,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_30:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %eax
; X64-HSW-NEXT:    leal (%rax,%rax,4), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_31:
; X64-HSW-NEXT:    leal (%rax,%rax,4), %ecx
; X64-HSW-NEXT:    leal (%rcx,%rcx,4), %ecx
; X64-HSW-NEXT:    jmp .LBB0_34
; X64-HSW-NEXT:  .LBB0_32:
; X64-HSW-NEXT:    leal (%rax,%rax,8), %eax
; X64-HSW-NEXT:    leal (%rax,%rax,2), %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_33:
; X64-HSW-NEXT:    leal (%rax,%rax,8), %ecx
; X64-HSW-NEXT:    leal (%rcx,%rcx,2), %ecx
; X64-HSW-NEXT:  .LBB0_34:
; X64-HSW-NEXT:    addl %eax, %ecx
; X64-HSW-NEXT:    movl %ecx, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_35:
; X64-HSW-NEXT:    leal (%rax,%rax,8), %ecx
; X64-HSW-NEXT:    leal (%rcx,%rcx,2), %ecx
; X64-HSW-NEXT:    addl %eax, %eax
; X64-HSW-NEXT:    addl %ecx, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_36:
; X64-HSW-NEXT:    leal (%rax,%rax), %ecx
; X64-HSW-NEXT:    shll $5, %eax
; X64-HSW-NEXT:    subl %ecx, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_37:
; X64-HSW-NEXT:    movl %eax, %ecx
; X64-HSW-NEXT:    shll $5, %ecx
; X64-HSW-NEXT:  .LBB0_38:
; X64-HSW-NEXT:    subl %eax, %ecx
; X64-HSW-NEXT:    movl %ecx, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
; X64-HSW-NEXT:  .LBB0_40:
; X64-HSW-NEXT:    shll $5, %eax
; X64-HSW-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-HSW-NEXT:    retq
  %3 = icmp eq i32 %1, 0
  %4 = icmp sgt i32 %1, 1
  %5 = or i1 %3, %4
  %6 = select i1 %5, i32 1, i32 %1
  switch i32 %0, label %69 [
    i32 1, label %70
    i32 2, label %7
    i32 3, label %9
    i32 4, label %11
    i32 5, label %13
    i32 6, label %15
    i32 7, label %17
    i32 8, label %19
    i32 9, label %21
    i32 10, label %23
    i32 11, label %25
    i32 12, label %27
    i32 13, label %29
    i32 14, label %31
    i32 15, label %33
    i32 16, label %35
    i32 17, label %37
    i32 18, label %39
    i32 19, label %41
    i32 20, label %43
    i32 21, label %45
    i32 22, label %47
    i32 23, label %49
    i32 24, label %51
    i32 25, label %53
    i32 26, label %55
    i32 27, label %57
    i32 28, label %59
    i32 29, label %61
    i32 30, label %63
    i32 31, label %65
    i32 32, label %67
  ]

; <label>:7:                                      ; preds = %2
  %8 = shl nsw i32 %6, 1
  br label %70

; <label>:9:                                      ; preds = %2
  %10 = mul nsw i32 %6, 3
  br label %70

; <label>:11:                                     ; preds = %2
  %12 = shl nsw i32 %6, 2
  br label %70

; <label>:13:                                     ; preds = %2
  %14 = mul nsw i32 %6, 5
  br label %70

; <label>:15:                                     ; preds = %2
  %16 = mul nsw i32 %6, 6
  br label %70

; <label>:17:                                     ; preds = %2
  %18 = mul nsw i32 %6, 7
  br label %70

; <label>:19:                                     ; preds = %2
  %20 = shl nsw i32 %6, 3
  br label %70

; <label>:21:                                     ; preds = %2
  %22 = mul nsw i32 %6, 9
  br label %70

; <label>:23:                                     ; preds = %2
  %24 = mul nsw i32 %6, 10
  br label %70

; <label>:25:                                     ; preds = %2
  %26 = mul nsw i32 %6, 11
  br label %70

; <label>:27:                                     ; preds = %2
  %28 = mul nsw i32 %6, 12
  br label %70

; <label>:29:                                     ; preds = %2
  %30 = mul nsw i32 %6, 13
  br label %70

; <label>:31:                                     ; preds = %2
  %32 = mul nsw i32 %6, 14
  br label %70

; <label>:33:                                     ; preds = %2
  %34 = mul nsw i32 %6, 15
  br label %70

; <label>:35:                                     ; preds = %2
  %36 = shl nsw i32 %6, 4
  br label %70

; <label>:37:                                     ; preds = %2
  %38 = mul nsw i32 %6, 17
  br label %70

; <label>:39:                                     ; preds = %2
  %40 = mul nsw i32 %6, 18
  br label %70

; <label>:41:                                     ; preds = %2
  %42 = mul nsw i32 %6, 19
  br label %70

; <label>:43:                                     ; preds = %2
  %44 = mul nsw i32 %6, 20
  br label %70

; <label>:45:                                     ; preds = %2
  %46 = mul nsw i32 %6, 21
  br label %70

; <label>:47:                                     ; preds = %2
  %48 = mul nsw i32 %6, 22
  br label %70

; <label>:49:                                     ; preds = %2
  %50 = mul nsw i32 %6, 23
  br label %70

; <label>:51:                                     ; preds = %2
  %52 = mul nsw i32 %6, 24
  br label %70

; <label>:53:                                     ; preds = %2
  %54 = mul nsw i32 %6, 25
  br label %70

; <label>:55:                                     ; preds = %2
  %56 = mul nsw i32 %6, 26
  br label %70

; <label>:57:                                     ; preds = %2
  %58 = mul nsw i32 %6, 27
  br label %70

; <label>:59:                                     ; preds = %2
  %60 = mul nsw i32 %6, 28
  br label %70

; <label>:61:                                     ; preds = %2
  %62 = mul nsw i32 %6, 29
  br label %70

; <label>:63:                                     ; preds = %2
  %64 = mul nsw i32 %6, 30
  br label %70

; <label>:65:                                     ; preds = %2
  %66 = mul nsw i32 %6, 31
  br label %70

; <label>:67:                                     ; preds = %2
  %68 = shl nsw i32 %6, 5
  br label %70

; <label>:69:                                     ; preds = %2
  br label %70

; <label>:70:                                     ; preds = %2, %69, %67, %65, %63, %61, %59, %57, %55, %53, %51, %49, %47, %45, %43, %41, %39, %37, %35, %33, %31, %29, %27, %25, %23, %21, %19, %17, %15, %13, %11, %9, %7
  %71 = phi i32 [ %8, %7 ], [ %10, %9 ], [ %12, %11 ], [ %14, %13 ], [ %16, %15 ], [ %18, %17 ], [ %20, %19 ], [ %22, %21 ], [ %24, %23 ], [ %26, %25 ], [ %28, %27 ], [ %30, %29 ], [ %32, %31 ], [ %34, %33 ], [ %36, %35 ], [ %38, %37 ], [ %40, %39 ], [ %42, %41 ], [ %44, %43 ], [ %46, %45 ], [ %48, %47 ], [ %50, %49 ], [ %52, %51 ], [ %54, %53 ], [ %56, %55 ], [ %58, %57 ], [ %60, %59 ], [ %62, %61 ], [ %64, %63 ], [ %66, %65 ], [ %68, %67 ], [ 0, %69 ], [ %6, %2 ]
  ret i32 %71
}

; Function Attrs: norecurse nounwind readnone uwtable
define i32 @foo() local_unnamed_addr #0 {
; X86-LABEL: foo:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 20
; X86-NEXT:    .cfi_offset %esi, -20
; X86-NEXT:    .cfi_offset %edi, -16
; X86-NEXT:    .cfi_offset %ebx, -12
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    pushl $0
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $1
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $1, %esi
; X86-NEXT:    pushl $1
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $2
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $2, %edi
; X86-NEXT:    orl %esi, %edi
; X86-NEXT:    pushl $1
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $3
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $3, %ebx
; X86-NEXT:    pushl $2
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $4
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $4, %esi
; X86-NEXT:    orl %ebx, %esi
; X86-NEXT:    orl %edi, %esi
; X86-NEXT:    pushl $2
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $5
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $5, %edi
; X86-NEXT:    pushl $3
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $6
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $6, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $3
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $7
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $7, %edi
; X86-NEXT:    orl %ebx, %edi
; X86-NEXT:    orl %esi, %edi
; X86-NEXT:    pushl $4
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $8
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $8, %esi
; X86-NEXT:    pushl $4
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $9
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $9, %ebx
; X86-NEXT:    orl %esi, %ebx
; X86-NEXT:    pushl $5
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $10
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebp
; X86-NEXT:    xorl $10, %ebp
; X86-NEXT:    orl %ebx, %ebp
; X86-NEXT:    pushl $5
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $11
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $11, %esi
; X86-NEXT:    orl %ebp, %esi
; X86-NEXT:    orl %edi, %esi
; X86-NEXT:    pushl $6
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $12
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $12, %edi
; X86-NEXT:    pushl $6
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $13
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $13, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $7
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $14
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $14, %edi
; X86-NEXT:    orl %ebx, %edi
; X86-NEXT:    pushl $7
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $15
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $15, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $8
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $16
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $16, %edi
; X86-NEXT:    orl %ebx, %edi
; X86-NEXT:    orl %esi, %edi
; X86-NEXT:    pushl $8
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $17
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $17, %esi
; X86-NEXT:    pushl $9
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $18
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $18, %ebx
; X86-NEXT:    orl %esi, %ebx
; X86-NEXT:    pushl $9
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $19
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $19, %esi
; X86-NEXT:    orl %ebx, %esi
; X86-NEXT:    pushl $10
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $20
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $20, %ebx
; X86-NEXT:    orl %esi, %ebx
; X86-NEXT:    pushl $10
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $21
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebp
; X86-NEXT:    xorl $21, %ebp
; X86-NEXT:    orl %ebx, %ebp
; X86-NEXT:    pushl $11
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $22
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $22, %esi
; X86-NEXT:    orl %ebp, %esi
; X86-NEXT:    orl %edi, %esi
; X86-NEXT:    pushl $11
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $23
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $23, %edi
; X86-NEXT:    pushl $12
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $24
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $24, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $12
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $25
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $25, %edi
; X86-NEXT:    orl %ebx, %edi
; X86-NEXT:    pushl $13
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $26
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $26, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $13
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $27
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $27, %edi
; X86-NEXT:    orl %ebx, %edi
; X86-NEXT:    pushl $14
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $28
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $28, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $14
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $29
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl $29, %edi
; X86-NEXT:    orl %ebx, %edi
; X86-NEXT:    orl %esi, %edi
; X86-NEXT:    pushl $15
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $30
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    xorl $30, %esi
; X86-NEXT:    pushl $15
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $31
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    xorl $31, %ebx
; X86-NEXT:    orl %esi, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    pushl $16
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl $32
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll mult@PLT
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:    xorl $32, %eax
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    orl %ebx, %eax
; X86-NEXT:    setne %cl
; X86-NEXT:    negl %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    popl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-HSW-LABEL: foo:
; X64-HSW:       # %bb.0:
; X64-HSW-NEXT:    pushq %rbp
; X64-HSW-NEXT:    .cfi_def_cfa_offset 16
; X64-HSW-NEXT:    pushq %r15
; X64-HSW-NEXT:    .cfi_def_cfa_offset 24
; X64-HSW-NEXT:    pushq %r14
; X64-HSW-NEXT:    .cfi_def_cfa_offset 32
; X64-HSW-NEXT:    pushq %rbx
; X64-HSW-NEXT:    .cfi_def_cfa_offset 40
; X64-HSW-NEXT:    pushq %rax
; X64-HSW-NEXT:    .cfi_def_cfa_offset 48
; X64-HSW-NEXT:    .cfi_offset %rbx, -40
; X64-HSW-NEXT:    .cfi_offset %r14, -32
; X64-HSW-NEXT:    .cfi_offset %r15, -24
; X64-HSW-NEXT:    .cfi_offset %rbp, -16
; X64-HSW-NEXT:    movl $1, %edi
; X64-HSW-NEXT:    xorl %esi, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $1, %ebx
; X64-HSW-NEXT:    movl $2, %edi
; X64-HSW-NEXT:    movl $1, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $2, %ebp
; X64-HSW-NEXT:    orl %ebx, %ebp
; X64-HSW-NEXT:    movl $3, %edi
; X64-HSW-NEXT:    movl $1, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $3, %ebx
; X64-HSW-NEXT:    movl $4, %edi
; X64-HSW-NEXT:    movl $2, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $4, %r14d
; X64-HSW-NEXT:    orl %ebx, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $5, %edi
; X64-HSW-NEXT:    movl $2, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $5, %ebx
; X64-HSW-NEXT:    movl $6, %edi
; X64-HSW-NEXT:    movl $3, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r15d
; X64-HSW-NEXT:    xorl $6, %r15d
; X64-HSW-NEXT:    orl %ebx, %r15d
; X64-HSW-NEXT:    movl $7, %edi
; X64-HSW-NEXT:    movl $3, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $7, %ebp
; X64-HSW-NEXT:    orl %r15d, %ebp
; X64-HSW-NEXT:    orl %r14d, %ebp
; X64-HSW-NEXT:    movl $8, %edi
; X64-HSW-NEXT:    movl $4, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $8, %ebx
; X64-HSW-NEXT:    movl $9, %edi
; X64-HSW-NEXT:    movl $4, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $9, %r14d
; X64-HSW-NEXT:    orl %ebx, %r14d
; X64-HSW-NEXT:    movl $10, %edi
; X64-HSW-NEXT:    movl $5, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r15d
; X64-HSW-NEXT:    xorl $10, %r15d
; X64-HSW-NEXT:    orl %r14d, %r15d
; X64-HSW-NEXT:    movl $11, %edi
; X64-HSW-NEXT:    movl $5, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $11, %ebx
; X64-HSW-NEXT:    orl %r15d, %ebx
; X64-HSW-NEXT:    orl %ebp, %ebx
; X64-HSW-NEXT:    movl $12, %edi
; X64-HSW-NEXT:    movl $6, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $12, %ebp
; X64-HSW-NEXT:    movl $13, %edi
; X64-HSW-NEXT:    movl $6, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $13, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $14, %edi
; X64-HSW-NEXT:    movl $7, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $14, %ebp
; X64-HSW-NEXT:    orl %r14d, %ebp
; X64-HSW-NEXT:    movl $15, %edi
; X64-HSW-NEXT:    movl $7, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $15, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $16, %edi
; X64-HSW-NEXT:    movl $8, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $16, %ebp
; X64-HSW-NEXT:    orl %r14d, %ebp
; X64-HSW-NEXT:    orl %ebx, %ebp
; X64-HSW-NEXT:    movl $17, %edi
; X64-HSW-NEXT:    movl $8, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $17, %ebx
; X64-HSW-NEXT:    movl $18, %edi
; X64-HSW-NEXT:    movl $9, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $18, %r14d
; X64-HSW-NEXT:    orl %ebx, %r14d
; X64-HSW-NEXT:    movl $19, %edi
; X64-HSW-NEXT:    movl $9, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $19, %ebx
; X64-HSW-NEXT:    orl %r14d, %ebx
; X64-HSW-NEXT:    movl $20, %edi
; X64-HSW-NEXT:    movl $10, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $20, %r14d
; X64-HSW-NEXT:    orl %ebx, %r14d
; X64-HSW-NEXT:    movl $21, %edi
; X64-HSW-NEXT:    movl $10, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r15d
; X64-HSW-NEXT:    xorl $21, %r15d
; X64-HSW-NEXT:    orl %r14d, %r15d
; X64-HSW-NEXT:    movl $22, %edi
; X64-HSW-NEXT:    movl $11, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $22, %ebx
; X64-HSW-NEXT:    orl %r15d, %ebx
; X64-HSW-NEXT:    orl %ebp, %ebx
; X64-HSW-NEXT:    movl $23, %edi
; X64-HSW-NEXT:    movl $11, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $23, %ebp
; X64-HSW-NEXT:    movl $24, %edi
; X64-HSW-NEXT:    movl $12, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $24, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $25, %edi
; X64-HSW-NEXT:    movl $12, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $25, %ebp
; X64-HSW-NEXT:    orl %r14d, %ebp
; X64-HSW-NEXT:    movl $26, %edi
; X64-HSW-NEXT:    movl $13, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $26, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $27, %edi
; X64-HSW-NEXT:    movl $13, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $27, %ebp
; X64-HSW-NEXT:    orl %r14d, %ebp
; X64-HSW-NEXT:    movl $28, %edi
; X64-HSW-NEXT:    movl $14, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $28, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $29, %edi
; X64-HSW-NEXT:    movl $14, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebp
; X64-HSW-NEXT:    xorl $29, %ebp
; X64-HSW-NEXT:    orl %r14d, %ebp
; X64-HSW-NEXT:    orl %ebx, %ebp
; X64-HSW-NEXT:    movl $30, %edi
; X64-HSW-NEXT:    movl $15, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %ebx
; X64-HSW-NEXT:    xorl $30, %ebx
; X64-HSW-NEXT:    movl $31, %edi
; X64-HSW-NEXT:    movl $15, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    movl %eax, %r14d
; X64-HSW-NEXT:    xorl $31, %r14d
; X64-HSW-NEXT:    orl %ebx, %r14d
; X64-HSW-NEXT:    orl %ebp, %r14d
; X64-HSW-NEXT:    movl $32, %edi
; X64-HSW-NEXT:    movl $16, %esi
; X64-HSW-NEXT:    callq mult@PLT
; X64-HSW-NEXT:    xorl $32, %eax
; X64-HSW-NEXT:    xorl %ecx, %ecx
; X64-HSW-NEXT:    orl %r14d, %eax
; X64-HSW-NEXT:    setne %cl
; X64-HSW-NEXT:    negl %ecx
; X64-HSW-NEXT:    movl %ecx, %eax
; X64-HSW-NEXT:    addq $8, %rsp
; X64-HSW-NEXT:    .cfi_def_cfa_offset 40
; X64-HSW-NEXT:    popq %rbx
; X64-HSW-NEXT:    .cfi_def_cfa_offset 32
; X64-HSW-NEXT:    popq %r14
; X64-HSW-NEXT:    .cfi_def_cfa_offset 24
; X64-HSW-NEXT:    popq %r15
; X64-HSW-NEXT:    .cfi_def_cfa_offset 16
; X64-HSW-NEXT:    popq %rbp
; X64-HSW-NEXT:    .cfi_def_cfa_offset 8
; X64-HSW-NEXT:    retq
  %1 = tail call i32 @mult(i32 1, i32 0)
  %2 = icmp ne i32 %1, 1
  %3 = tail call i32 @mult(i32 2, i32 1)
  %4 = icmp ne i32 %3, 2
  %5 = or i1 %2, %4
  %6 = tail call i32 @mult(i32 3, i32 1)
  %7 = icmp ne i32 %6, 3
  %8 = or i1 %5, %7
  %9 = tail call i32 @mult(i32 4, i32 2)
  %10 = icmp ne i32 %9, 4
  %11 = or i1 %8, %10
  %12 = tail call i32 @mult(i32 5, i32 2)
  %13 = icmp ne i32 %12, 5
  %14 = or i1 %11, %13
  %15 = tail call i32 @mult(i32 6, i32 3)
  %16 = icmp ne i32 %15, 6
  %17 = or i1 %14, %16
  %18 = tail call i32 @mult(i32 7, i32 3)
  %19 = icmp ne i32 %18, 7
  %20 = or i1 %17, %19
  %21 = tail call i32 @mult(i32 8, i32 4)
  %22 = icmp ne i32 %21, 8
  %23 = or i1 %20, %22
  %24 = tail call i32 @mult(i32 9, i32 4)
  %25 = icmp ne i32 %24, 9
  %26 = or i1 %23, %25
  %27 = tail call i32 @mult(i32 10, i32 5)
  %28 = icmp ne i32 %27, 10
  %29 = or i1 %26, %28
  %30 = tail call i32 @mult(i32 11, i32 5)
  %31 = icmp ne i32 %30, 11
  %32 = or i1 %29, %31
  %33 = tail call i32 @mult(i32 12, i32 6)
  %34 = icmp ne i32 %33, 12
  %35 = or i1 %32, %34
  %36 = tail call i32 @mult(i32 13, i32 6)
  %37 = icmp ne i32 %36, 13
  %38 = or i1 %35, %37
  %39 = tail call i32 @mult(i32 14, i32 7)
  %40 = icmp ne i32 %39, 14
  %41 = or i1 %38, %40
  %42 = tail call i32 @mult(i32 15, i32 7)
  %43 = icmp ne i32 %42, 15
  %44 = or i1 %41, %43
  %45 = tail call i32 @mult(i32 16, i32 8)
  %46 = icmp ne i32 %45, 16
  %47 = or i1 %44, %46
  %48 = tail call i32 @mult(i32 17, i32 8)
  %49 = icmp ne i32 %48, 17
  %50 = or i1 %47, %49
  %51 = tail call i32 @mult(i32 18, i32 9)
  %52 = icmp ne i32 %51, 18
  %53 = or i1 %50, %52
  %54 = tail call i32 @mult(i32 19, i32 9)
  %55 = icmp ne i32 %54, 19
  %56 = or i1 %53, %55
  %57 = tail call i32 @mult(i32 20, i32 10)
  %58 = icmp ne i32 %57, 20
  %59 = or i1 %56, %58
  %60 = tail call i32 @mult(i32 21, i32 10)
  %61 = icmp ne i32 %60, 21
  %62 = or i1 %59, %61
  %63 = tail call i32 @mult(i32 22, i32 11)
  %64 = icmp ne i32 %63, 22
  %65 = or i1 %62, %64
  %66 = tail call i32 @mult(i32 23, i32 11)
  %67 = icmp ne i32 %66, 23
  %68 = or i1 %65, %67
  %69 = tail call i32 @mult(i32 24, i32 12)
  %70 = icmp ne i32 %69, 24
  %71 = or i1 %68, %70
  %72 = tail call i32 @mult(i32 25, i32 12)
  %73 = icmp ne i32 %72, 25
  %74 = or i1 %71, %73
  %75 = tail call i32 @mult(i32 26, i32 13)
  %76 = icmp ne i32 %75, 26
  %77 = or i1 %74, %76
  %78 = tail call i32 @mult(i32 27, i32 13)
  %79 = icmp ne i32 %78, 27
  %80 = or i1 %77, %79
  %81 = tail call i32 @mult(i32 28, i32 14)
  %82 = icmp ne i32 %81, 28
  %83 = or i1 %80, %82
  %84 = tail call i32 @mult(i32 29, i32 14)
  %85 = icmp ne i32 %84, 29
  %86 = or i1 %83, %85
  %87 = tail call i32 @mult(i32 30, i32 15)
  %88 = icmp ne i32 %87, 30
  %89 = or i1 %86, %88
  %90 = tail call i32 @mult(i32 31, i32 15)
  %91 = icmp ne i32 %90, 31
  %92 = or i1 %89, %91
  %93 = tail call i32 @mult(i32 32, i32 16)
  %94 = icmp ne i32 %93, 32
  %95 = or i1 %92, %94
  %96 = sext i1 %95 to i32
  ret i32 %96
}

attributes #0 = { norecurse nounwind readnone uwtable  }
