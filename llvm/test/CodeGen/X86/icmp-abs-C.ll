; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i686-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=X86
; RUN: llc -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=X64

declare i64 @llvm.abs.i64(i64, i1)
declare i32 @llvm.abs.i32(i32, i1)
declare i16 @llvm.abs.i16(i16, i1)
declare i8 @llvm.abs.i8(i8, i1)

define i64 @eq_or_with_dom_abs(i64 %x) nounwind {
; X86-LABEL: eq_or_with_dom_abs:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    sarl $31, %eax
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    xorl %eax, %esi
; X86-NEXT:    subl %eax, %esi
; X86-NEXT:    sbbl %eax, %edx
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    xorl $12312, %eax # imm = 0x3018
; X86-NEXT:    xorl $64, %esi
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    orl %edx, %esi
; X86-NEXT:    sete %bl
; X86-NEXT:    xorl %esi, %esi
; X86-NEXT:    movl $2344, %edi # imm = 0x928
; X86-NEXT:    cmpl %eax, %edi
; X86-NEXT:    sbbl %edx, %esi
; X86-NEXT:    jb .LBB0_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movb %bl, %cl
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB0_2:
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: eq_or_with_dom_abs:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    negq %rcx
; X64-NEXT:    cmovsq %rdi, %rcx
; X64-NEXT:    movq %rcx, %rdx
; X64-NEXT:    xorq $12312, %rdx # imm = 0x3018
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $64, %rcx
; X64-NEXT:    sete %al
; X64-NEXT:    cmpq $2345, %rdx # imm = 0x929
; X64-NEXT:    cmovaeq %rdx, %rax
; X64-NEXT:    retq
  %absx = call i64 @llvm.abs.i64(i64 %x, i1 true)
  %foo = xor i64 %absx, 12312
  %bar = icmp ugt i64 %foo, 2344
  %cmp0 = icmp eq i64 %x, 64
  %cmp1 = icmp eq i64 %x, -64
  %cmp = or i1 %cmp0, %cmp1
  %cmp64 = zext i1 %cmp to i64
  %r = select i1 %bar, i64 %foo, i64 %cmp64
  ret i64 %r
}

define i32 @eq_or_with_dom_abs_non_po2(i32 %x) nounwind {
; X86-LABEL: eq_or_with_dom_abs_non_po2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    sarl $31, %eax
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    subl %eax, %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    xorl $12312, %eax # imm = 0x3018
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    cmpl $123, %edx
; X86-NEXT:    sete %dl
; X86-NEXT:    cmpl $2345, %eax # imm = 0x929
; X86-NEXT:    jae .LBB1_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movb %dl, %cl
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB1_2:
; X86-NEXT:    retl
;
; X64-LABEL: eq_or_with_dom_abs_non_po2:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    negl %ecx
; X64-NEXT:    cmovsl %edi, %ecx
; X64-NEXT:    movl %ecx, %edx
; X64-NEXT:    xorl $12312, %edx # imm = 0x3018
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $123, %ecx
; X64-NEXT:    sete %al
; X64-NEXT:    cmpl $2345, %edx # imm = 0x929
; X64-NEXT:    cmovael %edx, %eax
; X64-NEXT:    retq
  %absx = call i32 @llvm.abs.i32(i32 %x, i1 true)
  %foo = xor i32 %absx, 12312
  %bar = icmp ugt i32 %foo, 2344
  %cmp0 = icmp eq i32 %x, 123
  %cmp1 = icmp eq i32 %x, -123
  %cmp = or i1 %cmp0, %cmp1
  %cmp64 = zext i1 %cmp to i32
  %r = select i1 %bar, i32 %foo, i32 %cmp64
  ret i32 %r
}

define i8 @ne_and_with_dom_abs_non_pow2(i8 %x) nounwind {
; X86-LABEL: ne_and_with_dom_abs_non_pow2:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    sarb $7, %al
; X86-NEXT:    xorb %al, %cl
; X86-NEXT:    subb %al, %cl
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    xorb $12, %al
; X86-NEXT:    cmpb $121, %cl
; X86-NEXT:    setne %cl
; X86-NEXT:    cmpb $24, %al
; X86-NEXT:    jae .LBB2_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB2_2:
; X86-NEXT:    retl
;
; X64-LABEL: ne_and_with_dom_abs_non_pow2:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    sarb $7, %al
; X64-NEXT:    xorb %al, %dil
; X64-NEXT:    subb %al, %dil
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    xorb $12, %cl
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpb $121, %dil
; X64-NEXT:    setne %al
; X64-NEXT:    cmpb $24, %cl
; X64-NEXT:    movzbl %cl, %ecx
; X64-NEXT:    cmovael %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %absx = call i8 @llvm.abs.i8(i8 %x, i1 true)
  %foo = xor i8 %absx, 12
  %bar = icmp ugt i8 %foo, 23
  %cmp0 = icmp ne i8 %x, 121
  %cmp1 = icmp ne i8 %x, -121
  %cmp = and i1 %cmp0, %cmp1
  %cmp64 = zext i1 %cmp to i8
  %r = select i1 %bar, i8 %foo, i8 %cmp64
  ret i8 %r
}

define i16 @ne_and_with_dom_abs(i16 %x) nounwind {
; X86-LABEL: ne_and_with_dom_abs:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movswl %dx, %eax
; X86-NEXT:    sarl $15, %eax
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    subl %eax, %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    xorl $12312, %eax # imm = 0x3018
; X86-NEXT:    movzwl %ax, %esi
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    cmpw $64, %dx
; X86-NEXT:    setne %dl
; X86-NEXT:    cmpl $2345, %esi # imm = 0x929
; X86-NEXT:    jae .LBB3_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movb %dl, %cl
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB3_2:
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: ne_and_with_dom_abs:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    negw %cx
; X64-NEXT:    cmovsw %di, %cx
; X64-NEXT:    movl %ecx, %edx
; X64-NEXT:    xorl $12312, %edx # imm = 0x3018
; X64-NEXT:    movzwl %dx, %esi
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpw $64, %cx
; X64-NEXT:    setne %al
; X64-NEXT:    cmpl $2345, %esi # imm = 0x929
; X64-NEXT:    cmovael %edx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %absx = call i16 @llvm.abs.i16(i16 %x, i1 true)
  %foo = xor i16 %absx, 12312
  %bar = icmp ugt i16 %foo, 2344
  %cmp0 = icmp ne i16 %x, 64
  %cmp1 = icmp ne i16 %x, -64
  %cmp = and i1 %cmp0, %cmp1
  %cmp64 = zext i1 %cmp to i16
  %r = select i1 %bar, i16 %foo, i16 %cmp64
  ret i16 %r
}
