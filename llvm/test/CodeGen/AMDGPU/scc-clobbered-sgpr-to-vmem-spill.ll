; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck %s

; This was a negative test to catch an extreme case when all options are exhausted
; while trying to spill SGPRs to memory. After we enabled SGPR spills into virtual VGPRs
; the edge case won't arise and the test would always compile.

define amdgpu_kernel void @kernel0(ptr addrspace(1) %out, i32 %in) #1 {
; CHECK-LABEL: kernel0:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; implicit-def: $vgpr23 : SGPR spill to VGPR lane
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[2:3]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s2, 0
; CHECK-NEXT:    s_load_dword s0, s[4:5], 0x8
; CHECK-NEXT:    v_writelane_b32 v23, s3, 1
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:7]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s4, 2
; CHECK-NEXT:    v_writelane_b32 v23, s5, 3
; CHECK-NEXT:    v_writelane_b32 v23, s6, 4
; CHECK-NEXT:    v_writelane_b32 v23, s7, 5
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:11]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s4, 6
; CHECK-NEXT:    v_writelane_b32 v23, s5, 7
; CHECK-NEXT:    v_writelane_b32 v23, s6, 8
; CHECK-NEXT:    v_writelane_b32 v23, s7, 9
; CHECK-NEXT:    v_writelane_b32 v23, s8, 10
; CHECK-NEXT:    v_writelane_b32 v23, s9, 11
; CHECK-NEXT:    v_writelane_b32 v23, s10, 12
; CHECK-NEXT:    v_writelane_b32 v23, s11, 13
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[16:31]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s16, 14
; CHECK-NEXT:    v_writelane_b32 v23, s17, 15
; CHECK-NEXT:    v_writelane_b32 v23, s18, 16
; CHECK-NEXT:    v_writelane_b32 v23, s19, 17
; CHECK-NEXT:    v_writelane_b32 v23, s20, 18
; CHECK-NEXT:    v_writelane_b32 v23, s21, 19
; CHECK-NEXT:    v_writelane_b32 v23, s22, 20
; CHECK-NEXT:    v_writelane_b32 v23, s23, 21
; CHECK-NEXT:    v_writelane_b32 v23, s24, 22
; CHECK-NEXT:    v_writelane_b32 v23, s25, 23
; CHECK-NEXT:    v_writelane_b32 v23, s26, 24
; CHECK-NEXT:    v_writelane_b32 v23, s27, 25
; CHECK-NEXT:    v_writelane_b32 v23, s28, 26
; CHECK-NEXT:    v_writelane_b32 v23, s29, 27
; CHECK-NEXT:    v_writelane_b32 v23, s30, 28
; CHECK-NEXT:    v_writelane_b32 v23, s31, 29
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[2:3]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[16:19]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s16, 30
; CHECK-NEXT:    v_writelane_b32 v23, s17, 31
; CHECK-NEXT:    v_writelane_b32 v23, s18, 32
; CHECK-NEXT:    v_writelane_b32 v23, s19, 33
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[16:23]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s16, 34
; CHECK-NEXT:    v_writelane_b32 v23, s17, 35
; CHECK-NEXT:    v_writelane_b32 v23, s18, 36
; CHECK-NEXT:    v_writelane_b32 v23, s19, 37
; CHECK-NEXT:    v_writelane_b32 v23, s20, 38
; CHECK-NEXT:    v_writelane_b32 v23, s21, 39
; CHECK-NEXT:    v_writelane_b32 v23, s22, 40
; CHECK-NEXT:    v_writelane_b32 v23, s23, 41
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:19]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s4, 42
; CHECK-NEXT:    v_writelane_b32 v23, s5, 43
; CHECK-NEXT:    v_writelane_b32 v23, s6, 44
; CHECK-NEXT:    v_writelane_b32 v23, s7, 45
; CHECK-NEXT:    v_writelane_b32 v23, s8, 46
; CHECK-NEXT:    v_writelane_b32 v23, s9, 47
; CHECK-NEXT:    v_writelane_b32 v23, s10, 48
; CHECK-NEXT:    v_writelane_b32 v23, s11, 49
; CHECK-NEXT:    v_writelane_b32 v23, s12, 50
; CHECK-NEXT:    v_writelane_b32 v23, s13, 51
; CHECK-NEXT:    v_writelane_b32 v23, s14, 52
; CHECK-NEXT:    v_writelane_b32 v23, s15, 53
; CHECK-NEXT:    v_writelane_b32 v23, s16, 54
; CHECK-NEXT:    v_writelane_b32 v23, s17, 55
; CHECK-NEXT:    v_writelane_b32 v23, s18, 56
; CHECK-NEXT:    v_writelane_b32 v23, s19, 57
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[34:35]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[52:55]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[36:43]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v23, s36, 58
; CHECK-NEXT:    v_writelane_b32 v23, s37, 59
; CHECK-NEXT:    v_writelane_b32 v23, s38, 60
; CHECK-NEXT:    ; implicit-def: $vgpr0
; CHECK-NEXT:    v_writelane_b32 v23, s39, 61
; CHECK-NEXT:    v_writelane_b32 v23, s40, 62
; CHECK-NEXT:    v_writelane_b32 v0, s42, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_cmp_lg_u32 s0, 0
; CHECK-NEXT:    v_writelane_b32 v23, s41, 63
; CHECK-NEXT:    v_writelane_b32 v0, s43, 1
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[36:51]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[0:1]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:7]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v0, s4, 2
; CHECK-NEXT:    v_writelane_b32 v0, s5, 3
; CHECK-NEXT:    v_writelane_b32 v0, s6, 4
; CHECK-NEXT:    v_writelane_b32 v0, s7, 5
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:11]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v0, s4, 6
; CHECK-NEXT:    v_writelane_b32 v0, s5, 7
; CHECK-NEXT:    v_writelane_b32 v0, s6, 8
; CHECK-NEXT:    v_writelane_b32 v0, s7, 9
; CHECK-NEXT:    v_writelane_b32 v0, s8, 10
; CHECK-NEXT:    v_writelane_b32 v0, s9, 11
; CHECK-NEXT:    v_writelane_b32 v0, s10, 12
; CHECK-NEXT:    v_writelane_b32 v0, s11, 13
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:19]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v0, s4, 14
; CHECK-NEXT:    v_writelane_b32 v0, s5, 15
; CHECK-NEXT:    v_writelane_b32 v0, s6, 16
; CHECK-NEXT:    v_writelane_b32 v0, s7, 17
; CHECK-NEXT:    v_writelane_b32 v0, s8, 18
; CHECK-NEXT:    v_writelane_b32 v0, s9, 19
; CHECK-NEXT:    v_writelane_b32 v0, s10, 20
; CHECK-NEXT:    v_writelane_b32 v0, s11, 21
; CHECK-NEXT:    v_writelane_b32 v0, s12, 22
; CHECK-NEXT:    v_writelane_b32 v0, s13, 23
; CHECK-NEXT:    v_writelane_b32 v0, s14, 24
; CHECK-NEXT:    v_writelane_b32 v0, s15, 25
; CHECK-NEXT:    v_writelane_b32 v0, s16, 26
; CHECK-NEXT:    v_writelane_b32 v0, s17, 27
; CHECK-NEXT:    v_writelane_b32 v0, s18, 28
; CHECK-NEXT:    v_writelane_b32 v0, s19, 29
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:5]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v0, s4, 30
; CHECK-NEXT:    v_writelane_b32 v0, s5, 31
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[20:23]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[24:31]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; def s[4:19]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_writelane_b32 v0, s4, 32
; CHECK-NEXT:    v_writelane_b32 v0, s5, 33
; CHECK-NEXT:    v_writelane_b32 v0, s6, 34
; CHECK-NEXT:    v_writelane_b32 v0, s7, 35
; CHECK-NEXT:    v_writelane_b32 v0, s8, 36
; CHECK-NEXT:    v_writelane_b32 v0, s9, 37
; CHECK-NEXT:    v_writelane_b32 v0, s10, 38
; CHECK-NEXT:    v_writelane_b32 v0, s11, 39
; CHECK-NEXT:    v_writelane_b32 v0, s12, 40
; CHECK-NEXT:    v_writelane_b32 v0, s13, 41
; CHECK-NEXT:    v_writelane_b32 v0, s14, 42
; CHECK-NEXT:    v_writelane_b32 v0, s15, 43
; CHECK-NEXT:    v_writelane_b32 v0, s16, 44
; CHECK-NEXT:    v_writelane_b32 v0, s17, 45
; CHECK-NEXT:    v_writelane_b32 v0, s18, 46
; CHECK-NEXT:    v_writelane_b32 v0, s19, 47
; CHECK-NEXT:    s_cbranch_scc0 .LBB0_2
; CHECK-NEXT:  ; %bb.1: ; %ret
; CHECK-NEXT:    ; kill: killed $vgpr23
; CHECK-NEXT:    ; kill: killed $vgpr0
; CHECK-NEXT:    s_endpgm
; CHECK-NEXT:  .LBB0_2: ; %bb0
; CHECK-NEXT:    v_readlane_b32 s4, v23, 2
; CHECK-NEXT:    s_mov_b64 s[16:17], s[0:1]
; CHECK-NEXT:    v_readlane_b32 s0, v23, 0
; CHECK-NEXT:    v_readlane_b32 s5, v23, 3
; CHECK-NEXT:    v_readlane_b32 s6, v23, 4
; CHECK-NEXT:    v_readlane_b32 s7, v23, 5
; CHECK-NEXT:    v_readlane_b32 s1, v23, 1
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:1]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[4:7]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s4, v23, 6
; CHECK-NEXT:    v_readlane_b32 s5, v23, 7
; CHECK-NEXT:    v_readlane_b32 s6, v23, 8
; CHECK-NEXT:    v_readlane_b32 s7, v23, 9
; CHECK-NEXT:    v_readlane_b32 s8, v23, 10
; CHECK-NEXT:    v_readlane_b32 s9, v23, 11
; CHECK-NEXT:    v_readlane_b32 s10, v23, 12
; CHECK-NEXT:    v_readlane_b32 s11, v23, 13
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[4:11]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    s_mov_b64 s[18:19], s[2:3]
; CHECK-NEXT:    v_readlane_b32 s0, v23, 14
; CHECK-NEXT:    v_readlane_b32 s1, v23, 15
; CHECK-NEXT:    v_readlane_b32 s2, v23, 16
; CHECK-NEXT:    v_readlane_b32 s3, v23, 17
; CHECK-NEXT:    v_readlane_b32 s4, v23, 18
; CHECK-NEXT:    v_readlane_b32 s5, v23, 19
; CHECK-NEXT:    v_readlane_b32 s6, v23, 20
; CHECK-NEXT:    v_readlane_b32 s7, v23, 21
; CHECK-NEXT:    v_readlane_b32 s8, v23, 22
; CHECK-NEXT:    v_readlane_b32 s9, v23, 23
; CHECK-NEXT:    v_readlane_b32 s10, v23, 24
; CHECK-NEXT:    v_readlane_b32 s11, v23, 25
; CHECK-NEXT:    v_readlane_b32 s12, v23, 26
; CHECK-NEXT:    v_readlane_b32 s13, v23, 27
; CHECK-NEXT:    v_readlane_b32 s14, v23, 28
; CHECK-NEXT:    v_readlane_b32 s15, v23, 29
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:15]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v23, 30
; CHECK-NEXT:    v_readlane_b32 s1, v23, 31
; CHECK-NEXT:    v_readlane_b32 s2, v23, 32
; CHECK-NEXT:    v_readlane_b32 s3, v23, 33
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[18:19]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:3]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v23, 34
; CHECK-NEXT:    v_readlane_b32 s1, v23, 35
; CHECK-NEXT:    v_readlane_b32 s2, v23, 36
; CHECK-NEXT:    v_readlane_b32 s3, v23, 37
; CHECK-NEXT:    v_readlane_b32 s4, v23, 38
; CHECK-NEXT:    v_readlane_b32 s5, v23, 39
; CHECK-NEXT:    v_readlane_b32 s6, v23, 40
; CHECK-NEXT:    v_readlane_b32 s7, v23, 41
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:7]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v23, 42
; CHECK-NEXT:    v_readlane_b32 s1, v23, 43
; CHECK-NEXT:    v_readlane_b32 s2, v23, 44
; CHECK-NEXT:    v_readlane_b32 s3, v23, 45
; CHECK-NEXT:    v_readlane_b32 s4, v23, 46
; CHECK-NEXT:    v_readlane_b32 s5, v23, 47
; CHECK-NEXT:    v_readlane_b32 s6, v23, 48
; CHECK-NEXT:    v_readlane_b32 s7, v23, 49
; CHECK-NEXT:    v_readlane_b32 s8, v23, 50
; CHECK-NEXT:    v_readlane_b32 s9, v23, 51
; CHECK-NEXT:    v_readlane_b32 s10, v23, 52
; CHECK-NEXT:    v_readlane_b32 s11, v23, 53
; CHECK-NEXT:    v_readlane_b32 s12, v23, 54
; CHECK-NEXT:    v_readlane_b32 s13, v23, 55
; CHECK-NEXT:    v_readlane_b32 s14, v23, 56
; CHECK-NEXT:    v_readlane_b32 s15, v23, 57
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:15]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v23, 58
; CHECK-NEXT:    v_readlane_b32 s1, v23, 59
; CHECK-NEXT:    v_readlane_b32 s2, v23, 60
; CHECK-NEXT:    v_readlane_b32 s3, v23, 61
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[34:35]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[52:55]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s4, v23, 62
; CHECK-NEXT:    v_readlane_b32 s5, v23, 63
; CHECK-NEXT:    v_readlane_b32 s6, v0, 0
; CHECK-NEXT:    v_readlane_b32 s7, v0, 1
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:7]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v0, 2
; CHECK-NEXT:    v_readlane_b32 s1, v0, 3
; CHECK-NEXT:    v_readlane_b32 s2, v0, 4
; CHECK-NEXT:    v_readlane_b32 s3, v0, 5
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[36:51]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[16:17]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:3]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v0, 6
; CHECK-NEXT:    v_readlane_b32 s1, v0, 7
; CHECK-NEXT:    v_readlane_b32 s2, v0, 8
; CHECK-NEXT:    v_readlane_b32 s3, v0, 9
; CHECK-NEXT:    v_readlane_b32 s4, v0, 10
; CHECK-NEXT:    v_readlane_b32 s5, v0, 11
; CHECK-NEXT:    v_readlane_b32 s6, v0, 12
; CHECK-NEXT:    v_readlane_b32 s7, v0, 13
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:7]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v0, 14
; CHECK-NEXT:    v_readlane_b32 s1, v0, 15
; CHECK-NEXT:    v_readlane_b32 s2, v0, 16
; CHECK-NEXT:    v_readlane_b32 s3, v0, 17
; CHECK-NEXT:    v_readlane_b32 s4, v0, 18
; CHECK-NEXT:    v_readlane_b32 s5, v0, 19
; CHECK-NEXT:    v_readlane_b32 s6, v0, 20
; CHECK-NEXT:    v_readlane_b32 s7, v0, 21
; CHECK-NEXT:    v_readlane_b32 s8, v0, 22
; CHECK-NEXT:    v_readlane_b32 s9, v0, 23
; CHECK-NEXT:    v_readlane_b32 s10, v0, 24
; CHECK-NEXT:    v_readlane_b32 s11, v0, 25
; CHECK-NEXT:    v_readlane_b32 s12, v0, 26
; CHECK-NEXT:    v_readlane_b32 s13, v0, 27
; CHECK-NEXT:    v_readlane_b32 s14, v0, 28
; CHECK-NEXT:    v_readlane_b32 s15, v0, 29
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:15]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v0, 30
; CHECK-NEXT:    v_readlane_b32 s1, v0, 31
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:1]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s0, v0, 32
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[20:23]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[24:31]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    v_readlane_b32 s1, v0, 33
; CHECK-NEXT:    v_readlane_b32 s2, v0, 34
; CHECK-NEXT:    v_readlane_b32 s3, v0, 35
; CHECK-NEXT:    v_readlane_b32 s4, v0, 36
; CHECK-NEXT:    v_readlane_b32 s5, v0, 37
; CHECK-NEXT:    v_readlane_b32 s6, v0, 38
; CHECK-NEXT:    v_readlane_b32 s7, v0, 39
; CHECK-NEXT:    v_readlane_b32 s8, v0, 40
; CHECK-NEXT:    v_readlane_b32 s9, v0, 41
; CHECK-NEXT:    v_readlane_b32 s10, v0, 42
; CHECK-NEXT:    v_readlane_b32 s11, v0, 43
; CHECK-NEXT:    v_readlane_b32 s12, v0, 44
; CHECK-NEXT:    v_readlane_b32 s13, v0, 45
; CHECK-NEXT:    v_readlane_b32 s14, v0, 46
; CHECK-NEXT:    v_readlane_b32 s15, v0, 47
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; use s[0:15]
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    ; kill: killed $vgpr23
; CHECK-NEXT:    ; kill: killed $vgpr0
; CHECK-NEXT:    s_endpgm
  call void asm sideeffect "", "~{v[0:7]}" () #0
  call void asm sideeffect "", "~{v[8:15]}" () #0
  call void asm sideeffect "", "~{v[16:19]}"() #0
  call void asm sideeffect "", "~{v[20:21]}"() #0
  call void asm sideeffect "", "~{v22}"() #0

  %val0 = call <2 x i32> asm sideeffect "; def $0", "=s" () #0
  %val1 = call <4 x i32> asm sideeffect "; def $0", "=s" () #0
  %val2 = call <8 x i32> asm sideeffect "; def $0", "=s" () #0
  %val3 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %val4 = call <2 x i32> asm sideeffect "; def $0", "=s" () #0
  %val5 = call <4 x i32> asm sideeffect "; def $0", "=s" () #0
  %val6 = call <8 x i32> asm sideeffect "; def $0", "=s" () #0
  %val7 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %val8 = call <2 x i32> asm sideeffect "; def $0", "=s" () #0
  %val9 = call <4 x i32> asm sideeffect "; def $0", "=s" () #0
  %val10 = call <8 x i32> asm sideeffect "; def $0", "=s" () #0
  %val11 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %val12 = call <2 x i32> asm sideeffect "; def $0", "=s" () #0
  %val13 = call <4 x i32> asm sideeffect "; def $0", "=s" () #0
  %val14 = call <8 x i32> asm sideeffect "; def $0", "=s" () #0
  %val15 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %val16 = call <2 x i32> asm sideeffect "; def $0", "=s" () #0
  %val17 = call <4 x i32> asm sideeffect "; def $0", "=s" () #0
  %val18 = call <8 x i32> asm sideeffect "; def $0", "=s" () #0
  %val19 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %cmp = icmp eq i32 %in, 0
  br i1 %cmp, label %bb0, label %ret

