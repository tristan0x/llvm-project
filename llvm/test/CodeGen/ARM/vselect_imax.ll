; RUN: opt < %s -passes='print<cost-model>' -mtriple=arm-apple-ios6.0.0 -mcpu=cortex-a8 2>&1 -disable-output | FileCheck %s --check-prefix=COST
; RUN: llc -mtriple=arm-eabi -mattr=+neon %s -o - | FileCheck %s
; Make sure that ARM backend with NEON handles vselect.

define void @vmax_v4i32(ptr %m, <4 x i32> %a, <4 x i32> %b) {
; CHECK: vmax.s32 {{q[0-9]+}}, {{q[0-9]+}}, {{q[0-9]+}}
    %cmpres = icmp sgt <4 x i32> %a, %b
    %maxres = select <4 x i1> %cmpres, <4 x i32> %a,  <4 x i32> %b
    store <4 x i32> %maxres, ptr %m
    ret void
}

%T0_10 = type <16 x i16>
%T1_10 = type <16 x i1>
; CHECK-LABEL: func_blend10:
define void @func_blend10(ptr %loadaddr, ptr %loadaddr2,
                           ptr %blend, ptr %storeaddr) {
  %v0 = load %T0_10, ptr %loadaddr
  %v1 = load %T0_10, ptr %loadaddr2
  %c = icmp slt %T0_10 %v0, %v1
; CHECK: vmin.s16
; CHECK: vmin.s16
; COST: func_blend10
; COST: cost of 0 {{.*}} icmp
; COST: cost of 4 {{.*}} select
  %r = select %T1_10 %c, %T0_10 %v0, %T0_10 %v1
  store %T0_10 %r, ptr %storeaddr
  ret void
}
%T0_14 = type <8 x i32>
%T1_14 = type <8 x i1>
; CHECK-LABEL: func_blend14:
define void @func_blend14(ptr %loadaddr, ptr %loadaddr2,
                           ptr %blend, ptr %storeaddr) {
  %v0 = load %T0_14, ptr %loadaddr
  %v1 = load %T0_14, ptr %loadaddr2
  %c = icmp slt %T0_14 %v0, %v1
; CHECK: vmin.s32
; CHECK: vmin.s32
; COST: func_blend14
; COST: cost of 0 {{.*}} icmp
; COST: cost of 4 {{.*}} select
  %r = select %T1_14 %c, %T0_14 %v0, %T0_14 %v1
  store %T0_14 %r, ptr %storeaddr
  ret void
}
%T0_15 = type <16 x i32>
%T1_15 = type <16 x i1>
; CHECK-LABEL: func_blend15:
define void @func_blend15(ptr %loadaddr, ptr %loadaddr2,
                           ptr %blend, ptr %storeaddr) {
; CHECK: vmin.s32
; CHECK: vmin.s32
  %v0 = load %T0_15, ptr %loadaddr
  %v1 = load %T0_15, ptr %loadaddr2
  %c = icmp slt %T0_15 %v0, %v1
; COST: func_blend15
; COST: cost of 0 {{.*}} icmp
; COST: cost of 8 {{.*}} select
  %r = select %T1_15 %c, %T0_15 %v0, %T0_15 %v1
  store %T0_15 %r, ptr %storeaddr
  ret void
}

