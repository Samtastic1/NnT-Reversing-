Shader "JAW/FX/LightningArc" {
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Vector 5 [arcColor]
Float 6 [arcIntensity]
Vector 7 [viewDirection]
Float 8 [strokeTime]
Vector 9 [targetDelta]
Float 10 [arcWidth]
"3.0-!!ARBvp1.0
# 28 ALU
PARAM c[11] = { { 0, 0.5, 2 },
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
MAD R0.xyz, R0, c[8].x, vertex.attrib[14];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R0.zxyw, c[7].yzxw;
MAD R0.xyz, R0.yzxw, c[7].zxyw, -R1;
DP3 R0.w, R0, R0;
ADD R1.x, vertex.color.y, -c[0].y;
MUL R2.x, R1, c[0].z;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R2.x;
MOV R0.w, c[0].x;
MUL R0.xyz, R0, c[10].x;
ADD R0, vertex.position, R0;
MAD R1, vertex.texcoord[1].y, c[9], R0;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
MAD R0, R0, c[8].x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.color, c[5];
MOV result.texcoord[0].y, R2.x;
MUL result.texcoord[0].x, vertex.color, c[6];
END
# 28 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 4 [arcColor]
Float 5 [arcIntensity]
Vector 6 [viewDirection]
Float 7 [strokeTime]
Vector 8 [targetDelta]
Float 9 [arcWidth]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
def c10, 0.00000000, -0.50000000, 2.00000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.z, v4.x
mov r0.xy, v3
mad r0.xyz, r0, c7.x, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r1.xyz, r0.zxyw, c6.yzxw
mad r0.xyz, r0.yzxw, c6.zxyw, -r1
dp3 r0.w, r0, r0
add r1.x, v5.y, c10.y
mul r2.x, r1, c10.z
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r0.xyz, r0, r2.x
mov r0.w, c10.x
mul r0.xyz, r0, c9.x
add r0, v0, r0
mad r1, v4.y, c8, r0
mov r0.xyz, v1
mov r0.w, c10.x
mad r0, r0, c7.x, r1
dp4 o0.w, r0, c3
dp4 o0.z, r0, c2
dp4 o0.y, r0, c1
dp4 o0.x, r0, c0
mov o1, c4
mov o2.y, r2.x
mul o2.x, v5, c5
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 16 [arcColor]
Float 32 [arcIntensity]
Vector 48 [viewDirection]
Float 64 [strokeTime]
Vector 80 [targetDelta]
Float 96 [arcWidth]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjggdnoimhipimcbgfleginibepgnencnabaaaaaafiafaaaaadaaaaaa
cmaaaaaapeaaaaaagiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoeh
efeofeaafeeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaaddcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacacaaaaaadgaaaaafgcaabaaaaaaaaaaaagbbbaaa
adaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaaaeaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaacgbjbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
jgiecaaaaaaaaaaaadaaaaaadcaaaaalhcaabaaaaaaaaaaacgajbaaaaaaaaaaa
cgijcaaaaaaaaaaaadaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaabkbabaaaafaaaaaaabeaaaaaaaaaaalp
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egbobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaafaaaaaa
fgbfbaaaaeaaaaaaegaobaaaaaaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaabaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaabaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaagpccabaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaaibccabaaaacaaaaaaakbabaaa
afaaaaaaakiacaaaaaaaaaaaacaaaaaadcaaaaajcccabaaaacaaaaaabkbabaaa
afaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [arcColor]
"3.0-!!ARBfp1.0
# 5 ALU, 0 TEX
PARAM c[2] = { program.local[0],
		{ 1, 8 } };
TEMP R0;
MAD R0.x, -fragment.texcoord[0].y, fragment.texcoord[0].y, c[1];
MUL R0.x, R0, fragment.texcoord[0];
MUL R0.yzw, R0.x, c[0].xxyz;
MUL result.color.xyz, R0.yzww, c[1].y;
MUL result.color.w, R0.x, fragment.color.primary;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [arcColor]
"ps_3_0
; 5 ALU
def c1, 1.00000000, 8.00000000, 0, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
mad r0.x, -v1.y, v1.y, c1
mul r0.x, r0, v1
mul r0.yzw, r0.x, c0.xxyz
mul oC0.xyz, r0.yzww, c1.y
mul oC0.w, r0.x, v0
"
}
SubProgram "d3d11 " {
ConstBuffer "$Globals" 112
Vector 16 [arcColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfogfkgffabgblnojjiaefioebakoeganabaaaaaammabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaaaaaaaeaaaaaaa
dmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
dcaaaaakbcaabaaaaaaaaaaabkbabaiaebaaaaaaacaaaaaabkbabaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakbabaaa
acaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaaaaaaaaebaaaaaaeb
aaaaaaebaaaaaaaadoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}