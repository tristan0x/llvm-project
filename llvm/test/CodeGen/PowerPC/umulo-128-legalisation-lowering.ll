; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc64-unknown-linux-gnu | FileCheck %s --check-prefixes=PPC64
; RUN: llc < %s -mtriple=powerpc-unknown-linux-gnu | FileCheck %s --check-prefixes=PPC32

define { i128, i8 } @muloti_test(i128 %l, i128 %r) unnamed_addr #0 {
; PPC64-LABEL: muloti_test:
; PPC64:       # %bb.0: # %start
; PPC64-NEXT:    addic 8, 5, -1
; PPC64-NEXT:    mulhdu 9, 5, 4
; PPC64-NEXT:    mulld 10, 5, 4
; PPC64-NEXT:    subfe 5, 8, 5
; PPC64-NEXT:    mulld 8, 3, 6
; PPC64-NEXT:    add 8, 8, 10
; PPC64-NEXT:    addic 10, 3, -1
; PPC64-NEXT:    mulhdu 7, 3, 6
; PPC64-NEXT:    subfe 3, 10, 3
; PPC64-NEXT:    and 5, 3, 5
; PPC64-NEXT:    addic 3, 7, -1
; PPC64-NEXT:    subfe 7, 3, 7
; PPC64-NEXT:    or 5, 5, 7
; PPC64-NEXT:    mulhdu 10, 4, 6
; PPC64-NEXT:    addic 7, 9, -1
; PPC64-NEXT:    add 3, 10, 8
; PPC64-NEXT:    subfe 7, 7, 9
; PPC64-NEXT:    or 5, 5, 7
; PPC64-NEXT:    subc 7, 3, 10
; PPC64-NEXT:    subfe 7, 3, 3
; PPC64-NEXT:    neg 7, 7
; PPC64-NEXT:    or 5, 5, 7
; PPC64-NEXT:    mulld 4, 4, 6
; PPC64-NEXT:    blr
;
; PPC32-LABEL: muloti_test:
; PPC32:       # %bb.0: # %start
; PPC32-NEXT:    stwu 1, -64(1)
; PPC32-NEXT:    stw 26, 40(1) # 4-byte Folded Spill
; PPC32-NEXT:    mulhwu. 26, 7, 6
; PPC32-NEXT:    mcrf 6, 0
; PPC32-NEXT:    mfcr 12
; PPC32-NEXT:    stw 22, 24(1) # 4-byte Folded Spill
; PPC32-NEXT:    cmpwi 7, 5, 0
; PPC32-NEXT:    stw 23, 28(1) # 4-byte Folded Spill
; PPC32-NEXT:    mulhwu. 26, 5, 8
; PPC32-NEXT:    mcrf 5, 0
; PPC32-NEXT:    stw 24, 32(1) # 4-byte Folded Spill
; PPC32-NEXT:    cmpwi 2, 7, 0
; PPC32-NEXT:    stw 25, 36(1) # 4-byte Folded Spill
; PPC32-NEXT:    crnor 20, 30, 10
; PPC32-NEXT:    mulhwu. 26, 3, 10
; PPC32-NEXT:    mcrf 1, 0
; PPC32-NEXT:    stw 27, 44(1) # 4-byte Folded Spill
; PPC32-NEXT:    cmpwi 7, 9, 0
; PPC32-NEXT:    stw 28, 48(1) # 4-byte Folded Spill
; PPC32-NEXT:    cmpwi 2, 3, 0
; PPC32-NEXT:    mulhwu. 26, 9, 4
; PPC32-NEXT:    stw 29, 52(1) # 4-byte Folded Spill
; PPC32-NEXT:    crnor 21, 30, 10
; PPC32-NEXT:    stw 30, 56(1) # 4-byte Folded Spill
; PPC32-NEXT:    crorc 21, 21, 6
; PPC32-NEXT:    stw 12, 20(1)
; PPC32-NEXT:    mulhwu 12, 6, 10
; PPC32-NEXT:    crorc 21, 21, 2
; PPC32-NEXT:    li 11, 0
; PPC32-NEXT:    crorc 20, 20, 26
; PPC32-NEXT:    crorc 20, 20, 22
; PPC32-NEXT:    mullw 26, 5, 10
; PPC32-NEXT:    addc 12, 26, 12
; PPC32-NEXT:    mulhwu 0, 5, 10
; PPC32-NEXT:    addze 0, 0
; PPC32-NEXT:    mullw 23, 5, 8
; PPC32-NEXT:    mullw 22, 7, 6
; PPC32-NEXT:    mulhwu 30, 6, 9
; PPC32-NEXT:    mulhwu 29, 5, 9
; PPC32-NEXT:    mullw 25, 6, 9
; PPC32-NEXT:    mullw 24, 5, 9
; PPC32-NEXT:    mullw 5, 9, 4
; PPC32-NEXT:    add 9, 22, 23
; PPC32-NEXT:    mullw 23, 3, 10
; PPC32-NEXT:    add 26, 23, 5
; PPC32-NEXT:    addc 5, 25, 12
; PPC32-NEXT:    addze 30, 30
; PPC32-NEXT:    or. 3, 4, 3
; PPC32-NEXT:    mulhwu 27, 4, 10
; PPC32-NEXT:    mcrf 1, 0
; PPC32-NEXT:    addc 3, 0, 30
; PPC32-NEXT:    add 26, 27, 26
; PPC32-NEXT:    mullw 12, 4, 10
; PPC32-NEXT:    or. 4, 8, 7
; PPC32-NEXT:    addze 4, 11
; PPC32-NEXT:    addc 7, 24, 3
; PPC32-NEXT:    crnor 22, 2, 6
; PPC32-NEXT:    mulhwu 28, 8, 6
; PPC32-NEXT:    add 9, 28, 9
; PPC32-NEXT:    cmplw 6, 9, 28
; PPC32-NEXT:    cror 20, 20, 24
; PPC32-NEXT:    cmplw 6, 26, 27
; PPC32-NEXT:    cror 21, 21, 24
; PPC32-NEXT:    mullw 28, 8, 6
; PPC32-NEXT:    adde 8, 29, 4
; PPC32-NEXT:    addc 3, 12, 28
; PPC32-NEXT:    adde 9, 26, 9
; PPC32-NEXT:    addc 4, 7, 3
; PPC32-NEXT:    adde 3, 8, 9
; PPC32-NEXT:    cror 21, 22, 21
; PPC32-NEXT:    cmplw 4, 7
; PPC32-NEXT:    cmplw 1, 3, 8
; PPC32-NEXT:    lwz 12, 20(1)
; PPC32-NEXT:    cror 20, 21, 20
; PPC32-NEXT:    crandc 21, 4, 6
; PPC32-NEXT:    crand 22, 6, 0
; PPC32-NEXT:    cror 21, 22, 21
; PPC32-NEXT:    crnor 20, 20, 21
; PPC32-NEXT:    li 7, 1
; PPC32-NEXT:    mullw 6, 6, 10
; PPC32-NEXT:    bc 12, 20, .LBB0_1
; PPC32-NEXT:    b .LBB0_2
; PPC32-NEXT:  .LBB0_1: # %start
; PPC32-NEXT:    li 7, 0
; PPC32-NEXT:  .LBB0_2: # %start
; PPC32-NEXT:    mtcrf 32, 12 # cr2
; PPC32-NEXT:    lwz 30, 56(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 29, 52(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 28, 48(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 27, 44(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 26, 40(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 25, 36(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 24, 32(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 23, 28(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 22, 24(1) # 4-byte Folded Reload
; PPC32-NEXT:    addi 1, 1, 64
; PPC32-NEXT:    blr
start:
  %0 = tail call { i128, i1 } @llvm.umul.with.overflow.i128(i128 %l, i128 %r) #2
  %1 = extractvalue { i128, i1 } %0, 0
  %2 = extractvalue { i128, i1 } %0, 1
  %3 = zext i1 %2 to i8
  %4 = insertvalue { i128, i8 } undef, i128 %1, 0
  %5 = insertvalue { i128, i8 } %4, i8 %3, 1
  ret { i128, i8 } %5
}

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.umul.with.overflow.i128(i128, i128) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
