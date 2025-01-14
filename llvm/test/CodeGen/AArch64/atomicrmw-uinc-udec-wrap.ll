; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu < %s | FileCheck %s

define i8 @atomicrmw_uinc_wrap_i8(ptr %ptr, i8 %val) {
; CHECK-LABEL: atomicrmw_uinc_wrap_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB0_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w8, [x0]
; CHECK-NEXT:    cmp w8, w1, uxtb
; CHECK-NEXT:    csinc w9, wzr, w8, hs
; CHECK-NEXT:    stlxrb w10, w9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB0_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %result = atomicrmw uinc_wrap ptr %ptr, i8 %val seq_cst
  ret i8 %result
}

define i16 @atomicrmw_uinc_wrap_i16(ptr %ptr, i16 %val) {
; CHECK-LABEL: atomicrmw_uinc_wrap_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB1_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w8, [x0]
; CHECK-NEXT:    cmp w8, w1, uxth
; CHECK-NEXT:    csinc w9, wzr, w8, hs
; CHECK-NEXT:    stlxrh w10, w9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB1_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %result = atomicrmw uinc_wrap ptr %ptr, i16 %val seq_cst
  ret i16 %result
}

define i32 @atomicrmw_uinc_wrap_i32(ptr %ptr, i32 %val) {
; CHECK-LABEL: atomicrmw_uinc_wrap_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB2_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x0]
; CHECK-NEXT:    cmp w8, w1
; CHECK-NEXT:    csinc w9, wzr, w8, hs
; CHECK-NEXT:    stlxr w10, w9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB2_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %result = atomicrmw uinc_wrap ptr %ptr, i32 %val seq_cst
  ret i32 %result
}

define i64 @atomicrmw_uinc_wrap_i64(ptr %ptr, i64 %val) {
; CHECK-LABEL: atomicrmw_uinc_wrap_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB3_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x8, [x0]
; CHECK-NEXT:    cmp x8, x1
; CHECK-NEXT:    csinc x9, xzr, x8, hs
; CHECK-NEXT:    stlxr w10, x9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB3_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
  %result = atomicrmw uinc_wrap ptr %ptr, i64 %val seq_cst
  ret i64 %result
}

define i8 @atomicrmw_udec_wrap_i8(ptr %ptr, i8 %val) {
; CHECK-LABEL: atomicrmw_udec_wrap_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB4_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w8, [x0]
; CHECK-NEXT:    cmp w8, w1, uxtb
; CHECK-NEXT:    sub w9, w8, #1
; CHECK-NEXT:    ccmp w8, #0, #4, ls
; CHECK-NEXT:    csel w9, w1, w9, eq
; CHECK-NEXT:    stlxrb w10, w9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB4_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %result = atomicrmw udec_wrap ptr %ptr, i8 %val seq_cst
  ret i8 %result
}

define i16 @atomicrmw_udec_wrap_i16(ptr %ptr, i16 %val) {
; CHECK-LABEL: atomicrmw_udec_wrap_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB5_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrh w8, [x0]
; CHECK-NEXT:    cmp w8, w1, uxth
; CHECK-NEXT:    sub w9, w8, #1
; CHECK-NEXT:    ccmp w8, #0, #4, ls
; CHECK-NEXT:    csel w9, w1, w9, eq
; CHECK-NEXT:    stlxrh w10, w9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB5_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %result = atomicrmw udec_wrap ptr %ptr, i16 %val seq_cst
  ret i16 %result
}

define i32 @atomicrmw_udec_wrap_i32(ptr %ptr, i32 %val) {
; CHECK-LABEL: atomicrmw_udec_wrap_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB6_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x0]
; CHECK-NEXT:    cmp w8, w1
; CHECK-NEXT:    sub w9, w8, #1
; CHECK-NEXT:    ccmp w8, #0, #4, ls
; CHECK-NEXT:    csel w9, w1, w9, eq
; CHECK-NEXT:    stlxr w10, w9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB6_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %result = atomicrmw udec_wrap ptr %ptr, i32 %val seq_cst
  ret i32 %result
}

define i64 @atomicrmw_udec_wrap_i64(ptr %ptr, i64 %val) {
; CHECK-LABEL: atomicrmw_udec_wrap_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:  .LBB7_1: // %atomicrmw.start
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr x8, [x0]
; CHECK-NEXT:    cmp x8, x1
; CHECK-NEXT:    sub x9, x8, #1
; CHECK-NEXT:    ccmp x8, #0, #4, ls
; CHECK-NEXT:    csel x9, x1, x9, eq
; CHECK-NEXT:    stlxr w10, x9, [x0]
; CHECK-NEXT:    cbnz w10, .LBB7_1
; CHECK-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
  %result = atomicrmw udec_wrap ptr %ptr, i64 %val seq_cst
  ret i64 %result
}
