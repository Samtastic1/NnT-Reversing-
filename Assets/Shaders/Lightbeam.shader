Shader "Lightbeam/Lightbeam" {
Properties {
 _Color ("Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Width ("Width", Float) = 8.71
 _Tweak ("Tweak", Float) = 0.65
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="True" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="True" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Float 16 [_Width]
Float 17 [_Tweak]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[18] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.w, c[0].x;
MOV R1.xyz, c[13];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[15].w, -vertex.position;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP3 R0.w, R0, vertex.normal;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
MUL R1.xyz, vertex.attrib[14].w, R1;
DP3 R1.x, R0, R1;
DP3 R0.z, vertex.attrib[14], R0;
DP4 R1.w, vertex.position, c[8];
ADD R0.w, R0, c[17].x;
MUL R0.w, R0, c[16].x;
RSQ R2.x, R0.w;
MAD result.texcoord[1].xz, R0.z, R2.x, c[0].y;
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MAD result.texcoord[1].w, R2.x, R1.x, c[0].y;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.texcoord[1].y, vertex.texcoord[0];
MOV result.texcoord[2].z, -R0.x;
MOV result.texcoord[2].w, R1;
END
# 34 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Float 16 [_Width]
Float 17 [_Tweak]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c18.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c15.w, -v0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
dp3 r0.w, r1, v2
dp4 r1.w, v0, c7
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r2
mul r0.xyz, v1.w, r0
dp3 r0.x, r1, r0
add r0.w, r0, c17.x
mul r0.w, r0, c16.x
rsq r0.z, r0.w
mad o1.w, r0.z, r0.x, c18.y
dp3 r2.x, v1, r1
mad o1.xz, r2.x, r0.z, c18.y
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.y
mul r1.y, r1, c13.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c14.zwzw, r1
mov o1.y, v3
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 48
Float 32 [_Width]
Float 36 [_Tweak]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbbicmaeaogdbiklcfmjfkhcejaggioehabaaaaaagmagaaaaadaaaaaa
cmaaaaaamaaaaaaaeiabaaaaejfdeheoimaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapacaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcbmafaaaaeaaaabaaehabaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaadccbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaacaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaakfccabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahiccabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpdgaaaaafcccabaaaacaaaaaabkbabaaaadaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
# 7 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0.2 } };
TEMP R0;
TEX R0.y, fragment.texcoord[1].zwzw, texture[0], 2D;
TEX R0.x, fragment.texcoord[1], texture[0], 2D;
MUL R0.x, R0, R0.y;
MUL_SAT R0.y, fragment.texcoord[2].z, c[1].x;
MUL R0.x, R0, c[0].w;
MOV result.color.xyz, c[0];
MUL result.color.w, R0.x, R0.y;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 5 ALU, 2 TEX
dcl_2d s0
def c1, 0.20000000, 0, 0, 0
dcl_texcoord1 v0
dcl_texcoord2 v1.xyz
texld r0.y, v0.zwzw, s0
texld r0.x, v0, s0
mul_pp r0.x, r0, r0.y
mul_sat r0.y, v1.z, c1.x
mul_pp r0.x, r0, c0.w
mov_pp oC0.xyz, c0
mul_pp oC0.w, r0.x, r0.y
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeccnipeekigobcobefdjfmndmgeackababaaaaaaciacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaeaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdiabaaaaeaaaaaaaeoaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadecbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaamnmmemdodiaaaaahiccabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadoaaaaab"
}
}
 }
}
}