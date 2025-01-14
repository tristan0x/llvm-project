; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefixes=X64

%WideUInt32 = type { i32, i32 }

define void @PR25858_i32(ptr sret(%WideUInt32), ptr, ptr) nounwind {
; X86-LABEL: PR25858_i32:
; X86:       # %bb.0: # %top
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl (%edx), %esi
; X86-NEXT:    movl 4(%edx), %edx
; X86-NEXT:    subl (%ecx), %esi
; X86-NEXT:    sbbl 4(%ecx), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %esi, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    retl $4
;
; X64-LABEL: PR25858_i32:
; X64:       # %bb.0: # %top
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    movl (%rsi), %ecx
; X64-NEXT:    movl 4(%rsi), %esi
; X64-NEXT:    subl (%rdx), %ecx
; X64-NEXT:    sbbl 4(%rdx), %esi
; X64-NEXT:    movl %esi, 4(%rdi)
; X64-NEXT:    movl %ecx, (%rdi)
; X64-NEXT:    retq
top:
  %3 = load i32, ptr %1, align 4
  %4 = load i32, ptr %2, align 4
  %5 = sub i32 %3, %4
  %6 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %3, i32 %4)
  %7 = extractvalue { i32, i1 } %6, 1
  %8 = getelementptr inbounds %WideUInt32, ptr %1, i32 0, i32 1
  %9 = load i32, ptr %8, align 8
  %10 = getelementptr inbounds %WideUInt32, ptr %2, i32 0, i32 1
  %11 = load i32, ptr %10, align 8
  %12 = sub i32 %9, %11
  %.neg1 = sext i1 %7 to i32
  %13 = add i32 %12, %.neg1
  %14 = insertvalue %WideUInt32 undef, i32 %5, 0
  %15 = insertvalue %WideUInt32 %14, i32 %13, 1
  store %WideUInt32 %15, ptr %0, align 4
  ret void
}

declare  { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32)

%WideUInt64 = type { i64, i64 }

define void @PR25858_i64(ptr sret(%WideUInt64), ptr, ptr) nounwind {
; X86-LABEL: PR25858_i64:
; X86:       # %bb.0: # %top
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl (%edx), %esi
; X86-NEXT:    movl 4(%edx), %edi
; X86-NEXT:    movl 12(%edx), %ebx
; X86-NEXT:    movl 8(%edx), %edx
; X86-NEXT:    subl 8(%ecx), %edx
; X86-NEXT:    sbbl 12(%ecx), %ebx
; X86-NEXT:    subl (%ecx), %esi
; X86-NEXT:    sbbl 4(%ecx), %edi
; X86-NEXT:    sbbl $0, %edx
; X86-NEXT:    sbbl $0, %ebx
; X86-NEXT:    movl %esi, (%eax)
; X86-NEXT:    movl %edi, 4(%eax)
; X86-NEXT:    movl %edx, 8(%eax)
; X86-NEXT:    movl %ebx, 12(%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl $4
;
; X64-LABEL: PR25858_i64:
; X64:       # %bb.0: # %top
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    movq (%rsi), %rcx
; X64-NEXT:    movq 8(%rsi), %rsi
; X64-NEXT:    subq (%rdx), %rcx
; X64-NEXT:    sbbq 8(%rdx), %rsi
; X64-NEXT:    movq %rsi, 8(%rdi)
; X64-NEXT:    movq %rcx, (%rdi)
; X64-NEXT:    retq
top:
  %3 = load i64, ptr %1, align 8
  %4 = load i64, ptr %2, align 8
  %5 = sub i64 %3, %4
  %6 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %3, i64 %4)
  %7 = extractvalue { i64, i1 } %6, 1
  %8 = getelementptr inbounds %WideUInt64, ptr %1, i64 0, i32 1
  %9 = load i64, ptr %8, align 8
  %10 = getelementptr inbounds %WideUInt64, ptr %2, i64 0, i32 1
  %11 = load i64, ptr %10, align 8
  %12 = sub i64 %9, %11
  %.neg1 = sext i1 %7 to i64
  %13 = add i64 %12, %.neg1
  %14 = insertvalue %WideUInt64 undef, i64 %5, 0
  %15 = insertvalue %WideUInt64 %14, i64 %13, 1
  store %WideUInt64 %15, ptr %0, align 8
  ret void
}

declare  { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64)

; PR24545 less_than_ideal()
define i8 @PR24545(i32, i32, ptr nocapture readonly) {
; X86-LABEL: PR24545:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    cmpl (%ecx), %edx
; X86-NEXT:    sbbl 4(%ecx), %eax
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: PR24545:
; X64:       # %bb.0:
; X64-NEXT:    cmpl (%rdx), %edi
; X64-NEXT:    sbbl 4(%rdx), %esi
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %4 = load i32, ptr %2
  %5 = icmp ugt i32 %4, %0
  %6 = zext i1 %5 to i8
  %7 = getelementptr inbounds i32, ptr %2, i32 1
  %8 = load i32, ptr %7
  %9 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 %6, i32 %1, i32 %8)
  %10 = extractvalue { i8, i32 } %9, 0
  %11 = icmp ne i8 %10, 0
  %12 = zext i1 %11 to i8
  ret i8 %12
}

