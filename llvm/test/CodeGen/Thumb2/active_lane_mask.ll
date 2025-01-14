; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve %s -o - | FileCheck %s

define <2 x i64> @v2i64(i32 %index, i32 %TC, <2 x i64> %V1, <2 x i64> %V2) {
; CHECK-LABEL: v2i64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    vmov q1[2], q1[0], r0, r0
; CHECK-NEXT:    vmov.i64 q0, #0xffffffff
; CHECK-NEXT:    vand q1, q1, q0
; CHECK-NEXT:    movs r5, #0
; CHECK-NEXT:    vmov r0, r4, d3
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r1
; CHECK-NEXT:    vmov lr, r12, d2
; CHECK-NEXT:    adds r6, r0, #1
; CHECK-NEXT:    adc r4, r4, #0
; CHECK-NEXT:    subs.w r0, lr, #-1
; CHECK-NEXT:    vmov q1[2], q1[0], lr, r6
; CHECK-NEXT:    sbcs r0, r12, #0
; CHECK-NEXT:    vmov q1[3], q1[1], r12, r4
; CHECK-NEXT:    csetm r12, lo
; CHECK-NEXT:    subs.w r6, r6, #-1
; CHECK-NEXT:    bfi r5, r12, #0, #8
; CHECK-NEXT:    sbcs r6, r4, #0
; CHECK-NEXT:    mov.w r0, #0
; CHECK-NEXT:    csetm r6, lo
; CHECK-NEXT:    bfi r5, r6, #8, #8
; CHECK-NEXT:    vmsr p0, r5
; CHECK-NEXT:    vpsel q1, q1, q0
; CHECK-NEXT:    vand q0, q2, q0
; CHECK-NEXT:    vmov r1, r4, d0
; CHECK-NEXT:    vmov r6, r5, d2
; CHECK-NEXT:    vmov d0, r2, r3
; CHECK-NEXT:    subs r1, r6, r1
; CHECK-NEXT:    sbcs.w r1, r5, r4
; CHECK-NEXT:    vmov r5, r4, d1
; CHECK-NEXT:    csetm r1, lo
; CHECK-NEXT:    vldr d1, [sp, #16]
; CHECK-NEXT:    bfi r0, r1, #0, #8
; CHECK-NEXT:    vmov r1, r6, d3
; CHECK-NEXT:    subs r1, r1, r5
; CHECK-NEXT:    sbcs.w r1, r6, r4
; CHECK-NEXT:    csetm r1, lo
; CHECK-NEXT:    bfi r0, r1, #8, #8
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    add r0, sp, #24
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    vmov r0, r1, d0
; CHECK-NEXT:    vmov r2, r3, d1
; CHECK-NEXT:    pop {r4, r5, r6, pc}
  %active.lane.mask = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 %index, i32 %TC)
  %select = select <2 x i1> %active.lane.mask, <2 x i64> %V1, <2 x i64> %V2
  ret <2 x i64> %select
}

define <4 x i32> @v4i32(i32 %index, i32 %TC, <4 x i32> %V1, <4 x i32> %V2) {
; CHECK-LABEL: v4i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    adr.w r12, .LCPI1_0
; CHECK-NEXT:    vdup.32 q1, r1
; CHECK-NEXT:    vldrw.u32 q0, [r12]
; CHECK-NEXT:    vqadd.u32 q0, q0, r0
; CHECK-NEXT:    add r0, sp, #8
; CHECK-NEXT:    vcmp.u32 hi, q1, q0
; CHECK-NEXT:    vldr d1, [sp]
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vmov d0, r2, r3
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    vmov r0, r1, d0
; CHECK-NEXT:    vmov r2, r3, d1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
  %active.lane.mask = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index, i32 %TC)
  %select = select <4 x i1> %active.lane.mask, <4 x i32> %V1, <4 x i32> %V2
  ret <4 x i32> %select
}

