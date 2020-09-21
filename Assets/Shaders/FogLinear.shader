Shader "Hidden/FogLinear" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _FogColor ("Fog Color", Color) = (1,1,1,1)
 _FogStart ("Fog Start", Float) = 0
 _FogEnd ("Fog End", Float) = 0
 _FogDensity ("Fog Density", Float) = 0
 _FogBuffer ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_ProjectionParams]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
# 10 ALU
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_MainTex_ST]
"vs_2_0
; 10 ALU
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad oT2.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.xy, v1, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkepofejjggblbiejelaehikmlooldmnhabaaaaaammacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcneabaaaaeaaaabaahfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednfocjlfkfeimdjamokegjclgoajcdbafabaaaaaaciaeaaaaaeaaaaaa
daaaaaaaiiabaaaageadaaaaliadaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
aeabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoa
abaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiaahaaaakaafaaaaadabaaafia
aaaapeiaahaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaamoa
aaaaoeiappppaaaafdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
aaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ZBufferParams]
Vector 1 [_FogColor]
Float 2 [_FogStart]
Float 3 [_FogEnd]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FogBuffer] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 3 TEX
PARAM c[5] = { program.local[0..3],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TXP R1.x, fragment.texcoord[2], texture[2], 2D;
TEX R0.x, fragment.texcoord[0], texture[1], 2D;
MAD R0.y, R1.x, c[0].x, c[0];
MOV R0.z, c[2].x;
RCP R0.y, R0.y;
ADD R0.z, -R0, c[3].x;
FLR R0.y, R0;
MAD R0.w, R1.x, c[0].z, c[0];
ADD R2.xyz, R2, -c[1];
ADD R0.y, -R0, c[4].x;
RCP R0.w, R0.w;
MUL R0.y, R0.w, R0;
RCP R0.z, R0.z;
MAD R0.x, -R0.y, R0, c[3];
MUL_SAT R0.x, R0, R0.z;
MAD result.color.xyz, R0.x, R2, c[1];
MOV result.color.w, R2;
END
# 18 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ZBufferParams]
Vector 1 [_FogColor]
Float 2 [_FogStart]
Float 3 [_FogEnd]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FogBuffer] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_2_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 0, 0, 0
dcl t0.xy
dcl t2
texld r2, t0, s0
texldp r4, t2, s2
texld r3, t0, s1
mad r0.x, r4, c0, c0.y
rcp r0.x, r0.x
frc r1.x, r0
add r0.x, r0, -r1
mad r1.x, r4, c0.z, c0.w
rcp r1.x, r1.x
add r0.x, -r0, c4
mul r0.x, r1, r0
mov r1.x, c3
add r1.x, -c2, r1
rcp r1.x, r1.x
mad r0.x, -r0, r3, c3
mul_sat r0.x, r0, r1
add r1.xyz, r2, -c1
mov r0.w, r2
mad r0.xyz, r0.x, r1, c1
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FogBuffer] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 64
Vector 32 [_FogColor]
Float 48 [_FogStart]
Float 52 [_FogEnd]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlbfoodlfhcipginbhlmggfkeilnglmhmabaaaaaaiaadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiacaaaaeaaaaaaakkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaaldcaabaaaaaaaaaaacgikcaaaabaaaaaaahaaaaaaagaabaaaaaaaaaaa
hgipcaaaabaaaaaaahaaaaaaaoaaaaakdcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaabaaaaaaaaaaaebaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
akaabaaaabaaaaaabkiacaaaaaaaaaaaadaaaaaaaaaaaaakccaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaaocaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FogBuffer] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 64
Vector 32 [_FogColor]
Float 48 [_FogStart]
Float 52 [_FogEnd]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedkfmmdpkioldbajpilpoefgolffbjbfejabaaaaaageafaaaaaeaaaaaa
daaaaaaabaacaaaamaaeaaaadaafaaaaebgpgodjniabaaaaniabaaaaaaacpppp
jaabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaacaaacaaaaaaaaaaaaaaabaaahaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaagaaaaacaaaaaiia
abaapplaafaaaaadaaaaadiaaaaappiaabaaoelaecaaaaadaaaaapiaaaaaoeia
acaioekaecaaaaadabaaapiaaaaaoelaabaioekaecaaaaadacaaapiaaaaaoela
aaaioekaaeaaaaaeaaaaaciaacaaaakaaaaaaaiaacaaffkaaeaaaaaeaaaaabia
acaakkkaaaaaaaiaacaappkaagaaaaacaaaaabiaaaaaaaiaagaaaaacaaaaacia
aaaaffiabdaaaaacaaaaaeiaaaaaffiaacaaaaadaaaaaciaaaaakkibaaaaffia
acaaaaadaaaaaciaaaaaffibadaaaakaafaaaaadaaaaabiaaaaaffiaaaaaaaia
aeaaaaaeaaaaabiaaaaaaaiaabaaaaibabaaffkaacaaaaadaaaaaciaabaaaakb
abaaffkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaabbiaaaaaffiaaaaaaaia
bcaaaaaeabaaahiaaaaaaaiaacaaoeiaaaaaoekaabaaaaacabaaaiiaacaappia
abaaaaacaaaiapiaabaaoeiappppaaaafdeieefckiacaaaaeaaaaaaakkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaaldcaabaaaaaaaaaaacgikcaaaabaaaaaaahaaaaaaagaabaaaaaaaaaaa
hgipcaaaabaaaaaaahaaaaaaaoaaaaakdcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaabaaaaaaaaaaaebaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
akaabaaaabaaaaaabkiacaaaaaaaaaaaadaaaaaaaaaaaaakccaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaaocaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
}
Fallback Off
}