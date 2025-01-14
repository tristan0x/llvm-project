; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE,FALLBACK0
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx  | FileCheck %s --check-prefixes=AVX,AVX1,AVX1-ONLY,FALLBACK1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX1,AVX2,AVX2-ONLY,AVX2-SLOW,FALLBACK2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX1,AVX2,AVX2-ONLY,AVX2-FAST,FALLBACK3
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX1,AVX2,AVX2-ONLY,AVX2-FAST-PERLANE,FALLBACK4
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512F,AVX512-SLOW,AVX512F-SLOW,AVX512F-ONLY-SLOW,FALLBACK5
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512F,AVX512-FAST,AVX512F-FAST,AVX512F-ONLY-FAST,FALLBACK6
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+avx512dq | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512F,AVX512-SLOW,AVX512F-SLOW,AVX512DQ-SLOW,FALLBACK7
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+avx512dq,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512F,AVX512-FAST,AVX512F-FAST,AVX512DQ-FAST,FALLBACK8
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+avx512bw | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512BW,AVX512-SLOW,AVX512BW-SLOW,AVX512BW-ONLY-SLOW,FALLBACK9
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+avx512bw,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512BW,AVX512-FAST,AVX512BW-FAST,AVX512BW-ONLY-FAST,FALLBACK10
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+avx512dq,+avx512bw | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512BW,AVX512-SLOW,AVX512BW-SLOW,AVX512DQBW-SLOW,FALLBACK11
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl,+avx512dq,+avx512bw,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2,AVX512,AVX512BW,AVX512-FAST,AVX512BW-FAST,AVX512DQBW-FAST,FALLBACK12

; These patterns are produced by LoopVectorizer for interleaved stores.

define void @store_i16_stride2_vf2(ptr %in.vecptr0, ptr %in.vecptr1, ptr %out.vec) nounwind {
; SSE-LABEL: store_i16_stride2_vf2:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],mem[0],xmm0[1],mem[1],xmm0[2],mem[2],xmm0[3],mem[3]
; SSE-NEXT:    movq %xmm0, (%rdx)
; SSE-NEXT:    retq
;
; AVX-LABEL: store_i16_stride2_vf2:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],mem[0],xmm0[1],mem[1],xmm0[2],mem[2],xmm0[3],mem[3]
; AVX-NEXT:    vmovq %xmm0, (%rdx)
; AVX-NEXT:    retq
  %in.vec0 = load <2 x i16>, ptr %in.vecptr0, align 64
  %in.vec1 = load <2 x i16>, ptr %in.vecptr1, align 64
  %1 = shufflevector <2 x i16> %in.vec0, <2 x i16> %in.vec1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %interleaved.vec = shufflevector <4 x i16> %1, <4 x i16> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  store <4 x i16> %interleaved.vec, ptr %out.vec, align 64
  ret void
}

