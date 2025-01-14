; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -verify-machineinstrs -stop-before virtregrewriter | FileCheck %s

; Check LEA64_32r register is split to COPY10
define void @foo(i32 %M, i32 %N, i32 %K, ptr %A, ptr %B_rcr4, ptr %C, i32 %c_row_from, i32 %c_row_to, i32 %c_row_tile, i32 %c_col_from, i32 %c_col_to, i32 %c_col_tile) {
  ; CHECK-LABEL: name: foo
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x40000000), %bb.4(0x40000000)
  ; CHECK-NEXT:   liveins: $esi, $edx, $rcx, $r8, $r9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:gr64 = COPY $r9
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:gr64 = COPY $r8
  ; CHECK-NEXT:   MOV64mr %stack.1, 1, $noreg, 0, $noreg, $rcx :: (store (s64) into %stack.1)
  ; CHECK-NEXT:   undef [[COPY2:%[0-9]+]].sub_32bit:gr64_with_sub_8bit = COPY $edx
  ; CHECK-NEXT:   undef [[COPY3:%[0-9]+]].sub_32bit:gr64_nosp = COPY $esi
  ; CHECK-NEXT:   [[AVX512_512_SET0_:%[0-9]+]]:vr512 = AVX512_512_SET0
  ; CHECK-NEXT:   VMOVUPSZmr %stack.0, 1, $noreg, 0, $noreg, [[AVX512_512_SET0_]] :: (store (s512) into %stack.0, align 4)
  ; CHECK-NEXT:   MOV8mi %stack.0, 1, $noreg, 0, $noreg, 1 :: (store (s512) into %stack.0, align 4)
  ; CHECK-NEXT:   [[MOV32rm:%[0-9]+]]:gr32 = MOV32rm %fixed-stack.4, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.4, align 8)
  ; CHECK-NEXT:   [[MOV32rm1:%[0-9]+]]:gr32 = MOV32rm %fixed-stack.5, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.5, align 16)
  ; CHECK-NEXT:   [[LEA64_32r:%[0-9]+]]:gr32 = LEA64_32r [[COPY2]], 1, $noreg, 63, $noreg
  ; CHECK-NEXT:   TEST32rr [[COPY2]].sub_32bit, [[COPY2]].sub_32bit, implicit-def $eflags
  ; CHECK-NEXT:   [[LEA64_32r:%[0-9]+]]:gr32 = CMOV32rr [[LEA64_32r]], [[COPY2]].sub_32bit, 9, implicit $eflags
  ; CHECK-NEXT:   CMP32rr [[MOV32rm1]], [[MOV32rm]], implicit-def $eflags
  ; CHECK-NEXT:   JCC_1 %bb.4, 13, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.for.cond14.preheader.lr.ph:
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   undef [[MOV32rm2:%[0-9]+]].sub_32bit:gr64_nosp = MOV32rm %fixed-stack.0, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.0, align 8)
  ; CHECK-NEXT:   MOV16mr %stack.0, 1, $noreg, 16, $noreg, [[MOV32rm2]].sub_16bit :: (store (s512) into %stack.0 + 16, align 4)
  ; CHECK-NEXT:   [[MOV32rm3:%[0-9]+]]:gr32 = MOV32rm %fixed-stack.3, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.3, align 16)
  ; CHECK-NEXT:   MOV8mr %stack.0, 1, $noreg, 49, $noreg, [[MOV32rm3]].sub_8bit :: (store (s512) into %stack.0 + 49, align 1, basealign 4)
  ; CHECK-NEXT:   MOV8mr %stack.0, 1, $noreg, 48, $noreg, [[MOV32rm3]].sub_8bit :: (store (s512) into %stack.0 + 48, align 4)
  ; CHECK-NEXT:   [[LEA64_32r:%[0-9]+]]:gr32 = AND32ri [[LEA64_32r]], -64, implicit-def dead $eflags
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:gr32 = COPY [[COPY2]].sub_32bit
  ; CHECK-NEXT:   MOV16mr %stack.0, 1, $noreg, 18, $noreg, [[COPY4]].sub_16bit :: (store (s512) into %stack.0 + 18, align 2, basealign 4)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:gr32 = SUB32rr [[COPY4]], [[LEA64_32r]], implicit-def dead $eflags
  ; CHECK-NEXT:   MOV16mr %stack.0, 1, $noreg, 18, $noreg, [[COPY4]].sub_16bit :: (store (s512) into %stack.0 + 18, align 2, basealign 4)
  ; CHECK-NEXT:   [[MOVZX32rr16_:%[0-9]+]]:gr32 = MOVZX32rr16 [[COPY4]].sub_16bit
  ; CHECK-NEXT:   MOV8mr %stack.0, 1, $noreg, 50, $noreg, [[MOVZX32rr16_]].sub_8bit :: (store (s512) into %stack.0 + 50, align 2, basealign 4)
  ; CHECK-NEXT:   [[MOVZX32rr16_:%[0-9]+]]:gr32 = SHR32ri [[MOVZX32rr16_]], 2, implicit-def dead $eflags
  ; CHECK-NEXT:   MOV32mr %stack.2, 1, $noreg, 0, $noreg, [[MOVZX32rr16_]] :: (store (s32) into %stack.2)
  ; CHECK-NEXT:   MOV8mr %stack.0, 1, $noreg, 50, $noreg, [[MOVZX32rr16_]].sub_8bit :: (store (s512) into %stack.0 + 50, align 2, basealign 4)
  ; CHECK-NEXT:   [[LEA64_32r1:%[0-9]+]]:gr32 = LEA64_32r $noreg, 4, [[MOV32rm2]], 0, $noreg
  ; CHECK-NEXT:   MOV16mr %stack.0, 1, $noreg, 20, $noreg, [[LEA64_32r1]].sub_16bit :: (store (s512) into %stack.0 + 20, align 4)
  ; CHECK-NEXT:   PLDTILECFGV %stack.0, 1, $noreg, 0, $noreg, implicit-def dead $tmm0, implicit-def dead $tmm1, implicit-def dead $tmm2, implicit-def dead $tmm3, implicit-def dead $tmm4, implicit-def dead $tmm5, implicit-def dead $tmm6, implicit-def dead $tmm7 :: (load (s512) from %stack.0, align 4)
  ; CHECK-NEXT:   [[MOVSX64rr32_:%[0-9]+]]:gr64_nosp = MOVSX64rr32 [[COPY2]].sub_32bit
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]].sub_32bit:gr64_with_sub_8bit = SUB32rr [[COPY2]].sub_32bit, [[COPY4]], implicit-def dead $eflags
  ; CHECK-NEXT:   undef [[MOVZX32rr16_1:%[0-9]+]].sub_32bit:gr64_with_sub_8bit = MOVZX32rr16 [[COPY2]].sub_16bit
  ; CHECK-NEXT:   ADD64mr %stack.1, 1, $noreg, 0, $noreg, [[MOVZX32rr16_1]], implicit-def dead $eflags :: (store (s64) into %stack.1)
  ; CHECK-NEXT:   undef [[COPY5:%[0-9]+]].sub_32bit:gr64_with_sub_8bit = COPY [[MOVZX32rr16_1]].sub_32bit
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]].sub_32bit:gr64_with_sub_8bit = IMUL32rr [[COPY5]].sub_32bit, [[COPY3]].sub_32bit, implicit-def dead $eflags
  ; CHECK-NEXT:   [[LEA64_32r2:%[0-9]+]]:gr32 = LEA64_32r $noreg, 4, [[COPY3]], 0, $noreg
  ; CHECK-NEXT:   [[MOVSX64rr32_1:%[0-9]+]]:gr64 = MOVSX64rr32 [[LEA64_32r2]]
  ; CHECK-NEXT:   MOV64mr %stack.3, 1, $noreg, 0, $noreg, [[MOVSX64rr32_1]] :: (store (s64) into %stack.3)
  ; CHECK-NEXT:   [[MOVSX64rr32_2:%[0-9]+]]:gr64_nosp = MOVSX64rr32 [[COPY3]].sub_32bit
  ; CHECK-NEXT:   [[MOVSX64rm32_:%[0-9]+]]:gr64_nosp = MOVSX64rm32 %fixed-stack.2, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.2, align 8)
  ; CHECK-NEXT:   [[MOVSX64rr32_3:%[0-9]+]]:gr64_nosp = MOVSX64rr32 [[MOV32rm2]].sub_32bit
  ; CHECK-NEXT:   [[MOVSX64rm32_1:%[0-9]+]]:gr64 = MOVSX64rm32 %fixed-stack.1, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.1, align 16)
  ; CHECK-NEXT:   MOV64mr %stack.5, 1, $noreg, 0, $noreg, [[MOVSX64rm32_1]] :: (store (s64) into %stack.5)
  ; CHECK-NEXT:   [[MOVSX64rr32_4:%[0-9]+]]:gr64 = MOVSX64rr32 [[MOV32rm1]]
  ; CHECK-NEXT:   [[MOVSX64rr32_5:%[0-9]+]]:gr64 = MOVSX64rr32 [[MOV32rm3]]
  ; CHECK-NEXT:   [[MOVSX64rr32_6:%[0-9]+]]:gr64 = MOVSX64rr32 [[MOV32rm]]
  ; CHECK-NEXT:   MOV64mr %stack.8, 1, $noreg, 0, $noreg, [[MOVSX64rr32_6]] :: (store (s64) into %stack.8)
  ; CHECK-NEXT:   MOV64mr %stack.6, 1, $noreg, 0, $noreg, [[MOVSX64rr32_4]] :: (store (s64) into %stack.6)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:gr64_nosp = COPY [[MOVSX64rr32_4]]
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:gr64_nosp = IMUL64rr [[COPY6]], [[MOVSX64rr32_2]], implicit-def dead $eflags
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:gr64_nosp = ADD64rr [[COPY6]], [[MOVSX64rm32_]], implicit-def dead $eflags
  ; CHECK-NEXT:   [[LEA64r:%[0-9]+]]:gr64 = LEA64r [[COPY]], 4, [[COPY6]], 0, $noreg
  ; CHECK-NEXT:   MOV64mr %stack.9, 1, $noreg, 0, $noreg, [[LEA64r]] :: (store (s64) into %stack.9)
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:gr32 = COPY [[MOV32rm3]]
  ; CHECK-NEXT:   MOV64mr %stack.7, 1, $noreg, 0, $noreg, [[MOVSX64rr32_5]] :: (store (s64) into %stack.7)
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:gr64 = COPY [[MOVSX64rr32_5]]
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:gr64 = IMUL64rr [[COPY8]], [[MOVSX64rr32_2]], implicit-def dead $eflags
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:gr64 = SHL64ri [[COPY8]], 2, implicit-def dead $eflags
  ; CHECK-NEXT:   MOV64mr %stack.10, 1, $noreg, 0, $noreg, [[COPY8]] :: (store (s64) into %stack.10)
  ; CHECK-NEXT:   [[LEA64r1:%[0-9]+]]:gr64 = LEA64r $noreg, 4, [[MOVSX64rr32_3]], 0, $noreg
  ; CHECK-NEXT:   MOV64mr %stack.11, 1, $noreg, 0, $noreg, [[LEA64r1]] :: (store (s64) into %stack.11)
  ; CHECK-NEXT:   MOV64mr %stack.4, 1, $noreg, 0, $noreg, [[MOVSX64rm32_]] :: (store (s64) into %stack.4)
  ; CHECK-NEXT:   [[LEA64_32r3:%[0-9]+]]:gr32 = LEA64_32r [[COPY5]], 4, [[MOVSX64rm32_]], 0, $noreg
  ; CHECK-NEXT:   MOV32mr %stack.12, 1, $noreg, 0, $noreg, [[LEA64_32r3]] :: (store (s32) into %stack.12)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.for.cond14.preheader:
  ; CHECK-NEXT:   successors: %bb.3(0x40000000), %bb.5(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[MOV32rm4:%[0-9]+]]:gr32 = MOV32rm %fixed-stack.2, 1, $noreg, 0, $noreg :: (load (s32) from %fixed-stack.2, align 8)
  ; CHECK-NEXT:   CMP32rm [[MOV32rm4]], %fixed-stack.1, 1, $noreg, 0, $noreg, implicit-def $eflags :: (load (s32) from %fixed-stack.1, align 16)
  ; CHECK-NEXT:   [[MOV64rm:%[0-9]+]]:gr64 = MOV64rm %stack.11, 1, $noreg, 0, $noreg :: (load (s64) from %stack.11)
  ; CHECK-NEXT:   JCC_1 %bb.5, 13, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.for.body17.lr.ph:
  ; CHECK-NEXT:   successors: %bb.6(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[MOV64rm1:%[0-9]+]]:gr64 = MOV64rm %stack.6, 1, $noreg, 0, $noreg :: (load (s64) from %stack.6)
  ; CHECK-NEXT:   [[MOV64rm1:%[0-9]+]]:gr64 = nsw IMUL64rr [[MOV64rm1]], [[MOVSX64rr32_]], implicit-def dead $eflags
  ; CHECK-NEXT:   [[MOV64rm1:%[0-9]+]]:gr64 = ADD64rm [[MOV64rm1]], %stack.1, 1, $noreg, 0, $noreg, implicit-def dead $eflags :: (load (s64) from %stack.1)
  ; CHECK-NEXT:   MOV64mr %stack.13, 1, $noreg, 0, $noreg, [[MOV64rm1]] :: (store (s64) into %stack.13)
  ; CHECK-NEXT:   [[MOV32rm5:%[0-9]+]]:gr32 = MOV32rm %stack.12, 1, $noreg, 0, $noreg :: (load (s32) from %stack.12)
  ; CHECK-NEXT:   undef [[COPY9:%[0-9]+]].sub_32bit:gr64_nosp = COPY [[MOV32rm5]]
  ; CHECK-NEXT:   [[MOV64rm2:%[0-9]+]]:gr64 = MOV64rm %stack.9, 1, $noreg, 0, $noreg :: (load (s64) from %stack.9)
  ; CHECK-NEXT:   [[MOV64rm3:%[0-9]+]]:gr64 = MOV64rm %stack.4, 1, $noreg, 0, $noreg :: (load (s64) from %stack.4)
  ; CHECK-NEXT:   JMP_1 %bb.6
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4.for.cond.cleanup:
  ; CHECK-NEXT:   RET 0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.5.for.cond.cleanup16:
  ; CHECK-NEXT:   successors: %bb.2(0x7c000000), %bb.4(0x04000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[MOV64rm4:%[0-9]+]]:gr64 = MOV64rm %stack.6, 1, $noreg, 0, $noreg :: (load (s64) from %stack.6)
  ; CHECK-NEXT:   [[MOV64rm4:%[0-9]+]]:gr64 = ADD64rm [[MOV64rm4]], %stack.7, 1, $noreg, 0, $noreg, implicit-def dead $eflags :: (load (s64) from %stack.7)
  ; CHECK-NEXT:   [[MOV64rm5:%[0-9]+]]:gr64 = MOV64rm %stack.10, 1, $noreg, 0, $noreg :: (load (s64) from %stack.10)
  ; CHECK-NEXT:   ADD64mr %stack.9, 1, $noreg, 0, $noreg, [[MOV64rm5]], implicit-def dead $eflags :: (store (s64) into %stack.9)
  ; CHECK-NEXT:   MOV64mr %stack.6, 1, $noreg, 0, $noreg, [[MOV64rm4]] :: (store (s64) into %stack.6)
  ; CHECK-NEXT:   CMP64rm [[MOV64rm4]], %stack.8, 1, $noreg, 0, $noreg, implicit-def $eflags :: (load (s64) from %stack.8)
  ; CHECK-NEXT:   JCC_1 %bb.2, 12, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.6.for.body17:
  ; CHECK-NEXT:   successors: %bb.6(0x7c000000), %bb.5(0x04000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PTILEZEROV:%[0-9]+]]:tile = PTILEZEROV [[COPY7]].sub_16bit, [[MOV32rm2]].sub_16bit
  ; CHECK-NEXT:   [[MOV64rm6:%[0-9]+]]:gr64 = MOV64rm %stack.13, 1, $noreg, 0, $noreg :: (load (s64) from %stack.13)
  ; CHECK-NEXT:   [[PTILELOADDV:%[0-9]+]]:tile = PTILELOADDV [[COPY7]].sub_16bit, [[COPY4]].sub_16bit, [[MOV64rm6]], 1, [[MOVSX64rr32_]], 0, $noreg
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:gr64_nosp = MOVSX64rr32 [[COPY9]].sub_32bit
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:gr32 = COPY [[COPY7]]
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:gr64 = COPY [[MOVSX64rr32_3]]
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:gr64 = COPY [[MOVSX64rr32_2]]
  ; CHECK-NEXT:   [[COPY13:%[0-9]+]]:gr64 = COPY [[MOVSX64rr32_]]
  ; CHECK-NEXT:   [[COPY14:%[0-9]+]]:gr64 = COPY [[MOV32rm2]]
  ; CHECK-NEXT:   [[COPY15:%[0-9]+]]:gr64 = COPY [[COPY1]]
  ; CHECK-NEXT:   [[LEA64r2:%[0-9]+]]:gr64 = LEA64r [[COPY15]], 1, [[COPY9]], 0, $noreg
  ; CHECK-NEXT:   [[COPY16:%[0-9]+]]:gr64 = COPY [[MOV64rm]]
  ; CHECK-NEXT:   [[COPY17:%[0-9]+]]:gr32 = COPY [[COPY4]]
  ; CHECK-NEXT:   [[MOV32rm6:%[0-9]+]]:gr32 = MOV32rm %stack.2, 1, $noreg, 0, $noreg :: (load (s32) from %stack.2)
  ; CHECK-NEXT:   [[COPY18:%[0-9]+]]:gr32 = COPY [[LEA64_32r1]]
  ; CHECK-NEXT:   [[MOV64rm7:%[0-9]+]]:gr64_nosp = MOV64rm %stack.3, 1, $noreg, 0, $noreg :: (load (s64) from %stack.3)
  ; CHECK-NEXT:   [[PTILELOADDV1:%[0-9]+]]:tile = PTILELOADDV [[MOV32rm6]].sub_16bit, [[COPY18]].sub_16bit, [[LEA64r2]], 1, [[MOV64rm7]], 0, $noreg
  ; CHECK-NEXT:   [[LEA64_32r1:%[0-9]+]]:gr32 = COPY [[COPY18]]
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:gr32 = COPY [[COPY17]]
  ; CHECK-NEXT:   [[MOV64rm:%[0-9]+]]:gr64 = COPY [[COPY16]]
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:gr64 = COPY [[COPY15]]
  ; CHECK-NEXT:   [[MOV32rm2:%[0-9]+]]:gr64_nosp = COPY [[COPY14]]
  ; CHECK-NEXT:   [[MOVSX64rr32_:%[0-9]+]]:gr64_nosp = COPY [[COPY13]]
  ; CHECK-NEXT:   [[MOVSX64rr32_2:%[0-9]+]]:gr64_nosp = COPY [[COPY12]]
  ; CHECK-NEXT:   [[MOVSX64rr32_3:%[0-9]+]]:gr64_nosp = COPY [[COPY11]]
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:gr32 = COPY [[COPY10]]
  ; CHECK-NEXT:   [[MOV64rm8:%[0-9]+]]:gr64 = MOV64rm %stack.5, 1, $noreg, 0, $noreg :: (load (s64) from %stack.5)
  ; CHECK-NEXT:   [[PTILEZEROV:%[0-9]+]]:tile = PTDPBSSDV [[COPY7]].sub_16bit, [[LEA64_32r1]].sub_16bit, [[COPY4]].sub_16bit, [[PTILEZEROV]], [[PTILELOADDV]], [[PTILELOADDV1]]
  ; CHECK-NEXT:   PTILESTOREDV [[COPY7]].sub_16bit, [[MOV32rm2]].sub_16bit, [[MOV64rm2]], 1, [[MOVSX64rr32_2]], 0, $noreg, [[PTILEZEROV]]
  ; CHECK-NEXT:   [[MOV64rm3:%[0-9]+]]:gr64 = ADD64rr [[MOV64rm3]], [[MOVSX64rr32_3]], implicit-def dead $eflags
  ; CHECK-NEXT:   [[MOV64rm2:%[0-9]+]]:gr64 = ADD64rr [[MOV64rm2]], [[MOV64rm]], implicit-def dead $eflags
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]].sub_32bit:gr64_nosp = ADD32rr [[COPY9]].sub_32bit, [[LEA64_32r1]], implicit-def dead $eflags
  ; CHECK-NEXT:   CMP64rr [[MOV64rm3]], [[MOV64rm8]], implicit-def $eflags
  ; CHECK-NEXT:   JCC_1 %bb.6, 12, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.5