define <7 x i32> @v7i32(i32 %index, i32 %TC, <7 x i32> %V1, <7 x i32> %V2) {
; CHECK-LABEL: v7i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldr.w r12, [sp, #40]
; CHECK-NEXT:    vdup.32 q3, r2
; CHECK-NEXT:    ldr r3, [sp, #32]
; CHECK-NEXT:    adr r2, .LCPI2_1
; CHECK-NEXT:    vmov q0[2], q0[0], r3, r12
; CHECK-NEXT:    ldr.w r12, [sp, #44]
; CHECK-NEXT:    ldr r3, [sp, #36]
; CHECK-NEXT:    vmov q0[3], q0[1], r3, r12
; CHECK-NEXT:    ldr.w r12, [sp, #8]
; CHECK-NEXT:    ldr r3, [sp]
; CHECK-NEXT:    vmov q1[2], q1[0], r3, r12
; CHECK-NEXT:    ldr.w r12, [sp, #12]
; CHECK-NEXT:    ldr r3, [sp, #4]
; CHECK-NEXT:    vmov q1[3], q1[1], r3, r12
; CHECK-NEXT:    adr r3, .LCPI2_0
; CHECK-NEXT:    vldrw.u32 q2, [r3]
; CHECK-NEXT:    vqadd.u32 q2, q2, r1
; CHECK-NEXT:    vcmp.u32 hi, q3, q2
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:    ldr r2, [sp, #48]
; CHECK-NEXT:    vqadd.u32 q0, q0, r1
; CHECK-NEXT:    ldr r1, [sp, #52]
; CHECK-NEXT:    vcmp.u32 hi, q3, q0
; CHECK-NEXT:    vmov.32 q0[1], r1
; CHECK-NEXT:    ldr r1, [sp, #56]
; CHECK-NEXT:    vmov q0[2], q0[0], r2, r1
; CHECK-NEXT:    ldr r1, [sp, #20]
; CHECK-NEXT:    ldr r2, [sp, #16]
; CHECK-NEXT:    vmov.32 q1[1], r1
; CHECK-NEXT:    ldr r1, [sp, #24]
; CHECK-NEXT:    vmov q1[2], q1[0], r2, r1
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    vmov r1, s2
; CHECK-NEXT:    vmov.f32 s2, s1
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    strd r3, r2, [r0, #16]
; CHECK-NEXT:    str r1, [r0, #24]
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI2_0:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
; CHECK-NEXT:  .LCPI2_1:
; CHECK-NEXT:    .long 4 @ 0x4
; CHECK-NEXT:    .long 5 @ 0x5
; CHECK-NEXT:    .long 6 @ 0x6
; CHECK-NEXT:    .zero 4
  %active.lane.mask = call <7 x i1> @llvm.get.active.lane.mask.v7i1.i32(i32 %index, i32 %TC)
  %select = select <7 x i1> %active.lane.mask, <7 x i32> %V1, <7 x i32> %V2
  ret <7 x i32> %select
}

define <8 x i16> @v8i16(i32 %index, i32 %TC, <8 x i16> %V1, <8 x i16> %V2) {
; CHECK-LABEL: v8i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    adr.w r12, .LCPI3_0
; CHECK-NEXT:    vdup.32 q1, r1
; CHECK-NEXT:    vldrw.u32 q0, [r12]
; CHECK-NEXT:    vmov.i8 q2, #0xff
; CHECK-NEXT:    vqadd.u32 q0, q0, r0
; CHECK-NEXT:    vcmp.u32 hi, q1, q0
; CHECK-NEXT:    vmov.i8 q0, #0x0
; CHECK-NEXT:    vpsel q3, q2, q0
; CHECK-NEXT:    vmov r1, r12, d6
; CHECK-NEXT:    vmov.16 q4[0], r1
; CHECK-NEXT:    vmov.16 q4[1], r12
; CHECK-NEXT:    vmov r1, r12, d7
; CHECK-NEXT:    vmov.16 q4[2], r1
; CHECK-NEXT:    adr r1, .LCPI3_1
; CHECK-NEXT:    vldrw.u32 q3, [r1]
; CHECK-NEXT:    vmov.16 q4[3], r12
; CHECK-NEXT:    vqadd.u32 q3, q3, r0
; CHECK-NEXT:    vcmp.u32 hi, q1, q3
; CHECK-NEXT:    vpsel q0, q2, q0
; CHECK-NEXT:    vmov r0, r1, d0
; CHECK-NEXT:    vmov.16 q4[4], r0
; CHECK-NEXT:    vmov d0, r2, r3
; CHECK-NEXT:    vmov.16 q4[5], r1
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    vmov.16 q4[6], r0
; CHECK-NEXT:    add r0, sp, #24
; CHECK-NEXT:    vmov.16 q4[7], r1
; CHECK-NEXT:    vldr d1, [sp, #16]
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vcmp.i16 ne, q4, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    vmov r0, r1, d0
; CHECK-NEXT:    vmov r2, r3, d1
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI3_0:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
; CHECK-NEXT:  .LCPI3_1:
; CHECK-NEXT:    .long 4 @ 0x4
; CHECK-NEXT:    .long 5 @ 0x5
; CHECK-NEXT:    .long 6 @ 0x6
; CHECK-NEXT:    .long 7 @ 0x7
  %active.lane.mask = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 %index, i32 %TC)
  %select = select <8 x i1> %active.lane.mask, <8 x i16> %V1, <8 x i16> %V2
  ret <8 x i16> %select
}

define <16 x i8> @v16i8(i32 %index, i32 %TC, <16 x i8> %V1, <16 x i8> %V2) {
; CHECK-LABEL: v16i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    adr.w r12, .LCPI4_0
; CHECK-NEXT:    vdup.32 q3, r1
; CHECK-NEXT:    vldrw.u32 q0, [r12]
; CHECK-NEXT:    vmov.i8 q1, #0xff
; CHECK-NEXT:    vqadd.u32 q0, q0, r0
; CHECK-NEXT:    vcmp.u32 hi, q3, q0
; CHECK-NEXT:    vmov.i8 q0, #0x0
; CHECK-NEXT:    vpsel q2, q1, q0
; CHECK-NEXT:    vmov r1, r12, d4
; CHECK-NEXT:    vmov.16 q4[0], r1
; CHECK-NEXT:    vmov.16 q4[1], r12
; CHECK-NEXT:    vmov r1, r12, d5
; CHECK-NEXT:    vmov.16 q4[2], r1
; CHECK-NEXT:    adr r1, .LCPI4_1
; CHECK-NEXT:    vldrw.u32 q2, [r1]
; CHECK-NEXT:    vmov.16 q4[3], r12
; CHECK-NEXT:    vqadd.u32 q2, q2, r0
; CHECK-NEXT:    vcmp.u32 hi, q3, q2
; CHECK-NEXT:    vpsel q2, q1, q0
; CHECK-NEXT:    vmov r1, r12, d4
; CHECK-NEXT:    vmov.16 q4[4], r1
; CHECK-NEXT:    vmov.16 q4[5], r12
; CHECK-NEXT:    vmov r1, r12, d5
; CHECK-NEXT:    vmov.16 q4[6], r1
; CHECK-NEXT:    vmov.16 q4[7], r12
; CHECK-NEXT:    vcmp.i16 ne, q4, zr
; CHECK-NEXT:    vpsel q4, q1, q0
; CHECK-NEXT:    vmov.u16 r1, q4[0]
; CHECK-NEXT:    vmov.8 q2[0], r1
; CHECK-NEXT:    vmov.u16 r1, q4[1]
; CHECK-NEXT:    vmov.8 q2[1], r1
; CHECK-NEXT:    vmov.u16 r1, q4[2]
; CHECK-NEXT:    vmov.8 q2[2], r1
; CHECK-NEXT:    vmov.u16 r1, q4[3]
; CHECK-NEXT:    vmov.8 q2[3], r1
; CHECK-NEXT:    vmov.u16 r1, q4[4]
; CHECK-NEXT:    vmov.8 q2[4], r1
; CHECK-NEXT:    vmov.u16 r1, q4[5]
; CHECK-NEXT:    vmov.8 q2[5], r1
; CHECK-NEXT:    vmov.u16 r1, q4[6]
; CHECK-NEXT:    vmov.8 q2[6], r1
; CHECK-NEXT:    vmov.u16 r1, q4[7]
; CHECK-NEXT:    vmov.8 q2[7], r1
; CHECK-NEXT:    adr r1, .LCPI4_2
; CHECK-NEXT:    vldrw.u32 q4, [r1]
; CHECK-NEXT:    vqadd.u32 q4, q4, r0
; CHECK-NEXT:    vcmp.u32 hi, q3, q4
; CHECK-NEXT:    vpsel q4, q1, q0
; CHECK-NEXT:    vmov r1, r12, d8
; CHECK-NEXT:    vmov.16 q5[0], r1
; CHECK-NEXT:    vmov.16 q5[1], r12
; CHECK-NEXT:    vmov r1, r12, d9
; CHECK-NEXT:    vmov.16 q5[2], r1
; CHECK-NEXT:    adr r1, .LCPI4_3
; CHECK-NEXT:    vldrw.u32 q4, [r1]
; CHECK-NEXT:    vmov.16 q5[3], r12
; CHECK-NEXT:    vqadd.u32 q4, q4, r0
; CHECK-NEXT:    vcmp.u32 hi, q3, q4
; CHECK-NEXT:    vpsel q3, q1, q0
; CHECK-NEXT:    vmov r0, r1, d6
; CHECK-NEXT:    vmov.16 q5[4], r0
; CHECK-NEXT:    vmov.16 q5[5], r1
; CHECK-NEXT:    vmov r0, r1, d7
; CHECK-NEXT:    vmov.16 q5[6], r0
; CHECK-NEXT:    vmov.16 q5[7], r1
; CHECK-NEXT:    vcmp.i16 ne, q5, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.8 q2[8], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.8 q2[9], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.8 q2[10], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.8 q2[11], r0
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.8 q2[12], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.8 q2[13], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.8 q2[14], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.8 q2[15], r0
; CHECK-NEXT:    add r0, sp, #40
; CHECK-NEXT:    vldr d1, [sp, #32]
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vcmp.i8 ne, q2, zr
; CHECK-NEXT:    vmov d0, r2, r3
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    vmov r0, r1, d0
; CHECK-NEXT:    vmov r2, r3, d1
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
; CHECK-NEXT:  .LCPI4_1:
; CHECK-NEXT:    .long 4 @ 0x4
; CHECK-NEXT:    .long 5 @ 0x5
; CHECK-NEXT:    .long 6 @ 0x6
; CHECK-NEXT:    .long 7 @ 0x7
; CHECK-NEXT:  .LCPI4_2:
; CHECK-NEXT:    .long 8 @ 0x8
; CHECK-NEXT:    .long 9 @ 0x9
; CHECK-NEXT:    .long 10 @ 0xa
; CHECK-NEXT:    .long 11 @ 0xb
; CHECK-NEXT:  .LCPI4_3:
; CHECK-NEXT:    .long 12 @ 0xc
; CHECK-NEXT:    .long 13 @ 0xd
; CHECK-NEXT:    .long 14 @ 0xe
; CHECK-NEXT:    .long 15 @ 0xf
  %active.lane.mask = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 %index, i32 %TC)
  %select = select <16 x i1> %active.lane.mask, <16 x i8> %V1, <16 x i8> %V2
  ret <16 x i8> %select
}

define void @test_width2(ptr nocapture readnone %x, ptr nocapture %y, i8 zeroext %m) {
; CHECK-LABEL: test_width2:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    sub sp, #4
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    beq .LBB5_3
; CHECK-NEXT:  @ %bb.1: @ %for.body.preheader
; CHECK-NEXT:    adds r0, r2, #1
; CHECK-NEXT:    movs r3, #1
; CHECK-NEXT:    bic r0, r0, #1
; CHECK-NEXT:    subs r0, #2
; CHECK-NEXT:    add.w r0, r3, r0, lsr #1
; CHECK-NEXT:    dls lr, r0
; CHECK-NEXT:  .LBB5_2: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vctp.64 r2
; CHECK-NEXT:    @ implicit-def: $q0
; CHECK-NEXT:    subs r2, #2
; CHECK-NEXT:    vmrs r3, p0
; CHECK-NEXT:    and r0, r3, #1
; CHECK-NEXT:    ubfx r3, r3, #8, #1
; CHECK-NEXT:    rsb.w r12, r0, #0
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    rsbs r3, r3, #0
; CHECK-NEXT:    bfi r0, r12, #0, #1
; CHECK-NEXT:    sub.w r12, r1, #8
; CHECK-NEXT:    bfi r0, r3, #1, #1
; CHECK-NEXT:    lsls r3, r0, #31
; CHECK-NEXT:    itt ne
; CHECK-NEXT:    ldrne.w r3, [r12]
; CHECK-NEXT:    vmovne.32 q0[0], r3
; CHECK-NEXT:    lsls r0, r0, #30
; CHECK-NEXT:    itt mi
; CHECK-NEXT:    ldrmi.w r0, [r12, #4]
; CHECK-NEXT:    vmovmi.32 q0[2], r0
; CHECK-NEXT:    vmrs r3, p0
; CHECK-NEXT:    and r0, r3, #1
; CHECK-NEXT:    ubfx r3, r3, #8, #1
; CHECK-NEXT:    rsb.w r12, r0, #0
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    rsbs r3, r3, #0
; CHECK-NEXT:    bfi r0, r12, #0, #1
; CHECK-NEXT:    bfi r0, r3, #1, #1
; CHECK-NEXT:    lsls r3, r0, #31
; CHECK-NEXT:    itt ne
; CHECK-NEXT:    vmovne r3, s0
; CHECK-NEXT:    strne r3, [r1]
; CHECK-NEXT:    lsls r0, r0, #30
; CHECK-NEXT:    itt mi
; CHECK-NEXT:    vmovmi r0, s2
; CHECK-NEXT:    strmi r0, [r1, #4]
; CHECK-NEXT:    adds r1, #8
; CHECK-NEXT:    le lr, .LBB5_2
; CHECK-NEXT:  .LBB5_3: @ %for.cond.cleanup
; CHECK-NEXT:    add sp, #4
; CHECK-NEXT:    pop {r7, pc}
entry:
  %cmp9.not = icmp eq i8 %m, 0
  br i1 %cmp9.not, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i8 %m to i32
  %n.rnd.up = add nuw nsw i32 %wide.trip.count, 1
  %n.vec = and i32 %n.rnd.up, 510
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.body.preheader
  %index = phi i32 [ 0, %for.body.preheader ], [ %index.next, %vector.body ]
  %active.lane.mask = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 %index, i32 %wide.trip.count)
  %0 = add nsw i32 %index, -2
  %1 = getelementptr inbounds i32, ptr %y, i32 %0
  %wide.masked.load = call <2 x i32> @llvm.masked.load.v2i32.p0(ptr %1, i32 4, <2 x i1> %active.lane.mask, <2 x i32> undef)
  %2 = getelementptr inbounds i32, ptr %y, i32 %index
  call void @llvm.masked.store.v2i32.p0(<2 x i32> %wide.masked.load, ptr %2, i32 4, <2 x i1> %active.lane.mask)
  %index.next = add i32 %index, 2
  %3 = icmp eq i32 %index.next, %n.vec
  br i1 %3, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body, %entry
  ret void
}

declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32, i32)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <7 x i1> @llvm.get.active.lane.mask.v7i1.i32(i32, i32)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32, i32)
declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32, i32)
declare <2 x i32> @llvm.masked.load.v2i32.p0(ptr, i32, <2 x i1>, <2 x i32>)
declare void @llvm.masked.store.v2i32.p0(<2 x i32>, ptr, i32, <2 x i1>)
