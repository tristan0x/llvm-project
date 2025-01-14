; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux-gnux32 | FileCheck %s -check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-linux-gnux32 -mattr=-sse | FileCheck %s -check-prefix=NOSSE
; RUN: llc < %s -mtriple=i386-linux-gnux32 | FileCheck %s -check-prefix=32BITABI
; RUN: llc < %s -mtriple=i686-linux-gnux32 | FileCheck %s -check-prefix=32BITABI
;
; Verifies that x32 va_start lowering is sane. To regenerate this test, use
; cat <<EOF |
; #include <stdarg.h>
;
; int foo(float a, const char* fmt, ...) {
;   va_list ap;
;   va_start(ap, fmt);
;   int value = va_arg(ap, int);
;   va_end(ap);
;   return value;
; }
; EOF
; build/bin/clang -mx32 -O3 -o- -S -emit-llvm -xc -
;
target datalayout = "e-m:e-p:32:32-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnux32"

%struct.__va_list_tag = type { i32, i32, ptr, ptr }

define i32 @foo(float %a, ptr nocapture readnone %fmt, ...) nounwind {
; SSE-LABEL: foo:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    subl $72, %esp
; SSE-NEXT:    movq %rsi, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movq %rdx, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movq %rcx, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movq %r8, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movq %r9, -{{[0-9]+}}(%esp)
; SSE-NEXT:    testb %al, %al
; SSE-NEXT:    je .LBB0_5
; SSE-NEXT:  # %bb.4: # %entry
; SSE-NEXT:    movaps %xmm1, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movaps %xmm2, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movaps %xmm3, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movaps %xmm4, (%esp)
; SSE-NEXT:    movaps %xmm5, {{[0-9]+}}(%esp)
; SSE-NEXT:    movaps %xmm6, {{[0-9]+}}(%esp)
; SSE-NEXT:    movaps %xmm7, {{[0-9]+}}(%esp)
; SSE-NEXT:  .LBB0_5: # %entry
; SSE-NEXT:    leal -{{[0-9]+}}(%rsp), %eax
; SSE-NEXT:    movl %eax, -{{[0-9]+}}(%esp)
; SSE-NEXT:    leal {{[0-9]+}}(%rsp), %eax
; SSE-NEXT:    movl %eax, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movabsq $274877906952, %rax # imm = 0x4000000008
; SSE-NEXT:    movq %rax, -{{[0-9]+}}(%esp)
; SSE-NEXT:    movl $8, %ecx
; SSE-NEXT:    cmpl $40, %ecx
; SSE-NEXT:    ja .LBB0_2
; SSE-NEXT:  # %bb.1: # %vaarg.in_reg
; SSE-NEXT:    movl -{{[0-9]+}}(%esp), %eax
; SSE-NEXT:    addl %ecx, %eax
; SSE-NEXT:    addl $8, %ecx
; SSE-NEXT:    movl %ecx, -{{[0-9]+}}(%esp)
; SSE-NEXT:    jmp .LBB0_3
; SSE-NEXT:  .LBB0_2: # %vaarg.in_mem
; SSE-NEXT:    movl -{{[0-9]+}}(%esp), %eax
; SSE-NEXT:    leal 8(%rax), %ecx
; SSE-NEXT:    movl %ecx, -{{[0-9]+}}(%esp)
; SSE-NEXT:  .LBB0_3: # %vaarg.end
; SSE-NEXT:    movl (%eax), %eax
; SSE-NEXT:    addl $72, %esp
; SSE-NEXT:    retq
;
; NOSSE-LABEL: foo:
; NOSSE:       # %bb.0: # %entry
; NOSSE-NEXT:    movq %rsi, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movq %rdx, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movq %rcx, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movq %r8, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movq %r9, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    leal -{{[0-9]+}}(%rsp), %eax
; NOSSE-NEXT:    movl %eax, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    leal {{[0-9]+}}(%rsp), %eax
; NOSSE-NEXT:    movl %eax, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movabsq $206158430216, %rax # imm = 0x3000000008
; NOSSE-NEXT:    movq %rax, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movl $8, %ecx
; NOSSE-NEXT:    cmpl $40, %ecx
; NOSSE-NEXT:    ja .LBB0_2
; NOSSE-NEXT:  # %bb.1: # %vaarg.in_reg
; NOSSE-NEXT:    movl -{{[0-9]+}}(%esp), %eax
; NOSSE-NEXT:    addl %ecx, %eax
; NOSSE-NEXT:    addl $8, %ecx
; NOSSE-NEXT:    movl %ecx, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movl (%eax), %eax
; NOSSE-NEXT:    retq
; NOSSE-NEXT:  .LBB0_2: # %vaarg.in_mem
; NOSSE-NEXT:    movl -{{[0-9]+}}(%esp), %eax
; NOSSE-NEXT:    leal 8(%rax), %ecx
; NOSSE-NEXT:    movl %ecx, -{{[0-9]+}}(%esp)
; NOSSE-NEXT:    movl (%eax), %eax
; NOSSE-NEXT:    retq
;
; 32BITABI-LABEL: foo:
; 32BITABI:       # %bb.0: # %entry
; 32BITABI-NEXT:    subl $28, %esp
; 32BITABI-NEXT:    leal {{[0-9]+}}(%esp), %eax
; 32BITABI-NEXT:    movl %eax, (%esp)
; 32BITABI-NEXT:    cmpl $40, %eax
; 32BITABI-NEXT:    ja .LBB0_2
; 32BITABI-NEXT:  # %bb.1: # %vaarg.in_reg
; 32BITABI-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; 32BITABI-NEXT:    addl %eax, %ecx
; 32BITABI-NEXT:    addl $8, %eax
; 32BITABI-NEXT:    movl %eax, (%esp)
; 32BITABI-NEXT:    jmp .LBB0_3
; 32BITABI-NEXT:  .LBB0_2: # %vaarg.in_mem
; 32BITABI-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; 32BITABI-NEXT:    leal 8(%ecx), %eax
; 32BITABI-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; 32BITABI-NEXT:  .LBB0_3: # %vaarg.end
; 32BITABI-NEXT:    movl (%ecx), %eax
; 32BITABI-NEXT:    addl $28, %esp
; 32BITABI-NEXT:    retl
entry:
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr %ap) #2
  call void @llvm.va_start(ptr %ap)
  %gp_offset = load i32, ptr %ap, align 16
  %fits_in_gp = icmp ult i32 %gp_offset, 41
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %ap, i32 0, i32 0, i32 3
  %reg_save_area = load ptr, ptr %0, align 4
  %1 = getelementptr i8, ptr %reg_save_area, i32 %gp_offset
  %2 = add i32 %gp_offset, 8
  store i32 %2, ptr %ap, align 16
  br label %vaarg.end
vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %ap, i32 0, i32 0, i32 2
  %overflow_arg_area = load ptr, ptr %overflow_arg_area_p, align 8
  %overflow_arg_area.next = getelementptr i8, ptr %overflow_arg_area, i32 8
  store ptr %overflow_arg_area.next, ptr %overflow_arg_area_p, align 8
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr.in = phi ptr [ %1, %vaarg.in_reg ], [ %overflow_arg_area, %vaarg.in_mem ]
  %3 = load i32, ptr %vaarg.addr.in, align 4
  call void @llvm.va_end(ptr %ap)
  call void @llvm.lifetime.end.p0(i64 16, ptr %ap) #2
  ret i32 %3
}

; Function Attrs: nounwind argmemonly
declare void @llvm.lifetime.start.p0(i64, ptr nocapture) nounwind

; Function Attrs: nounwind
declare void @llvm.va_start(ptr) nounwind

; Function Attrs: nounwind
declare void @llvm.va_end(ptr) nounwind

; Function Attrs: nounwind argmemonly
declare void @llvm.lifetime.end.p0(i64, ptr nocapture) nounwind