entry:
  %rem = srem i32 %K, 64
  %conv3 = trunc i32 %rem to i16
  %conv4 = trunc i32 %c_row_tile to i16
  %conv5 = trunc i32 %c_col_tile to i16
  %0 = lshr i16 %conv3, 2
  %conv13 = shl i16 %conv5, 2
  %cmp83 = icmp slt i32 %c_row_from, %c_row_to
  br i1 %cmp83, label %for.cond14.preheader.lr.ph, label %for.cond.cleanup

for.cond14.preheader.lr.ph:                       ; preds = %entry
  %sub = sub nsw i32 %K, %rem
  %conv1 = and i32 %sub, 65535
  %cmp1581 = icmp slt i32 %c_col_from, %c_col_to
  %conv20 = sext i32 %K to i64
  %mul22 = mul nsw i32 %conv1, %N
  %mul27 = shl nsw i32 %N, 2
  %conv28 = sext i32 %mul27 to i64
  %conv34 = sext i32 %N to i64
  %1 = sext i32 %c_col_from to i64
  %2 = sext i32 %c_col_tile to i64
  %3 = sext i32 %c_col_to to i64
  %4 = sext i32 %c_row_from to i64
  %5 = sext i32 %c_row_tile to i64
  %6 = zext i32 %conv1 to i64
  %7 = sext i32 %c_row_to to i64
  br label %for.cond14.preheader

