; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown              | FileCheck %s --check-prefixes=X64-NOBMI2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi2 | FileCheck %s --check-prefixes=X64-BMI2
; RUN: llc < %s -mtriple=i686-unknown-unknown                | FileCheck %s --check-prefixes=X32-NOBMI2
; RUN: llc < %s -mtriple=i686-unknown-unknown   -mattr=+bmi2 | FileCheck %s --check-prefixes=X32-BMI2

define i64 @t0(i64 %val, i64 %shamt) nounwind {
; X64-NOBMI2-LABEL: t0:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    leaq 32(%rsi), %rcx
; X64-NOBMI2-NEXT:    negq %rcx
; X64-NOBMI2-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: t0:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    addq $32, %rsi
; X64-BMI2-NEXT:    negq %rsi
; X64-BMI2-NEXT:    shlxq %rsi, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: t0:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movb $32, %cl
; X32-NOBMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB0_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB0_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: t0:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movb $32, %cl
; X32-BMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB0_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB0_2:
; X32-BMI2-NEXT:    retl
  %negshamt = sub i64 32, %shamt
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}

; The constant we are subtracting from should be a multiple of 32.
define i64 @n1(i64 %val, i64 %shamt) nounwind {
; X64-NOBMI2-LABEL: n1:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    movb $33, %cl
; X64-NOBMI2-NEXT:    subb %sil, %cl
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: n1:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    movb $33, %al
; X64-BMI2-NEXT:    subb %sil, %al
; X64-BMI2-NEXT:    shlxq %rax, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: n1:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movb $33, %cl
; X32-NOBMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB1_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB1_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: n1:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movb $33, %cl
; X32-BMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB1_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB1_2:
; X32-BMI2-NEXT:    retl
  %negshamt = sub i64 33, %shamt
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}
define i64 @n2(i64 %val, i64 %shamt) nounwind {
; X64-NOBMI2-LABEL: n2:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    movb $31, %cl
; X64-NOBMI2-NEXT:    subb %sil, %cl
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: n2:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    movb $31, %al
; X64-BMI2-NEXT:    subb %sil, %al
; X64-BMI2-NEXT:    shlxq %rax, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: n2:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movb $31, %cl
; X32-NOBMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB2_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB2_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: n2:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movb $31, %cl
; X32-BMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB2_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB2_2:
; X32-BMI2-NEXT:    retl
  %negshamt = sub i64 31, %shamt
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}

define i64 @t3(i64 %val, i64 %shamt) nounwind {
; X64-NOBMI2-LABEL: t3:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rsi, %rcx
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    negb %cl
; X64-NOBMI2-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: t3:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    negb %sil
; X64-BMI2-NEXT:    shlxq %rsi, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: t3:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movb $64, %cl
; X32-NOBMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB3_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB3_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: t3:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movb $64, %cl
; X32-BMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB3_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB3_2:
; X32-BMI2-NEXT:    retl
  %negshamt = sub i64 64, %shamt
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}

define i64 @t4(i64 %val, i64 %shamt) nounwind {
; X64-NOBMI2-LABEL: t4:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    leaq 96(%rsi), %rcx
; X64-NOBMI2-NEXT:    negq %rcx
; X64-NOBMI2-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: t4:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    addq $96, %rsi
; X64-BMI2-NEXT:    negq %rsi
; X64-BMI2-NEXT:    shlxq %rsi, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: t4:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movb $96, %cl
; X32-NOBMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB4_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB4_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: t4:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movb $96, %cl
; X32-BMI2-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB4_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB4_2:
; X32-BMI2-NEXT:    retl
  %negshamt = sub i64 96, %shamt
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}

define i64 @t5_cse(i64 %val, i64 %shamt, ptr%dst) nounwind {
; X64-NOBMI2-LABEL: t5_cse:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    leaq 32(%rsi), %rcx
; X64-NOBMI2-NEXT:    movq %rcx, (%rdx)
; X64-NOBMI2-NEXT:    negq %rcx
; X64-NOBMI2-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: t5_cse:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    addq $32, %rsi
; X64-BMI2-NEXT:    movq %rsi, (%rdx)
; X64-BMI2-NEXT:    negq %rsi
; X64-BMI2-NEXT:    shlxq %rsi, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: t5_cse:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %ebx
; X32-NOBMI2-NEXT:    pushl %edi
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NOBMI2-NEXT:    movl %ebx, %edi
; X32-NOBMI2-NEXT:    addl $32, %edi
; X32-NOBMI2-NEXT:    adcl $0, %ecx
; X32-NOBMI2-NEXT:    movl %edi, (%eax)
; X32-NOBMI2-NEXT:    movl %ecx, 4(%eax)
; X32-NOBMI2-NEXT:    movb $32, %cl
; X32-NOBMI2-NEXT:    subb %bl, %cl
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB5_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB5_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    popl %edi
; X32-NOBMI2-NEXT:    popl %ebx
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: t5_cse:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    pushl %ebx
; X32-BMI2-NEXT:    pushl %edi
; X32-BMI2-NEXT:    pushl %esi
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-BMI2-NEXT:    movl %ebx, %edi
; X32-BMI2-NEXT:    addl $32, %edi
; X32-BMI2-NEXT:    adcl $0, %esi
; X32-BMI2-NEXT:    movl %edi, (%ecx)
; X32-BMI2-NEXT:    movl %esi, 4(%ecx)
; X32-BMI2-NEXT:    movb $32, %cl
; X32-BMI2-NEXT:    subb %bl, %cl
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB5_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB5_2:
; X32-BMI2-NEXT:    popl %esi
; X32-BMI2-NEXT:    popl %edi
; X32-BMI2-NEXT:    popl %ebx
; X32-BMI2-NEXT:    retl
  %incshamt = add i64 %shamt, 32
  store i64 %incshamt, ptr %dst
  %negshamt = sub i64 32, %shamt
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}

