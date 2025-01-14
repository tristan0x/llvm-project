; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp %s -o - | FileCheck %s

define arm_aapcs_vfpcc <8 x i16> @zext_unscaled_i8_i16(ptr %base, ptr %offptr) {
; CHECK-LABEL: zext_unscaled_i8_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrb.u16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, ptr %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %gather = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> %ptrs, i32 1, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i8> undef)
  %gather.zext = zext <8 x i8> %gather to <8 x i16>
  ret <8 x i16> %gather.zext
}

define arm_aapcs_vfpcc <8 x i16> @zext_unscaled_i8_i16_noext(ptr %base, ptr %offptr) {
; CHECK-LABEL: zext_unscaled_i8_i16_noext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, lr}
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    vldrb.s32 q0, [r1, #4]
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vmov r12, r3, d0
; CHECK-NEXT:    vmov r2, lr, d1
; CHECK-NEXT:    vldrb.s32 q0, [r1]
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    ldrb r5, [r3]
; CHECK-NEXT:    vmov r3, r4, d0
; CHECK-NEXT:    ldrb r6, [r2]
; CHECK-NEXT:    ldrb.w r2, [r12]
; CHECK-NEXT:    ldrb.w lr, [lr]
; CHECK-NEXT:    ldrb r0, [r0]
; CHECK-NEXT:    ldrb r1, [r1]
; CHECK-NEXT:    ldrb r3, [r3]
; CHECK-NEXT:    ldrb r4, [r4]
; CHECK-NEXT:    vmov.16 q0[0], r3
; CHECK-NEXT:    vmov.16 q0[1], r4
; CHECK-NEXT:    vmov.16 q0[2], r0
; CHECK-NEXT:    vmov.16 q0[3], r1
; CHECK-NEXT:    vmov.16 q0[4], r2
; CHECK-NEXT:    vmov.16 q0[5], r5
; CHECK-NEXT:    vmov.16 q0[6], r6
; CHECK-NEXT:    vmov.16 q0[7], lr
; CHECK-NEXT:    vmovlb.u8 q0, q0
; CHECK-NEXT:    pop {r4, r5, r6, pc}
entry:
  %offs = load <8 x i8>, ptr %offptr, align 2
  %ptrs = getelementptr inbounds i8, ptr %base, <8 x i8> %offs
  %gather = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> %ptrs, i32 1, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i8> undef)
  %gather.zext = zext <8 x i8> %gather to <8 x i16>
  ret <8 x i16> %gather.zext
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_sext(ptr %base, ptr %offptr) {
; CHECK-LABEL: scaled_v8i16_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r7, lr}
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    vldrb.s32 q0, [r1, #4]
; CHECK-NEXT:    vshl.i32 q0, q0, #1
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    vmov r12, lr, d1
; CHECK-NEXT:    vldrb.s32 q0, [r1]
; CHECK-NEXT:    vshl.i32 q0, q0, #1
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vmov r4, r5, d0
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    ldrh r2, [r2]
; CHECK-NEXT:    ldrh r3, [r3]
; CHECK-NEXT:    ldrh.w r12, [r12]
; CHECK-NEXT:    ldrh.w lr, [lr]
; CHECK-NEXT:    ldrh r4, [r4]
; CHECK-NEXT:    ldrh r5, [r5]
; CHECK-NEXT:    vmov.16 q0[0], r4
; CHECK-NEXT:    ldrh r0, [r0]
; CHECK-NEXT:    vmov.16 q0[1], r5
; CHECK-NEXT:    ldrh r1, [r1]
; CHECK-NEXT:    vmov.16 q0[2], r0
; CHECK-NEXT:    vmov.16 q0[3], r1
; CHECK-NEXT:    vmov.16 q0[4], r2
; CHECK-NEXT:    vmov.16 q0[5], r3
; CHECK-NEXT:    vmov.16 q0[6], r12
; CHECK-NEXT:    vmov.16 q0[7], lr
; CHECK-NEXT:    pop {r4, r5, r7, pc}
entry:
  %offs = load <8 x i8>, ptr %offptr, align 2
  %offs.sext = sext <8 x i8> %offs to <8 x i16>
  %ptrs = getelementptr inbounds i16, ptr %base, <8 x i16> %offs.sext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0(<8 x ptr> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_zext(ptr %base, ptr %offptr) {
; CHECK-LABEL: scaled_v8i16_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r7, lr}
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    vldrb.u32 q0, [r1, #4]
; CHECK-NEXT:    vshl.i32 q0, q0, #1
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    vmov r12, lr, d1
; CHECK-NEXT:    vldrb.u32 q0, [r1]
; CHECK-NEXT:    vshl.i32 q0, q0, #1
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vmov r4, r5, d0
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    ldrh r2, [r2]
; CHECK-NEXT:    ldrh r3, [r3]
; CHECK-NEXT:    ldrh.w r12, [r12]
; CHECK-NEXT:    ldrh.w lr, [lr]
; CHECK-NEXT:    ldrh r4, [r4]
; CHECK-NEXT:    ldrh r5, [r5]
; CHECK-NEXT:    vmov.16 q0[0], r4
; CHECK-NEXT:    ldrh r0, [r0]
; CHECK-NEXT:    vmov.16 q0[1], r5
; CHECK-NEXT:    ldrh r1, [r1]
; CHECK-NEXT:    vmov.16 q0[2], r0
; CHECK-NEXT:    vmov.16 q0[3], r1
; CHECK-NEXT:    vmov.16 q0[4], r2
; CHECK-NEXT:    vmov.16 q0[5], r3
; CHECK-NEXT:    vmov.16 q0[6], r12
; CHECK-NEXT:    vmov.16 q0[7], lr
; CHECK-NEXT:    pop {r4, r5, r7, pc}
entry:
  %offs = load <8 x i8>, ptr %offptr, align 2
  %offs.zext = zext <8 x i8> %offs to <8 x i16>
  %ptrs = getelementptr inbounds i16, ptr %base, <8 x i16> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0(<8 x ptr> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @sext_unscaled_i8_i16(ptr %base, ptr %offptr) {
; CHECK-LABEL: sext_unscaled_i8_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrb.s16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, ptr %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %gather = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> %ptrs, i32 1, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i8> undef)
  %gather.sext = sext <8 x i8> %gather to <8 x i16>
  ret <8 x i16> %gather.sext
}

define arm_aapcs_vfpcc <8 x i16> @unscaled_i16_i16(ptr %base, ptr %offptr) {
; CHECK-LABEL: unscaled_i16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, ptr %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %byte_ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %ptrs = bitcast <8 x ptr> %byte_ptrs to <8 x ptr>
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0(<8 x ptr> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x half> @unscaled_f16_i16(ptr %base, ptr %offptr) {
; CHECK-LABEL: unscaled_f16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, ptr %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %byte_ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %ptrs = bitcast <8 x ptr> %byte_ptrs to <8 x ptr>
  %gather = call <8 x half> @llvm.masked.gather.v8f16.v8p0(<8 x ptr> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x half> undef)
  ret <8 x half> %gather
}

define arm_aapcs_vfpcc <8 x i16> @zext_unsigned_unscaled_i8_i8(ptr %base, ptr %offptr) {
; CHECK-LABEL: zext_unsigned_unscaled_i8_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q1, [r1]
; CHECK-NEXT:    vldrb.u16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i8>, ptr %offptr, align 1
  %offs.zext = zext <8 x i8> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %gather = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> %ptrs, i32 1, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i8> undef)
  %gather.zext = zext <8 x i8> %gather to <8 x i16>
  ret <8 x i16> %gather.zext
}

define arm_aapcs_vfpcc <8 x i16> @sext_unsigned_unscaled_i8_i8(ptr %base, ptr %offptr) {
; CHECK-LABEL: sext_unsigned_unscaled_i8_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q1, [r1]
; CHECK-NEXT:    vldrb.s16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i8>, ptr %offptr, align 1
  %offs.zext = zext <8 x i8> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %gather = call <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr> %ptrs, i32 1, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i8> undef)
  %gather.sext = sext <8 x i8> %gather to <8 x i16>
  ret <8 x i16> %gather.sext
}

define arm_aapcs_vfpcc <8 x i16> @unsigned_unscaled_i16_i8(ptr %base, ptr %offptr) {
; CHECK-LABEL: unsigned_unscaled_i16_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i8>, ptr %offptr, align 1
  %offs.zext = zext <8 x i8> %offs to <8 x i32>
  %byte_ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %ptrs = bitcast <8 x ptr> %byte_ptrs to <8 x ptr>
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0(<8 x ptr> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x half> @unsigned_unscaled_f16_i8(ptr %base, ptr %offptr) {
; CHECK-LABEL: unsigned_unscaled_f16_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i8>, ptr %offptr, align 1
  %offs.zext = zext <8 x i8> %offs to <8 x i32>
  %byte_ptrs = getelementptr inbounds i8, ptr %base, <8 x i32> %offs.zext
  %ptrs = bitcast <8 x ptr> %byte_ptrs to <8 x ptr>
  %gather = call <8 x half> @llvm.masked.gather.v8f16.v8p0(<8 x ptr> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x half> undef)
  ret <8 x half> %gather
}

declare <8 x i8> @llvm.masked.gather.v8i8.v8p0(<8 x ptr>, i32, <8 x i1>, <8 x i8>) #1
declare <8 x i16> @llvm.masked.gather.v8i16.v8p0(<8 x ptr>, i32, <8 x i1>, <8 x i16>) #1
declare <8 x half> @llvm.masked.gather.v8f16.v8p0(<8 x ptr>, i32, <8 x i1>, <8 x half>) #1