for.cond14.preheader:                             ; preds = %for.cond.cleanup16, %for.cond14.preheader.lr.ph
  %indvars.iv87 = phi i64 [ %4, %for.cond14.preheader.lr.ph ], [ %indvars.iv.next88, %for.cond.cleanup16 ]
  br i1 %cmp1581, label %for.body17.lr.ph, label %for.cond.cleanup16

for.body17.lr.ph:                                 ; preds = %for.cond14.preheader
  %8 = mul nsw i64 %indvars.iv87, %conv20
  %9 = add nsw i64 %8, %6
  %arrayidx = getelementptr inbounds i8, ptr %A, i64 %9
  %10 = mul nsw i64 %indvars.iv87, %conv34
  br label %for.body17

for.cond.cleanup:                                 ; preds = %for.cond.cleanup16, %entry
  ret void

for.cond.cleanup16:                               ; preds = %for.body17, %for.cond14.preheader
  %indvars.iv.next88 = add i64 %indvars.iv87, %5
  %cmp = icmp slt i64 %indvars.iv.next88, %7
  br i1 %cmp, label %for.cond14.preheader, label %for.cond.cleanup

for.body17:                                       ; preds = %for.body17, %for.body17.lr.ph
  %indvars.iv = phi i64 [ %1, %for.body17.lr.ph ], [ %indvars.iv.next, %for.body17 ]
  %11 = tail call x86_amx @llvm.x86.tilezero.internal(i16 %conv4, i16 %conv5)
  %12 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %conv4, i16 %conv3, ptr %arrayidx, i64 %conv20)
  %13 = trunc i64 %indvars.iv to i32
  %mul23 = shl nsw i32 %13, 2
  %add24 = add nsw i32 %mul23, %mul22
  %idxprom25 = sext i32 %add24 to i64
  %arrayidx26 = getelementptr inbounds i8, ptr %B_rcr4, i64 %idxprom25
  %14 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 %conv13, ptr %arrayidx26, i64 %conv28)
  %15 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %conv4, i16 %conv13, i16 %conv3, x86_amx %11, x86_amx %12, x86_amx %14)
  %16 = add nsw i64 %indvars.iv, %10
  %arrayidx33 = getelementptr inbounds i32, ptr %C, i64 %16
  tail call void @llvm.x86.tilestored64.internal(i16 %conv4, i16 %conv5, ptr %arrayidx33, i64 %conv34, x86_amx %15)
  %indvars.iv.next = add i64 %indvars.iv, %2
  %cmp15 = icmp slt i64 %indvars.iv.next, %3
  br i1 %cmp15, label %for.body17, label %for.cond.cleanup16
}

declare x86_amx @llvm.x86.tilezero.internal(i16, i16)
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, ptr, i64)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare void @llvm.x86.tilestored64.internal(i16, i16, ptr, i64, x86_amx)