define i64 @t6_cse2(i64 %val, i64 %shamt, ptr%dst) nounwind {
; X64-NOBMI2-LABEL: t6_cse2:
; X64-NOBMI2:       # %bb.0:
; X64-NOBMI2-NEXT:    movq %rdi, %rax
; X64-NOBMI2-NEXT:    movl $32, %ecx
; X64-NOBMI2-NEXT:    subq %rsi, %rcx
; X64-NOBMI2-NEXT:    movq %rcx, (%rdx)
; X64-NOBMI2-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NOBMI2-NEXT:    shlq %cl, %rax
; X64-NOBMI2-NEXT:    retq
;
; X64-BMI2-LABEL: t6_cse2:
; X64-BMI2:       # %bb.0:
; X64-BMI2-NEXT:    movl $32, %eax
; X64-BMI2-NEXT:    subq %rsi, %rax
; X64-BMI2-NEXT:    movq %rax, (%rdx)
; X64-BMI2-NEXT:    shlxq %rax, %rdi, %rax
; X64-BMI2-NEXT:    retq
;
; X32-NOBMI2-LABEL: t6_cse2:
; X32-NOBMI2:       # %bb.0:
; X32-NOBMI2-NEXT:    pushl %edi
; X32-NOBMI2-NEXT:    pushl %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NOBMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NOBMI2-NEXT:    xorl %edi, %edi
; X32-NOBMI2-NEXT:    movl $32, %ecx
; X32-NOBMI2-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X32-NOBMI2-NEXT:    sbbl {{[0-9]+}}(%esp), %edi
; X32-NOBMI2-NEXT:    movl %ecx, (%eax)
; X32-NOBMI2-NEXT:    movl %edi, 4(%eax)
; X32-NOBMI2-NEXT:    movl %esi, %eax
; X32-NOBMI2-NEXT:    shll %cl, %eax
; X32-NOBMI2-NEXT:    shldl %cl, %esi, %edx
; X32-NOBMI2-NEXT:    testb $32, %cl
; X32-NOBMI2-NEXT:    je .LBB6_2
; X32-NOBMI2-NEXT:  # %bb.1:
; X32-NOBMI2-NEXT:    movl %eax, %edx
; X32-NOBMI2-NEXT:    xorl %eax, %eax
; X32-NOBMI2-NEXT:  .LBB6_2:
; X32-NOBMI2-NEXT:    popl %esi
; X32-NOBMI2-NEXT:    popl %edi
; X32-NOBMI2-NEXT:    retl
;
; X32-BMI2-LABEL: t6_cse2:
; X32-BMI2:       # %bb.0:
; X32-BMI2-NEXT:    pushl %edi
; X32-BMI2-NEXT:    pushl %esi
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-BMI2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-BMI2-NEXT:    xorl %edi, %edi
; X32-BMI2-NEXT:    movl $32, %ecx
; X32-BMI2-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X32-BMI2-NEXT:    sbbl {{[0-9]+}}(%esp), %edi
; X32-BMI2-NEXT:    movl %ecx, (%esi)
; X32-BMI2-NEXT:    movl %edi, 4(%esi)
; X32-BMI2-NEXT:    shldl %cl, %eax, %edx
; X32-BMI2-NEXT:    shlxl %ecx, %eax, %eax
; X32-BMI2-NEXT:    testb $32, %cl
; X32-BMI2-NEXT:    je .LBB6_2
; X32-BMI2-NEXT:  # %bb.1:
; X32-BMI2-NEXT:    movl %eax, %edx
; X32-BMI2-NEXT:    xorl %eax, %eax
; X32-BMI2-NEXT:  .LBB6_2:
; X32-BMI2-NEXT:    popl %esi
; X32-BMI2-NEXT:    popl %edi
; X32-BMI2-NEXT:    retl
  %negshamt = sub i64 32, %shamt
  store i64 %negshamt, ptr %dst
  %shifted = shl i64 %val, %negshamt
  ret i64 %shifted
}