; We adjusted the cost model of the following selects. When we improve code
; lowering we also need to adjust the cost.
%T0_18 = type <4 x i64>
%T1_18 = type <4 x i1>
define void @func_blend18(ptr %loadaddr, ptr %loadaddr2,
; CHECK-LABEL: func_blend18:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r11, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r11, lr}
; CHECK-NEXT:    vld1.64 {d16, d17}, [r1:128]!
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0:128]!
; CHECK-NEXT:    vmov r4, r6, d16
; CHECK-NEXT:    vld1.64 {d20, d21}, [r1:128]
; CHECK-NEXT:    mov r1, #0
; CHECK-NEXT:    vld1.64 {d22, d23}, [r0:128]
; CHECK-NEXT:    vmov r0, r12, d20
; CHECK-NEXT:    vmov r2, lr, d22
; CHECK-NEXT:    subs r0, r2, r0
; CHECK-NEXT:    vmov r2, r5, d18
; CHECK-NEXT:    sbcs r0, lr, r12
; CHECK-NEXT:    vmov r7, lr, d17
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    subs r2, r2, r4
; CHECK-NEXT:    sbcs r6, r5, r6
; CHECK-NEXT:    vmov r2, r12, d21
; CHECK-NEXT:    vmov r5, r4, d23
; CHECK-NEXT:    mov r6, #0
; CHECK-NEXT:    movlt r6, #1
; CHECK-NEXT:    cmp r6, #0
; CHECK-NEXT:    mvnne r6, #0
; CHECK-NEXT:    subs r2, r5, r2
; CHECK-NEXT:    sbcs r4, r4, r12
; CHECK-NEXT:    mov r2, #0
; CHECK-NEXT:    vmov r4, r5, d19
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    subs r7, r4, r7
; CHECK-NEXT:    sbcs r7, r5, lr
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    mvnne r1, #0
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    mvnne r2, #0
; CHECK-NEXT:    vdup.32 d25, r1
; CHECK-NEXT:    vdup.32 d27, r2
; CHECK-NEXT:    vdup.32 d24, r6
; CHECK-NEXT:    vdup.32 d26, r0
; CHECK-NEXT:    vbit q8, q9, q12
; CHECK-NEXT:    vorr q9, q13, q13
; CHECK-NEXT:    vbsl q9, q11, q10
; CHECK-NEXT:    vst1.64 {d16, d17}, [r3:128]!
; CHECK-NEXT:    vst1.64 {d18, d19}, [r3:128]
; CHECK-NEXT:    pop {r4, r5, r6, r7, r11, lr}
; CHECK-NEXT:    mov pc, lr
                           ptr %blend, ptr %storeaddr) {
  %v0 = load %T0_18, ptr %loadaddr
  %v1 = load %T0_18, ptr %loadaddr2
  %c = icmp slt %T0_18 %v0, %v1
; COST: func_blend18
; COST: cost of 0 {{.*}} icmp
; COST: cost of 21 {{.*}} select
  %r = select %T1_18 %c, %T0_18 %v0, %T0_18 %v1
  store %T0_18 %r, ptr %storeaddr
  ret void
}
%T0_19 = type <8 x i64>
%T1_19 = type <8 x i1>
define void @func_blend19(ptr %loadaddr, ptr %loadaddr2,
; CHECK-LABEL: func_blend19:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, lr}
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    vld1.64 {d28, d29}, [r1:128]!
; CHECK-NEXT:    vld1.64 {d30, d31}, [r0:128]!
; CHECK-NEXT:    vld1.64 {d16, d17}, [r1:128]!
; CHECK-NEXT:    vld1.64 {d22, d23}, [r0:128]!
; CHECK-NEXT:    vld1.64 {d18, d19}, [r1:128]!
; CHECK-NEXT:    vld1.64 {d24, d25}, [r0:128]!
; CHECK-NEXT:    vld1.64 {d20, d21}, [r1:128]
; CHECK-NEXT:    vld1.64 {d26, d27}, [r0:128]
; CHECK-NEXT:    vmov r0, r12, d20
; CHECK-NEXT:    vmov r1, r2, d26
; CHECK-NEXT:    subs r0, r1, r0
; CHECK-NEXT:    mov r1, #0
; CHECK-NEXT:    sbcs r0, r2, r12
; CHECK-NEXT:    vmov lr, r12, d17
; CHECK-NEXT:    vmov r2, r4, d23
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    subs r2, r2, lr
; CHECK-NEXT:    sbcs r2, r4, r12
; CHECK-NEXT:    vmov r4, lr, d24
; CHECK-NEXT:    mov r2, #0
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    mvnne r2, #0
; CHECK-NEXT:    vdup.32 d1, r2
; CHECK-NEXT:    vmov r2, r12, d18
; CHECK-NEXT:    subs r2, r4, r2
; CHECK-NEXT:    vmov r4, r5, d31
; CHECK-NEXT:    sbcs r2, lr, r12
; CHECK-NEXT:    vmov lr, r12, d29
; CHECK-NEXT:    mov r2, #0
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    mvnne r2, #0
; CHECK-NEXT:    subs r4, r4, lr
; CHECK-NEXT:    sbcs r5, r5, r12
; CHECK-NEXT:    vmov r4, lr, d30
; CHECK-NEXT:    mov r5, #0
; CHECK-NEXT:    movlt r5, #1
; CHECK-NEXT:    cmp r5, #0
; CHECK-NEXT:    mvnne r5, #0
; CHECK-NEXT:    vdup.32 d3, r5
; CHECK-NEXT:    vmov r5, r12, d28
; CHECK-NEXT:    subs r4, r4, r5
; CHECK-NEXT:    sbcs r5, lr, r12
; CHECK-NEXT:    vmov r4, lr, d22
; CHECK-NEXT:    mov r5, #0
; CHECK-NEXT:    movlt r5, #1
; CHECK-NEXT:    cmp r5, #0
; CHECK-NEXT:    mvnne r5, #0
; CHECK-NEXT:    vdup.32 d2, r5
; CHECK-NEXT:    vmov r5, r12, d16
; CHECK-NEXT:    vbit q14, q15, q1
; CHECK-NEXT:    subs r4, r4, r5
; CHECK-NEXT:    sbcs r5, lr, r12
; CHECK-NEXT:    vmov lr, r12, d21
; CHECK-NEXT:    vmov r4, r6, d27
; CHECK-NEXT:    mov r5, #0
; CHECK-NEXT:    movlt r5, #1
; CHECK-NEXT:    cmp r5, #0
; CHECK-NEXT:    mvnne r5, #0
; CHECK-NEXT:    vdup.32 d0, r5
; CHECK-NEXT:    mov r5, #0
; CHECK-NEXT:    vbit q8, q11, q0
; CHECK-NEXT:    subs r4, r4, lr
; CHECK-NEXT:    sbcs r6, r6, r12
; CHECK-NEXT:    vmov r4, lr, d25
; CHECK-NEXT:    vmov r6, r12, d19
; CHECK-NEXT:    movlt r5, #1
; CHECK-NEXT:    subs r4, r4, r6
; CHECK-NEXT:    sbcs r6, lr, r12
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    mvnne r1, #0
; CHECK-NEXT:    cmp r5, #0
; CHECK-NEXT:    vdup.32 d31, r1
; CHECK-NEXT:    mvnne r5, #0
; CHECK-NEXT:    vdup.32 d30, r2
; CHECK-NEXT:    vdup.32 d3, r5
; CHECK-NEXT:    vbit q9, q12, q15
; CHECK-NEXT:    vdup.32 d2, r0
; CHECK-NEXT:    vst1.64 {d28, d29}, [r3:128]!
; CHECK-NEXT:    vbit q10, q13, q1
; CHECK-NEXT:    vst1.64 {d16, d17}, [r3:128]!
; CHECK-NEXT:    vst1.64 {d18, d19}, [r3:128]!
; CHECK-NEXT:    vst1.64 {d20, d21}, [r3:128]
; CHECK-NEXT:    pop {r4, r5, r6, lr}
; CHECK-NEXT:    mov pc, lr
                           ptr %blend, ptr %storeaddr) {
  %v0 = load %T0_19, ptr %loadaddr
  %v1 = load %T0_19, ptr %loadaddr2
  %c = icmp slt %T0_19 %v0, %v1
; COST: func_blend19
; COST: cost of 0 {{.*}} icmp
; COST: cost of 54 {{.*}} select
  %r = select %T1_19 %c, %T0_19 %v0, %T0_19 %v1
  store %T0_19 %r, ptr %storeaddr
  ret void
}
%T0_20 = type <16 x i64>
%T1_20 = type <16 x i1>
define void @func_blend20(ptr %loadaddr, ptr %loadaddr2,
; CHECK-LABEL: func_blend20:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, r9, r10, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r8, r9, r10, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    mov r8, r1
; CHECK-NEXT:    mov lr, r0
; CHECK-NEXT:    vld1.64 {d16, d17}, [r8:128]!
; CHECK-NEXT:    add r9, r0, #64
; CHECK-NEXT:    add r10, r1, #64
; CHECK-NEXT:    mov r12, #0
; CHECK-NEXT:    vld1.64 {d22, d23}, [lr:128]!
; CHECK-NEXT:    vld1.64 {d18, d19}, [r8:128]!
; CHECK-NEXT:    vld1.64 {d20, d21}, [lr:128]!
; CHECK-NEXT:    vmov r6, r4, d19
; CHECK-NEXT:    vmov r5, r7, d21
; CHECK-NEXT:    vld1.64 {d2, d3}, [r9:128]!
; CHECK-NEXT:    vld1.64 {d6, d7}, [r10:128]!
; CHECK-NEXT:    vld1.64 {d0, d1}, [r10:128]!
; CHECK-NEXT:    vld1.64 {d4, d5}, [r9:128]!
; CHECK-NEXT:    subs r6, r5, r6
; CHECK-NEXT:    sbcs r4, r7, r4
; CHECK-NEXT:    vmov r5, r6, d18
; CHECK-NEXT:    vmov r7, r2, d20
; CHECK-NEXT:    mov r4, #0
; CHECK-NEXT:    movlt r4, #1
; CHECK-NEXT:    cmp r4, #0
; CHECK-NEXT:    mvnne r4, #0
; CHECK-NEXT:    vdup.32 d25, r4
; CHECK-NEXT:    subs r5, r7, r5
; CHECK-NEXT:    sbcs r2, r2, r6
; CHECK-NEXT:    vmov r4, r5, d5
; CHECK-NEXT:    mov r2, #0
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    mvnne r2, #0
; CHECK-NEXT:    vdup.32 d24, r2
; CHECK-NEXT:    vmov r0, r2, d1
; CHECK-NEXT:    subs r0, r4, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    vmov r4, r5, d4
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    vdup.32 d9, r0
; CHECK-NEXT:    vmov r0, r2, d0
; CHECK-NEXT:    subs r0, r4, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    vmov r4, r5, d3
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    vdup.32 d8, r0
; CHECK-NEXT:    vmov r0, r2, d7
; CHECK-NEXT:    subs r0, r4, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    vmov r4, r5, d2
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    vdup.32 d11, r0
; CHECK-NEXT:    vmov r0, r2, d6
; CHECK-NEXT:    subs r0, r4, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    vmov r4, r5, d23
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    vdup.32 d10, r0
; CHECK-NEXT:    vmov r0, r2, d17
; CHECK-NEXT:    subs r0, r4, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    vmov r4, r5, d22
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    vdup.32 d27, r0
; CHECK-NEXT:    vmov r0, r2, d16
; CHECK-NEXT:    subs r0, r4, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    vdup.32 d26, r0
; CHECK-NEXT:    vorr q14, q13, q13
; CHECK-NEXT:    vbsl q14, q11, q8
; CHECK-NEXT:    vld1.64 {d26, d27}, [r9:128]!
; CHECK-NEXT:    vorr q8, q5, q5
; CHECK-NEXT:    vld1.64 {d30, d31}, [r10:128]!
; CHECK-NEXT:    vbsl q8, q1, q3
; CHECK-NEXT:    vld1.64 {d6, d7}, [r8:128]!
; CHECK-NEXT:    vld1.64 {d22, d23}, [r8:128]
; CHECK-NEXT:    vld1.64 {d2, d3}, [lr:128]!
; CHECK-NEXT:    vbif q10, q9, q12
; CHECK-NEXT:    vorr q9, q4, q4
; CHECK-NEXT:    vmov r0, r2, d22
; CHECK-NEXT:    vbsl q9, q2, q0
; CHECK-NEXT:    vld1.64 {d24, d25}, [lr:128]
; CHECK-NEXT:    vmov r7, r5, d24
; CHECK-NEXT:    vld1.64 {d4, d5}, [r9:128]
; CHECK-NEXT:    vld1.64 {d8, d9}, [r10:128]
; CHECK-NEXT:    subs r0, r7, r0
; CHECK-NEXT:    sbcs r0, r5, r2
; CHECK-NEXT:    vmov r5, r4, d26
; CHECK-NEXT:    vmov r0, r7, d30
; CHECK-NEXT:    mov r2, #0
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    mvnne r2, #0
; CHECK-NEXT:    subs r0, r5, r0
; CHECK-NEXT:    sbcs r0, r4, r7
; CHECK-NEXT:    vmov r7, r5, d31
; CHECK-NEXT:    vmov r4, r6, d27
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    mvnne r0, #0
; CHECK-NEXT:    subs r7, r4, r7
; CHECK-NEXT:    mov r4, #0
; CHECK-NEXT:    sbcs r7, r6, r5
; CHECK-NEXT:    vmov r5, r1, d25
; CHECK-NEXT:    vmov r7, r6, d23
; CHECK-NEXT:    movlt r4, #1
; CHECK-NEXT:    cmp r4, #0
; CHECK-NEXT:    mvnne r4, #0
; CHECK-NEXT:    subs r7, r5, r7
; CHECK-NEXT:    mov r5, #0
; CHECK-NEXT:    sbcs r1, r1, r6
; CHECK-NEXT:    vmov r6, r7, d3
; CHECK-NEXT:    vmov r1, lr, d7
; CHECK-NEXT:    movlt r5, #1
; CHECK-NEXT:    cmp r5, #0
; CHECK-NEXT:    mvnne r5, #0
; CHECK-NEXT:    subs r1, r6, r1
; CHECK-NEXT:    sbcs r1, r7, lr
; CHECK-NEXT:    vmov r6, r7, d2
; CHECK-NEXT:    mov r1, #0
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    mvnne r1, #0
; CHECK-NEXT:    vdup.32 d1, r1
; CHECK-NEXT:    vmov r1, lr, d6
; CHECK-NEXT:    subs r1, r6, r1
; CHECK-NEXT:    sbcs r1, r7, lr
; CHECK-NEXT:    vmov r6, r7, d4
; CHECK-NEXT:    mov r1, #0
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    mvnne r1, #0
; CHECK-NEXT:    vdup.32 d0, r1
; CHECK-NEXT:    vmov r1, lr, d8
; CHECK-NEXT:    vbsl q0, q1, q3
; CHECK-NEXT:    vdup.32 d3, r5
; CHECK-NEXT:    vdup.32 d7, r4
; CHECK-NEXT:    mov r4, #0
; CHECK-NEXT:    vdup.32 d6, r0
; CHECK-NEXT:    mov r0, r3
; CHECK-NEXT:    vst1.64 {d28, d29}, [r0:128]!
; CHECK-NEXT:    vbif q13, q15, q3
; CHECK-NEXT:    vdup.32 d2, r2
; CHECK-NEXT:    vbit q11, q12, q1
; CHECK-NEXT:    vst1.64 {d20, d21}, [r0:128]!
; CHECK-NEXT:    subs r1, r6, r1
; CHECK-NEXT:    vmov r6, r5, d5
; CHECK-NEXT:    sbcs r1, r7, lr
; CHECK-NEXT:    vmov r1, r7, d9
; CHECK-NEXT:    movlt r4, #1
; CHECK-NEXT:    subs r1, r6, r1
; CHECK-NEXT:    sbcs r1, r5, r7
; CHECK-NEXT:    movlt r12, #1
; CHECK-NEXT:    cmp r12, #0
; CHECK-NEXT:    mvnne r12, #0
; CHECK-NEXT:    cmp r4, #0
; CHECK-NEXT:    vdup.32 d29, r12
; CHECK-NEXT:    mvnne r4, #0
; CHECK-NEXT:    vdup.32 d28, r4
; CHECK-NEXT:    vorr q10, q14, q14
; CHECK-NEXT:    vbsl q10, q2, q4
; CHECK-NEXT:    vst1.64 {d0, d1}, [r0:128]!
; CHECK-NEXT:    vst1.64 {d22, d23}, [r0:128]
; CHECK-NEXT:    add r0, r3, #64
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0:128]!
; CHECK-NEXT:    vst1.64 {d18, d19}, [r0:128]!
; CHECK-NEXT:    vst1.64 {d26, d27}, [r0:128]!
; CHECK-NEXT:    vst1.64 {d20, d21}, [r0:128]
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    pop {r4, r5, r6, r7, r8, r9, r10, lr}
; CHECK-NEXT:    mov pc, lr
                           ptr %blend, ptr %storeaddr) {
  %v0 = load %T0_20, ptr %loadaddr
  %v1 = load %T0_20, ptr %loadaddr2
  %c = icmp slt %T0_20 %v0, %v1
; COST: func_blend20
; COST: cost of 0 {{.*}} icmp
; COST: cost of 108 {{.*}} select
  %r = select %T1_20 %c, %T0_20 %v0, %T0_20 %v1
  store %T0_20 %r, ptr %storeaddr
  ret void
}