bb0:
  call void asm sideeffect "; use $0", "s"(<2 x i32> %val0) #0
  call void asm sideeffect "; use $0", "s"(<4 x i32> %val1) #0
  call void asm sideeffect "; use $0", "s"(<8 x i32> %val2) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %val3) #0
  call void asm sideeffect "; use $0", "s"(<2 x i32> %val4) #0
  call void asm sideeffect "; use $0", "s"(<4 x i32> %val5) #0
  call void asm sideeffect "; use $0", "s"(<8 x i32> %val6) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %val7) #0
  call void asm sideeffect "; use $0", "s"(<2 x i32> %val8) #0
  call void asm sideeffect "; use $0", "s"(<4 x i32> %val9) #0
  call void asm sideeffect "; use $0", "s"(<8 x i32> %val10) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %val11) #0
  call void asm sideeffect "; use $0", "s"(<2 x i32> %val12) #0
  call void asm sideeffect "; use $0", "s"(<4 x i32> %val13) #0
  call void asm sideeffect "; use $0", "s"(<8 x i32> %val14) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %val15) #0
  call void asm sideeffect "; use $0", "s"(<2 x i32> %val16) #0
  call void asm sideeffect "; use $0", "s"(<4 x i32> %val17) #0
  call void asm sideeffect "; use $0", "s"(<8 x i32> %val18) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %val19) #0
  br label %ret

ret:
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind "amdgpu-waves-per-eu"="10,10" }