define void @store_i16_stride2_vf4(ptr %in.vecptr0, ptr %in.vecptr1, ptr %out.vec) nounwind {
; SSE-LABEL: store_i16_stride2_vf4:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; SSE-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; SSE-NEXT:    movdqa %xmm1, (%rdx)
; SSE-NEXT:    retq
;
; AVX-LABEL: store_i16_stride2_vf4:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vmovq {{.*#+}} xmm1 = mem[0],zero
; AVX-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; AVX-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX-NEXT:    retq
  %in.vec0 = load <4 x i16>, ptr %in.vecptr0, align 64
  %in.vec1 = load <4 x i16>, ptr %in.vecptr1, align 64
  %1 = shufflevector <4 x i16> %in.vec0, <4 x i16> %in.vec1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %interleaved.vec = shufflevector <8 x i16> %1, <8 x i16> poison, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  store <8 x i16> %interleaved.vec, ptr %out.vec, align 64
  ret void
}

define void @store_i16_stride2_vf8(ptr %in.vecptr0, ptr %in.vecptr1, ptr %out.vec) nounwind {
; SSE-LABEL: store_i16_stride2_vf8:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    movdqa (%rsi), %xmm1
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; SSE-NEXT:    punpckhwd {{.*#+}} xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; SSE-NEXT:    movdqa %xmm0, 16(%rdx)
; SSE-NEXT:    movdqa %xmm2, (%rdx)
; SSE-NEXT:    retq
;
; AVX1-ONLY-LABEL: store_i16_stride2_vf8:
; AVX1-ONLY:       # %bb.0:
; AVX1-ONLY-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-ONLY-NEXT:    vmovdqa (%rsi), %xmm1
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; AVX1-ONLY-NEXT:    vmovdqa %xmm0, 16(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm2, (%rdx)
; AVX1-ONLY-NEXT:    retq
;
; AVX2-ONLY-LABEL: store_i16_stride2_vf8:
; AVX2-ONLY:       # %bb.0:
; AVX2-ONLY-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-ONLY-NEXT:    vinserti128 $1, (%rsi), %ymm0, %ymm0
; AVX2-ONLY-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-ONLY-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[0,1,8,9,2,3,10,11,4,5,12,13,6,7,14,15,16,17,24,25,18,19,26,27,20,21,28,29,22,23,30,31]
; AVX2-ONLY-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-ONLY-NEXT:    vzeroupper
; AVX2-ONLY-NEXT:    retq
;
; AVX512F-LABEL: store_i16_stride2_vf8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm0
; AVX512F-NEXT:    vinserti128 $1, (%rsi), %ymm0, %ymm0
; AVX512F-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[0,1,8,9,2,3,10,11,4,5,12,13,6,7,14,15,16,17,24,25,18,19,26,27,20,21,28,29,22,23,30,31]
; AVX512F-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: store_i16_stride2_vf8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %xmm0
; AVX512BW-NEXT:    vinserti128 $1, (%rsi), %ymm0, %ymm0
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm1 = [0,8,1,9,2,10,3,11,4,12,5,13,6,14,7,15]
; AVX512BW-NEXT:    vpermw %ymm0, %ymm1, %ymm0
; AVX512BW-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
  %in.vec0 = load <8 x i16>, ptr %in.vecptr0, align 64
  %in.vec1 = load <8 x i16>, ptr %in.vecptr1, align 64
  %1 = shufflevector <8 x i16> %in.vec0, <8 x i16> %in.vec1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i16> %1, <16 x i16> poison, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  store <16 x i16> %interleaved.vec, ptr %out.vec, align 64
  ret void
}

define void @store_i16_stride2_vf16(ptr %in.vecptr0, ptr %in.vecptr1, ptr %out.vec) nounwind {
; SSE-LABEL: store_i16_stride2_vf16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    movdqa 16(%rdi), %xmm1
; SSE-NEXT:    movdqa (%rsi), %xmm2
; SSE-NEXT:    movdqa 16(%rsi), %xmm3
; SSE-NEXT:    movdqa %xmm0, %xmm4
; SSE-NEXT:    punpckhwd {{.*#+}} xmm4 = xmm4[4],xmm2[4],xmm4[5],xmm2[5],xmm4[6],xmm2[6],xmm4[7],xmm2[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    punpckhwd {{.*#+}} xmm2 = xmm2[4],xmm3[4],xmm2[5],xmm3[5],xmm2[6],xmm3[6],xmm2[7],xmm3[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1],xmm1[2],xmm3[2],xmm1[3],xmm3[3]
; SSE-NEXT:    movdqa %xmm1, 32(%rdx)
; SSE-NEXT:    movdqa %xmm2, 48(%rdx)
; SSE-NEXT:    movdqa %xmm0, (%rdx)
; SSE-NEXT:    movdqa %xmm4, 16(%rdx)
; SSE-NEXT:    retq
;
; AVX1-ONLY-LABEL: store_i16_stride2_vf16:
; AVX1-ONLY:       # %bb.0:
; AVX1-ONLY-NEXT:    vmovdqa (%rsi), %xmm0
; AVX1-ONLY-NEXT:    vmovdqa 16(%rsi), %xmm1
; AVX1-ONLY-NEXT:    vmovdqa (%rdi), %xmm2
; AVX1-ONLY-NEXT:    vmovdqa 16(%rdi), %xmm3
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm4 = xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm1 = xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
; AVX1-ONLY-NEXT:    vmovdqa %xmm1, 48(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm2, 32(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm4, 16(%rdx)
; AVX1-ONLY-NEXT:    retq
;
; AVX2-ONLY-LABEL: store_i16_stride2_vf16:
; AVX2-ONLY:       # %bb.0:
; AVX2-ONLY-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-ONLY-NEXT:    vmovdqa (%rsi), %ymm1
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm2 = ymm0[4],ymm1[4],ymm0[5],ymm1[5],ymm0[6],ymm1[6],ymm0[7],ymm1[7],ymm0[12],ymm1[12],ymm0[13],ymm1[13],ymm0[14],ymm1[14],ymm0[15],ymm1[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm0 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[8],ymm1[8],ymm0[9],ymm1[9],ymm0[10],ymm1[10],ymm0[11],ymm1[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm1 = ymm0[0,1],ymm2[0,1]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm0 = ymm0[2,3],ymm2[2,3]
; AVX2-ONLY-NEXT:    vmovdqa %ymm0, 32(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm1, (%rdx)
; AVX2-ONLY-NEXT:    vzeroupper
; AVX2-ONLY-NEXT:    retq
;
; AVX512F-LABEL: store_i16_stride2_vf16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rsi), %xmm0
; AVX512F-NEXT:    vmovdqa 16(%rsi), %xmm1
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm3
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm4 = xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm2 = xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
; AVX512F-NEXT:    vmovdqa %xmm1, 32(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm2, 48(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX512F-NEXT:    vmovdqa %xmm4, 16(%rdx)
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: store_i16_stride2_vf16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vinserti64x4 $1, (%rsi), %zmm0, %zmm0
; AVX512BW-NEXT:    vmovdqa64 {{.*#+}} zmm1 = [0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23,8,24,9,25,10,26,11,27,12,28,13,29,14,30,15,31]
; AVX512BW-NEXT:    vpermw %zmm0, %zmm1, %zmm0
; AVX512BW-NEXT:    vmovdqa64 %zmm0, (%rdx)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
  %in.vec0 = load <16 x i16>, ptr %in.vecptr0, align 64
  %in.vec1 = load <16 x i16>, ptr %in.vecptr1, align 64
  %1 = shufflevector <16 x i16> %in.vec0, <16 x i16> %in.vec1, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %interleaved.vec = shufflevector <32 x i16> %1, <32 x i16> poison, <32 x i32> <i32 0, i32 16, i32 1, i32 17, i32 2, i32 18, i32 3, i32 19, i32 4, i32 20, i32 5, i32 21, i32 6, i32 22, i32 7, i32 23, i32 8, i32 24, i32 9, i32 25, i32 10, i32 26, i32 11, i32 27, i32 12, i32 28, i32 13, i32 29, i32 14, i32 30, i32 15, i32 31>
  store <32 x i16> %interleaved.vec, ptr %out.vec, align 64
  ret void
}

define void @store_i16_stride2_vf32(ptr %in.vecptr0, ptr %in.vecptr1, ptr %out.vec) nounwind {
; SSE-LABEL: store_i16_stride2_vf32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    movdqa 16(%rdi), %xmm1
; SSE-NEXT:    movdqa 32(%rdi), %xmm2
; SSE-NEXT:    movdqa 48(%rdi), %xmm3
; SSE-NEXT:    movdqa (%rsi), %xmm4
; SSE-NEXT:    movdqa 16(%rsi), %xmm5
; SSE-NEXT:    movdqa 32(%rsi), %xmm6
; SSE-NEXT:    movdqa 48(%rsi), %xmm7
; SSE-NEXT:    movdqa %xmm0, %xmm8
; SSE-NEXT:    punpckhwd {{.*#+}} xmm8 = xmm8[4],xmm4[4],xmm8[5],xmm4[5],xmm8[6],xmm4[6],xmm8[7],xmm4[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1],xmm0[2],xmm4[2],xmm0[3],xmm4[3]
; SSE-NEXT:    movdqa %xmm1, %xmm4
; SSE-NEXT:    punpckhwd {{.*#+}} xmm4 = xmm4[4],xmm5[4],xmm4[5],xmm5[5],xmm4[6],xmm5[6],xmm4[7],xmm5[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm5[0],xmm1[1],xmm5[1],xmm1[2],xmm5[2],xmm1[3],xmm5[3]
; SSE-NEXT:    movdqa %xmm2, %xmm5
; SSE-NEXT:    punpckhwd {{.*#+}} xmm5 = xmm5[4],xmm6[4],xmm5[5],xmm6[5],xmm5[6],xmm6[6],xmm5[7],xmm6[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3]
; SSE-NEXT:    movdqa %xmm3, %xmm6
; SSE-NEXT:    punpckhwd {{.*#+}} xmm6 = xmm6[4],xmm7[4],xmm6[5],xmm7[5],xmm6[6],xmm7[6],xmm6[7],xmm7[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1],xmm3[2],xmm7[2],xmm3[3],xmm7[3]
; SSE-NEXT:    movdqa %xmm3, 96(%rdx)
; SSE-NEXT:    movdqa %xmm6, 112(%rdx)
; SSE-NEXT:    movdqa %xmm2, 64(%rdx)
; SSE-NEXT:    movdqa %xmm5, 80(%rdx)
; SSE-NEXT:    movdqa %xmm1, 32(%rdx)
; SSE-NEXT:    movdqa %xmm4, 48(%rdx)
; SSE-NEXT:    movdqa %xmm0, (%rdx)
; SSE-NEXT:    movdqa %xmm8, 16(%rdx)
; SSE-NEXT:    retq
;
; AVX1-ONLY-LABEL: store_i16_stride2_vf32:
; AVX1-ONLY:       # %bb.0:
; AVX1-ONLY-NEXT:    vmovdqa (%rsi), %xmm0
; AVX1-ONLY-NEXT:    vmovdqa 16(%rsi), %xmm1
; AVX1-ONLY-NEXT:    vmovdqa 32(%rsi), %xmm2
; AVX1-ONLY-NEXT:    vmovdqa 48(%rsi), %xmm3
; AVX1-ONLY-NEXT:    vmovdqa (%rdi), %xmm4
; AVX1-ONLY-NEXT:    vmovdqa 16(%rdi), %xmm5
; AVX1-ONLY-NEXT:    vmovdqa 32(%rdi), %xmm6
; AVX1-ONLY-NEXT:    vmovdqa 48(%rdi), %xmm7
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm8 = xmm6[4],xmm2[4],xmm6[5],xmm2[5],xmm6[6],xmm2[6],xmm6[7],xmm2[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm6[0],xmm2[0],xmm6[1],xmm2[1],xmm6[2],xmm2[2],xmm6[3],xmm2[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm6 = xmm7[4],xmm3[4],xmm7[5],xmm3[5],xmm7[6],xmm3[6],xmm7[7],xmm3[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm3 = xmm7[0],xmm3[0],xmm7[1],xmm3[1],xmm7[2],xmm3[2],xmm7[3],xmm3[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm7 = xmm5[4],xmm1[4],xmm5[5],xmm1[5],xmm5[6],xmm1[6],xmm5[7],xmm1[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm5[0],xmm1[0],xmm5[1],xmm1[1],xmm5[2],xmm1[2],xmm5[3],xmm1[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm5 = xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3]
; AVX1-ONLY-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm5, 16(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm1, 32(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm7, 48(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm3, 96(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm6, 112(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm2, 64(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm8, 80(%rdx)
; AVX1-ONLY-NEXT:    retq
;
; AVX2-ONLY-LABEL: store_i16_stride2_vf32:
; AVX2-ONLY:       # %bb.0:
; AVX2-ONLY-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-ONLY-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX2-ONLY-NEXT:    vmovdqa (%rsi), %ymm2
; AVX2-ONLY-NEXT:    vmovdqa 32(%rsi), %ymm3
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm4 = ymm0[4],ymm2[4],ymm0[5],ymm2[5],ymm0[6],ymm2[6],ymm0[7],ymm2[7],ymm0[12],ymm2[12],ymm0[13],ymm2[13],ymm0[14],ymm2[14],ymm0[15],ymm2[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm0 = ymm0[0],ymm2[0],ymm0[1],ymm2[1],ymm0[2],ymm2[2],ymm0[3],ymm2[3],ymm0[8],ymm2[8],ymm0[9],ymm2[9],ymm0[10],ymm2[10],ymm0[11],ymm2[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm2 = ymm0[2,3],ymm4[2,3]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm0 = ymm0[0,1],ymm4[0,1]
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm4 = ymm1[4],ymm3[4],ymm1[5],ymm3[5],ymm1[6],ymm3[6],ymm1[7],ymm3[7],ymm1[12],ymm3[12],ymm1[13],ymm3[13],ymm1[14],ymm3[14],ymm1[15],ymm3[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm1 = ymm1[0],ymm3[0],ymm1[1],ymm3[1],ymm1[2],ymm3[2],ymm1[3],ymm3[3],ymm1[8],ymm3[8],ymm1[9],ymm3[9],ymm1[10],ymm3[10],ymm1[11],ymm3[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm3 = ymm1[2,3],ymm4[2,3]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm1 = ymm1[0,1],ymm4[0,1]
; AVX2-ONLY-NEXT:    vmovdqa %ymm1, 64(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm3, 96(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm2, 32(%rdx)
; AVX2-ONLY-NEXT:    vzeroupper
; AVX2-ONLY-NEXT:    retq
;
; AVX512F-LABEL: store_i16_stride2_vf32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rsi), %xmm0
; AVX512F-NEXT:    vmovdqa 16(%rsi), %xmm1
; AVX512F-NEXT:    vmovdqa 32(%rsi), %xmm2
; AVX512F-NEXT:    vmovdqa 48(%rsi), %xmm3
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm4
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm5
; AVX512F-NEXT:    vmovdqa 32(%rdi), %xmm6
; AVX512F-NEXT:    vmovdqa 48(%rdi), %xmm7
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm8 = xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm4 = xmm5[4],xmm1[4],xmm5[5],xmm1[5],xmm5[6],xmm1[6],xmm5[7],xmm1[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm5[0],xmm1[0],xmm5[1],xmm1[1],xmm5[2],xmm1[2],xmm5[3],xmm1[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm5 = xmm6[4],xmm2[4],xmm6[5],xmm2[5],xmm6[6],xmm2[6],xmm6[7],xmm2[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm6[0],xmm2[0],xmm6[1],xmm2[1],xmm6[2],xmm2[2],xmm6[3],xmm2[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm6 = xmm7[4],xmm3[4],xmm7[5],xmm3[5],xmm7[6],xmm3[6],xmm7[7],xmm3[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm3 = xmm7[0],xmm3[0],xmm7[1],xmm3[1],xmm7[2],xmm3[2],xmm7[3],xmm3[3]
; AVX512F-NEXT:    vmovdqa %xmm3, 96(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm6, 112(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm2, 64(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm5, 80(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm1, 32(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm4, 48(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX512F-NEXT:    vmovdqa %xmm8, 16(%rdx)
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: store_i16_stride2_vf32:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512BW-NEXT:    vmovdqa64 (%rsi), %zmm1
; AVX512BW-NEXT:    vmovdqa64 {{.*#+}} zmm2 = [0,32,1,33,2,34,3,35,4,36,5,37,6,38,7,39,8,40,9,41,10,42,11,43,12,44,13,45,14,46,15,47]
; AVX512BW-NEXT:    vpermi2w %zmm1, %zmm0, %zmm2
; AVX512BW-NEXT:    vmovdqa64 {{.*#+}} zmm3 = [16,48,17,49,18,50,19,51,20,52,21,53,22,54,23,55,24,56,25,57,26,58,27,59,28,60,29,61,30,62,31,63]
; AVX512BW-NEXT:    vpermi2w %zmm1, %zmm0, %zmm3
; AVX512BW-NEXT:    vmovdqa64 %zmm3, 64(%rdx)
; AVX512BW-NEXT:    vmovdqa64 %zmm2, (%rdx)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
  %in.vec0 = load <32 x i16>, ptr %in.vecptr0, align 64
  %in.vec1 = load <32 x i16>, ptr %in.vecptr1, align 64
  %1 = shufflevector <32 x i16> %in.vec0, <32 x i16> %in.vec1, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %interleaved.vec = shufflevector <64 x i16> %1, <64 x i16> poison, <64 x i32> <i32 0, i32 32, i32 1, i32 33, i32 2, i32 34, i32 3, i32 35, i32 4, i32 36, i32 5, i32 37, i32 6, i32 38, i32 7, i32 39, i32 8, i32 40, i32 9, i32 41, i32 10, i32 42, i32 11, i32 43, i32 12, i32 44, i32 13, i32 45, i32 14, i32 46, i32 15, i32 47, i32 16, i32 48, i32 17, i32 49, i32 18, i32 50, i32 19, i32 51, i32 20, i32 52, i32 21, i32 53, i32 22, i32 54, i32 23, i32 55, i32 24, i32 56, i32 25, i32 57, i32 26, i32 58, i32 27, i32 59, i32 28, i32 60, i32 29, i32 61, i32 30, i32 62, i32 31, i32 63>
  store <64 x i16> %interleaved.vec, ptr %out.vec, align 64
  ret void
}

define void @store_i16_stride2_vf64(ptr %in.vecptr0, ptr %in.vecptr1, ptr %out.vec) nounwind {
; SSE-LABEL: store_i16_stride2_vf64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa 112(%rdi), %xmm0
; SSE-NEXT:    movdqa 96(%rdi), %xmm6
; SSE-NEXT:    movdqa 80(%rdi), %xmm4
; SSE-NEXT:    movdqa 64(%rdi), %xmm3
; SSE-NEXT:    movdqa (%rdi), %xmm7
; SSE-NEXT:    movdqa 16(%rdi), %xmm1
; SSE-NEXT:    movdqa 32(%rdi), %xmm2
; SSE-NEXT:    movdqa 48(%rdi), %xmm5
; SSE-NEXT:    movdqa 96(%rsi), %xmm10
; SSE-NEXT:    movdqa 80(%rsi), %xmm11
; SSE-NEXT:    movdqa 64(%rsi), %xmm12
; SSE-NEXT:    movdqa (%rsi), %xmm9
; SSE-NEXT:    movdqa 16(%rsi), %xmm13
; SSE-NEXT:    movdqa 32(%rsi), %xmm14
; SSE-NEXT:    movdqa 48(%rsi), %xmm15
; SSE-NEXT:    movdqa %xmm7, %xmm8
; SSE-NEXT:    punpckhwd {{.*#+}} xmm8 = xmm8[4],xmm9[4],xmm8[5],xmm9[5],xmm8[6],xmm9[6],xmm8[7],xmm9[7]
; SSE-NEXT:    movdqa %xmm8, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    punpcklwd {{.*#+}} xmm7 = xmm7[0],xmm9[0],xmm7[1],xmm9[1],xmm7[2],xmm9[2],xmm7[3],xmm9[3]
; SSE-NEXT:    movdqa %xmm1, %xmm9
; SSE-NEXT:    punpckhwd {{.*#+}} xmm9 = xmm9[4],xmm13[4],xmm9[5],xmm13[5],xmm9[6],xmm13[6],xmm9[7],xmm13[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm13[0],xmm1[1],xmm13[1],xmm1[2],xmm13[2],xmm1[3],xmm13[3]
; SSE-NEXT:    movdqa %xmm2, %xmm13
; SSE-NEXT:    punpckhwd {{.*#+}} xmm13 = xmm13[4],xmm14[4],xmm13[5],xmm14[5],xmm13[6],xmm14[6],xmm13[7],xmm14[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm14[0],xmm2[1],xmm14[1],xmm2[2],xmm14[2],xmm2[3],xmm14[3]
; SSE-NEXT:    movdqa %xmm5, %xmm14
; SSE-NEXT:    punpckhwd {{.*#+}} xmm14 = xmm14[4],xmm15[4],xmm14[5],xmm15[5],xmm14[6],xmm15[6],xmm14[7],xmm15[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm5 = xmm5[0],xmm15[0],xmm5[1],xmm15[1],xmm5[2],xmm15[2],xmm5[3],xmm15[3]
; SSE-NEXT:    movdqa %xmm3, %xmm15
; SSE-NEXT:    punpckhwd {{.*#+}} xmm15 = xmm15[4],xmm12[4],xmm15[5],xmm12[5],xmm15[6],xmm12[6],xmm15[7],xmm12[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm12[0],xmm3[1],xmm12[1],xmm3[2],xmm12[2],xmm3[3],xmm12[3]
; SSE-NEXT:    movdqa %xmm4, %xmm12
; SSE-NEXT:    punpckhwd {{.*#+}} xmm12 = xmm12[4],xmm11[4],xmm12[5],xmm11[5],xmm12[6],xmm11[6],xmm12[7],xmm11[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm4 = xmm4[0],xmm11[0],xmm4[1],xmm11[1],xmm4[2],xmm11[2],xmm4[3],xmm11[3]
; SSE-NEXT:    movdqa %xmm6, %xmm11
; SSE-NEXT:    punpckhwd {{.*#+}} xmm11 = xmm11[4],xmm10[4],xmm11[5],xmm10[5],xmm11[6],xmm10[6],xmm11[7],xmm10[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm6 = xmm6[0],xmm10[0],xmm6[1],xmm10[1],xmm6[2],xmm10[2],xmm6[3],xmm10[3]
; SSE-NEXT:    movdqa 112(%rsi), %xmm10
; SSE-NEXT:    movdqa %xmm0, %xmm8
; SSE-NEXT:    punpckhwd {{.*#+}} xmm8 = xmm8[4],xmm10[4],xmm8[5],xmm10[5],xmm8[6],xmm10[6],xmm8[7],xmm10[7]
; SSE-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm10[0],xmm0[1],xmm10[1],xmm0[2],xmm10[2],xmm0[3],xmm10[3]
; SSE-NEXT:    movdqa %xmm0, 224(%rdx)
; SSE-NEXT:    movdqa %xmm8, 240(%rdx)
; SSE-NEXT:    movdqa %xmm6, 192(%rdx)
; SSE-NEXT:    movdqa %xmm11, 208(%rdx)
; SSE-NEXT:    movdqa %xmm4, 160(%rdx)
; SSE-NEXT:    movdqa %xmm12, 176(%rdx)
; SSE-NEXT:    movdqa %xmm3, 128(%rdx)
; SSE-NEXT:    movdqa %xmm15, 144(%rdx)
; SSE-NEXT:    movdqa %xmm5, 96(%rdx)
; SSE-NEXT:    movdqa %xmm14, 112(%rdx)
; SSE-NEXT:    movdqa %xmm2, 64(%rdx)
; SSE-NEXT:    movdqa %xmm13, 80(%rdx)
; SSE-NEXT:    movdqa %xmm1, 32(%rdx)
; SSE-NEXT:    movdqa %xmm9, 48(%rdx)
; SSE-NEXT:    movdqa %xmm7, (%rdx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 16(%rdx)
; SSE-NEXT:    retq
;
; AVX1-ONLY-LABEL: store_i16_stride2_vf64:
; AVX1-ONLY:       # %bb.0:
; AVX1-ONLY-NEXT:    vmovdqa 64(%rsi), %xmm1
; AVX1-ONLY-NEXT:    vmovdqa 64(%rdi), %xmm2
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm0 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
; AVX1-ONLY-NEXT:    vmovdqa %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; AVX1-ONLY-NEXT:    vmovdqa 80(%rsi), %xmm3
; AVX1-ONLY-NEXT:    vmovdqa 80(%rdi), %xmm4
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm2 = xmm4[4],xmm3[4],xmm4[5],xmm3[5],xmm4[6],xmm3[6],xmm4[7],xmm3[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm3 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3]
; AVX1-ONLY-NEXT:    vmovdqa (%rsi), %xmm4
; AVX1-ONLY-NEXT:    vmovdqa 16(%rsi), %xmm5
; AVX1-ONLY-NEXT:    vmovdqa 32(%rsi), %xmm6
; AVX1-ONLY-NEXT:    vmovdqa 48(%rsi), %xmm7
; AVX1-ONLY-NEXT:    vmovdqa (%rdi), %xmm8
; AVX1-ONLY-NEXT:    vmovdqa 16(%rdi), %xmm9
; AVX1-ONLY-NEXT:    vmovdqa 32(%rdi), %xmm10
; AVX1-ONLY-NEXT:    vmovdqa 48(%rdi), %xmm11
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm12 = xmm8[4],xmm4[4],xmm8[5],xmm4[5],xmm8[6],xmm4[6],xmm8[7],xmm4[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm4 = xmm8[0],xmm4[0],xmm8[1],xmm4[1],xmm8[2],xmm4[2],xmm8[3],xmm4[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm8 = xmm10[4],xmm6[4],xmm10[5],xmm6[5],xmm10[6],xmm6[6],xmm10[7],xmm6[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm6 = xmm10[0],xmm6[0],xmm10[1],xmm6[1],xmm10[2],xmm6[2],xmm10[3],xmm6[3]
; AVX1-ONLY-NEXT:    vmovdqa 96(%rsi), %xmm10
; AVX1-ONLY-NEXT:    vmovdqa 96(%rdi), %xmm13
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm14 = xmm13[4],xmm10[4],xmm13[5],xmm10[5],xmm13[6],xmm10[6],xmm13[7],xmm10[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm10 = xmm13[0],xmm10[0],xmm13[1],xmm10[1],xmm13[2],xmm10[2],xmm13[3],xmm10[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm13 = xmm11[4],xmm7[4],xmm11[5],xmm7[5],xmm11[6],xmm7[6],xmm11[7],xmm7[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm7 = xmm11[0],xmm7[0],xmm11[1],xmm7[1],xmm11[2],xmm7[2],xmm11[3],xmm7[3]
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm11 = xmm9[4],xmm5[4],xmm9[5],xmm5[5],xmm9[6],xmm5[6],xmm9[7],xmm5[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm5 = xmm9[0],xmm5[0],xmm9[1],xmm5[1],xmm9[2],xmm5[2],xmm9[3],xmm5[3]
; AVX1-ONLY-NEXT:    vmovdqa 112(%rsi), %xmm9
; AVX1-ONLY-NEXT:    vmovdqa 112(%rdi), %xmm15
; AVX1-ONLY-NEXT:    vpunpckhwd {{.*#+}} xmm0 = xmm15[4],xmm9[4],xmm15[5],xmm9[5],xmm15[6],xmm9[6],xmm15[7],xmm9[7]
; AVX1-ONLY-NEXT:    vpunpcklwd {{.*#+}} xmm9 = xmm15[0],xmm9[0],xmm15[1],xmm9[1],xmm15[2],xmm9[2],xmm15[3],xmm9[3]
; AVX1-ONLY-NEXT:    vmovdqa %xmm9, 224(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm0, 240(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm5, 32(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm11, 48(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm7, 96(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm13, 112(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm10, 192(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm14, 208(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm6, 64(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm8, 80(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm4, (%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm12, 16(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm3, 160(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm2, 176(%rdx)
; AVX1-ONLY-NEXT:    vmovdqa %xmm1, 128(%rdx)
; AVX1-ONLY-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; AVX1-ONLY-NEXT:    vmovaps %xmm0, 144(%rdx)
; AVX1-ONLY-NEXT:    retq
;
; AVX2-ONLY-LABEL: store_i16_stride2_vf64:
; AVX2-ONLY:       # %bb.0:
; AVX2-ONLY-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-ONLY-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX2-ONLY-NEXT:    vmovdqa 64(%rdi), %ymm2
; AVX2-ONLY-NEXT:    vmovdqa 96(%rdi), %ymm3
; AVX2-ONLY-NEXT:    vmovdqa (%rsi), %ymm4
; AVX2-ONLY-NEXT:    vmovdqa 32(%rsi), %ymm5
; AVX2-ONLY-NEXT:    vmovdqa 64(%rsi), %ymm6
; AVX2-ONLY-NEXT:    vmovdqa 96(%rsi), %ymm7
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm8 = ymm0[4],ymm4[4],ymm0[5],ymm4[5],ymm0[6],ymm4[6],ymm0[7],ymm4[7],ymm0[12],ymm4[12],ymm0[13],ymm4[13],ymm0[14],ymm4[14],ymm0[15],ymm4[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm0 = ymm0[0],ymm4[0],ymm0[1],ymm4[1],ymm0[2],ymm4[2],ymm0[3],ymm4[3],ymm0[8],ymm4[8],ymm0[9],ymm4[9],ymm0[10],ymm4[10],ymm0[11],ymm4[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm4 = ymm0[2,3],ymm8[2,3]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm0 = ymm0[0,1],ymm8[0,1]
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm8 = ymm1[4],ymm5[4],ymm1[5],ymm5[5],ymm1[6],ymm5[6],ymm1[7],ymm5[7],ymm1[12],ymm5[12],ymm1[13],ymm5[13],ymm1[14],ymm5[14],ymm1[15],ymm5[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm1 = ymm1[0],ymm5[0],ymm1[1],ymm5[1],ymm1[2],ymm5[2],ymm1[3],ymm5[3],ymm1[8],ymm5[8],ymm1[9],ymm5[9],ymm1[10],ymm5[10],ymm1[11],ymm5[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm5 = ymm1[2,3],ymm8[2,3]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm1 = ymm1[0,1],ymm8[0,1]
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm8 = ymm2[4],ymm6[4],ymm2[5],ymm6[5],ymm2[6],ymm6[6],ymm2[7],ymm6[7],ymm2[12],ymm6[12],ymm2[13],ymm6[13],ymm2[14],ymm6[14],ymm2[15],ymm6[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm2 = ymm2[0],ymm6[0],ymm2[1],ymm6[1],ymm2[2],ymm6[2],ymm2[3],ymm6[3],ymm2[8],ymm6[8],ymm2[9],ymm6[9],ymm2[10],ymm6[10],ymm2[11],ymm6[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm6 = ymm2[2,3],ymm8[2,3]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm2 = ymm2[0,1],ymm8[0,1]
; AVX2-ONLY-NEXT:    vpunpckhwd {{.*#+}} ymm8 = ymm3[4],ymm7[4],ymm3[5],ymm7[5],ymm3[6],ymm7[6],ymm3[7],ymm7[7],ymm3[12],ymm7[12],ymm3[13],ymm7[13],ymm3[14],ymm7[14],ymm3[15],ymm7[15]
; AVX2-ONLY-NEXT:    vpunpcklwd {{.*#+}} ymm3 = ymm3[0],ymm7[0],ymm3[1],ymm7[1],ymm3[2],ymm7[2],ymm3[3],ymm7[3],ymm3[8],ymm7[8],ymm3[9],ymm7[9],ymm3[10],ymm7[10],ymm3[11],ymm7[11]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm7 = ymm3[2,3],ymm8[2,3]
; AVX2-ONLY-NEXT:    vperm2i128 {{.*#+}} ymm3 = ymm3[0,1],ymm8[0,1]
; AVX2-ONLY-NEXT:    vmovdqa %ymm3, 192(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm7, 224(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm2, 128(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm6, 160(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm1, 64(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm5, 96(%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-ONLY-NEXT:    vmovdqa %ymm4, 32(%rdx)
; AVX2-ONLY-NEXT:    vzeroupper
; AVX2-ONLY-NEXT:    retq
;
; AVX512F-LABEL: store_i16_stride2_vf64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa 64(%rsi), %xmm1
; AVX512F-NEXT:    vmovdqa 64(%rdi), %xmm2
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; AVX512F-NEXT:    vmovdqa64 %xmm0, %xmm16
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm1 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
; AVX512F-NEXT:    vmovdqa 80(%rsi), %xmm3
; AVX512F-NEXT:    vmovdqa 80(%rdi), %xmm4
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm3 = xmm4[4],xmm3[4],xmm4[5],xmm3[5],xmm4[6],xmm3[6],xmm4[7],xmm3[7]
; AVX512F-NEXT:    vmovdqa 96(%rsi), %xmm5
; AVX512F-NEXT:    vmovdqa 96(%rdi), %xmm6
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm4 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm5 = xmm6[4],xmm5[4],xmm6[5],xmm5[5],xmm6[6],xmm5[6],xmm6[7],xmm5[7]
; AVX512F-NEXT:    vmovdqa 112(%rsi), %xmm6
; AVX512F-NEXT:    vmovdqa 112(%rdi), %xmm7
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm8 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm6 = xmm7[4],xmm6[4],xmm7[5],xmm6[5],xmm7[6],xmm6[6],xmm7[7],xmm6[7]
; AVX512F-NEXT:    vmovdqa (%rsi), %xmm7
; AVX512F-NEXT:    vmovdqa 16(%rsi), %xmm9
; AVX512F-NEXT:    vmovdqa 32(%rsi), %xmm10
; AVX512F-NEXT:    vmovdqa 48(%rsi), %xmm11
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm12
; AVX512F-NEXT:    vmovdqa 32(%rdi), %xmm13
; AVX512F-NEXT:    vmovdqa 48(%rdi), %xmm14
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm15 = xmm13[0],xmm10[0],xmm13[1],xmm10[1],xmm13[2],xmm10[2],xmm13[3],xmm10[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm10 = xmm13[4],xmm10[4],xmm13[5],xmm10[5],xmm13[6],xmm10[6],xmm13[7],xmm10[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm13 = xmm14[0],xmm11[0],xmm14[1],xmm11[1],xmm14[2],xmm11[2],xmm14[3],xmm11[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm11 = xmm14[4],xmm11[4],xmm14[5],xmm11[5],xmm14[6],xmm11[6],xmm14[7],xmm11[7]
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm14 = xmm12[0],xmm7[0],xmm12[1],xmm7[1],xmm12[2],xmm7[2],xmm12[3],xmm7[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm7 = xmm12[4],xmm7[4],xmm12[5],xmm7[5],xmm12[6],xmm7[6],xmm12[7],xmm7[7]
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm12
; AVX512F-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm12[0],xmm9[0],xmm12[1],xmm9[1],xmm12[2],xmm9[2],xmm12[3],xmm9[3]
; AVX512F-NEXT:    vpunpckhwd {{.*#+}} xmm9 = xmm12[4],xmm9[4],xmm12[5],xmm9[5],xmm12[6],xmm9[6],xmm12[7],xmm9[7]
; AVX512F-NEXT:    vmovdqa %xmm9, 48(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm0, 32(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm7, 16(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm14, (%rdx)
; AVX512F-NEXT:    vmovdqa %xmm11, 112(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm13, 96(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm10, 80(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm15, 64(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm6, 240(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm8, 224(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm5, 208(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm4, 192(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm3, 176(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm2, 160(%rdx)
; AVX512F-NEXT:    vmovdqa %xmm1, 144(%rdx)
; AVX512F-NEXT:    vmovdqa64 %xmm16, 128(%rdx)
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: store_i16_stride2_vf64:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512BW-NEXT:    vmovdqa64 64(%rdi), %zmm1
; AVX512BW-NEXT:    vmovdqa64 (%rsi), %zmm2
; AVX512BW-NEXT:    vmovdqa64 64(%rsi), %zmm3
; AVX512BW-NEXT:    vmovdqa64 {{.*#+}} zmm4 = [16,48,17,49,18,50,19,51,20,52,21,53,22,54,23,55,24,56,25,57,26,58,27,59,28,60,29,61,30,62,31,63]
; AVX512BW-NEXT:    vmovdqa64 %zmm0, %zmm5
; AVX512BW-NEXT:    vpermt2w %zmm2, %zmm4, %zmm5
; AVX512BW-NEXT:    vmovdqa64 {{.*#+}} zmm6 = [0,32,1,33,2,34,3,35,4,36,5,37,6,38,7,39,8,40,9,41,10,42,11,43,12,44,13,45,14,46,15,47]
; AVX512BW-NEXT:    vpermt2w %zmm2, %zmm6, %zmm0
; AVX512BW-NEXT:    vpermi2w %zmm3, %zmm1, %zmm4
; AVX512BW-NEXT:    vpermt2w %zmm3, %zmm6, %zmm1
; AVX512BW-NEXT:    vmovdqa64 %zmm1, 128(%rdx)
; AVX512BW-NEXT:    vmovdqa64 %zmm4, 192(%rdx)
; AVX512BW-NEXT:    vmovdqa64 %zmm0, (%rdx)
; AVX512BW-NEXT:    vmovdqa64 %zmm5, 64(%rdx)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
  %in.vec0 = load <64 x i16>, ptr %in.vecptr0, align 64
  %in.vec1 = load <64 x i16>, ptr %in.vecptr1, align 64
  %1 = shufflevector <64 x i16> %in.vec0, <64 x i16> %in.vec1, <128 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127>
  %interleaved.vec = shufflevector <128 x i16> %1, <128 x i16> poison, <128 x i32> <i32 0, i32 64, i32 1, i32 65, i32 2, i32 66, i32 3, i32 67, i32 4, i32 68, i32 5, i32 69, i32 6, i32 70, i32 7, i32 71, i32 8, i32 72, i32 9, i32 73, i32 10, i32 74, i32 11, i32 75, i32 12, i32 76, i32 13, i32 77, i32 14, i32 78, i32 15, i32 79, i32 16, i32 80, i32 17, i32 81, i32 18, i32 82, i32 19, i32 83, i32 20, i32 84, i32 21, i32 85, i32 22, i32 86, i32 23, i32 87, i32 24, i32 88, i32 25, i32 89, i32 26, i32 90, i32 27, i32 91, i32 28, i32 92, i32 29, i32 93, i32 30, i32 94, i32 31, i32 95, i32 32, i32 96, i32 33, i32 97, i32 34, i32 98, i32 35, i32 99, i32 36, i32 100, i32 37, i32 101, i32 38, i32 102, i32 39, i32 103, i32 40, i32 104, i32 41, i32 105, i32 42, i32 106, i32 43, i32 107, i32 44, i32 108, i32 45, i32 109, i32 46, i32 110, i32 47, i32 111, i32 48, i32 112, i32 49, i32 113, i32 50, i32 114, i32 51, i32 115, i32 52, i32 116, i32 53, i32 117, i32 54, i32 118, i32 55, i32 119, i32 56, i32 120, i32 57, i32 121, i32 58, i32 122, i32 59, i32 123, i32 60, i32 124, i32 61, i32 125, i32 62, i32 126, i32 63, i32 127>
  store <128 x i16> %interleaved.vec, ptr %out.vec, align 64
  ret void
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; AVX1: {{.*}}
; AVX2: {{.*}}
; AVX2-FAST: {{.*}}
; AVX2-FAST-PERLANE: {{.*}}
; AVX2-SLOW: {{.*}}
; AVX512: {{.*}}
; AVX512-FAST: {{.*}}
; AVX512-SLOW: {{.*}}
; AVX512BW-FAST: {{.*}}
; AVX512BW-ONLY-FAST: {{.*}}
; AVX512BW-ONLY-SLOW: {{.*}}
; AVX512BW-SLOW: {{.*}}
; AVX512DQ-FAST: {{.*}}
; AVX512DQ-SLOW: {{.*}}
; AVX512DQBW-FAST: {{.*}}
; AVX512DQBW-SLOW: {{.*}}
; AVX512F-FAST: {{.*}}
; AVX512F-ONLY-FAST: {{.*}}
; AVX512F-ONLY-SLOW: {{.*}}
; AVX512F-SLOW: {{.*}}
; FALLBACK0: {{.*}}
; FALLBACK1: {{.*}}
; FALLBACK10: {{.*}}
; FALLBACK11: {{.*}}
; FALLBACK12: {{.*}}
; FALLBACK2: {{.*}}
; FALLBACK3: {{.*}}
; FALLBACK4: {{.*}}
; FALLBACK5: {{.*}}
; FALLBACK6: {{.*}}
; FALLBACK7: {{.*}}
; FALLBACK8: {{.*}}
; FALLBACK9: {{.*}}