define i32 @PR40483_sub1(ptr, i32) nounwind {
; X86-LABEL: PR40483_sub1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, (%ecx)
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    retl
;
; X64-LABEL: PR40483_sub1:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, (%rdi)
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
  %3 = load i32, ptr %0, align 4
  %4 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 0, i32 %3, i32 %1)
  %5 = extractvalue { i8, i32 } %4, 1
  store i32 %5, ptr %0, align 4
  %6 = sub i32 %1, %3
  %7 = add i32 %6, %5
  ret i32 %7
}

define i32 @PR40483_sub2(ptr, i32) nounwind {
; X86-LABEL: PR40483_sub2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, (%ecx)
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    retl
;
; X64-LABEL: PR40483_sub2:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, (%rdi)
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
  %3 = load i32, ptr %0, align 4
  %4 = sub i32 %3, %1
  %5 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 0, i32 %3, i32 %1)
  %6 = extractvalue { i8, i32 } %5, 1
  store i32 %6, ptr %0, align 4
  %7 = sub i32 %4, %6
  ret i32 %7
}

define i32 @PR40483_sub3(ptr, i32) nounwind {
; X86-LABEL: PR40483_sub3:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    subl %esi, %ecx
; X86-NEXT:    subl %esi, %edx
; X86-NEXT:    movl %edx, (%eax)
; X86-NEXT:    jae .LBB5_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
; X86-NEXT:  .LBB5_1:
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: PR40483_sub3:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    subl %esi, %eax
; X64-NEXT:    movl %eax, %edx
; X64-NEXT:    negl %edx
; X64-NEXT:    orl %eax, %edx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    subl %esi, %ecx
; X64-NEXT:    movl %ecx, (%rdi)
; X64-NEXT:    cmovael %edx, %eax
; X64-NEXT:    retq
  %3 = load i32, ptr %0, align 8
  %4 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 0, i32 %3, i32 %1)
  %5 = extractvalue { i8, i32 } %4, 1
  store i32 %5, ptr %0, align 8
  %6 = extractvalue { i8, i32 } %4, 0
  %7 = icmp eq i8 %6, 0
  %8 = sub i32 %1, %3
  %9 = or i32 %5, %8
  %10 = select i1 %7, i32 %9, i32 0
  ret i32 %10
}

define i32 @PR40483_sub4(ptr, i32) nounwind {
; X86-LABEL: PR40483_sub4:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl (%edx), %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, (%edx)
; X86-NEXT:    jae .LBB6_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB6_2:
; X86-NEXT:    retl
;
; X64-LABEL: PR40483_sub4:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    subl %esi, %eax
; X64-NEXT:    movl %eax, (%rdi)
; X64-NEXT:    cmovael %ecx, %eax
; X64-NEXT:    retq
  %3 = load i32, ptr %0, align 8
  %4 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 0, i32 %3, i32 %1)
  %5 = extractvalue { i8, i32 } %4, 1
  store i32 %5, ptr %0, align 8
  %6 = extractvalue { i8, i32 } %4, 0
  %7 = icmp eq i8 %6, 0
  %8 = sub i32 %3, %1
  %9 = or i32 %5, %8
  %10 = select i1 %7, i32 0, i32 %9
  ret i32 %10
}

; Verify that a bogus cmov is simplified.

define i32 @PR40483_sub5(ptr, i32) nounwind {
; X86-LABEL: PR40483_sub5:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, (%ecx)
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    retl
;
; X64-LABEL: PR40483_sub5:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, (%rdi)
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
  %3 = load i32, ptr %0, align 8
  %4 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 0, i32 %3, i32 %1)
  %5 = extractvalue { i8, i32 } %4, 1
  store i32 %5, ptr %0, align 8
  %6 = extractvalue { i8, i32 } %4, 0
  %7 = icmp eq i8 %6, 0
  %8 = sub i32 %1, %3
  %9 = add i32 %8, %5
  %10 = select i1 %7, i32 %9, i32 0
  ret i32 %10
}

define i32 @PR40483_sub6(ptr, i32) nounwind {
; X86-LABEL: PR40483_sub6:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl (%edx), %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, (%edx)
; X86-NEXT:    jae .LBB8_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    leal (%ecx,%ecx), %eax
; X86-NEXT:  .LBB8_2:
; X86-NEXT:    retl
;
; X64-LABEL: PR40483_sub6:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    subl %esi, %eax
; X64-NEXT:    movl %eax, (%rdi)
; X64-NEXT:    leal (%rax,%rax), %eax
; X64-NEXT:    cmovael %ecx, %eax
; X64-NEXT:    retq
  %3 = load i32, ptr %0, align 8
  %4 = tail call { i8, i32 } @llvm.x86.subborrow.32(i8 0, i32 %3, i32 %1)
  %5 = extractvalue { i8, i32 } %4, 1
  store i32 %5, ptr %0, align 8
  %6 = extractvalue { i8, i32 } %4, 0
  %7 = icmp eq i8 %6, 0
  %8 = sub i32 %3, %1
  %9 = add i32 %8, %5
  %10 = select i1 %7, i32 0, i32 %9
  ret i32 %10
}

declare { i8, i32 } @llvm.x86.subborrow.32(i8, i32, i32)
