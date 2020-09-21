Shader "Hidden/Glow 11/BlurEffectConeTap" {
Properties {
 _MainTex ("", any) = "" {}
 _Strength ("Strength", Float) = 1
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_TexelSize]
Vector 6 [_BlurOffsets]
"!!ARBvp1.0
# 13 ALU
PARAM c[7] = { { 1, -1 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
MOV R0.zw, c[6].xyxy;
MOV R0.xy, c[5];
MAD R0.xy, R0, -c[6], vertex.texcoord[0];
MUL R1.xy, R0.zwzw, c[5];
MAD result.texcoord[1].xy, R0.zwzw, c[5], R0;
MAD result.texcoord[2].xy, R0.zwzw, -c[5], R0;
MAD result.texcoord[3].xy, R1, c[0], R0;
MAD result.texcoord[4].xy, -R1, c[0], R0;
MOV result.texcoord[0].xy, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
Vector 5 [_BlurOffsets]
"vs_2_0
; 15 ALU
def c6, 1.00000000, -1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c5
mad r1.xy, c4, -r0, v1
mov r0.xy, c4
mad oT1.xy, c5, r0, r1
mov r0.zw, c4.xyxy
mul r0.zw, c5.xyxy, r0
mov r0.xy, c4
mad oT2.xy, c5, -r0, r1
mad oT3.xy, r0.zwzw, c6, r1
mad oT4.xy, -r0.zwzw, c6, r1
mov oT0.xy, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_TexelSize]
Vector 32 [_BlurOffsets]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddhbfkbijjmgnmogjbdnmfpogboepgnfcabaaaaaaiaadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceaacaaaa
eaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaaegiacaiaebaaaaaa
aaaaaaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaegbabaaaabaaaaaadgaaaaaf
dccabaaaabaaaaaaegaabaaaaaaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaa
abaaaaaadcaaaaamdccabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaaacaaaaaa
egiacaaaaaaaaaaaabaaaaaaegaabaaaaaaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaadcaaaaamdccabaaa
aeaaaaaaogakbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaandccabaaaafaaaaaaogakbaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_TexelSize]
Vector 32 [_BlurOffsets]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgkknbajbeliiknooadnbddfoohgpoeiaabaaaaaapeaeaaaaaeaaaaaa
daaaaaaakaabaaaaoiadaaaadmaeaaaaebgpgodjgiabaaaagiabaaaaaaacpopp
ciabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaadiaacaaoekaaeaaaaaeaaaaamia
aaaaeeiaabaaeekbabaaeejaaeaaaaaeacaaadoaaaaaoeiaabaaoekbaaaaooia
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeadaaadoaaaaaoeiaahaaoeka
aaaaooiaaeaaaaaeaeaaadoaaaaaoeiaahaaoekbaaaaooiaabaaaaacaaaaadoa
aaaaooiaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaadoaabaaoejappppaaaa
fdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaa
egiacaiaebaaaaaaaaaaaaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaegbabaaa
abaaaaaadgaaaaafdccabaaaabaaaaaaegaabaaaaaaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaabaaaaaadcaaaaamdccabaaaadaaaaaaegiacaiaebaaaaaa
aaaaaaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaegaabaaaaaaaaaaadiaaaaaj
mcaabaaaaaaaaaaaagiecaaaaaaaaaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaa
dcaaaaamdccabaaaaeaaaaaaogakbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaaaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaandccabaaaafaaaaaaogakbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaegaabaaa
aaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Strength]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 4 TEX
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3, fragment.texcoord[4], texture[0], 2D;
TEX R2, fragment.texcoord[3], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[0].x;
END
# 8 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Strength]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 5 ALU, 4 TEX
dcl_2d s0
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r0, t4, s0
texld r1, t3, s0
texld r2, t2, s0
texld r3, t1, s0
add_pp r2, r3, r2
add_pp r1, r2, r1
add_pp r0, r1, r0
mul_pp r0, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_Strength]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmhbdcccjjonlfepjomobdimgkfckamibabaaaaaakaacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciaabaaaa
eaaaaaaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
pccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_Strength]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedglkhkeelglchcehfbhegambjefdmcmcdabaaaaaalaadaaaaaeaaaaaa
daaaaaaadmabaaaameacaaaahmadaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
naaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaaiaacaacdlabpaaaaacaaaaaaiaadaacdlabpaaaaacaaaaaaiaaeaacdla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaecaaaaad
abaaapiaacaaoelaaaaioekaecaaaaadacaaapiaadaaoelaaaaioekaecaaaaad
adaaapiaaeaaoelaaaaioekaacaaaaadaaaacpiaaaaaoeiaabaaoeiaacaaaaad
aaaacpiaacaaoeiaaaaaoeiaacaaaaadaaaacpiaadaaoeiaaaaaoeiaafaaaaad
aaaacpiaaaaaoeiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
iaabaaaaeaaaaaaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}