; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=s390x-linux-gnu -mcpu=z13 < %s  | FileCheck %s

; Store a <4 x i31> vector.
define void @fun0(<4 x i31> %src, ptr %p)
; CHECK-LABEL: fun0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vlgvf %r1, %v24, 0
; CHECK-NEXT:    vlgvf %r0, %v24, 1
; CHECK-NEXT:    sllg %r1, %r1, 29
; CHECK-NEXT:    rosbg %r1, %r0, 35, 63, 62
; CHECK-NEXT:    nihh %r1, 4095
; CHECK-NEXT:    stg %r1, 0(%r2)
; CHECK-NEXT:    vlgvf %r1, %v24, 2
; CHECK-NEXT:    sllg %r0, %r0, 62
; CHECK-NEXT:    rosbg %r0, %r1, 2, 32, 31
; CHECK-NEXT:    vlgvf %r1, %v24, 3
; CHECK-NEXT:    rosbg %r0, %r1, 33, 63, 0
; CHECK-NEXT:    stg %r0, 8(%r2)
; CHECK-NEXT:    br %r14
{
  store <4 x i31> %src, ptr %p
  ret void
}

; Store a <16 x i1> vector.
define i16 @fun1(<16 x i1> %src)
; CHECK-LABEL: fun1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    aghi %r15, -168
; CHECK-NEXT:    .cfi_def_cfa_offset 328
; CHECK-NEXT:    vlgvb %r1, %v24, 0
; CHECK-NEXT:    vlgvb %r0, %v24, 1
; CHECK-NEXT:    risblg %r1, %r1, 16, 144, 15
; CHECK-NEXT:    rosbg %r1, %r0, 49, 49, 14
; CHECK-NEXT:    vlgvb %r0, %v24, 2
; CHECK-NEXT:    rosbg %r1, %r0, 50, 50, 13
; CHECK-NEXT:    vlgvb %r0, %v24, 3
; CHECK-NEXT:    rosbg %r1, %r0, 51, 51, 12
; CHECK-NEXT:    vlgvb %r0, %v24, 4
; CHECK-NEXT:    rosbg %r1, %r0, 52, 52, 11
; CHECK-NEXT:    vlgvb %r0, %v24, 5
; CHECK-NEXT:    rosbg %r1, %r0, 53, 53, 10
; CHECK-NEXT:    vlgvb %r0, %v24, 6
; CHECK-NEXT:    rosbg %r1, %r0, 54, 54, 9
; CHECK-NEXT:    vlgvb %r0, %v24, 7
; CHECK-NEXT:    rosbg %r1, %r0, 55, 55, 8
; CHECK-NEXT:    vlgvb %r0, %v24, 8
; CHECK-NEXT:    rosbg %r1, %r0, 56, 56, 7
; CHECK-NEXT:    vlgvb %r0, %v24, 9
; CHECK-NEXT:    rosbg %r1, %r0, 57, 57, 6
; CHECK-NEXT:    vlgvb %r0, %v24, 10
; CHECK-NEXT:    rosbg %r1, %r0, 58, 58, 5
; CHECK-NEXT:    vlgvb %r0, %v24, 11
; CHECK-NEXT:    rosbg %r1, %r0, 59, 59, 4
; CHECK-NEXT:    vlgvb %r0, %v24, 12
; CHECK-NEXT:    rosbg %r1, %r0, 60, 60, 3
; CHECK-NEXT:    vlgvb %r0, %v24, 13
; CHECK-NEXT:    rosbg %r1, %r0, 61, 61, 2
; CHECK-NEXT:    vlgvb %r0, %v24, 14
; CHECK-NEXT:    rosbg %r1, %r0, 62, 62, 1
; CHECK-NEXT:    vlgvb %r0, %v24, 15
; CHECK-NEXT:    rosbg %r1, %r0, 63, 63, 0
; CHECK-NEXT:    llhr %r2, %r1
; CHECK-NEXT:    aghi %r15, 168
; CHECK-NEXT:    br %r14
{
  %res = bitcast <16 x i1> %src to i16
  ret i16 %res
}

; Truncate a <8 x i32> vector to <8 x i31> and store it (test splitting).
define void @fun2(<8 x i32> %src, ptr %p)
; CHECK-LABEL: fun2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vlgvf %r0, %v26, 3
; CHECK-NEXT:    vlgvf %r5, %v24, 0
; CHECK-NEXT:    vlgvf %r3, %v24, 1
; CHECK-NEXT:    srlk %r1, %r0, 8
; CHECK-NEXT:    sth %r1, 28(%r2)
; CHECK-NEXT:    vlgvf %r1, %v24, 2
; CHECK-NEXT:    sllg %r5, %r5, 33
; CHECK-NEXT:    sllg %r4, %r3, 58
; CHECK-NEXT:    risbgn %r1, %r1, 6, 164, 27
; CHECK-NEXT:    rosbg %r5, %r3, 31, 55, 2
; CHECK-NEXT:    vlgvf %r3, %v26, 2
; CHECK-NEXT:    stc %r0, 30(%r2)
; CHECK-NEXT:    ogr %r4, %r1
; CHECK-NEXT:    risbgn %r0, %r0, 33, 167, 0
; CHECK-NEXT:    rosbg %r5, %r4, 56, 63, 8
; CHECK-NEXT:    risbgn %r3, %r3, 2, 160, 31
; CHECK-NEXT:    ogr %r0, %r3
; CHECK-NEXT:    vlgvf %r4, %v24, 3
; CHECK-NEXT:    srlg %r0, %r0, 24
; CHECK-NEXT:    rosbg %r1, %r4, 37, 63, 60
; CHECK-NEXT:    st %r0, 24(%r2)
; CHECK-NEXT:    vlgvf %r0, %v26, 0
; CHECK-NEXT:    stg %r5, 0(%r2)
; CHECK-NEXT:    risbgn %r0, %r0, 4, 162, 29
; CHECK-NEXT:    sllg %r5, %r4, 60
; CHECK-NEXT:    ogr %r5, %r0
; CHECK-NEXT:    sllg %r1, %r1, 8
; CHECK-NEXT:    rosbg %r1, %r5, 56, 63, 8
; CHECK-NEXT:    stg %r1, 8(%r2)
; CHECK-NEXT:    vlgvf %r1, %v26, 1
; CHECK-NEXT:    sllg %r4, %r1, 62
; CHECK-NEXT:    ogr %r3, %r4
; CHECK-NEXT:    rosbg %r0, %r1, 35, 63, 62
; CHECK-NEXT:    sllg %r0, %r0, 8
; CHECK-NEXT:    rosbg %r0, %r3, 56, 63, 8
; CHECK-NEXT:    stg %r0, 16(%r2)
; CHECK-NEXT:    br %r14
{
  %tmp = trunc <8 x i32> %src to <8 x i31>
  store <8 x i31> %tmp, ptr %p
  ret void
}

; Load and store a <3 x i31> vector (test widening).
define void @fun3(ptr %src, ptr %p)
; CHECK-LABEL: fun3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    llgf %r0, 8(%r2)
; CHECK-NEXT:    lg %r1, 0(%r2)
; CHECK-NEXT:    stg %r1, 0(%r3)
; CHECK-NEXT:    st %r0, 8(%r3)
; CHECK-NEXT:    br %r14
{
  %tmp = load <3 x i31>, ptr %src
  store <3 x i31> %tmp, ptr %p
  ret void
}
