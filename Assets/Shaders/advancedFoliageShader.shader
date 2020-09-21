Shader "ats advanced foliage shader" {
Properties {
 _Color ("Shininess(R) Edge fluttering(G) 2nd Bending (B) 1st Bending(A)", Color) = (1,1,1,1)
 _TranslucencyColor ("Translucency Color", Color) = (0.73,0.85,0.41,1)
 _Cutoff ("Alpha cutoff", Range(0,1)) = 0.3
 _TranslucencyViewDependency ("View dependency", Range(0,1)) = 0.7
 _ShadowStrength ("Shadow Strength", Range(0,1)) = 0.8
 _ShadowOffsetScale ("Shadow Offset Scale", Float) = 1
 _MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
 _BumpTransSpecMap ("Normal (GA) Trans(R) Spec(B)", 2D) = "bump" {}
 _Scale ("Scale", Vector) = (1,1,1,1)
 _SquashAmount ("Squash", Float) = 1
}
SubShader { 
 LOD 200
 Tags { "IGNOREPROJECTOR"="True" "RenderType"="AtsFoliage" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "IGNOREPROJECTOR"="True" "RenderType"="AtsFoliage" }
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_Wind]
Vector 25 [_MainTex_ST]
"!!ARBvp1.0
# 81 ALU
PARAM c[28] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..25],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R0.x, c[0];
DP3 R0.w, R0.x, c[8];
ADD R0.x, vertex.color, R0.w;
ADD R0.z, vertex.color.y, R0.x;
MOV R0.y, R0.x;
ADD R1.xy, vertex.position.xzzw, c[13].y;
DP3 R0.x, vertex.position, R0.z;
ADD R0.xy, R1, R0;
MUL R1, R0.xxyy, c[26];
FRC R1, R1;
MAD R1, R1, c[0].y, c[0].z;
FRC R1, R1;
MAD R1, R1, c[0].y, -c[0].x;
ABS R2, R1;
MAD R1, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R1, R2, R1;
ADD R1.xy, R1.xzzw, R1.ywzw;
MUL R0.xyz, R1.y, c[24];
MUL R1.zw, vertex.color.xyyz, c[27].xyzx;
SLT R2.xy, c[27].y, vertex.normal.xzzw;
SLT R2.zw, vertex.normal.xyxz, c[27].y;
ADD R2.zw, R2.xyxy, -R2;
MUL R2.xy, R1.z, vertex.normal.xzzw;
MUL R2.xz, R2.xyyw, R2.zyww;
MOV R2.y, R1.w;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R1.xyxw, R2, R0;
MAD R4.xyz, R0, c[24].w, vertex.position;
DP3 R0.y, vertex.attrib[14], vertex.attrib[14];
RSQ R0.y, R0.y;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, vertex.normal;
MUL R3.xyz, R0.y, vertex.attrib[14];
MUL R0.xyz, vertex.color.z, c[24];
MAD R0.xyz, R0, R0.w, R4;
MOV R0.w, vertex.position;
MUL R1.xyz, R2.zxyw, R3.yzxw;
MAD R4.xyz, R2.yzxw, R3.zxyw, -R1;
MOV R1.w, c[0].x;
MOV R1.xyz, c[14];
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV R0.w, c[0].x;
DP4 R5.z, R1, c[11];
DP4 R5.y, R1, c[10];
DP4 R5.x, R1, c[9];
MAD R5.xyz, R5, c[23].w, -R0;
MUL R1.xyz, R2, c[23].w;
DP3 R2.w, R1, c[6];
MUL R4.xyz, R4, vertex.attrib[14].w;
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R6.z, R0, c[18];
DP4 R6.y, R0, c[17];
DP4 R6.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
MUL R1.xyz, R0.w, c[22];
ADD R0.xyz, R6, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R0, c[15];
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 result.texcoord[3].y, R4, R5;
DP3 result.texcoord[3].z, R2, R5;
DP3 result.texcoord[3].x, R3, R5;
DP3 result.texcoord[1].y, R1, R4;
DP3 result.texcoord[1].z, R2, R1;
DP3 result.texcoord[1].x, R1, R3;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
END
# 81 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
Vector 23 [_Wind]
Vector 24 [_MainTex_ST]
"vs_2_0
; 86 ALU
def c25, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c26, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c27, 2.00000000, 3.00000000, 0.22500001, 0.10000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.w, c25.x, r0
add r0.y, v5.x, r0.w
add r0.x, v5.y, r0.y
add r1.xy, v0.xzzw, c12.y
dp3 r0.x, v0, r0.x
add r0.xy, r1, r0
mul r1, r0.xxyy, c26
frc r1, r1
mad r1, r1, c25.y, c25.z
frc r1, r1
mad r1, r1, c25.y, c25.w
abs r2, r1
mad r1, -r2, c27.x, c27.y
mul r2, r2, r2
mul r1, r2, r1
add r1.xy, r1.xzzw, r1.ywzw
mul r0.xyz, r1.y, c23
mul r1.z, v5.y, c27.w
mul r1.zw, r1.z, v2.xyxz
slt r2.zw, v2.xyxz, -v2.xyxz
slt r2.xy, -v2.xzzw, v2.xzzw
sub r2.xy, r2, r2.zwzw
mul r2.xz, r1.zyww, r2.xyyw
mov r1.w, c25.x
mul r2.y, v5.z, c27.z
mul r0.xyz, v5.z, r0
mad r0.xyz, r1.xyxw, r2, r0
mad r4.xyz, r0, c23.w, v0
dp3 r0.y, v1, v1
rsq r0.y, r0.y
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r2.xyz, r0.x, v2
mul r3.xyz, r0.y, v1
mul r0.xyz, v5.z, c23
mad r0.xyz, r0, r0.w, r4
mov r0.w, v0
mul r1.xyz, r2.zxyw, r3.yzxw
mad r4.xyz, r2.yzxw, r3.zxyw, -r1
mov r1.xyz, c13
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov r0.w, c25.x
dp4 r5.z, r1, c10
dp4 r5.y, r1, c9
dp4 r5.x, r1, c8
mad r5.xyz, r5, c22.w, -r0
mul r1.xyz, r2, c22.w
dp3 r2.w, r1, c5
mul r4.xyz, r4, v1.w
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
dp4 r6.z, r0, c17
dp4 r6.y, r0, c16
dp4 r6.x, r0, c15
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp3 oT3.y, r4, r5
dp4 r0.z, r1, c20
dp4 r0.y, r1, c19
dp4 r0.x, r1, c18
mul r1.xyz, r0.w, c21
add r0.xyz, r6, r0
add oT2.xyz, r0, r1
dp3 oT3.z, r2, r5
dp3 oT3.x, r3, r5
mov r0, c10
dp4 r5.z, c14, r0
mov r1, c8
mov r0, c9
dp4 r5.x, c14, r1
dp4 r5.y, c14, r0
dp3 oT1.y, r5, r4
dp3 oT1.z, r2, r5
dp3 oT1.x, r5, r3
mov oD0, v5
mad oT0.xy, v3, c24, c24.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfpcnfgedkmopcbhbflhlmcmnjmmheilbabaaaaaajiamaaaaadaaaaaa
cmaaaaaapeaaaaaalaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcoaakaaaaeaaaabaaliacaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaiaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaa
aeaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaa
diaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
adaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaafaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaafaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaafaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaafaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaagaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaahaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaaahaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaagaaaaaabbaaaaaiecaabaaaahaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaafaaaaaaegacbaaa
afaaaaaaegacbaaaahaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaafaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaa
baaaaaahbccabaaaafaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
eccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedoaghgekmhcaieemcacjdjnjhmlncbghoabaaaaaamibcaaaaaeaaaaaa
daaaaaaafmagaaaaeebbaaaaambcaaaaebgpgodjceagaaaaceagaaaaaaacpopp
jaafaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
abaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaaacaacgaaahaaagaa
aaaaaaaaadaaaaaaaeaaanaaaaaaaaaaadaaamaaadaabbaaaaaaaaaaadaabaaa
afaabeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapkamnmmpmdpamaceldp
aaaamadomlkbefdofbaaaaafbkaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialp
fbaaaaafblaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoeja
acaaoekaacaaookaabaaaaacaaaaapiaafaaoekaafaaaaadabaaahiaaaaaffia
bfaaoekaaeaaaaaeabaaahiabeaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bgaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaappiaaaaaoeia
ceaaaaacabaaahiaabaaoejaaiaaaaadacaaaboaabaaoeiaaaaaoeiaceaaaaac
acaaahiaacaaoejaafaaaaadadaaahiaabaamjiaacaanciaaeaaaaaeadaaahia
acaamjiaabaanciaadaaoeibafaaaaadadaaahiaadaaoeiaabaappjaaiaaaaad
acaaacoaadaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeiaaaaaoeiaabaaaaac
aaaaabiabbaappkaabaaaaacaaaaaciabcaappkaabaaaaacaaaaaeiabdaappka
aiaaaaadaaaaabiaaaaaoeiabkaaaakaacaaaaadaeaaaciaaaaaaaiaafaaaaja
acaaaaadaaaaaciaaeaaffiaafaaffjaaiaaaaadaeaaabiaaaaaoejaaaaaffia
acaaaaadafaaapiaaaaakajaadaaffkaacaaaaadaeaaapiaaeaafaiaafaaoeia
afaaaaadaeaaapiaaeaaoeiabjaaoekabdaaaaacaeaaapiaaeaaoeiaaeaaaaae
aeaaapiaaeaaoeiabkaaffkabkaakkkabdaaaaacaeaaapiaaeaaoeiaaeaaaaae
aeaaapiaaeaaoeiabkaaffkabkaappkacdaaaaacaeaaapiaaeaaoeiaafaaaaad
afaaapiaaeaaoeiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiablaaaakbblaaffka
afaaaaadaeaaapiaaeaaoeiaafaaoeiaacaaaaadaaaaaoiaaeaaheiaaeaacaia
afaaaaadaeaaahiaaaaakkiaabaaoekaafaaaaadaeaaahiaaeaaoeiaafaakkja
amaaaaadafaaadiaacaaoijbacaaoijaamaaaaadafaaamiaacaaiejaacaaiejb
acaaaaadafaaadiaafaaooibafaaoeiaafaaaaadabaaaiiaafaaffjablaakkka
afaaaaadafaaamiaabaappiaacaaiejaafaaaaadafaaafiaafaaneiaafaapgia
afaaaaadafaaaciaafaakkjablaappkaaeaaaaaeaaaaaoiaaaaaoeiaafaajaia
aeaajaiaaeaaaaaeaaaaaoiaaaaaoeiaabaappkaaaaajajaafaaaaadaeaaahia
afaakkjaabaaoekaaeaaaaaeaaaaahiaaeaaoeiaaaaaaaiaaaaapjiaabaaaaac
aeaaahiaaeaaoekaafaaaaadafaaahiaaeaaffiabfaaoekaaeaaaaaeaeaaalia
beaakekaaeaaaaiaafaakeiaaeaaaaaeaeaaahiabgaaoekaaeaakkiaaeaapeia
acaaaaadaeaaahiaaeaaoeiabhaaoekaaeaaaaaeaeaaahiaaeaaoeiabiaappka
aaaaoeibaiaaaaadaeaaaboaabaaoeiaaeaaoeiaaiaaaaadaeaaacoaadaaoeia
aeaaoeiaaiaaaaadaeaaaeoaacaaoeiaaeaaoeiaafaaaaadabaaahiaacaaoeia
biaappkaafaaaaadacaaahiaabaaffiabcaaoekaaeaaaaaeabaaaliabbaakeka
abaaaaiaacaakeiaaeaaaaaeabaaahiabdaaoekaabaakkiaabaapeiaabaaaaac
abaaaiiabkaaaakaajaaaaadacaaabiaagaaoekaabaaoeiaajaaaaadacaaacia
ahaaoekaabaaoeiaajaaaaadacaaaeiaaiaaoekaabaaoeiaafaaaaadadaaapia
abaacjiaabaakeiaajaaaaadaeaaabiaajaaoekaadaaoeiaajaaaaadaeaaacia
akaaoekaadaaoeiaajaaaaadaeaaaeiaalaaoekaadaaoeiaacaaaaadacaaahia
acaaoeiaaeaaoeiaafaaaaadaaaaaiiaabaaffiaabaaffiaaeaaaaaeaaaaaiia
abaaaaiaabaaaaiaaaaappibaeaaaaaeadaaahoaamaaoekaaaaappiaacaaoeia
afaaaaadabaaapiaaaaaffiaaoaaoekaaeaaaaaeabaaapiaanaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapia
baaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaafaaoejappppaaaafdeieefc
oaakaaaaeaaaabaaliacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
pcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaiaaaaaadgaaaaag
bcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaa
dkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaa
aoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaa
akbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaa
afaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaa
aaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamado
mlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaia
ibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaak
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaa
acaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
diaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaa
ghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaa
acaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaa
adaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadgaaaaafpccabaaaacaaaaaa
egbobaaaafaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaa
adaaaaaadcaaaaakhcaabaaaaeaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaa
egacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
pgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaadaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaafaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
afaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaagaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaahaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaagaaaaaabbaaaaai
ccaabaaaahaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaagaaaaaabbaaaaai
ecaabaaaahaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaagaaaaaaaaaaaaah
hcaabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaahaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
afaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaaheccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_Time]
Vector 15 [_Wind]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[20] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..17],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[13].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[18];
FRC R0, R0;
MUL R0, R0, c[19].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[19].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[19].x, c[19].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[15];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[19].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[15].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[15];
MOV R0.w, vertex.position;
MAD R0.xyz, R0, R2.x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 41 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_Time]
Vector 13 [_Wind]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"vs_2_0
; 42 ALU
def c16, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c17, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c18, 2.00000000, 3.00000000, 0.10000000, 0.22500001
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c16.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c12.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c17
frc r0, r0
mad r0, r0, c16.y, c16.z
frc r0, r0
mad r0, r0, c16.y, c16.w
abs r0, r0
mad r1, -r0, c18.x, c18.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c13
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c18.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c18.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c13.w, v0
mul r0.xyz, v5.z, c13
mov r0.w, v0
mad r0.xyz, r0, r2.x, r1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov oD0, v5
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 48 [_Wind]
Vector 112 [unity_LightmapST]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddioaidhbodffppogmkiehmncfilbahcfabaaaaaafeahaaaaadaaaaaa
cmaaaaaapeaaaaaaiaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcmmafaaaaeaaaabaahdabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaa
aaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaaaoaaaaaa
baaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaa
afaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaai
pcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdo
bkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialp
diaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaa
abaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaa
dbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaa
ogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaak
fcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdo
aaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaa
diaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaaj
ocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaa
dcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaa
agbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 48 [_Wind]
Vector 112 [unity_LightmapST]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedmgkgbbchnhljbicecoioddmefhdlpoeiabaaaaaapaakaaaaaeaaaaaa
daaaaaaamiadaaaajmajaaaageakaaaaebgpgodjjaadaaaajaadaaaaaaacpopp
cmadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaa
acaaaaaaaeaaafaaaaaaaaaaacaaamaaadaaajaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafamaaapkamnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafanaaapka
aaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaafaoaaapkaaaaaaaeaaaaaeaea
mnmmmmdnghggggdobpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoekaadaaookaaeaaaaaeaaaaamoa
aeaabejaacaabekaacaalekaabaaaaacaaaaabiaajaappkaabaaaaacaaaaacia
akaappkaabaaaaacaaaaaeiaalaappkaaiaaaaadaaaaabiaaaaaoeiaanaaaaka
acaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaabaaffiaafaaffja
aiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaadacaaapiaaaaakajaaeaaffka
acaaaaadabaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeiaamaaoeka
bdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaanaaffkaanaakkka
bdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaanaaffkaanaappka
cdaaaaacabaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeiaaeaaaaae
abaaapiaabaaoeiaaoaaaakbaoaaffkaafaaaaadabaaapiaabaaoeiaacaaoeia
acaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaadabaaahiaaaaakkiaabaaoeka
afaaaaadabaaahiaabaaoeiaafaakkjaamaaaaadacaaadiaacaaoijbacaaoija
amaaaaadacaaamiaacaaiejaacaaiejbacaaaaadacaaadiaacaaooibacaaoeia
afaaaaadabaaaiiaafaaffjaaoaakkkaafaaaaadacaaamiaabaappiaacaaieja
afaaaaadacaaafiaacaaneiaacaapgiaafaaaaadacaaaciaafaakkjaaoaappka
aeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaiaaeaaaaaeaaaaaoiaaaaaoeia
abaappkaaaaajajaafaaaaadabaaahiaafaakkjaabaaoekaaeaaaaaeaaaaahia
abaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaapiaaaaaffiaagaaoekaaeaaaaae
abaaapiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoa
afaaoejappppaaaafdeieefcmmafaaaaeaaaabaahdabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacaeaaaaaa
dgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
aaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaa
acaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaa
bkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaa
aaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldp
aaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaa
egaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaa
dbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
igbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaia
ebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdn
aaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaa
agbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaa
acaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaa
agajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaa
aaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaa
afaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahafaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaahnaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_Time]
Vector 15 [_Wind]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[20] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..17],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[13].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[18];
FRC R0, R0;
MUL R0, R0, c[19].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[19].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[19].x, c[19].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[15];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[19].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[15].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[15];
MOV R0.w, vertex.position;
MAD R0.xyz, R0, R2.x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 41 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_Time]
Vector 13 [_Wind]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"vs_2_0
; 42 ALU
def c16, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c17, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c18, 2.00000000, 3.00000000, 0.10000000, 0.22500001
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c16.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c12.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c17
frc r0, r0
mad r0, r0, c16.y, c16.z
frc r0, r0
mad r0, r0, c16.y, c16.w
abs r0, r0
mad r1, -r0, c18.x, c18.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c13
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c18.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c18.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c13.w, v0
mul r0.xyz, v5.z, c13
mov r0.w, v0
mad r0.xyz, r0, r2.x, r1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov oD0, v5
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 48 [_Wind]
Vector 112 [unity_LightmapST]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddioaidhbodffppogmkiehmncfilbahcfabaaaaaafeahaaaaadaaaaaa
cmaaaaaapeaaaaaaiaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcmmafaaaaeaaaabaahdabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaa
aaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaaaoaaaaaa
baaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaa
afaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaai
pcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdo
bkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialp
diaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaa
abaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaa
dbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaa
ogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaak
fcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdo
aaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaa
diaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaaj
ocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaa
dcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaa
agbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 48 [_Wind]
Vector 112 [unity_LightmapST]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedmgkgbbchnhljbicecoioddmefhdlpoeiabaaaaaapaakaaaaaeaaaaaa
daaaaaaamiadaaaajmajaaaageakaaaaebgpgodjjaadaaaajaadaaaaaaacpopp
cmadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaa
acaaaaaaaeaaafaaaaaaaaaaacaaamaaadaaajaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafamaaapkamnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafanaaapka
aaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaafaoaaapkaaaaaaaeaaaaaeaea
mnmmmmdnghggggdobpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoekaadaaookaaeaaaaaeaaaaamoa
aeaabejaacaabekaacaalekaabaaaaacaaaaabiaajaappkaabaaaaacaaaaacia
akaappkaabaaaaacaaaaaeiaalaappkaaiaaaaadaaaaabiaaaaaoeiaanaaaaka
acaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaabaaffiaafaaffja
aiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaadacaaapiaaaaakajaaeaaffka
acaaaaadabaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeiaamaaoeka
bdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaanaaffkaanaakkka
bdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaanaaffkaanaappka
cdaaaaacabaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeiaaeaaaaae
abaaapiaabaaoeiaaoaaaakbaoaaffkaafaaaaadabaaapiaabaaoeiaacaaoeia
acaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaadabaaahiaaaaakkiaabaaoeka
afaaaaadabaaahiaabaaoeiaafaakkjaamaaaaadacaaadiaacaaoijbacaaoija
amaaaaadacaaamiaacaaiejaacaaiejbacaaaaadacaaadiaacaaooibacaaoeia
afaaaaadabaaaiiaafaaffjaaoaakkkaafaaaaadacaaamiaabaappiaacaaieja
afaaaaadacaaafiaacaaneiaacaapgiaafaaaaadacaaaciaafaakkjaaoaappka
aeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaiaaeaaaaaeaaaaaoiaaaaaoeia
abaappkaaaaajajaafaaaaadabaaahiaafaakkjaabaaoekaaeaaaaaeaaaaahia
abaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaapiaaaaaffiaagaaoekaaeaaaaae
abaaapiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoa
afaaoejappppaaaafdeieefcmmafaaaaeaaaabaahdabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacaeaaaaaa
dgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
aaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaa
acaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaa
bkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaa
aaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldp
aaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaa
egaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaa
dbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
igbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaia
ebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdn
aaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaa
agbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaa
acaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaa
agajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaa
aaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaa
afaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahafaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaahnaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_ProjectionParams]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [unity_Scale]
Vector 25 [_Wind]
Vector 26 [_MainTex_ST]
"!!ARBvp1.0
# 86 ALU
PARAM c[29] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..26],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R0.x, c[0];
DP3 R0.w, R0.x, c[8];
ADD R0.x, vertex.color, R0.w;
MOV R4.w, vertex.position;
ADD R0.z, vertex.color.y, R0.x;
MOV R0.y, R0.x;
ADD R1.xy, vertex.position.xzzw, c[13].y;
DP3 R0.x, vertex.position, R0.z;
ADD R0.xy, R1, R0;
MUL R1, R0.xxyy, c[27];
FRC R1, R1;
MAD R1, R1, c[0].y, c[0].z;
FRC R1, R1;
MAD R1, R1, c[0].y, -c[0].x;
ABS R2, R1;
MAD R1, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R1, R2, R1;
ADD R1.xy, R1.xzzw, R1.ywzw;
MUL R0.xyz, R1.y, c[25];
MUL R1.zw, vertex.color.xyyz, c[28].xyzx;
SLT R2.xy, c[28].y, vertex.normal.xzzw;
SLT R2.zw, vertex.normal.xyxz, c[28].y;
ADD R2.zw, R2.xyxy, -R2;
MUL R2.xy, R1.z, vertex.normal.xzzw;
MUL R2.xz, R2.xyyw, R2.zyww;
MOV R2.y, R1.w;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R1.xyxw, R2, R0;
MAD R1.xyz, R0, c[25].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[25];
MAD R4.xyz, R0, R0.w, R1;
DP4 R0.w, R4, c[4];
DP4 R0.z, R4, c[3];
DP4 R0.x, R4, c[1];
DP4 R0.y, R4, c[2];
MUL R1.xyz, R0.xyww, c[28].w;
MOV result.position, R0;
MUL R1.y, R1, c[15].x;
MOV result.texcoord[4].zw, R0;
DP3 R0.y, vertex.attrib[14], vertex.attrib[14];
RSQ R0.y, R0.y;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, vertex.normal;
MUL R3.xyz, R0.y, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MUL R1.xyz, R2.zxyw, R3.yzxw;
MAD R0.xyz, R2.yzxw, R3.zxyw, -R1;
MOV R1.w, c[0].x;
MOV R1.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R5.z, R1, c[11];
DP4 R5.x, R1, c[9];
DP4 R5.y, R1, c[10];
MAD R5.xyz, R5, c[24].w, -R4;
MUL R4.xyz, R0, vertex.attrib[14].w;
MUL R1.xyz, R2, c[24].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R6.z, R0, c[19];
DP4 R6.y, R0, c[18];
DP4 R6.x, R0, c[17];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[22];
DP4 R0.y, R1, c[21];
DP4 R0.x, R1, c[20];
MUL R1.xyz, R0.w, c[23];
ADD R0.xyz, R6, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R0, c[16];
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 result.texcoord[3].y, R4, R5;
DP3 result.texcoord[3].z, R2, R5;
DP3 result.texcoord[3].x, R3, R5;
DP3 result.texcoord[1].y, R1, R4;
DP3 result.texcoord[1].z, R2, R1;
DP3 result.texcoord[1].x, R1, R3;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 86 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [unity_Scale]
Vector 25 [_Wind]
Vector 26 [_MainTex_ST]
"vs_2_0
; 92 ALU
def c27, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c28, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c29, 2.00000000, 3.00000000, 0.22500001, 0.10000000
def c30, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c27.x, r0
add r0.y, v5.x, r0.x
add r0.z, v5.y, r0.y
mov r0.w, r0.y
mov r4.w, v0
add r1.xy, v0.xzzw, c12.y
dp3 r0.z, v0, r0.z
add r0.zw, r1.xyxy, r0
mul r1, r0.zzww, c28
frc r1, r1
mad r1, r1, c27.y, c27.z
frc r1, r1
mad r1, r1, c27.y, c27.w
abs r2, r1
mad r1, -r2, c29.x, c29.y
mul r2, r2, r2
mul r1, r2, r1
add r0.zw, r1.xyxz, r1.xyyw
mul r1.xyz, r0.w, c25
mov r1.w, c27.x
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r0.y, v5, c29.w
mul r2.xy, r0.y, v2.xzzw
mul r2.xz, r2.xyyw, r2.zyww
mul r2.y, v5.z, c29.z
mul r1.xyz, v5.z, r1
mad r1.xyz, r0.zwzw, r2, r1
mad r2.xyz, r1, c25.w, v0
mul r1.xyz, v5.z, c25
mad r4.xyz, r1, r0.x, r2
dp4 r0.w, r4, c3
dp4 r0.z, r4, c2
dp4 r0.x, r4, c0
dp4 r0.y, r4, c1
mul r1.xyz, r0.xyww, c30.x
mov oPos, r0
mul r1.y, r1, c14.x
mov oT4.zw, r0
dp3 r0.y, v1, v1
rsq r0.y, r0.y
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r2.xyz, r0.x, v2
mul r3.xyz, r0.y, v1
mad oT4.xy, r1.z, c15.zwzw, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r0.xyz, r2.yzxw, r3.zxyw, -r1
mov r1.xyz, c13
mov r0.w, c27.x
dp4 r5.z, r1, c10
dp4 r5.x, r1, c8
dp4 r5.y, r1, c9
mad r5.xyz, r5, c24.w, -r4
mul r4.xyz, r0, v1.w
mul r1.xyz, r2, c24.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
dp4 r6.z, r0, c19
dp4 r6.y, r0, c18
dp4 r6.x, r0, c17
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp3 oT3.y, r4, r5
dp4 r0.z, r1, c22
dp4 r0.y, r1, c21
dp4 r0.x, r1, c20
mul r1.xyz, r0.w, c23
add r0.xyz, r6, r0
add oT2.xyz, r0, r1
dp3 oT3.z, r2, r5
dp3 oT3.x, r3, r5
mov r0, c10
dp4 r5.z, c16, r0
mov r1, c8
mov r0, c9
dp4 r5.x, c16, r1
dp4 r5.y, c16, r0
dp3 oT1.y, r5, r4
dp3 oT1.z, r2, r5
dp3 oT1.x, r5, r3
mov oD0, v5
mad oT0.xy, v3, c26, c26.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedgjcgfoifbhoefeahhpifpjjbhehnmajnabaaaaaageanaaaaadaaaaaa
cmaaaaaapeaaaaaamiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheommaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaamfaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefcjealaaaaeaaaabaaofacaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacajaaaaaadgaaaaagbcaabaaaaaaaaaaa
dkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaak
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaa
acaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaaj
pcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaa
dcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaea
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaa
adaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaa
diaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaah
kcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaa
aaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaak
ocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaahhcaabaaaafaaaaaa
jgaebaaaadaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaa
aeaaaaaacgajbaaaadaaaaaaegacbaiaebaaaaaaafaaaaaadiaaaaahhcaabaaa
afaaaaaaegacbaaaafaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaeaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaacaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaa
acaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaagaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaahaaaaaajgacbaaaacaaaaaa
egakbaaaacaaaaaabbaaaaaibcaabaaaaiaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaahaaaaaabbaaaaaiccaabaaaaiaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaahaaaaaabbaaaaaiecaabaaaaiaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaahaaaaaaaaaaaaahhcaabaaaagaaaaaaegacbaaaagaaaaaaegacbaaa
aiaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaagaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaafaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
afaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaafmccabaaaagaaaaaakgaobaaa
abaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedlodekmakkoddhjlcpbflhopdiieaoaojabaaaaaaoabdaaaaaeaaaaaa
daaaaaaakiagaaaaeebcaaaaambdaaaaebgpgodjhaagaaaahaagaaaaaaacpopp
nmafaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaahaa
abaaabaaaaaaaaaaaaaaalaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
abaaaeaaacaaaeaaaaaaaaaaacaaaaaaabaaagaaaaaaaaaaacaacgaaahaaahaa
aaaaaaaaadaaaaaaaeaaaoaaaaaaaaaaadaaamaaadaabcaaaaaaaaaaadaabaaa
afaabfaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbkaaapkamnmmpmdpamaceldp
aaaamadomlkbefdofbaaaaafblaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialp
fbaaaaafbmaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoeja
acaaoekaacaaookaabaaaaacaaaaapiaagaaoekaafaaaaadabaaahiaaaaaffia
bgaaoekaaeaaaaaeabaaahiabfaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bhaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabiaaoekaaaaappiaaaaaoeia
ceaaaaacabaaahiaabaaoejaaiaaaaadacaaaboaabaaoeiaaaaaoeiaceaaaaac
acaaahiaacaaoejaafaaaaadadaaahiaabaamjiaacaanciaaeaaaaaeadaaahia
acaamjiaabaanciaadaaoeibafaaaaadadaaahiaadaaoeiaabaappjaaiaaaaad
acaaacoaadaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeiaaaaaoeiaabaaaaac
aaaaabiabcaappkaabaaaaacaaaaaciabdaappkaabaaaaacaaaaaeiabeaappka
aiaaaaadaaaaabiaaaaaoeiablaaaakaacaaaaadaeaaaciaaaaaaaiaafaaaaja
acaaaaadaaaaaciaaeaaffiaafaaffjaaiaaaaadaeaaabiaaaaaoejaaaaaffia
acaaaaadafaaapiaaaaakajaadaaffkaacaaaaadaeaaapiaaeaafaiaafaaoeia
afaaaaadaeaaapiaaeaaoeiabkaaoekabdaaaaacaeaaapiaaeaaoeiaaeaaaaae
aeaaapiaaeaaoeiablaaffkablaakkkabdaaaaacaeaaapiaaeaaoeiaaeaaaaae
aeaaapiaaeaaoeiablaaffkablaappkacdaaaaacaeaaapiaaeaaoeiaafaaaaad
afaaapiaaeaaoeiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiabmaaaakbbmaaffka
afaaaaadaeaaapiaaeaaoeiaafaaoeiaacaaaaadaaaaaoiaaeaaheiaaeaacaia
afaaaaadaeaaahiaaaaakkiaabaaoekaafaaaaadaeaaahiaaeaaoeiaafaakkja
amaaaaadafaaadiaacaaoijbacaaoijaamaaaaadafaaamiaacaaiejaacaaiejb
acaaaaadafaaadiaafaaooibafaaoeiaafaaaaadabaaaiiaafaaffjabmaakkka
afaaaaadafaaamiaabaappiaacaaiejaafaaaaadafaaafiaafaaneiaafaapgia
afaaaaadafaaaciaafaakkjabmaappkaaeaaaaaeaaaaaoiaaaaaoeiaafaajaia
aeaajaiaaeaaaaaeaaaaaoiaaaaaoeiaabaappkaaaaajajaafaaaaadaeaaahia
afaakkjaabaaoekaaeaaaaaeaaaaahiaaeaaoeiaaaaaaaiaaaaapjiaabaaaaac
aeaaahiaaeaaoekaafaaaaadafaaahiaaeaaffiabgaaoekaaeaaaaaeaeaaalia
bfaakekaaeaaaaiaafaakeiaaeaaaaaeaeaaahiabhaaoekaaeaakkiaaeaapeia
acaaaaadaeaaahiaaeaaoeiabiaaoekaaeaaaaaeaeaaahiaaeaaoeiabjaappka
aaaaoeibaiaaaaadaeaaaboaabaaoeiaaeaaoeiaaiaaaaadaeaaacoaadaaoeia
aeaaoeiaaiaaaaadaeaaaeoaacaaoeiaaeaaoeiaafaaaaadabaaahiaacaaoeia
bjaappkaafaaaaadacaaahiaabaaffiabdaaoekaaeaaaaaeabaaaliabcaakeka
abaaaaiaacaakeiaaeaaaaaeabaaahiabeaaoekaabaakkiaabaapeiaabaaaaac
abaaaiiablaaaakaajaaaaadacaaabiaahaaoekaabaaoeiaajaaaaadacaaacia
aiaaoekaabaaoeiaajaaaaadacaaaeiaajaaoekaabaaoeiaafaaaaadadaaapia
abaacjiaabaakeiaajaaaaadaeaaabiaakaaoekaadaaoeiaajaaaaadaeaaacia
alaaoekaadaaoeiaajaaaaadaeaaaeiaamaaoekaadaaoeiaacaaaaadacaaahia
acaaoeiaaeaaoeiaafaaaaadaaaaaiiaabaaffiaabaaffiaaeaaaaaeaaaaaiia
abaaaaiaabaaaaiaaaaappibaeaaaaaeadaaahoaanaaoekaaaaappiaacaaoeia
afaaaaadabaaapiaaaaaffiaapaaoekaaeaaaaaeabaaapiaaoaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapia
bbaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaad
abaaaiiaabaaaaiablaakkkbafaaaaadabaaafiaaaaapeiablaakkkbacaaaaad
afaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacafaaamoaaaaaoeiaabaaaaacabaaapoa
afaaoejappppaaaafdeieefcjealaaaaeaaaabaaofacaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacajaaaaaadgaaaaagbcaabaaaaaaaaaaa
dkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaak
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaa
acaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaaj
pcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaa
dcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaea
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaa
adaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaa
diaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaah
kcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaa
aaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaak
ocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaahhcaabaaaafaaaaaa
jgaebaaaadaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaa
aeaaaaaacgajbaaaadaaaaaaegacbaiaebaaaaaaafaaaaaadiaaaaahhcaabaaa
afaaaaaaegacbaaaafaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaeaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaacaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaa
acaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaagaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaahaaaaaajgacbaaaacaaaaaa
egakbaaaacaaaaaabbaaaaaibcaabaaaaiaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaahaaaaaabbaaaaaiccaabaaaaiaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaahaaaaaabbaaaaaiecaabaaaaiaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaahaaaaaaaaaaaaahhcaabaaaagaaaaaaegacbaaaagaaaaaaegacbaaa
aiaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaagaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaafaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
afaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaafmccabaaaagaaaaaakgaobaaa
abaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 16 [_Wind]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
"!!ARBvp1.0
# 46 ALU
PARAM c[21] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..18],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[13].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[19];
FRC R0, R0;
MUL R0, R0, c[20].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[20].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[20].x, c[20].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[16];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[20].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[16].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[16];
MAD R1.xyz, R0, R2.x, R1;
MOV R1.w, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[20].w;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 46 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_Wind]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 47 ALU
def c18, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c19, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c20, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c21, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c18.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c12.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c19
frc r0, r0
mad r0, r0, c18.y, c18.z
frc r0, r0
mad r0, r0, c18.y, c18.w
abs r0, r0
mad r1, -r0, c20.x, c20.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c15
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c20.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c20.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c15.w, v0
mul r0.xyz, v5.z, c15
mad r1.xyz, r0, r2.x, r1
mov r1.w, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c21.x
mul r2.y, r2, c13.x
mad oT2.xy, r2.z, c14.zwzw, r2
mov oPos, r0
mov oT2.zw, r0
mov oD0, v5
mad oT0.xy, v3, c17, c17.zwzw
mad oT1.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 112 [_Wind]
Vector 176 [unity_LightmapST]
Vector 192 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbhmpcfpklhbdcihccigifkcnicpkbnkoabaaaaaaaeaiaaaaadaaaaaa
cmaaaaaapeaaaaaajiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcgeagaaaa
eaaaabaajjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacaeaaaaaadgaaaaag
bcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaa
dkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaa
aoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaa
akbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaa
afaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaa
aaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamado
mlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaia
ibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaak
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaa
acaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
diaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaa
ghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaa
acaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaa
ahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaa
aaaaaaaaamaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadgaaaaafpccabaaaacaaaaaa
egbobaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 112 [_Wind]
Vector 176 [unity_LightmapST]
Vector 192 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefieceddichkiinibdleadmpfmdfdehfeopmecmabaaaaaapialaaaaaeaaaaaa
daaaaaaacaaeaaaaimakaaaafealaaaaebgpgodjoiadaaaaoiadaaaaaaacpopp
hiadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaahaa
abaaabaaaaaaaaaaaaaaalaaacaaacaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaaacaaamaaadaaakaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkamnmmpmdpamaceldpaaaamado
mlkbefdofbaaaaafaoaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaaf
apaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeaaaaamoaaeaabejaacaabekaacaalekaabaaaaacaaaaabia
akaappkaabaaaaacaaaaaciaalaappkaabaaaaacaaaaaeiaamaappkaaiaaaaad
aaaaabiaaaaaoeiaaoaaaakaacaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaad
aaaaaciaabaaffiaafaaffjaaiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaad
acaaapiaaaaakajaaeaaffkaacaaaaadabaaapiaabaafaiaacaaoeiaafaaaaad
abaaapiaabaaoeiaanaaoekabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaaoaaffkaaoaakkkabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaaoaaffkaaoaappkacdaaaaacabaaapiaabaaoeiaafaaaaadacaaapia
abaaoeiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaapaaaakbapaaffkaafaaaaad
abaaapiaabaaoeiaacaaoeiaacaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaad
abaaahiaaaaakkiaabaaoekaafaaaaadabaaahiaabaaoeiaafaakkjaamaaaaad
acaaadiaacaaoijbacaaoijaamaaaaadacaaamiaacaaiejaacaaiejbacaaaaad
acaaadiaacaaooibacaaoeiaafaaaaadabaaaiiaafaaffjaapaakkkaafaaaaad
acaaamiaabaappiaacaaiejaafaaaaadacaaafiaacaaneiaacaapgiaafaaaaad
acaaaciaafaakkjaapaappkaaeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaia
aeaaaaaeaaaaaoiaaaaaoeiaabaappkaaaaajajaafaaaaadabaaahiaafaakkja
abaaoekaaeaaaaaeaaaaahiaabaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaapia
aaaaffiaahaaoekaaeaaaaaeabaaapiaagaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaia
aoaakkkbafaaaaadabaaafiaaaaapeiaaoaakkkbacaaaaadacaaadoaabaakkia
abaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacabaaapoaafaaoejappppaaaa
fdeieefcgeagaaaaeaaaabaajjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
aeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaacaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaa
adaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
adaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
amaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
adaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 16 [_Wind]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
"!!ARBvp1.0
# 46 ALU
PARAM c[21] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..18],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[13].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[19];
FRC R0, R0;
MUL R0, R0, c[20].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[20].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[20].x, c[20].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[16];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[20].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[16].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[16];
MAD R1.xyz, R0, R2.x, R1;
MOV R1.w, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[20].w;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 46 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_Wind]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 47 ALU
def c18, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c19, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c20, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c21, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c18.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c12.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c19
frc r0, r0
mad r0, r0, c18.y, c18.z
frc r0, r0
mad r0, r0, c18.y, c18.w
abs r0, r0
mad r1, -r0, c20.x, c20.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c15
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c20.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c20.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c15.w, v0
mul r0.xyz, v5.z, c15
mad r1.xyz, r0, r2.x, r1
mov r1.w, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c21.x
mul r2.y, r2, c13.x
mad oT2.xy, r2.z, c14.zwzw, r2
mov oPos, r0
mov oT2.zw, r0
mov oD0, v5
mad oT0.xy, v3, c17, c17.zwzw
mad oT1.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 112 [_Wind]
Vector 176 [unity_LightmapST]
Vector 192 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbhmpcfpklhbdcihccigifkcnicpkbnkoabaaaaaaaeaiaaaaadaaaaaa
cmaaaaaapeaaaaaajiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcgeagaaaa
eaaaabaajjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacaeaaaaaadgaaaaag
bcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaa
dkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaa
aoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaa
akbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaa
afaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaa
aaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamado
mlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaia
ibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaak
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaa
acaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
diaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaa
ghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaa
acaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaa
ahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaa
aaaaaaaaamaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadgaaaaafpccabaaaacaaaaaa
egbobaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 112 [_Wind]
Vector 176 [unity_LightmapST]
Vector 192 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefieceddichkiinibdleadmpfmdfdehfeopmecmabaaaaaapialaaaaaeaaaaaa
daaaaaaacaaeaaaaimakaaaafealaaaaebgpgodjoiadaaaaoiadaaaaaaacpopp
hiadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaahaa
abaaabaaaaaaaaaaaaaaalaaacaaacaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaaacaaamaaadaaakaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkamnmmpmdpamaceldpaaaamado
mlkbefdofbaaaaafaoaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaaf
apaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeaaaaamoaaeaabejaacaabekaacaalekaabaaaaacaaaaabia
akaappkaabaaaaacaaaaaciaalaappkaabaaaaacaaaaaeiaamaappkaaiaaaaad
aaaaabiaaaaaoeiaaoaaaakaacaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaad
aaaaaciaabaaffiaafaaffjaaiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaad
acaaapiaaaaakajaaeaaffkaacaaaaadabaaapiaabaafaiaacaaoeiaafaaaaad
abaaapiaabaaoeiaanaaoekabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaaoaaffkaaoaakkkabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaaoaaffkaaoaappkacdaaaaacabaaapiaabaaoeiaafaaaaadacaaapia
abaaoeiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaapaaaakbapaaffkaafaaaaad
abaaapiaabaaoeiaacaaoeiaacaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaad
abaaahiaaaaakkiaabaaoekaafaaaaadabaaahiaabaaoeiaafaakkjaamaaaaad
acaaadiaacaaoijbacaaoijaamaaaaadacaaamiaacaaiejaacaaiejbacaaaaad
acaaadiaacaaooibacaaoeiaafaaaaadabaaaiiaafaaffjaapaakkkaafaaaaad
acaaamiaabaappiaacaaiejaafaaaaadacaaafiaacaaneiaacaapgiaafaaaaad
acaaaciaafaakkjaapaappkaaeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaia
aeaaaaaeaaaaaoiaaaaaoeiaabaappkaaaaajajaafaaaaadabaaahiaafaakkja
abaaoekaaeaaaaaeaaaaahiaabaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaapia
aaaaffiaahaaoekaaeaaaaaeabaaapiaagaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaia
aoaakkkbafaaaaadabaaafiaaaaapeiaaoaakkkbacaaaaadacaaadoaabaakkia
abaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacabaaapoaafaaoejappppaaaa
fdeieefcgeagaaaaeaaaabaajjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
aeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaacaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaa
adaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
adaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
amaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
adaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
Vector 32 [_Wind]
Vector 33 [_MainTex_ST]
"!!ARBvp1.0
# 111 ALU
PARAM c[36] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..33],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
MOV R0.x, c[0];
DP3 R0.x, R0.x, c[8];
ADD R0.y, vertex.color.x, R0.x;
ADD R0.z, vertex.color.y, R0.y;
ADD R1.xy, vertex.position.xzzw, c[13].y;
MOV R0.w, R0.y;
DP3 R0.z, vertex.position, R0.z;
ADD R0.zw, R1.xyxy, R0;
MUL R1, R0.zzww, c[34];
FRC R1, R1;
MAD R1, R1, c[0].y, c[0].z;
FRC R1, R1;
MAD R1, R1, c[0].y, -c[0].x;
ABS R2, R1;
MAD R1, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R1, R2, R1;
ADD R0.zw, R1.xyxz, R1.xyyw;
MUL R1.xyz, R0.w, c[32];
MOV R1.w, vertex.position;
MUL R2.xy, vertex.color.yzzw, c[35].zxzw;
SLT R2.zw, c[35].y, vertex.normal.xyxz;
SLT R3.xy, vertex.normal.xzzw, c[35].y;
ADD R3.xy, R2.zwzw, -R3;
MUL R2.zw, R2.x, vertex.normal.xyxz;
MUL R2.xz, R2.zyww, R3.xyyw;
MUL R1.xyz, vertex.color.z, R1;
MAD R1.xyz, R0.zwzw, R2, R1;
MAD R2.xyz, R1, c[32].w, vertex.position;
MUL R1.xyz, vertex.color.z, c[32];
MAD R1.xyz, R1, R0.x, R2;
DP4 R0.y, R1, c[6];
DP4 R0.x, R1, c[5];
ADD R3, -R0.y, c[17];
ADD R2, -R0.x, c[16];
MUL R0, R3, R3;
MAD R4, R2, R2, R0;
DP3 R5.x, vertex.normal, vertex.normal;
RSQ R0.x, R5.x;
MUL R6.xyz, R0.x, vertex.normal;
MUL R7.xyz, R6, c[31].w;
DP3 R6.w, R7, c[6];
DP4 R0.y, R1, c[7];
ADD R0, -R0.y, c[18];
MAD R4, R0, R0, R4;
DP3 R7.w, R7, c[5];
MUL R3, R6.w, R3;
MAD R2, R7.w, R2, R3;
DP3 R3.x, R7, c[7];
MAD R0, R3.x, R0, R2;
MUL R5, R4, c[19];
MOV R7.x, R6.w;
MOV R7.y, R3.x;
MOV R7.z, c[0].x;
RSQ R2.x, R4.x;
RSQ R2.y, R4.y;
RSQ R2.z, R4.z;
RSQ R2.w, R4.w;
MUL R0, R0, R2;
ADD R2, R5, c[0].x;
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[35].y;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[21];
MAD R2.xyz, R0.x, c[20], R2;
MAD R0.xyz, R0.z, c[22], R2;
MAD R2.xyz, R0.w, c[23], R0;
MUL R0, R7.wxyy, R7.xyyw;
DP4 R4.z, R0, c[29];
DP4 R4.x, R0, c[27];
DP4 R4.y, R0, c[28];
MUL R0.y, R6.w, R6.w;
DP3 R0.x, vertex.attrib[14], vertex.attrib[14];
MOV R2.w, c[0].x;
MAD R0.y, R7.w, R7.w, -R0;
DP4 R3.z, R7.wxyz, c[26];
DP4 R3.y, R7.wxyz, c[25];
DP4 R3.x, R7.wxyz, c[24];
ADD R3.xyz, R3, R4;
MUL R4.xyz, R0.y, c[30];
ADD R4.xyz, R3, R4;
ADD result.texcoord[2].xyz, R4, R2;
MOV R2.xyz, c[14];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, vertex.attrib[14];
MUL R3.xyz, R6.zxyw, R0.yzxw;
MAD R3.xyz, R6.yzxw, R0.zxyw, -R3;
MUL R3.xyz, R3, vertex.attrib[14].w;
DP4 R4.z, R2, c[11];
DP4 R4.x, R2, c[9];
DP4 R4.y, R2, c[10];
MAD R2.xyz, R4, c[31].w, -R1;
DP3 result.texcoord[3].y, R3, R2;
DP3 result.texcoord[3].z, R6, R2;
DP3 result.texcoord[3].x, R0, R2;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
MOV R1, c[15];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
DP3 result.texcoord[1].y, R2, R3;
DP3 result.texcoord[1].z, R6, R2;
DP3 result.texcoord[1].x, R2, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[33], c[33].zwzw;
END
# 111 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [unity_Scale]
Vector 31 [_Wind]
Vector 32 [_MainTex_ST]
"vs_2_0
; 118 ALU
def c33, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c34, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c35, 2.00000000, 3.00000000, 0.22500001, 0.10000000
def c36, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c33.x, r0
add r0.y, v5.x, r0.x
add r0.z, v5.y, r0.y
mov r0.w, r0.y
add r1.xy, v0.xzzw, c12.y
dp3 r0.z, v0, r0.z
add r0.zw, r1.xyxy, r0
mul r1, r0.zzww, c34
frc r1, r1
mad r1, r1, c33.y, c33.z
frc r1, r1
mad r1, r1, c33.y, c33.w
abs r2, r1
mad r1, -r2, c35.x, c35.y
mul r2, r2, r2
mul r1, r2, r1
add r0.zw, r1.xyxz, r1.xyyw
mul r1.xyz, r0.w, c31
mov r1.w, v0
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r0.y, v5, c35.w
mul r2.xy, r0.y, v2.xzzw
mul r2.xz, r2.xyyw, r2.zyww
mul r2.y, v5.z, c35.z
mul r1.xyz, v5.z, r1
mad r1.xyz, r0.zwzw, r2, r1
mad r2.xyz, r1, c31.w, v0
mul r1.xyz, v5.z, c31
mad r1.xyz, r1, r0.x, r2
dp4 r0.y, r1, c5
dp4 r0.x, r1, c4
add r3, -r0.y, c16
add r2, -r0.x, c15
mul r0, r3, r3
mad r4, r2, r2, r0
dp3 r5.x, v2, v2
rsq r0.x, r5.x
mul r6.xyz, r0.x, v2
mul r7.xyz, r6, c30.w
dp3 r6.w, r7, c5
dp4 r0.y, r1, c6
add r0, -r0.y, c17
mad r4, r0, r0, r4
dp3 r7.w, r7, c4
mul r3, r6.w, r3
mad r2, r7.w, r2, r3
dp3 r3.x, r7, c6
mad r0, r3.x, r0, r2
mul r5, r4, c18
mov r7.x, r6.w
mov r7.y, r3.x
mov r7.z, c33.x
rsq r2.x, r4.x
rsq r2.y, r4.y
rsq r2.z, r4.z
rsq r2.w, r4.w
mul r0, r0, r2
add r2, r5, c33.x
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c36.x
mul r0, r0, r2
mul r2.xyz, r0.y, c20
mad r2.xyz, r0.x, c19, r2
mad r0.xyz, r0.z, c21, r2
mad r2.xyz, r0.w, c22, r0
mul r0, r7.wxyy, r7.xyyw
dp4 r4.z, r0, c28
dp4 r4.x, r0, c26
dp4 r4.y, r0, c27
mul r0.y, r6.w, r6.w
dp3 r0.x, v1, v1
mov r2.w, c33.x
mad r0.y, r7.w, r7.w, -r0
dp4 r3.z, r7.wxyz, c25
dp4 r3.y, r7.wxyz, c24
dp4 r3.x, r7.wxyz, c23
add r3.xyz, r3, r4
mul r4.xyz, r0.y, c29
add r4.xyz, r3, r4
add oT2.xyz, r4, r2
mov r2.xyz, c13
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
mul r3.xyz, r6.zxyw, r0.yzxw
mad r3.xyz, r6.yzxw, r0.zxyw, -r3
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
mad r4.xyz, r4, c30.w, -r1
mul r2.xyz, r3, v1.w
dp3 oT3.y, r2, r4
dp3 oT3.z, r6, r4
dp3 oT3.x, r0, r4
mov r3, c8
dp4 r4.x, c14, r3
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
mov r1, c10
dp4 r4.z, c14, r1
mov r1, c9
dp4 r4.y, c14, r1
dp3 oT1.y, r4, r2
dp3 oT1.z, r6, r4
dp3 oT1.x, r4, r0
mov oD0, v5
mad oT0.xy, v3, c32, c32.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjfmflfpkhilegclpebepifbgnohnimpfabaaaaaaoiapaaaaadaaaaaa
cmaaaaaapeaaaaaalaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcdaaoaaaaeaaaabaaimadaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacalaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaa
aeaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaa
diaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaabaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaagaaaaaaegaobaaaafaaaaaa
egaobaaaafaaaaaaaaaaaaajpcaabaaaahaaaaaaagaabaiaebaaaaaaabaaaaaa
egiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaa
abaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaa
ahaaaaaaegaobaaaahaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaagaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaaagaaaaaadcaaaaanpcaabaaa
aiaaaaaaegaobaaaagaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpeeaaaaafpcaabaaaagaaaaaaegaobaaaagaaaaaa
aoaaaaakpcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaaiaaaaaadiaaaaaihcaabaaaajaaaaaaegacbaaaadaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaakaaaaaafgafbaaaajaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaajaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaajaaaaaaegaibaaaakaaaaaadcaaaaakhcaabaaaajaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaajaaaaaaegadbaaaajaaaaaadiaaaaahpcaabaaa
afaaaaaaegaobaaaafaaaaaafgafbaaaajaaaaaadcaaaaajpcaabaaaafaaaaaa
egaobaaaahaaaaaaagaabaaaajaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaabaaaaaakgakbaaaajaaaaaaegaobaaaafaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaagaaaaaaegaobaaaabaaaaaadeaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaaiaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaafaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaafaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaa
afaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
abaaaaaaegacbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaajaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaajaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaajaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaajaaaaaadiaaaaahpcaabaaaagaaaaaajgacbaaaajaaaaaaegakbaaa
ajaaaaaabbaaaaaibcaabaaaahaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
agaaaaaabbaaaaaiccaabaaaahaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
agaaaaaabbaaaaaiecaabaaaahaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
agaaaaaaaaaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaahaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaajaaaaaabkaabaaaajaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaaaajaaaaaaakaabaaaajaaaaaadkaabaiaebaaaaaa
aaaaaaaadcaaaaakhcaabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
aaaaaaaaegacbaaaafaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaa
egacbaaaafaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaafaaaaaaegacbaaaadaaaaaa
egacbaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaeaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedfooniofmmjgdocedhainklledhhplfcgabaaaaaacibiaaaaaeaaaaaa
daaaaaaagmaiaaaakebgaaaagmbhaaaaebgpgodjdeaiaaaadeaiaaaaaaacpopp
kaahaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
abaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaaacaaacaaaiaaagaa
aaaaaaaaacaacgaaahaaaoaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaa
ajaabjaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafccaaapkamnmmpmdpamaceldp
aaaamadomlkbefdofbaaaaafcdaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialp
fbaaaaafceaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdofbaaaaafcfaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaooka
abaaaaacaaaaapiaafaaoekaafaaaaadabaaahiaaaaaffiaboaaoekaaeaaaaae
abaaahiabnaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabpaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiacaaaoekaaaaappiaaaaaoeiaceaaaaacabaaahia
abaaoejaaiaaaaadacaaaboaabaaoeiaaaaaoeiaceaaaaacacaaahiaacaaoeja
afaaaaadadaaahiaabaamjiaacaanciaaeaaaaaeadaaahiaacaamjiaabaancia
adaaoeibafaaaaadadaaahiaadaaoeiaabaappjaaiaaaaadacaaacoaadaaoeia
aaaaoeiaaiaaaaadacaaaeoaacaaoeiaaaaaoeiaabaaaaacaaaaahiaaeaaoeka
afaaaaadaeaaahiaaaaaffiaboaaoekaaeaaaaaeaaaaaliabnaakekaaaaaaaia
aeaakeiaaeaaaaaeaaaaahiabpaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahia
aaaaoeiacaaaoekaabaaaaacaeaaabiabjaappkaabaaaaacaeaaaciabkaappka
abaaaaacaeaaaeiablaappkaaiaaaaadaaaaaiiaaeaaoeiacdaaaakaacaaaaad
aeaaaciaaaaappiaafaaaajaacaaaaadabaaaiiaaeaaffiaafaaffjaaiaaaaad
aeaaabiaaaaaoejaabaappiaacaaaaadafaaapiaaaaakajaadaaffkaacaaaaad
aeaaapiaaeaafaiaafaaoeiaafaaaaadaeaaapiaaeaaoeiaccaaoekabdaaaaac
aeaaapiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiacdaaffkacdaakkkabdaaaaac
aeaaapiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiacdaaffkacdaappkacdaaaaac
aeaaapiaaeaaoeiaafaaaaadafaaapiaaeaaoeiaaeaaoeiaaeaaaaaeaeaaapia
aeaaoeiaceaaaakbceaaffkaafaaaaadaeaaapiaaeaaoeiaafaaoeiaacaaaaad
aeaaahiaaeaanniaaeaamiiaafaaaaadafaaahiaaeaaffiaabaaoekaafaaaaad
afaaahiaafaaoeiaafaakkjaamaaaaadagaaadiaacaaoijbacaaoijaamaaaaad
agaaamiaacaaiejaacaaiejbacaaaaadagaaadiaagaaooibagaaoeiaafaaaaad
abaaaiiaafaaffjaceaakkkaafaaaaadagaaamiaabaappiaacaaiejaafaaaaad
agaaafiaagaaneiaagaapgiaafaaaaadagaaaciaafaakkjaceaappkaaeaaaaae
aeaaahiaaeaaoeiaagaaoeiaafaaoeiaaeaaaaaeaeaaahiaaeaaoeiaabaappka
aaaaoejaafaaaaadafaaahiaafaakkjaabaaoekaaeaaaaaeaeaaahiaafaaoeia
aaaappiaaeaaoeiaaeaaaaaeaaaaahiaaaaaoeiacbaappkaaeaaoeibaiaaaaad
aeaaaboaabaaoeiaaaaaoeiaaiaaaaadaeaaacoaadaaoeiaaaaaoeiaaiaaaaad
aeaaaeoaacaaoeiaaaaaoeiaafaaaaadaaaaahiaacaaoeiacbaappkaafaaaaad
abaaahiaaaaaffiabkaaoekaaeaaaaaeaaaaaliabjaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahiablaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiacdaaaaka
ajaaaaadabaaabiaaoaaoekaaaaaoeiaajaaaaadabaaaciaapaaoekaaaaaoeia
ajaaaaadabaaaeiabaaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeia
ajaaaaadadaaabiabbaaoekaacaaoeiaajaaaaadadaaaciabcaaoekaacaaoeia
ajaaaaadadaaaeiabdaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeia
afaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaia
aaaappibaeaaaaaeabaaahiabeaaoekaaaaappiaabaaoeiaafaaaaadacaaahia
aeaaffiabkaaoekaaeaaaaaeacaaahiabjaaoekaaeaaaaiaacaaoeiaaeaaaaae
acaaahiablaaoekaaeaakkiaacaaoeiaaeaaaaaeacaaahiabmaaoekaaaaappja
acaaoeiaacaaaaadadaaapiaacaaaaibagaaoekaacaaaaadafaaapiaacaaffib
ahaaoekaacaaaaadacaaapiaacaakkibaiaaoekaafaaaaadagaaapiaaaaaffia
afaaoeiaafaaaaadafaaapiaafaaoeiaafaaoeiaaeaaaaaeafaaapiaadaaoeia
adaaoeiaafaaoeiaaeaaaaaeadaaapiaadaaoeiaaaaaaaiaagaaoeiaaeaaaaae
aaaaapiaacaaoeiaaaaakkiaadaaoeiaaeaaaaaeacaaapiaacaaoeiaacaaoeia
afaaoeiaahaaaaacadaaabiaacaaaaiaahaaaaacadaaaciaacaaffiaahaaaaac
adaaaeiaacaakkiaahaaaaacadaaaiiaacaappiaabaaaaacafaaabiacdaaaaka
aeaaaaaeacaaapiaacaaoeiaajaaoekaafaaaaiaafaaaaadaaaaapiaaaaaoeia
adaaoeiaalaaaaadaaaaapiaaaaaoeiacfaaaakaagaaaaacadaaabiaacaaaaia
agaaaaacadaaaciaacaaffiaagaaaaacadaaaeiaacaakkiaagaaaaacadaaaiia
acaappiaafaaaaadaaaaapiaaaaaoeiaadaaoeiaafaaaaadacaaahiaaaaaffia
alaaoekaaeaaaaaeacaaahiaakaaoekaaaaaaaiaacaaoeiaaeaaaaaeaaaaahia
amaaoekaaaaakkiaacaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaappiaaaaaoeia
acaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaeaaffiabgaaoeka
aeaaaaaeaaaaapiabfaaoekaaeaaaaiaaaaaoeiaaeaaaaaeaaaaapiabhaaoeka
aeaakkiaaaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaapoaafaaoejappppaaaafdeieefcdaaoaaaaeaaaabaaimadaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacalaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaa
egaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaa
abaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaa
fgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
agbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
dcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaaf
dcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaa
afaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaa
acaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaa
agaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaa
aaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaa
ahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaahhcaabaaa
aeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaaeaaaaaa
jgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaa
acaaaaaaadaaaaaadiaaaaahpcaabaaaagaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaaaaaaaajpcaabaaaahaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaa
egaobaaaahaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaagaaaaaadcaaaaanpcaabaaaaiaaaaaa
egaobaaaagaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpeeaaaaafpcaabaaaagaaaaaaegaobaaaagaaaaaaaoaaaaak
pcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
aiaaaaaadiaaaaaihcaabaaaajaaaaaaegacbaaaadaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaakaaaaaafgafbaaaajaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaajaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
ajaaaaaaegaibaaaakaaaaaadcaaaaakhcaabaaaajaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaajaaaaaaegadbaaaajaaaaaadiaaaaahpcaabaaaafaaaaaa
egaobaaaafaaaaaafgafbaaaajaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaa
ahaaaaaaagaabaaaajaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaabaaaaaa
egaobaaaabaaaaaakgakbaaaajaaaaaaegaobaaaafaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaagaaaaaaegaobaaaabaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaaiaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
afaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
afaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaafaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaajaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
ajaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
ajaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
ajaaaaaadiaaaaahpcaabaaaagaaaaaajgacbaaaajaaaaaaegakbaaaajaaaaaa
bbaaaaaibcaabaaaahaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaagaaaaaa
bbaaaaaiccaabaaaahaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaagaaaaaa
bbaaaaaiecaabaaaahaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaagaaaaaa
aaaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaajaaaaaabkaabaaaajaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaajaaaaaaakaabaaaajaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhcaabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaa
egacbaaaafaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
afaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaaheccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_ProjectionParams]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [unity_Scale]
Vector 33 [_Wind]
Vector 34 [_MainTex_ST]
"!!ARBvp1.0
# 117 ALU
PARAM c[37] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..34],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
MOV R0.x, c[0];
DP3 R0.x, R0.x, c[8];
ADD R0.y, vertex.color.x, R0.x;
ADD R0.z, vertex.color.y, R0.y;
ADD R1.xy, vertex.position.xzzw, c[13].y;
MOV R0.w, R0.y;
DP3 R0.z, vertex.position, R0.z;
ADD R0.zw, R1.xyxy, R0;
MUL R1, R0.zzww, c[35];
FRC R1, R1;
MAD R1, R1, c[0].y, c[0].z;
FRC R1, R1;
MAD R1, R1, c[0].y, -c[0].x;
ABS R2, R1;
MAD R1, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R1, R2, R1;
ADD R0.zw, R1.xyxz, R1.xyyw;
MUL R1.xyz, R0.w, c[33];
MOV R1.w, vertex.position;
MUL R2.xy, vertex.color.yzzw, c[36].zxzw;
SLT R2.zw, c[36].y, vertex.normal.xyxz;
SLT R3.xy, vertex.normal.xzzw, c[36].y;
ADD R3.xy, R2.zwzw, -R3;
MUL R2.zw, R2.x, vertex.normal.xyxz;
MUL R2.xz, R2.zyww, R3.xyyw;
MUL R1.xyz, vertex.color.z, R1;
MAD R1.xyz, R0.zwzw, R2, R1;
MAD R2.xyz, R1, c[33].w, vertex.position;
MUL R1.xyz, vertex.color.z, c[33];
MAD R1.xyz, R1, R0.x, R2;
DP4 R0.y, R1, c[6];
DP4 R0.x, R1, c[5];
ADD R3, -R0.y, c[18];
ADD R2, -R0.x, c[17];
MUL R0, R3, R3;
MAD R4, R2, R2, R0;
DP3 R5.x, vertex.normal, vertex.normal;
RSQ R0.x, R5.x;
MUL R6.xyz, R0.x, vertex.normal;
MUL R7.xyz, R6, c[32].w;
DP3 R6.w, R7, c[6];
DP4 R0.y, R1, c[7];
ADD R0, -R0.y, c[19];
MAD R4, R0, R0, R4;
DP3 R7.w, R7, c[5];
MUL R3, R6.w, R3;
MAD R2, R7.w, R2, R3;
DP3 R3.w, R7, c[7];
MAD R0, R3.w, R0, R2;
MUL R5, R4, c[20];
MOV R7.x, R6.w;
MOV R7.y, R3.w;
MOV R7.z, c[0].x;
RSQ R2.x, R4.x;
RSQ R2.y, R4.y;
RSQ R2.z, R4.z;
RSQ R2.w, R4.w;
MUL R0, R0, R2;
ADD R2, R5, c[0].x;
DP4 R5.z, R7.wxyz, c[27];
DP4 R5.y, R7.wxyz, c[26];
DP4 R5.x, R7.wxyz, c[25];
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[36].y;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[22];
MAD R2.xyz, R0.x, c[21], R2;
MAD R0.xyz, R0.z, c[23], R2;
MAD R3.xyz, R0.w, c[24], R0;
MUL R0, R7.wxyy, R7.xyyw;
MUL R2.z, R6.w, R6.w;
DP4 R2.w, R1, c[4];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[36].w;
DP4 R7.z, R0, c[30];
DP4 R7.y, R0, c[29];
DP4 R7.x, R0, c[28];
MAD R2.z, R7.w, R7.w, -R2;
MUL R0.xyz, R2.z, c[31];
DP4 R2.z, R1, c[3];
ADD R5.xyz, R5, R7;
ADD R0.xyz, R5, R0;
ADD result.texcoord[2].xyz, R0, R3;
MOV R0.x, R4;
MUL R0.y, R4, c[15].x;
ADD result.texcoord[4].xy, R0, R4.z;
DP3 R0.z, vertex.attrib[14], vertex.attrib[14];
RSQ R0.x, R0.z;
MUL R0.xyz, R0.x, vertex.attrib[14];
MUL R3.xyz, R6.zxyw, R0.yzxw;
MAD R3.xyz, R6.yzxw, R0.zxyw, -R3;
MOV result.position, R2;
MOV result.texcoord[4].zw, R2;
MOV R2.w, c[0].x;
MOV R2.xyz, c[14];
DP4 R4.z, R2, c[11];
DP4 R4.x, R2, c[9];
DP4 R4.y, R2, c[10];
MAD R1.xyz, R4, c[32].w, -R1;
MUL R3.xyz, R3, vertex.attrib[14].w;
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[3].z, R6, R1;
MOV R2, c[16];
DP3 result.texcoord[3].x, R0, R1;
DP4 R1.z, R2, c[11];
DP4 R1.x, R2, c[9];
DP4 R1.y, R2, c[10];
DP3 result.texcoord[1].y, R1, R3;
DP3 result.texcoord[1].z, R6, R1;
DP3 result.texcoord[1].x, R1, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 117 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [unity_Scale]
Vector 33 [_Wind]
Vector 34 [_MainTex_ST]
"vs_2_0
; 124 ALU
def c35, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c36, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c37, 2.00000000, 3.00000000, 0.22500001, 0.10000000
def c38, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c35.x, r0
add r0.y, v5.x, r0.x
add r0.z, v5.y, r0.y
mov r0.w, r0.y
add r1.xy, v0.xzzw, c12.y
dp3 r0.z, v0, r0.z
add r0.zw, r1.xyxy, r0
mul r1, r0.zzww, c36
frc r1, r1
mad r1, r1, c35.y, c35.z
frc r1, r1
mad r1, r1, c35.y, c35.w
abs r2, r1
mad r1, -r2, c37.x, c37.y
mul r2, r2, r2
mul r1, r2, r1
add r0.zw, r1.xyxz, r1.xyyw
mul r1.xyz, r0.w, c33
mov r1.w, v0
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r0.y, v5, c37.w
mul r2.xy, r0.y, v2.xzzw
mul r2.xz, r2.xyyw, r2.zyww
mul r2.y, v5.z, c37.z
mul r1.xyz, v5.z, r1
mad r1.xyz, r0.zwzw, r2, r1
mad r2.xyz, r1, c33.w, v0
mul r1.xyz, v5.z, c33
mad r1.xyz, r1, r0.x, r2
dp4 r0.y, r1, c5
dp4 r0.x, r1, c4
add r3, -r0.y, c18
add r2, -r0.x, c17
mul r0, r3, r3
mad r4, r2, r2, r0
dp3 r5.x, v2, v2
rsq r0.x, r5.x
mul r6.xyz, r0.x, v2
mul r7.xyz, r6, c32.w
dp3 r6.w, r7, c5
dp4 r0.y, r1, c6
add r0, -r0.y, c19
mad r4, r0, r0, r4
dp3 r7.w, r7, c4
mul r3, r6.w, r3
mad r2, r7.w, r2, r3
dp3 r3.w, r7, c6
mad r0, r3.w, r0, r2
mul r5, r4, c20
mov r7.x, r6.w
mov r7.y, r3.w
mov r7.z, c35.x
rsq r2.x, r4.x
rsq r2.y, r4.y
rsq r2.z, r4.z
rsq r2.w, r4.w
mul r0, r0, r2
add r2, r5, c35.x
dp4 r5.z, r7.wxyz, c27
dp4 r5.y, r7.wxyz, c26
dp4 r5.x, r7.wxyz, c25
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c38.x
mul r0, r0, r2
mul r2.xyz, r0.y, c22
mad r2.xyz, r0.x, c21, r2
mad r0.xyz, r0.z, c23, r2
mad r3.xyz, r0.w, c24, r0
mul r0, r7.wxyy, r7.xyyw
mul r2.z, r6.w, r6.w
dp4 r2.w, r1, c3
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
mul r4.xyz, r2.xyww, c38.y
dp4 r7.z, r0, c30
dp4 r7.y, r0, c29
dp4 r7.x, r0, c28
mad r2.z, r7.w, r7.w, -r2
mul r0.xyz, r2.z, c31
dp4 r2.z, r1, c2
add r5.xyz, r5, r7
add r0.xyz, r5, r0
add oT2.xyz, r0, r3
mov r0.x, r4
mul r0.y, r4, c14.x
mad oT4.xy, r4.z, c15.zwzw, r0
dp3 r0.z, v1, v1
rsq r0.x, r0.z
mul r0.xyz, r0.x, v1
mul r3.xyz, r6.zxyw, r0.yzxw
mad r3.xyz, r6.yzxw, r0.zxyw, -r3
mov oPos, r2
mov oT4.zw, r2
mov r2.w, c35.x
mov r2.xyz, c13
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
mad r2.xyz, r4, c32.w, -r1
mul r3.xyz, r3, v1.w
mov r1, c10
dp4 r4.z, c16, r1
mov r1, c9
dp4 r4.y, c16, r1
dp3 oT3.y, r3, r2
dp3 oT3.z, r6, r2
dp3 oT3.x, r0, r2
mov r2, c8
dp4 r4.x, c16, r2
dp3 oT1.y, r4, r3
dp3 oT1.z, r6, r4
dp3 oT1.x, r4, r0
mov oD0, v5
mad oT0.xy, v3, c34, c34.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcgcghgejipmkfdccfiecejogekfkbkolabaaaaaalebaaaaaadaaaaaa
cmaaaaaapeaaaaaamiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheommaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaamfaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefcoeaoaaaaeaaaabaaljadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacamaaaaaadgaaaaagbcaabaaaaaaaaaaa
dkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaak
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaa
acaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaaj
pcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaa
dcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaea
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaa
adaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaa
diaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaah
kcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaa
aaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaak
ocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaahhcaabaaaafaaaaaa
jgaebaaaadaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaa
aeaaaaaacgajbaaaadaaaaaaegacbaiaebaaaaaaafaaaaaadiaaaaahhcaabaaa
afaaaaaaegacbaaaafaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajpcaabaaaagaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaahaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
aaaaaaajpcaabaaaaiaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaaeaaaaaadcaaaaajpcaabaaaahaaaaaaegaobaaaaiaaaaaaegaobaaa
aiaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaaahaaaaaaegaobaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaahaaaaaadcaaaaanpcaabaaaajaaaaaaegaobaaa
ahaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpeeaaaaafpcaabaaaahaaaaaaegaobaaaahaaaaaaaoaaaaakpcaabaaa
ajaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaajaaaaaa
diaaaaaihcaabaaaakaaaaaaegacbaaaaeaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaalaaaaaafgafbaaaakaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaakaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaakaaaaaa
egaibaaaalaaaaaadcaaaaakhcaabaaaakaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaakaaaaaaegadbaaaakaaaaaadiaaaaahpcaabaaaagaaaaaaegaobaaa
agaaaaaafgafbaaaakaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaaiaaaaaa
agaabaaaakaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
acaaaaaakgakbaaaakaaaaaaegaobaaaagaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaahaaaaaaegaobaaaacaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaajaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaagaaaaaa
fgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaa
agaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaaakaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaagaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaakaaaaaa
bbaaaaaiccaabaaaagaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaakaaaaaa
bbaaaaaiecaabaaaagaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaakaaaaaa
diaaaaahpcaabaaaahaaaaaajgacbaaaakaaaaaaegakbaaaakaaaaaabbaaaaai
bcaabaaaaiaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaahaaaaaabbaaaaai
ccaabaaaaiaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaahaaaaaabbaaaaai
ecaabaaaaiaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaahaaaaaaaaaaaaah
hcaabaaaagaaaaaaegacbaaaagaaaaaaegacbaaaaiaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaakaaaaaabkaabaaaakaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaakaaaaaaakaabaaaakaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
agaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaagaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaia
ebaaaaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaaheccabaaaafaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaa
aaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
dgaaaaafmccabaaaagaaaaaakgaobaaaabaaaaaaaaaaaaahdccabaaaagaaaaaa
kgakbaaaaaaaaaaamgaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedapgcflgmdefkgbhdnmeclnhmlalmaflhabaaaaaaeabjaaaaaeaaaaaa
daaaaaaaliaiaaaakebhaaaagmbiaaaaebgpgodjiaaiaaaaiaaiaaaaaaacpopp
omahaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaahaa
abaaabaaaaaaaaaaaaaaalaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
abaaaeaaacaaaeaaaaaaaaaaacaaaaaaabaaagaaaaaaaaaaacaaacaaaiaaahaa
aaaaaaaaacaacgaaahaaapaaaaaaaaaaadaaaaaaaeaabgaaaaaaaaaaadaaamaa
ajaabkaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcdaaapkamnmmpmdpamaceldp
aaaamadomlkbefdofbaaaaafceaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialp
fbaaaaafcfaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdofbaaaaafcgaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaooka
abaaaaacaaaaapiaagaaoekaafaaaaadabaaahiaaaaaffiabpaaoekaaeaaaaae
abaaahiaboaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiacaaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiacbaaoekaaaaappiaaaaaoeiaceaaaaacabaaahia
abaaoejaaiaaaaadacaaaboaabaaoeiaaaaaoeiaceaaaaacacaaahiaacaaoeja
afaaaaadadaaahiaabaamjiaacaanciaaeaaaaaeadaaahiaacaamjiaabaancia
adaaoeibafaaaaadadaaahiaadaaoeiaabaappjaaiaaaaadacaaacoaadaaoeia
aaaaoeiaaiaaaaadacaaaeoaacaaoeiaaaaaoeiaabaaaaacaaaaahiaaeaaoeka
afaaaaadaeaaahiaaaaaffiabpaaoekaaeaaaaaeaaaaaliaboaakekaaaaaaaia
aeaakeiaaeaaaaaeaaaaahiacaaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahia
aaaaoeiacbaaoekaabaaaaacaeaaabiabkaappkaabaaaaacaeaaaciablaappka
abaaaaacaeaaaeiabmaappkaaiaaaaadaaaaaiiaaeaaoeiaceaaaakaacaaaaad
aeaaaciaaaaappiaafaaaajaacaaaaadabaaaiiaaeaaffiaafaaffjaaiaaaaad
aeaaabiaaaaaoejaabaappiaacaaaaadafaaapiaaaaakajaadaaffkaacaaaaad
aeaaapiaaeaafaiaafaaoeiaafaaaaadaeaaapiaaeaaoeiacdaaoekabdaaaaac
aeaaapiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiaceaaffkaceaakkkabdaaaaac
aeaaapiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiaceaaffkaceaappkacdaaaaac
aeaaapiaaeaaoeiaafaaaaadafaaapiaaeaaoeiaaeaaoeiaaeaaaaaeaeaaapia
aeaaoeiacfaaaakbcfaaffkaafaaaaadaeaaapiaaeaaoeiaafaaoeiaacaaaaad
aeaaahiaaeaanniaaeaamiiaafaaaaadafaaahiaaeaaffiaabaaoekaafaaaaad
afaaahiaafaaoeiaafaakkjaamaaaaadagaaadiaacaaoijbacaaoijaamaaaaad
agaaamiaacaaiejaacaaiejbacaaaaadagaaadiaagaaooibagaaoeiaafaaaaad
abaaaiiaafaaffjacfaakkkaafaaaaadagaaamiaabaappiaacaaiejaafaaaaad
agaaafiaagaaneiaagaapgiaafaaaaadagaaaciaafaakkjacfaappkaaeaaaaae
aeaaahiaaeaaoeiaagaaoeiaafaaoeiaaeaaaaaeaeaaahiaaeaaoeiaabaappka
aaaaoejaafaaaaadafaaahiaafaakkjaabaaoekaaeaaaaaeaeaaahiaafaaoeia
aaaappiaaeaaoeiaaeaaaaaeaaaaahiaaaaaoeiaccaappkaaeaaoeibaiaaaaad
aeaaaboaabaaoeiaaaaaoeiaaiaaaaadaeaaacoaadaaoeiaaaaaoeiaaiaaaaad
aeaaaeoaacaaoeiaaaaaoeiaafaaaaadaaaaahiaacaaoeiaccaappkaafaaaaad
abaaahiaaaaaffiablaaoekaaeaaaaaeaaaaaliabkaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahiabmaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiaceaaaaka
ajaaaaadabaaabiaapaaoekaaaaaoeiaajaaaaadabaaaciabaaaoekaaaaaoeia
ajaaaaadabaaaeiabbaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeia
ajaaaaadadaaabiabcaaoekaacaaoeiaajaaaaadadaaaciabdaaoekaacaaoeia
ajaaaaadadaaaeiabeaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeia
afaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaia
aaaappibaeaaaaaeabaaahiabfaaoekaaaaappiaabaaoeiaafaaaaadacaaahia
aeaaffiablaaoekaaeaaaaaeacaaahiabkaaoekaaeaaaaiaacaaoeiaaeaaaaae
acaaahiabmaaoekaaeaakkiaacaaoeiaaeaaaaaeacaaahiabnaaoekaaaaappja
acaaoeiaacaaaaadadaaapiaacaaaaibahaaoekaacaaaaadafaaapiaacaaffib
aiaaoekaacaaaaadacaaapiaacaakkibajaaoekaafaaaaadagaaapiaaaaaffia
afaaoeiaafaaaaadafaaapiaafaaoeiaafaaoeiaaeaaaaaeafaaapiaadaaoeia
adaaoeiaafaaoeiaaeaaaaaeadaaapiaadaaoeiaaaaaaaiaagaaoeiaaeaaaaae
aaaaapiaacaaoeiaaaaakkiaadaaoeiaaeaaaaaeacaaapiaacaaoeiaacaaoeia
afaaoeiaahaaaaacadaaabiaacaaaaiaahaaaaacadaaaciaacaaffiaahaaaaac
adaaaeiaacaakkiaahaaaaacadaaaiiaacaappiaabaaaaacafaaabiaceaaaaka
aeaaaaaeacaaapiaacaaoeiaakaaoekaafaaaaiaafaaaaadaaaaapiaaaaaoeia
adaaoeiaalaaaaadaaaaapiaaaaaoeiacgaaaakaagaaaaacadaaabiaacaaaaia
agaaaaacadaaaciaacaaffiaagaaaaacadaaaeiaacaakkiaagaaaaacadaaaiia
acaappiaafaaaaadaaaaapiaaaaaoeiaadaaoeiaafaaaaadacaaahiaaaaaffia
amaaoekaaeaaaaaeacaaahiaalaaoekaaaaaaaiaacaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaakkiaacaaoeiaaeaaaaaeaaaaahiaaoaaoekaaaaappiaaaaaoeia
acaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaeaaffiabhaaoeka
aeaaaaaeaaaaapiabgaaoekaaeaaaaiaaaaaoeiaaeaaaaaeaaaaapiabiaaoeka
aeaakkiaaaaaoeiaaeaaaaaeaaaaapiabjaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaceaakkkbafaaaaad
abaaafiaaaaapeiaceaakkkbacaaaaadafaaadoaabaakkiaabaaomiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
afaaamoaaaaaoeiaabaaaaacabaaapoaafaaoejappppaaaafdeieefcoeaoaaaa
eaaaabaaljadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
amaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaa
adaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
adaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaa
afaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaa
egbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadiaaaaahhcaabaaaafaaaaaajgaebaaaadaaaaaacgajbaaaaeaaaaaa
dcaaaaakhcaabaaaafaaaaaajgaebaaaaeaaaaaacgajbaaaadaaaaaaegacbaia
ebaaaaaaafaaaaaadiaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaapgbpbaaa
abaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaagaaaaaafgafbaia
ebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaahaaaaaa
egaobaaaagaaaaaaegaobaaaagaaaaaaaaaaaaajpcaabaaaaiaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaa
ahaaaaaaegaobaaaaiaaaaaaegaobaaaaiaaaaaaegaobaaaahaaaaaadcaaaaaj
pcaabaaaahaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaahaaaaaa
dcaaaaanpcaabaaaajaaaaaaegaobaaaahaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpeeaaaaafpcaabaaaahaaaaaa
egaobaaaahaaaaaaaoaaaaakpcaabaaaajaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaajaaaaaadiaaaaaihcaabaaaakaaaaaaegacbaaa
aeaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaalaaaaaafgafbaaa
akaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaakaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaakaaaaaaegaibaaaalaaaaaadcaaaaakhcaabaaa
akaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaakaaaaaaegadbaaaakaaaaaa
diaaaaahpcaabaaaagaaaaaaegaobaaaagaaaaaafgafbaaaakaaaaaadcaaaaaj
pcaabaaaagaaaaaaegaobaaaaiaaaaaaagaabaaaakaaaaaaegaobaaaagaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaakgakbaaaakaaaaaaegaobaaa
agaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaahaaaaaaegaobaaaacaaaaaa
deaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaajaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaagaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
acaaaaaaegacbaaaagaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaacaaaaaaegacbaaaagaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaf
icaabaaaakaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaagaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaakaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaakaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaakaaaaaadiaaaaahpcaabaaaahaaaaaajgacbaaa
akaaaaaaegakbaaaakaaaaaabbaaaaaibcaabaaaaiaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaahaaaaaabbaaaaaiccaabaaaaiaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaahaaaaaabbaaaaaiecaabaaaaiaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaahaaaaaaaaaaaaahhcaabaaaagaaaaaaegacbaaaagaaaaaa
egacbaaaaiaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaakaaaaaabkaabaaa
akaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaakaaaaaaakaabaaaakaaaaaa
dkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaagaaaaaaegiccaaaacaaaaaa
cmaaaaaapgapbaaaaaaaaaaaegacbaaaagaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaacaaaaaaegacbaaaagaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaafaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
afaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaafmccabaaaagaaaaaakgaobaaa
abaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
"!!ARBfp1.0
# 42 ALU, 2 TEX
PARAM c[7] = { program.local[0..4],
		{ 0.60009766, 2, 1, 0.39990234 },
		{ 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[4];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.z, R2.x;
MUL R3.xyz, R2.z, fragment.texcoord[3];
ADD R4.xyz, R3, fragment.texcoord[1];
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[0], texture[1], 2D;
MAD R2.xy, R1.wyzw, c[5].y, -c[5].z;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.y, R2.z, R2.w;
DP3 R1.w, R4, R4;
RSQ R1.w, R1.w;
ADD R1.y, -R1, c[5].z;
RSQ R1.y, R1.y;
RCP R2.z, R1.y;
MOV R1.y, c[6];
MUL R2.w, R1.y, c[1].x;
MUL R4.xyz, R1.w, R4;
DP3 R1.w, R2, R4;
DP3 R1.y, fragment.texcoord[1], R2;
MOV_SAT R2.x, -R1.y;
MAX R1.w, R1, c[6].x;
POW R2.z, R1.w, R2.w;
DP3_SAT R1.w, R3, -fragment.texcoord[1];
ADD R2.y, R1.w, -R2.x;
MUL R1.w, R1.z, R2.z;
MAD R1.z, R2.y, c[3].x, R2.x;
MAD R1.y, R1, c[5].x, c[5].w;
MAX R2.x, R1.y, c[6];
MUL R1.x, R1.z, R1;
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[5].y, R2.x;
ADD R2.x, fragment.color.primary, c[5];
MUL R0.xyz, R0, R2.x;
MUL R1.xyz, R0, R1;
MUL R2.xyz, R1.w, c[0];
MUL R0.xyz, R0, fragment.texcoord[2];
MAD R1.xyz, R1, c[0], R2;
MAD result.color.xyz, R1, c[5].y, R0;
END
# 42 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
"ps_2_0
; 47 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 0.60009766, 0.39990234
def c6, 2.00000000, -1.00000000, 128.00000000, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
texld r6, t0, s1
add_pp r0.x, r2.w, -c4
cmp r0.x, r0, c5, c5.y
mov_pp r0, -r0.x
mov r1.x, r6.w
mov r1.y, r6
mad_pp r4.xy, r1, c6.x, c6.y
mul_pp r1.xy, r4, r4
mul_pp r2.xyz, r2, v0.w
texkill r0.xyzw
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, t3
add_pp_sat r0.x, r1, r1.y
add_pp r5.xyz, r3, t1
dp3_pp r1.x, r5, r5
add_pp r0.x, -r0, c5.y
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r5
dp3_pp r1.x, r4, r1
mov_pp r0.x, c1
mul_pp r0.x, c6.z, r0
max_pp r1.x, r1, c5
pow_pp r5.x, r1.x, r0.x
dp3_pp r1.x, t1, r4
mov_pp_sat r4.x, -r1
dp3_pp_sat r0.x, r3, -t1
add_pp r3.x, r0, -r4
mov_pp r0.x, r5.x
mad_pp r3.x, r3, c3, r4
mad_pp r1.x, r1, c5.z, c5.w
mul_pp r3.x, r3, r6
mul_pp r0.x, r6.z, r0
max_pp r1.x, r1, c5
mul_pp r3.xyz, r3.x, c2
mad_pp r3.xyz, r3, c6.x, r1.x
add_pp r1.x, v0, c5.z
mul_pp r1.xyz, r2, r1.x
mul_pp r2.xyz, r1, r3
mul_pp r0.xyz, r0.x, c0
mul_pp r1.xyz, r1, t2
mad_pp r0.xyz, r2, c0, r0
mad_pp r0.xyz, r0, c6.x, r1
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Vector 64 [_Color]
Vector 80 [_TranslucencyColor] 3
Float 92 [_TranslucencyViewDependency]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedojihehbljjadmbaniiiljaonmlnmppbkabaaaaaammagaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
kiafaaaaeaaaaaaagkabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadjcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajocaabaaaabaaaaaaagbjbaaaafaaaaaaagaabaaaabaaaaaa
agbjbaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaa
afaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaiaebaaaaaa
adaaaaaabaaaaaahbcaabaaaacaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
fgaobaaaabaaaaaaagaabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaacaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaabkaabaaaacaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaadaaaaaaegbcbaaaadaaaaaadeaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaa
aaaaaaeddiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
bjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaacaaaaaabkaabaaaabaaaaaadiaaaaaiocaabaaaacaaaaaafgafbaaa
abaaaaaaagijcaaaaaaaaaaaabaaaaaadgcaaaagccaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
jkjjbjdpabeaaaaamnmmmmdodeaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaadkiacaaaaaaaaaaaafaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
acaaaaaaakaabaaaabaaaaaadiaaaaailcaabaaaabaaaaaaagaabaaaabaaaaaa
egiicaaaaaaaaaaaafaaaaaadcaaaaamhcaabaaaabaaaaaaegadbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaakgakbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaa
abeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
jgahbaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaa
egacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Vector 64 [_Color]
Vector 80 [_TranslucencyColor] 3
Float 92 [_TranslucencyViewDependency]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfbjiaodlplopbhgjfpchbpgajdagcagcabaaaaaadaakaaaaaeaaaaaa
daaaaaaajaadaaaaeaajaaaapmajaaaaebgpgodjfiadaaaafiadaaaaaaacpppp
aiadaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaacaaabaaaaaaaaaaaaaaaiaa
abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkajkjjbjdpaaaaaaeaaaaaialp
aaaaaaaafbaaaaafafaaapkaaaaaaaedjkjjbjdpmnmmmmdoaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoelaaaaioeka
acaaaaadabaacpiaaaaappiaadaaaakbebaaaaababaaapiaecaaaaadabaacpia
aaaaoelaabaioekaaiaaaaadacaaciiaaeaaoelaaeaaoelaahaaaaacacaacbia
acaappiaafaaaaadadaachiaacaaaaiaaeaaoelaabaaaaacaeaaahiaaeaaoela
aeaaaaaeacaachiaaeaaoeiaacaaaaiaacaaoelaceaaaaacaeaachiaacaaoeia
aiaaaaadaeaadiiaadaaoeiaacaaoelbaeaaaaaeacaacbiaabaappiaaeaaffka
aeaakkkaaeaaaaaeacaacciaabaaffiaaeaaffkaaeaakkkafkaaaaaeacaadiia
acaaoeiaacaaoeiaaeaappkaacaaaaadacaaciiaacaappibaeaakkkbahaaaaac
acaaciiaacaappiaagaaaaacacaaceiaacaappiaaiaaaaadacaaciiaacaaoeia
acaaoelaaiaaaaadabaacciaacaaoeiaaeaaoeiaalaaaaadacaacbiaabaaffia
aeaappkaabaaaaacabaadciaacaappibaeaaaaaeabaaciiaacaappiaafaaffka
afaakkkaalaaaaadacaacciaabaappiaaeaappkabcaaaaaeacaaceiaacaappka
aeaappiaabaaffiaafaaaaadabaacbiaabaaaaiaacaakkiaafaaaaadadaachia
abaaaaiaacaaoekaaeaaaaaeacaacoiaadaabliaaeaaffkaacaaffiaafaaaaad
adaachiaaaaaoeiaabaapplaacaaaaadadaaciiaabaaaalaaeaaaakaafaaaaad
adaachiaadaappiaadaaoeiaafaaaaadacaacoiaacaaoeiaadaabliaabaaaaac
adaaaiiaafaaaakaafaaaaadadaaciiaadaappiaabaaaakacaaaaaadabaacbia
acaaaaiaadaappiaafaaaaadadaaciiaabaakkiaabaaaaiaafaaaaadabaachia
adaappiaaaaaoekaaeaaaaaeabaachiaacaabliaaaaaoekaabaaoeiaacaaaaad
abaachiaabaaoeiaabaaoeiaaeaaaaaeaaaachiaadaaoeiaadaaoelaabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckiafaaaaeaaaaaaagkabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajocaabaaa
abaaaaaaagbjbaaaafaaaaaaagaabaaaabaaaaaaagbjbaaaadaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaabacaaaaibcaabaaa
abaaaaaaegacbaaaacaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahccaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaa
ddaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaai
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaadaaaaaabkaabaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaadaaaaaa
egbcbaaaadaaaaaadeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
abaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaabjaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaacaaaaaabkaabaaa
abaaaaaadiaaaaaiocaabaaaacaaaaaafgafbaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaadgcaaaagccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadcaaaaaj
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdo
deaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaadkiacaaaaaaaaaaaafaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaailcaabaaaabaaaaaaagaabaaaabaaaaaaegiicaaaaaaaaaaaafaaaaaa
dcaaaaamhcaabaaaabaaaaaaegadbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaakgakbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaajgahbaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
knaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
"!!ARBfp1.0
# 11 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0.60009766, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[0];
ADD R2.x, fragment.color.primary, c[1];
MUL R0.xyz, R0, fragment.color.primary.w;
MUL R0.xyz, R0, R2.x;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[1].y;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
"ps_2_0
; 11 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
def c1, 0.60009766, 0.00000000, 1.00000000, 8.00000000
dcl t0.xy
dcl v0.xyzw
dcl t1.xy
texld r2, t0, s0
texld r1, t1, s2
add_pp r0.x, r2.w, -c0
cmp r0.x, r0, c1.y, c1.z
mov_pp r0, -r0.x
mul_pp r2.xyz, r2, v0.w
mul_pp r1.xyz, r1.w, r1
texkill r0.xyzw
add_pp r0.x, v0, c1
mul_pp r0.xyz, r2, r0.x
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.w
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 160
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcdijlggdbojhoidnmmlbhdfahdjmakgfabaaaaaanaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcnmabaaaaeaaaaaaahhaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaad
jcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
ajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 160
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedffmhogjidcabhmkfechldeblacjpapamabaaaaaabeaeaaaaaeaaaaaa
daaaaaaahaabaaaafeadaaaaoaadaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
aaabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaajaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkajkjjbjdp
aaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappiaaaaaaakbabaaaaac
acaaadiaaaaabllaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
afaaaaadacaachiaaaaaoeiaabaapplaacaaaaadacaaciiaabaaaalaabaaaaka
afaaaaadacaachiaacaappiaacaaoeiaafaaaaadabaaciiaabaappiaabaaffka
afaaaaadabaachiaabaaoeiaabaappiaafaaaaadaaaachiaabaaoeiaacaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcnmabaaaaeaaaaaaahhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gcbaaaadjcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"!!ARBfp1.0
# 26 ALU, 4 TEX
PARAM c[5] = { program.local[0],
		{ 2, 1, 8, 0.60009766 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.yw, fragment.texcoord[0], texture[1], 2D;
TEX R2, fragment.texcoord[1], texture[3], 2D;
MAD R3.xy, R3.wyzw, c[1].x, -c[1].y;
SLT R1.x, R0.w, c[0];
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R3.z, R3, R3.w;
ADD R3.z, -R3, c[1].y;
RSQ R3.z, R3.z;
RCP R3.z, R3.z;
MUL R2.xyz, R2.w, R2;
DP3_SAT R4.z, R3, c[2];
DP3_SAT R4.x, R3, c[4];
DP3_SAT R4.y, R3, c[3];
MUL R2.xyz, R2, R4;
DP3 R2.x, R2, c[1].z;
ADD R2.y, fragment.color.primary.x, c[1].w;
MUL R0.xyz, R0, fragment.color.primary.w;
MUL R0.xyz, R0, R2.y;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R2.x;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[1].z;
END
# 26 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_2_0
; 25 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c1, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c2, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c3, -0.40824831, 0.70710677, 0.57735026, 0.60009766
def c4, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xy
texld r2, t0, s0
texld r1, t1, s2
texld r3, t1, s3
add_pp r0.x, r2.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
mul_pp r3.xyz, r3.w, r3
mul_pp r2.xyz, r2, v0.w
mul_pp r1.xyz, r1.w, r1
texkill r0.xyzw
texld r0, t0, s1
mov r0.x, r0.w
mad_pp r4.xy, r0, c1.z, c1.w
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c1.y
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
dp3_pp_sat r0.z, r4, c2
dp3_pp_sat r0.y, r4, c3
dp3_pp_sat r0.x, r4, c4
mul_pp r0.xyz, r3, r0
dp3_pp r0.x, r0, c2.w
add_pp r3.x, v0, c3.w
mul_pp r2.xyz, r2, r3.x
mul_pp r0.xyz, r1, r0.x
mul_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 160
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkdnjjakpdpjmhhchdkpjpjgnccjbailcabaaaaaaoaaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomadaaaaeaaaaaaaplaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaak
ecaabaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaa
jkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 160
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecediagllpgeicjbhnionjgeaklmlmolhoffabaaaaaaiaahaaaaaeaaaaaa
daaaaaaammacaaaamaagaaaaemahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
feacaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaaaaaaaaa
abababaaacacacaaadadadaaaaaaajaaabaaaaaaaaaaaaaaaaacppppfbaaaaaf
abaaapkajkjjbjdpaaaaaaeaaaaaialpaaaaaaaafbaaaaafacaaapkaaaaaaaeb
dkmnbddpaaaaaaaaolaffbdpfbaaaaafadaaapkaomafnblopdaedfdpdkmnbddp
aaaaaaaafbaaaaafaeaaapkaolafnblopdaedflpdkmnbddpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappia
aaaaaakbabaaaaacacaaadiaaaaabllaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaadaioekaecaaaaadacaacpiaacaaoeiaacaioekaecaaaaadadaacpia
aaaaoelaabaioekaafaaaaadabaaciiaabaappiaacaaaakaafaaaaadabaachia
abaaoeiaabaappiaaeaaaaaeaeaacbiaadaappiaabaaffkaabaakkkaaeaaaaae
aeaacciaadaaffiaabaaffkaabaakkkafkaaaaaeabaadiiaaeaaoeiaaeaaoeia
abaappkaacaaaaadabaaciiaabaappibabaakkkbahaaaaacabaaciiaabaappia
agaaaaacaeaaceiaabaappiaaiaaaaadadaadbiaacaablkaaeaaoeiaaiaaaaad
adaadciaadaaoekaaeaaoeiaaiaaaaadadaadeiaaeaaoekaaeaaoeiaaiaaaaad
abaacbiaadaaoeiaabaaoeiaafaaaaadacaaciiaacaappiaacaaaakaafaaaaad
abaacoiaacaabliaacaappiaafaaaaadabaachiaabaaaaiaabaabliaafaaaaad
acaachiaaaaaoeiaabaapplaacaaaaadabaaciiaabaaaalaabaaaakaafaaaaad
acaachiaabaappiaacaaoeiaafaaaaadaaaachiaabaaoeiaacaaoeiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcomadaaaaeaaaaaaaplaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaak
ecaabaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaa
jkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaahnaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapajaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_ShadowStrength]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
# 46 ALU, 3 TEX
PARAM c[8] = { program.local[0..5],
		{ 0.60009766, 2, 1, 0.39990234 },
		{ 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TXP R4.x, fragment.texcoord[4], texture[2], 2D;
SLT R1.x, R0.w, c[5];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[0], texture[1], 2D;
MAD R3.xy, R1.wyzw, c[6].y, -c[6].z;
RSQ R1.y, R2.x;
MUL R2.xyz, R1.y, fragment.texcoord[3];
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R1.y, R3.z, R3.w;
ADD R1.w, -R1.y, c[6].z;
ADD R4.yzw, R2.xxyz, fragment.texcoord[1].xxyz;
DP3 R1.y, R4.yzww, R4.yzww;
RSQ R1.w, R1.w;
RCP R3.z, R1.w;
RSQ R1.y, R1.y;
MUL R4.yzw, R1.y, R4;
MOV R1.y, c[7];
DP3 R1.w, R3, R4.yzww;
MAX R1.w, R1, c[7].x;
MUL R1.y, R1, c[1].x;
POW R1.y, R1.w, R1.y;
MUL R1.y, R1.z, R1;
DP3 R2.w, fragment.texcoord[1], R3;
DP3_SAT R1.z, R2, -fragment.texcoord[1];
MOV_SAT R1.w, -R2;
ADD R1.z, R1, -R1.w;
MAD R1.z, R1, c[3].x, R1.w;
MUL R2.xyz, R1.y, c[0];
MAD R1.y, R2.w, c[6].x, c[6].w;
MAX R1.w, R1.y, c[7].x;
MUL R1.x, R1.z, R1;
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[6].y, R1.w;
ADD R1.w, fragment.color.primary.x, c[6].x;
MUL R0.xyz, R0, R1.w;
MUL R1.xyz, R0, R1;
MAD R1.xyz, R1, c[0], R2;
MUL R0.xyz, R0, fragment.texcoord[2];
MOV R2.x, c[6].y;
MAD R1.w, R4.x, c[6].y, -c[6].y;
MAD R1.w, R1, c[4].x, R2.x;
MAD result.color.xyz, R1, R1.w, R0;
END
# 46 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_ShadowStrength]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
; 50 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 0.00000000, 1.00000000, 0.60009766, 0.39990234
def c7, 2.00000000, -1.00000000, 128.00000000, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r2, t0, s0
texld r6, t0, s1
texldp r7, t4, s2
add_pp r0.x, r2.w, -c5
cmp r0.x, r0, c6, c6.y
mov_pp r0, -r0.x
mov r1.x, r6.w
mov r1.y, r6
mad_pp r4.xy, r1, c7.x, c7.y
mul_pp r1.xy, r4, r4
mul_pp r2.xyz, r2, v0.w
texkill r0.xyzw
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, t3
add_pp r5.xyz, r3, t1
add_pp_sat r0.x, r1, r1.y
dp3_pp r1.x, r5, r5
add_pp r0.x, -r0, c6.y
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r5
dp3_pp r1.x, r4, r1
mov_pp r0.x, c1
dp3_pp_sat r3.x, r3, -t1
mul_pp r0.x, c7.z, r0
max_pp r1.x, r1, c6
pow_pp r5.x, r1.x, r0.x
dp3_pp r1.x, t1, r4
mov_pp_sat r4.x, -r1
mov_pp r0.x, r5.x
add_pp r3.x, r3, -r4
mad_pp r3.x, r3, c3, r4
mad_pp r1.x, r1, c6.z, c6.w
mul_pp r3.x, r3, r6
mul_pp r0.x, r6.z, r0
mul_pp r3.xyz, r3.x, c2
max_pp r1.x, r1, c6
mad_pp r1.xyz, r3, c7.x, r1.x
mul_pp r3.xyz, r0.x, c0
add_pp r0.x, v0, c6.z
mul_pp r0.xyz, r2, r0.x
mul_pp r1.xyz, r0, r1
mad_pp r2.xyz, r1, c0, r3
mul_pp r3.xyz, r0, t2
mov_pp r0.x, c7
mad_pp r1.x, r7, c7, -c7
mad_pp r0.x, r1, c4, r0
mad_pp r0.xyz, r2, r0.x, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 160 [_ShadowStrength]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecednedddikpllaepdipmdajffihkdmkhobiabaaaaaajiahaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmagaaaaeaaaaaaa
jhabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaamaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajocaabaaaabaaaaaaagbjbaaaafaaaaaaagaabaaaabaaaaaa
agbjbaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaa
afaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaiaebaaaaaa
adaaaaaabaaaaaahbcaabaaaacaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
fgaobaaaabaaaaaaagaabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaacaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaabkaabaaaacaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaadaaaaaaegbcbaaaadaaaaaadeaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaaeddiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
bjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaacaaaaaabkaabaaaabaaaaaadiaaaaaiocaabaaaacaaaaaafgafbaaa
abaaaaaaagijcaaaaaaaaaaaabaaaaaadgcaaaagccaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
jkjjbjdpabeaaaaamnmmmmdodeaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
acaaaaaaakaabaaaabaaaaaadiaaaaailcaabaaaabaaaaaaagaabaaaabaaaaaa
egiicaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaabaaaaaaegadbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaakgakbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaa
abeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaajgahbaaa
acaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaaamadcaaaaakicaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 160 [_ShadowStrength]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedknlaaflpedinmledjacafcgakdonfdbaabaaaaaajaalaaaaaeaaaaaa
daaaaaaaceaeaaaaiiakaaaafmalaaaaebgpgodjomadaaaaomadaaaaaaacpppp
jiadaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaadaaabaaaaaaaaaa
aaaaamaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkajkjjbjdpaaaaaaea
aaaaialpaaaaaaaafbaaaaafagaaapkaaaaaaaedjkjjbjdpmnmmmmdoaaaaaaaa
fbaaaaafahaaapkaaaaaaaeaaaaaaamaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaacaaaaadabaacpiaaaaappia
aeaaaakbagaaaaacacaaaiiaafaapplaafaaaaadacaaadiaacaappiaafaaoela
ebaaaaababaaapiaecaaaaadabaacpiaaaaaoelaacaioekaecaaaaadacaacpia
acaaoeiaaaaioekaaiaaaaadacaacciaaeaaoelaaeaaoelaahaaaaacacaaccia
acaaffiaafaaaaadadaachiaacaaffiaaeaaoelaabaaaaacaeaaahiaaeaaoela
aeaaaaaeaeaachiaaeaaoeiaacaaffiaacaaoelaceaaaaacafaachiaaeaaoeia
aiaaaaadafaadiiaadaaoeiaacaaoelbaeaaaaaeadaacbiaabaappiaafaaffka
afaakkkaaeaaaaaeadaacciaabaaffiaafaaffkaafaakkkafkaaaaaeadaadiia
adaaoeiaadaaoeiaafaappkaacaaaaadadaaciiaadaappibafaakkkbahaaaaac
adaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaadadaaciiaadaaoeia
acaaoelaaiaaaaadabaacciaadaaoeiaafaaoeiaalaaaaadacaacciaabaaffia
afaappkaabaaaaacabaadciaadaappibaeaaaaaeabaaciiaadaappiaagaaffka
agaakkkaalaaaaadacaaceiaabaappiaafaappkabcaaaaaeacaaciiaacaappka
afaappiaabaaffiaafaaaaadacaaciiaabaaaaiaacaappiaafaaaaadadaachia
acaappiaacaaoekaaeaaaaaeadaachiaadaaoeiaafaaffkaacaakkiaafaaaaad
aeaachiaaaaaoeiaabaapplaacaaaaadadaaciiaabaaaalaafaaaakaafaaaaad
aeaachiaadaappiaaeaaoeiaafaaaaadadaachiaadaaoeiaaeaaoeiaafaaaaad
aeaachiaaeaaoeiaadaaoelaabaaaaacadaaaiiaagaaaakaafaaaaadadaaciia
adaappiaabaaaakacaaaaaadaeaaciiaacaaffiaadaappiaafaaaaadadaaciia
abaakkiaaeaappiaafaaaaadabaachiaadaappiaaaaaoekaaeaaaaaeabaachia
adaaoeiaaaaaoekaabaaoeiaaeaaaaaeabaaciiaacaaaaiaahaaaakaahaaffka
abaaaaacaeaaaiiaafaaffkaaeaaaaaeabaaciiaadaaaakaabaappiaaeaappia
aeaaaaaeaaaachiaabaaoeiaabaappiaaeaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcfmagaaaaeaaaaaaajhabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajocaabaaaabaaaaaa
agbjbaaaafaaaaaaagaabaaaabaaaaaaagbjbaaaadaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaabacaaaaibcaabaaaabaaaaaa
egacbaaaacaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaahbcaabaaaacaaaaaa
jgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahccaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaa
acaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaabkaabaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaa
jgahbaaaabaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaadaaaaaaegbcbaaa
adaaaaaadeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaadkaabaaaabaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaacaaaaaabkaabaaaabaaaaaa
diaaaaaiocaabaaaacaaaaaafgafbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
dgcaaaagccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadcaaaaajecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaadkiacaaaaaaaaaaaajaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaai
lcaabaaaabaaaaaaagaabaaaabaaaaaaegiicaaaaaaaaaaaajaaaaaadcaaaaam
hcaabaaaabaaaaaaegadbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaakgakbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaajgahbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaamadcaaaaakicaabaaa
aaaaaaaaakiacaaaaaaaaaaaakaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaea
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
# 17 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.60009766, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1], texture[3], 2D;
TXP R3.x, fragment.texcoord[2], texture[2], 2D;
SLT R1.x, R0.w, c[0];
ADD R1.w, fragment.color.primary.x, c[1].x;
MUL R0.xyz, R0, fragment.color.primary.w;
MUL R0.xyz, R0, R1.w;
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[1].y;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[1].z;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL result.color.xyz, R0, R1;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
; 16 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c1, 0.60009766, 0.00000000, 1.00000000, 8.00000000
def c2, 2.00000000, 0, 0, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xy
dcl t2
texldp r1, t2, s2
texld r2, t0, s0
add_pp r0.x, r2.w, -c0
cmp r0.x, r0, c1.y, c1.z
mov_pp r0, -r0.x
mul_pp r2.xyz, r2, v0.w
texkill r0.xyzw
texld r0, t1, s3
mul_pp r3.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r3.xyz, r3, c1.w
mul_pp r0.xyz, r0, c2.x
min_pp r0.xyz, r3, r0
mul_pp r1.xyz, r3, r1.x
max_pp r1.xyz, r0, r1
add_pp r0.x, v0, c1
mul_pp r0.xyz, r2, r0.x
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 224
Float 208 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedomdbojgnlkffifnllbfceohpiklmkbbpabaaaaaanmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcnaacaaaaeaaaaaaaleaaaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
anaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaa
agajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
ddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaa
abaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdp
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 224
Float 208 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjafnegemlmkbcneefbflhjaobmloedihabaaaaaaliafaaaaaeaaaaaa
daaaaaaaaiacaaaaoaaeaaaaieafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
jeabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
aaababaaacacacaaaaaaanaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapka
jkjjbjdpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaacplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
aaaaoelaabaioekaacaaaaadabaacpiaaaaappiaaaaaaakbagaaaaacacaaaiia
acaapplaafaaaaadacaaadiaacaappiaacaaoelaabaaaaacadaaadiaaaaablla
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaaaaioekaecaaaaadacaacpia
adaaoeiaacaioekaacaaaaadabaacciaabaaaaiaabaaaaiaafaaaaadabaacoia
acaabliaabaaffiaafaaaaadacaaciiaacaappiaabaaffkaafaaaaadacaachia
acaaoeiaacaappiaakaaaaadadaachiaabaabliaacaaoeiaafaaaaadabaachia
abaaaaiaacaaoeiaalaaaaadacaachiaadaaoeiaabaaoeiaafaaaaadabaachia
aaaaoeiaabaapplaacaaaaadabaaciiaabaaaalaabaaaakaafaaaaadabaachia
abaappiaabaaoeiaafaaaaadaaaachiaacaaoeiaabaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcnaacaaaaeaaaaaaaleaaaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaa
jkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaajfaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapajaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
# 32 ALU, 5 TEX
PARAM c[5] = { program.local[0],
		{ 0.60009766, 2, 1, 8 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1], texture[4], 2D;
TEX R3.yw, fragment.texcoord[0], texture[1], 2D;
TXP R4.x, fragment.texcoord[2], texture[2], 2D;
MAD R3.xy, R3.wyzw, c[1].y, -c[1].z;
SLT R1.x, R0.w, c[0];
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R3.z, R3, R3.w;
ADD R3.z, -R3, c[1];
RSQ R3.z, R3.z;
RCP R3.z, R3.z;
MUL R2.xyz, R2.w, R2;
DP3_SAT R4.w, R3, c[2];
DP3_SAT R4.y, R3, c[4];
DP3_SAT R4.z, R3, c[3];
MUL R2.xyz, R2, R4.yzww;
DP3 R2.w, R2, c[1].w;
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[3], 2D;
MUL R2.xyz, R1.w, R1;
MUL R3.xyz, R2, R2.w;
MUL R2.xyz, R1, R4.x;
MUL R1.xyz, R3, c[1].w;
MUL R3.xyz, R2, c[1].y;
MUL R2.xyz, R1, R4.x;
MIN R1.xyz, R1, R3;
ADD R1.w, fragment.color.primary.x, c[1].x;
MAX R1.xyz, R1, R2;
MUL R0.xyz, R0, R1.w;
MUL result.color.xyz, R0, R1;
END
# 32 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
; 30 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c1, 0.00000000, 1.00000000, 0.60009766, 8.00000000
def c2, 2.00000000, -1.00000000, 0, 0
def c3, -0.40824828, -0.70710677, 0.57735026, 0
def c4, -0.40824831, 0.70710677, 0.57735026, 0
def c5, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xy
dcl t2
texld r3, t0, s0
texldp r5, t2, s2
texld r2, t1, s3
texld r1, t1, s4
add_pp r0.x, r3.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
mul_pp r1.xyz, r1.w, r1
texkill r0.xyzw
texld r0, t0, s1
mov r0.x, r0.w
mad_pp r4.xy, r0, c2.x, c2.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c1.y
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
dp3_pp_sat r0.z, r4, c3
dp3_pp_sat r0.y, r4, c4
dp3_pp_sat r0.x, r4, c5
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r2.w, r2
dp3_pp r0.x, r0, c1.w
mul_pp r0.xyz, r1, r0.x
mul_pp r1.xyz, r2, r5.x
mul_pp r0.xyz, r0, c1.w
mul_pp r2.xyz, r0, r5.x
mul_pp r1.xyz, r1, c2.x
min_pp r0.xyz, r0, r1
max_pp r1.xyz, r0, r2
add_pp r0.x, v0, c1.z
mul_pp r2.xyz, r3, v0.w
mul_pp r0.xyz, r2, r0.x
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r3
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 224
Float 208 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfkdkliaepobiapndchblefkahocmdahjabaaaaaaomafaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcoaaeaaaaeaaaaaaadiabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaanaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaak
ecaabaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaa
adaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaa
abaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaagaabaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaapgapbaaaabaaaaaaddaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 224
Float 208 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedepliikhleconclpicjgcjbnlgjfhdnbcabaaaaaaceajaaaaaeaaaaaa
daaaaaaageadaaaaemaiaaaapaaiaaaaebgpgodjcmadaaaacmadaaaaaaacpppp
oiacaaaaeeaaaaaaabaadiaaaaaaeeaaaaaaeeaaafaaceaaaaaaeeaaacaaaaaa
aaababaaabacacaaadadadaaaeaeaeaaaaaaanaaabaaaaaaaaaaaaaaaaacpppp
fbaaaaafabaaapkajkjjbjdpaaaaaaeaaaaaialpaaaaaaaafbaaaaafacaaapka
aaaaaaebdkmnbddpaaaaaaaaolaffbdpfbaaaaafadaaapkaomafnblopdaedfdp
dkmnbddpaaaaaaaafbaaaaafaeaaapkaolafnblopdaedflpdkmnbddpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
ecaaaaadaaaacpiaaaaaoelaabaioekaacaaaaadabaacpiaaaaappiaaaaaaakb
abaaaaacacaaadiaaaaabllaagaaaaacacaaaeiaacaapplaafaaaaadadaaadia
acaakkiaacaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaaeaioeka
ecaaaaadacaacpiaacaaoeiaadaioekaecaaaaadaeaacpiaaaaaoelaacaioeka
ecaaaaadadaacpiaadaaoeiaaaaioekaafaaaaadabaaciiaabaappiaacaaaaka
afaaaaadabaachiaabaaoeiaabaappiaaeaaaaaeafaacbiaaeaappiaabaaffka
abaakkkaaeaaaaaeafaacciaaeaaffiaabaaffkaabaakkkafkaaaaaeabaadiia
afaaoeiaafaaoeiaabaappkaacaaaaadabaaciiaabaappibabaakkkbahaaaaac
abaaciiaabaappiaagaaaaacafaaceiaabaappiaaiaaaaadaeaadbiaacaablka
afaaoeiaaiaaaaadaeaadciaadaaoekaafaaoeiaaiaaaaadaeaadeiaaeaaoeka
afaaoeiaaiaaaaadabaacbiaaeaaoeiaabaaoeiaafaaaaadacaaciiaacaappia
acaaaakaafaaaaadabaacoiaacaabliaacaappiaafaaaaadabaachiaabaaaaia
abaabliaacaaaaadabaaciiaadaaaaiaadaaaaiaafaaaaadadaachiaadaaaaia
abaaoeiaafaaaaadacaachiaacaaoeiaabaappiaakaaaaadaeaachiaacaaoeia
abaaoeiaalaaaaadabaachiaaeaaoeiaadaaoeiaafaaaaadacaachiaaaaaoeia
abaapplaacaaaaadabaaciiaabaaaalaabaaaakaafaaaaadacaachiaabaappia
acaaoeiaafaaaaadaaaachiaabaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoaaeaaaaeaaaaaaadiabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaanaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaak
ecaabaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaa
adaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaa
abaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaagaabaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaapgapbaaaabaaaaaaddaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "IGNOREPROJECTOR"="True" "RenderType"="AtsFoliage" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [unity_Scale]
Vector 21 [_Wind]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 70 ALU
PARAM c[25] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R0.x, c[0];
DP3 R1.x, R0.x, c[8];
ADD R0.x, vertex.color, R1;
ADD R1.y, vertex.color, R0.x;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[17].y;
DP3 R0.x, vertex.position, R1.y;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[23];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R2, R0;
MAD R0, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R0, R2, R0;
ADD R1.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R1.w, c[21];
MOV R0.w, vertex.position;
MUL R2.xy, vertex.color.yzzw, c[24].zxzw;
SLT R2.zw, c[24].y, vertex.normal.xyxz;
SLT R3.xy, vertex.normal.xzzw, c[24].y;
ADD R3.xy, R2.zwzw, -R3;
MUL R2.zw, R2.x, vertex.normal.xyxz;
MUL R2.xz, R2.zyww, R3.xyyw;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R1.zwzw, R2, R0;
MAD R2.xyz, R0, c[21].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[21];
MAD R0.xyz, R0, R1.x, R2;
DP4 R1.w, R0, c[8];
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
DP4 result.texcoord[3].z, R1, c[15];
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
DP3 R1.y, vertex.attrib[14], vertex.attrib[14];
RSQ R1.y, R1.y;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.x, R1.x;
MUL R3.xyz, R1.y, vertex.attrib[14];
MUL R2.xyz, R1.x, vertex.normal;
MUL R4.xyz, R2.zxyw, R3.yzxw;
MAD R4.xyz, R2.yzxw, R3.zxyw, -R4;
MOV R1.w, c[0].x;
MOV R1.xyz, c[18];
DP4 R5.z, R1, c[11];
DP4 R5.x, R1, c[9];
DP4 R5.y, R1, c[10];
MOV R1, c[19];
MAD R5.xyz, R5, c[20].w, -R0;
MUL R4.xyz, R4, vertex.attrib[14].w;
DP4 R6.z, R1, c[11];
DP4 R6.x, R1, c[9];
DP4 R6.y, R1, c[10];
MAD R1.xyz, R6, c[20].w, -R0;
DP3 result.texcoord[1].y, R1, R4;
DP3 result.texcoord[2].y, R4, R5;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP3 result.texcoord[1].z, R2, R1;
DP3 result.texcoord[1].x, R1, R3;
DP3 result.texcoord[2].z, R2, R5;
DP3 result.texcoord[2].x, R3, R5;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 70 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Wind]
Vector 21 [_MainTex_ST]
"vs_2_0
; 77 ALU
def c22, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c23, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c24, 2.00000000, 3.00000000, 0.22500001, 0.10000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c22.x, r0
add r0.y, v5.x, r0.x
add r0.z, v5.y, r0.y
mov r0.w, r0.y
add r1.xy, v0.xzzw, c16.y
dp3 r0.z, v0, r0.z
add r0.zw, r1.xyxy, r0
mul r1, r0.zzww, c23
frc r1, r1
mad r1, r1, c22.y, c22.z
frc r1, r1
mad r1, r1, c22.y, c22.w
abs r2, r1
mad r1, -r2, c24.x, c24.y
mul r2, r2, r2
mul r1, r2, r1
add r0.zw, r1.xyxz, r1.xyyw
mul r1.xyz, r0.w, c20
mov r1.w, v0
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r0.y, v5, c24.w
mul r2.xy, r0.y, v2.xzzw
mul r2.xz, r2.xyyw, r2.zyww
mul r2.y, v5.z, c24.z
mul r1.xyz, v5.z, r1
mad r1.xyz, r0.zwzw, r2, r1
mad r2.xyz, r1, c20.w, v0
mul r1.xyz, v5.z, c20
mad r1.xyz, r1, r0.x, r2
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 r0.y, v1, v1
rsq r0.y, r0.y
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r4.xyz, r0.y, v1
mul r3.xyz, r0.x, v2
mul r2.xyz, r3.zxyw, r4.yzxw
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r6.xyz, r5, c19.w, -r1
mad r2.xyz, r3.yzxw, r4.zxyw, -r2
mul r5.xyz, r2, v1.w
mov r0, c10
dp4 r7.z, c18, r0
mov r0, c9
mov r2, c8
dp4 r7.x, c18, r2
dp4 r7.y, c18, r0
mad r0.xyz, r7, c19.w, -r1
dp3 oT1.y, r0, r5
dp3 oT2.y, r5, r6
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r3, r0
dp3 oT1.x, r0, r4
dp3 oT2.z, r3, r6
dp3 oT2.x, r4, r6
mov oD0, v5
mad oT0.xy, v3, c21, c21.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkmofachhgiemabedghceebamlkcfjnbaabaaaaaaomalaaaaadaaaaaa
cmaaaaaapeaaaaaalaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcdeakaaaaeaaaabaainacaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaah
bccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaak
hcaabaaaaeaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaa
aeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaa
aaaaaaaabaaaaaahbccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedkcdjdhoaliegbnpmfnoebgledihphlicabaaaaaakebbaaaaaeaaaaaa
daaaaaaaoeafaaaacabaaaaaoibaaaaaebgpgodjkmafaaaakmafaaaaaaacpopp
daafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
afaaabaaaaaaaaaaaaaaalaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaajaaaoaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafbiaaapkaaaaaiadpaaaaaaea
aaaaaalpaaaaialpfbaaaaafbjaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdo
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaae
aaaaadoaadaaoejaagaaoekaagaaookaabaaaaacaaaaapiaajaaoekaafaaaaad
abaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabfaaoeka
aaaappiaaaaaoeiaabaaaaacabaaabiaaoaappkaabaaaaacabaaaciaapaappka
abaaaaacabaaaeiabaaappkaaiaaaaadaaaaaiiaabaaoeiabiaaaakaacaaaaad
abaaaciaaaaappiaafaaaajaacaaaaadabaaaeiaabaaffiaafaaffjaaiaaaaad
abaaabiaaaaaoejaabaakkiaacaaaaadacaaapiaaaaakajaahaaffkaacaaaaad
abaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeiabhaaoekabdaaaaac
abaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiabiaaffkabiaakkkabdaaaaac
abaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiabiaaffkabiaappkacdaaaaac
abaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeiaaeaaaaaeabaaapia
abaaoeiabjaaaakbbjaaffkaafaaaaadabaaapiaabaaoeiaacaaoeiaacaaaaad
abaaahiaabaanniaabaamiiaafaaaaadacaaahiaabaaffiaafaaoekaafaaaaad
acaaahiaacaaoeiaafaakkjaamaaaaadadaaadiaacaaoijbacaaoijaamaaaaad
adaaamiaacaaiejaacaaiejbacaaaaadadaaadiaadaaooibadaaoeiaafaaaaad
abaaaiiaafaaffjabjaakkkaafaaaaadadaaamiaabaappiaacaaiejaafaaaaad
adaaafiaadaaneiaadaapgiaafaaaaadadaaaciaafaakkjabjaappkaaeaaaaae
abaaahiaabaaoeiaadaaoeiaacaaoeiaaeaaaaaeabaaahiaabaaoeiaafaappka
aaaaoejaafaaaaadacaaahiaafaakkjaafaaoekaaeaaaaaeabaaahiaacaaoeia
aaaappiaabaaoeiaaeaaaaaeaaaaahiaaaaaoeiabgaappkaabaaoeibceaaaaac
acaaahiaabaaoejaaiaaaaadacaaaboaacaaoeiaaaaaoeiaceaaaaacadaaahia
acaaoejaafaaaaadaeaaahiaacaamjiaadaanciaaeaaaaaeaeaaahiaadaamjia
acaanciaaeaaoeibafaaaaadaeaaahiaaeaaoeiaabaappjaaiaaaaadacaaacoa
aeaaoeiaaaaaoeiaaiaaaaadacaaaeoaadaaoeiaaaaaoeiaabaaaaacaaaaahia
aiaaoekaafaaaaadafaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakeka
aaaaaaiaafaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaacaaaaad
aaaaahiaaaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeiabgaappkaabaaoeib
aiaaaaadadaaaboaacaaoeiaaaaaoeiaaiaaaaadadaaacoaaeaaoeiaaaaaoeia
aiaaaaadadaaaeoaadaaoeiaaaaaoeiaafaaaaadaaaaapiaabaaffiaapaaoeka
aeaaaaaeaaaaapiaaoaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
abaakkiaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaad
acaaahiaaaaaffiaacaaoekaaeaaaaaeacaaahiaabaaoekaaaaaaaiaacaaoeia
aeaaaaaeaaaaahiaadaaoekaaaaakkiaacaaoeiaaeaaaaaeaeaaahoaaeaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaapiaabaaffiaalaaoekaaeaaaaaeaaaaapia
akaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaabaakkiaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaafaaoeja
ppppaaaafdeieefcdeakaaaaeaaaabaainacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
afaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaa
adaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
adaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaheccabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaaeaaaaaajgaebaaa
adaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
aeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_Scale]
Vector 17 [_Wind]
Vector 18 [_MainTex_ST]
"!!ARBvp1.0
# 63 ALU
PARAM c[21] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..18],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0.x, c[0];
DP3 R0.w, R0.x, c[8];
ADD R0.x, vertex.color, R0.w;
ADD R0.z, vertex.color.y, R0.x;
MOV R0.y, R0.x;
MOV R3.w, c[0].x;
ADD R1.xy, vertex.position.xzzw, c[13].y;
DP3 R0.x, vertex.position, R0.z;
ADD R0.xy, R1, R0;
MUL R1, R0.xxyy, c[19];
FRC R1, R1;
MAD R1, R1, c[0].y, c[0].z;
FRC R1, R1;
MAD R1, R1, c[0].y, -c[0].x;
ABS R1, R1;
MAD R2, -R1, c[0].y, c[0].w;
MUL R1, R1, R1;
MUL R1, R1, R2;
ADD R2.xy, R1.xzzw, R1.ywzw;
MUL R0.xyz, R2.y, c[17];
MUL R1.zw, vertex.color.xyyz, c[20].xyzx;
SLT R2.zw, vertex.normal.xyxz, c[20].y;
SLT R1.xy, c[20].y, vertex.normal.xzzw;
ADD R1.xy, R1, -R2.zwzw;
MUL R2.zw, R1.z, vertex.normal.xyxz;
MUL R1.xz, R2.zyww, R1.xyyw;
MOV R1.y, R1.w;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R2.xyxw, R1, R0;
MAD R4.xyz, R0, c[17].w, vertex.position;
DP3 R0.y, vertex.attrib[14], vertex.attrib[14];
RSQ R0.y, R0.y;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R2.xyz, R0.y, vertex.attrib[14];
MUL R1.xyz, R0.x, vertex.normal;
MUL R3.xyz, R1.zxyw, R2.yzxw;
MAD R5.xyz, R1.yzxw, R2.zxyw, -R3;
MUL R0.xyz, vertex.color.z, c[17];
MAD R0.xyz, R0, R0.w, R4;
MOV R0.w, vertex.position;
MOV R3.xyz, c[14];
DP4 R4.z, R3, c[11];
DP4 R4.y, R3, c[10];
DP4 R4.x, R3, c[9];
MAD R4.xyz, R4, c[16].w, -R0;
MUL R3.xyz, R5, vertex.attrib[14].w;
DP3 result.texcoord[2].y, R3, R4;
DP3 result.texcoord[2].z, R1, R4;
DP3 result.texcoord[2].x, R2, R4;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV R0, c[15];
DP4 R4.z, R0, c[11];
DP4 R4.x, R0, c[9];
DP4 R4.y, R0, c[10];
DP3 result.texcoord[1].y, R4, R3;
DP3 result.texcoord[1].z, R1, R4;
DP3 result.texcoord[1].x, R4, R2;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 63 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_Scale]
Vector 16 [_Wind]
Vector 17 [_MainTex_ST]
"vs_2_0
; 68 ALU
def c18, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c19, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c20, 2.00000000, 3.00000000, 0.22500001, 0.10000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.w, c18.x, r0
add r0.y, v5.x, r0.w
add r0.x, v5.y, r0.y
add r1.xy, v0.xzzw, c12.y
dp3 r0.x, v0, r0.x
add r0.xy, r1, r0
mul r1, r0.xxyy, c19
frc r1, r1
mad r1, r1, c18.y, c18.z
frc r1, r1
mad r1, r1, c18.y, c18.w
abs r1, r1
mad r2, -r1, c20.x, c20.y
mul r1, r1, r1
mul r1, r1, r2
add r1.xy, r1.xzzw, r1.ywzw
mul r0.xyz, r1.y, c16
mul r1.z, v5.y, c20.w
mul r1.zw, r1.z, v2.xyxz
slt r2.zw, v2.xyxz, -v2.xyxz
slt r2.xy, -v2.xzzw, v2.xzzw
sub r2.xy, r2, r2.zwzw
mul r2.xz, r1.zyww, r2.xyyw
mov r1.w, c18.x
mul r2.y, v5.z, c20.z
mul r0.xyz, v5.z, r0
mad r0.xyz, r1.xyxw, r2, r0
mad r4.xyz, r0, c16.w, v0
dp3 r0.y, v1, v1
rsq r0.y, r0.y
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r3.xyz, r0.y, v1
mul r2.xyz, r0.x, v2
mul r0.xyz, v5.z, c16
mad r0.xyz, r0, r0.w, r4
mov r0.w, v0
mul r1.xyz, r2.zxyw, r3.yzxw
mad r4.xyz, r2.yzxw, r3.zxyw, -r1
mov r1.xyz, c13
dp4 r5.z, r1, c10
dp4 r5.y, r1, c9
dp4 r5.x, r1, c8
mad r1.xyz, r5, c15.w, -r0
mul r4.xyz, r4, v1.w
dp3 oT2.y, r4, r1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov r0, c10
dp4 r5.z, c14, r0
mov r0, c9
dp4 r5.y, c14, r0
dp3 oT2.z, r2, r1
dp3 oT2.x, r3, r1
mov r1, c8
dp4 r5.x, c14, r1
dp3 oT1.y, r5, r4
dp3 oT1.z, r2, r5
dp3 oT1.x, r5, r3
mov oD0, v5
mad oT0.xy, v3, c17, c17.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmjgjfgcobfjdpmkjjobajjigkohblopkabaaaaaagmakaaaaadaaaaaa
cmaaaaaapeaaaaaajiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaajfaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcmmaiaaaa
eaaaabaaddacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaa
egaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaa
abaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaa
fgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
agbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
dcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaaf
dcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaa
afaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaa
acaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaa
agaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaa
aaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaa
ahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaabaaaaaadiaaaaahhcaabaaaadaaaaaacgajbaaa
abaaaaaajgaebaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaabaaaaaa
cgajbaaaacaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaeaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbccabaaaadaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaaeaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaeaaaaaapgipcaaa
adaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaaaeaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaaeaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaadaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedphnpmjohkhacmbehnngiejliccpfokfpabaaaaaaieapaaaaaeaaaaaa
daaaaaaaeeafaaaabiaoaaaaoaaoaaaaebgpgodjamafaaaaamafaaaaaaacpopp
ieaeaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
abaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaaadaaaaaaaeaaagaa
aaaaaaaaadaaamaaadaaakaaaaaaaaaaadaabaaaafaaanaaaaaaaaaaaaaaaaaa
aaacpoppfbaaaaafbcaaapkamnmmpmdpamaceldpaaaamadomlkbefdofbaaaaaf
bdaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaafbeaaapkaaaaaaaea
aaaaeaeamnmmmmdnghggggdobpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaabaaaaac
aaaaapiaafaaoekaafaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaaeabaaahia
anaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaappiaaaaaoeiaceaaaaacabaaahiaabaaoeja
aiaaaaadacaaaboaabaaoeiaaaaaoeiaceaaaaacacaaahiaacaaoejaafaaaaad
adaaahiaabaamjiaacaanciaaeaaaaaeadaaahiaacaamjiaabaanciaadaaoeib
afaaaaadadaaahiaadaaoeiaabaappjaaiaaaaadacaaacoaadaaoeiaaaaaoeia
aiaaaaadacaaaeoaacaaoeiaaaaaoeiaabaaaaacaaaaabiaakaappkaabaaaaac
aaaaaciaalaappkaabaaaaacaaaaaeiaamaappkaaiaaaaadaaaaabiaaaaaoeia
bdaaaakaacaaaaadaeaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaaeaaffia
afaaffjaaiaaaaadaeaaabiaaaaaoejaaaaaffiaacaaaaadafaaapiaaaaakaja
adaaffkaacaaaaadaeaaapiaaeaafaiaafaaoeiaafaaaaadaeaaapiaaeaaoeia
bcaaoekabdaaaaacaeaaapiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiabdaaffka
bdaakkkabdaaaaacaeaaapiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiabdaaffka
bdaappkacdaaaaacaeaaapiaaeaaoeiaafaaaaadafaaapiaaeaaoeiaaeaaoeia
aeaaaaaeaeaaapiaaeaaoeiabeaaaakbbeaaffkaafaaaaadaeaaapiaaeaaoeia
afaaoeiaacaaaaadaaaaaoiaaeaaheiaaeaacaiaafaaaaadaeaaahiaaaaakkia
abaaoekaafaaaaadaeaaahiaaeaaoeiaafaakkjaamaaaaadafaaadiaacaaoijb
acaaoijaamaaaaadafaaamiaacaaiejaacaaiejbacaaaaadafaaadiaafaaooib
afaaoeiaafaaaaadabaaaiiaafaaffjabeaakkkaafaaaaadafaaamiaabaappia
acaaiejaafaaaaadafaaafiaafaaneiaafaapgiaafaaaaadafaaaciaafaakkja
beaappkaaeaaaaaeaaaaaoiaaaaaoeiaafaajaiaaeaajaiaaeaaaaaeaaaaaoia
aaaaoeiaabaappkaaaaajajaafaaaaadaeaaahiaafaakkjaabaaoekaaeaaaaae
aaaaahiaaeaaoeiaaaaaaaiaaaaapjiaabaaaaacaeaaahiaaeaaoekaafaaaaad
afaaahiaaeaaffiaaoaaoekaaeaaaaaeaeaaaliaanaakekaaeaaaaiaafaakeia
aeaaaaaeaeaaahiaapaaoekaaeaakkiaaeaapeiaacaaaaadaeaaahiaaeaaoeia
baaaoekaaeaaaaaeaeaaahiaaeaaoeiabbaappkaaaaaoeibaiaaaaadadaaaboa
abaaoeiaaeaaoeiaaiaaaaadadaaacoaadaaoeiaaeaaoeiaaiaaaaadadaaaeoa
acaaoeiaaeaaoeiaafaaaaadabaaapiaaaaaffiaahaaoekaaeaaaaaeabaaapia
agaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaafaaoeja
ppppaaaafdeieefcmmaiaaaaeaaaabaaddacaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaa
aaaaaaaadkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaa
baaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaa
afaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaai
pcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdo
bkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialp
diaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaa
abaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaa
dbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaa
ogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaak
fcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdo
aaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaa
diaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaaj
ocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaa
dcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaa
agbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ahaaaaaaogikcaaaaaaaaaaaahaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaadiaaaaah
hcaabaaaadaaaaaacgajbaaaabaaaaaajgaebaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaaeaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaa
aeaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
aeaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaa
baaaaaahbccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaabaaaaaah
eccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaaeaaaaaadiaaaaajhcaabaaa
aeaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaeaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaa
baaaaaahbccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
eccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaa
aeaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
jfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaakl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [unity_Scale]
Vector 21 [_Wind]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 71 ALU
PARAM c[25] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R0.x, c[0];
DP3 R1.x, R0.x, c[8];
ADD R0.x, vertex.color, R1;
ADD R1.y, vertex.color, R0.x;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[17].y;
DP3 R0.x, vertex.position, R1.y;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[23];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R2, R0;
MAD R0, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R0, R2, R0;
ADD R1.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R1.w, c[21];
MOV R0.w, vertex.position;
MUL R2.xy, vertex.color.yzzw, c[24].zxzw;
SLT R2.zw, c[24].y, vertex.normal.xyxz;
SLT R3.xy, vertex.normal.xzzw, c[24].y;
ADD R3.xy, R2.zwzw, -R3;
MUL R2.zw, R2.x, vertex.normal.xyxz;
MUL R2.xz, R2.zyww, R3.xyyw;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R1.zwzw, R2, R0;
MAD R2.xyz, R0, c[21].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[21];
MAD R0.xyz, R0, R1.x, R2;
DP4 R1.w, R0, c[8];
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
DP4 result.texcoord[3].w, R1, c[16];
DP4 result.texcoord[3].z, R1, c[15];
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
DP3 R1.y, vertex.attrib[14], vertex.attrib[14];
RSQ R1.y, R1.y;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.x, R1.x;
MUL R3.xyz, R1.y, vertex.attrib[14];
MUL R2.xyz, R1.x, vertex.normal;
MUL R4.xyz, R2.zxyw, R3.yzxw;
MAD R4.xyz, R2.yzxw, R3.zxyw, -R4;
MOV R1.w, c[0].x;
MOV R1.xyz, c[18];
DP4 R5.z, R1, c[11];
DP4 R5.x, R1, c[9];
DP4 R5.y, R1, c[10];
MOV R1, c[19];
MAD R5.xyz, R5, c[20].w, -R0;
MUL R4.xyz, R4, vertex.attrib[14].w;
DP4 R6.z, R1, c[11];
DP4 R6.x, R1, c[9];
DP4 R6.y, R1, c[10];
MAD R1.xyz, R6, c[20].w, -R0;
DP3 result.texcoord[1].y, R1, R4;
DP3 result.texcoord[2].y, R4, R5;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP3 result.texcoord[1].z, R2, R1;
DP3 result.texcoord[1].x, R1, R3;
DP3 result.texcoord[2].z, R2, R5;
DP3 result.texcoord[2].x, R3, R5;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 71 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Wind]
Vector 21 [_MainTex_ST]
"vs_2_0
; 78 ALU
def c22, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c23, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c24, 2.00000000, 3.00000000, 0.22500001, 0.10000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c22.x, r0
add r0.y, v5.x, r0.x
add r0.z, v5.y, r0.y
mov r0.w, r0.y
add r1.xy, v0.xzzw, c16.y
dp3 r0.z, v0, r0.z
add r0.zw, r1.xyxy, r0
mul r1, r0.zzww, c23
frc r1, r1
mad r1, r1, c22.y, c22.z
frc r1, r1
mad r1, r1, c22.y, c22.w
abs r2, r1
mad r1, -r2, c24.x, c24.y
mul r2, r2, r2
mul r1, r2, r1
add r0.zw, r1.xyxz, r1.xyyw
mul r1.xyz, r0.w, c20
mov r1.w, v0
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r0.y, v5, c24.w
mul r2.xy, r0.y, v2.xzzw
mul r2.xz, r2.xyyw, r2.zyww
mul r2.y, v5.z, c24.z
mul r1.xyz, v5.z, r1
mad r1.xyz, r0.zwzw, r2, r1
mad r2.xyz, r1, c20.w, v0
mul r1.xyz, v5.z, c20
mad r1.xyz, r1, r0.x, r2
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 r0.y, v1, v1
rsq r0.y, r0.y
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r4.xyz, r0.y, v1
mul r3.xyz, r0.x, v2
mul r2.xyz, r3.zxyw, r4.yzxw
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r6.xyz, r5, c19.w, -r1
mad r2.xyz, r3.yzxw, r4.zxyw, -r2
mul r5.xyz, r2, v1.w
mov r0, c10
dp4 r7.z, c18, r0
mov r0, c9
mov r2, c8
dp4 r7.x, c18, r2
dp4 r7.y, c18, r0
mad r0.xyz, r7, c19.w, -r1
dp3 oT1.y, r0, r5
dp3 oT2.y, r5, r6
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r3, r0
dp3 oT1.x, r0, r4
dp3 oT2.z, r3, r6
dp3 oT2.x, r4, r6
mov oD0, v5
mad oT0.xy, v3, c21, c21.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedpaeeeihffnehipgpkohndkplpedlancfabaaaaaaomalaaaaadaaaaaa
cmaaaaaapeaaaaaalaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcdeakaaaaeaaaabaainacaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaah
bccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaak
hcaabaaaaeaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaa
aeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaa
aaaaaaaabaaaaaahbccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaafaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedpdhhbcbogljmaoohdaimnmadcgeljoamabaaaaaakebbaaaaaeaaaaaa
daaaaaaaoeafaaaacabaaaaaoibaaaaaebgpgodjkmafaaaakmafaaaaaaacpopp
daafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
afaaabaaaaaaaaaaaaaaalaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaajaaaoaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafbiaaapkaaaaaiadpaaaaaaea
aaaaaalpaaaaialpfbaaaaafbjaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdo
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaae
aaaaadoaadaaoejaagaaoekaagaaookaabaaaaacaaaaapiaajaaoekaafaaaaad
abaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabfaaoeka
aaaappiaaaaaoeiaabaaaaacabaaabiaaoaappkaabaaaaacabaaaciaapaappka
abaaaaacabaaaeiabaaappkaaiaaaaadaaaaaiiaabaaoeiabiaaaakaacaaaaad
abaaaciaaaaappiaafaaaajaacaaaaadabaaaeiaabaaffiaafaaffjaaiaaaaad
abaaabiaaaaaoejaabaakkiaacaaaaadacaaapiaaaaakajaahaaffkaacaaaaad
abaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeiabhaaoekabdaaaaac
abaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiabiaaffkabiaakkkabdaaaaac
abaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiabiaaffkabiaappkacdaaaaac
abaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeiaaeaaaaaeabaaapia
abaaoeiabjaaaakbbjaaffkaafaaaaadabaaapiaabaaoeiaacaaoeiaacaaaaad
abaaahiaabaanniaabaamiiaafaaaaadacaaahiaabaaffiaafaaoekaafaaaaad
acaaahiaacaaoeiaafaakkjaamaaaaadadaaadiaacaaoijbacaaoijaamaaaaad
adaaamiaacaaiejaacaaiejbacaaaaadadaaadiaadaaooibadaaoeiaafaaaaad
abaaaiiaafaaffjabjaakkkaafaaaaadadaaamiaabaappiaacaaiejaafaaaaad
adaaafiaadaaneiaadaapgiaafaaaaadadaaaciaafaakkjabjaappkaaeaaaaae
abaaahiaabaaoeiaadaaoeiaacaaoeiaaeaaaaaeabaaahiaabaaoeiaafaappka
aaaaoejaafaaaaadacaaahiaafaakkjaafaaoekaaeaaaaaeabaaahiaacaaoeia
aaaappiaabaaoeiaaeaaaaaeaaaaahiaaaaaoeiabgaappkaabaaoeibceaaaaac
acaaahiaabaaoejaaiaaaaadacaaaboaacaaoeiaaaaaoeiaceaaaaacadaaahia
acaaoejaafaaaaadaeaaahiaacaamjiaadaanciaaeaaaaaeaeaaahiaadaamjia
acaanciaaeaaoeibafaaaaadaeaaahiaaeaaoeiaabaappjaaiaaaaadacaaacoa
aeaaoeiaaaaaoeiaaiaaaaadacaaaeoaadaaoeiaaaaaoeiaabaaaaacaaaaahia
aiaaoekaafaaaaadafaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakeka
aaaaaaiaafaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaacaaaaad
aaaaahiaaaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeiabgaappkaabaaoeib
aiaaaaadadaaaboaacaaoeiaaaaaoeiaaiaaaaadadaaacoaaeaaoeiaaaaaoeia
aiaaaaadadaaaeoaadaaoeiaaaaaoeiaafaaaaadaaaaapiaabaaffiaapaaoeka
aeaaaaaeaaaaapiaaoaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
abaakkiaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaad
acaaapiaaaaaffiaacaaoekaaeaaaaaeacaaapiaabaaoekaaaaaaaiaacaaoeia
aeaaaaaeacaaapiaadaaoekaaaaakkiaacaaoeiaaeaaaaaeaeaaapoaaeaaoeka
aaaappiaacaaoeiaafaaaaadaaaaapiaabaaffiaalaaoekaaeaaaaaeaaaaapia
akaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaabaakkiaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaafaaoeja
ppppaaaafdeieefcdeakaaaaeaaaabaainacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
afaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaa
adaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
adaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaheccabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaaeaaaaaajgaebaaa
adaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
aeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaa
aeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaa
egiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaakl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [unity_Scale]
Vector 21 [_Wind]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 70 ALU
PARAM c[25] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R0.x, c[0];
DP3 R1.x, R0.x, c[8];
ADD R0.x, vertex.color, R1;
ADD R1.y, vertex.color, R0.x;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[17].y;
DP3 R0.x, vertex.position, R1.y;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[23];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R2, R0;
MAD R0, -R2, c[0].y, c[0].w;
MUL R2, R2, R2;
MUL R0, R2, R0;
ADD R1.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R1.w, c[21];
MOV R0.w, vertex.position;
MUL R2.xy, vertex.color.yzzw, c[24].zxzw;
SLT R2.zw, c[24].y, vertex.normal.xyxz;
SLT R3.xy, vertex.normal.xzzw, c[24].y;
ADD R3.xy, R2.zwzw, -R3;
MUL R2.zw, R2.x, vertex.normal.xyxz;
MUL R2.xz, R2.zyww, R3.xyyw;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R1.zwzw, R2, R0;
MAD R2.xyz, R0, c[21].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[21];
MAD R0.xyz, R0, R1.x, R2;
DP4 R1.w, R0, c[8];
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
DP4 result.texcoord[3].z, R1, c[15];
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
DP3 R1.y, vertex.attrib[14], vertex.attrib[14];
RSQ R1.y, R1.y;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.x, R1.x;
MUL R3.xyz, R1.y, vertex.attrib[14];
MUL R2.xyz, R1.x, vertex.normal;
MUL R4.xyz, R2.zxyw, R3.yzxw;
MAD R4.xyz, R2.yzxw, R3.zxyw, -R4;
MOV R1.w, c[0].x;
MOV R1.xyz, c[18];
DP4 R5.z, R1, c[11];
DP4 R5.x, R1, c[9];
DP4 R5.y, R1, c[10];
MOV R1, c[19];
MAD R5.xyz, R5, c[20].w, -R0;
MUL R4.xyz, R4, vertex.attrib[14].w;
DP4 R6.z, R1, c[11];
DP4 R6.x, R1, c[9];
DP4 R6.y, R1, c[10];
MAD R1.xyz, R6, c[20].w, -R0;
DP3 result.texcoord[1].y, R1, R4;
DP3 result.texcoord[2].y, R4, R5;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP3 result.texcoord[1].z, R2, R1;
DP3 result.texcoord[1].x, R1, R3;
DP3 result.texcoord[2].z, R2, R5;
DP3 result.texcoord[2].x, R3, R5;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 70 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Wind]
Vector 21 [_MainTex_ST]
"vs_2_0
; 77 ALU
def c22, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c23, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c24, 2.00000000, 3.00000000, 0.22500001, 0.10000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c22.x, r0
add r0.y, v5.x, r0.x
add r0.z, v5.y, r0.y
mov r0.w, r0.y
add r1.xy, v0.xzzw, c16.y
dp3 r0.z, v0, r0.z
add r0.zw, r1.xyxy, r0
mul r1, r0.zzww, c23
frc r1, r1
mad r1, r1, c22.y, c22.z
frc r1, r1
mad r1, r1, c22.y, c22.w
abs r2, r1
mad r1, -r2, c24.x, c24.y
mul r2, r2, r2
mul r1, r2, r1
add r0.zw, r1.xyxz, r1.xyyw
mul r1.xyz, r0.w, c20
mov r1.w, v0
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r0.y, v5, c24.w
mul r2.xy, r0.y, v2.xzzw
mul r2.xz, r2.xyyw, r2.zyww
mul r2.y, v5.z, c24.z
mul r1.xyz, v5.z, r1
mad r1.xyz, r0.zwzw, r2, r1
mad r2.xyz, r1, c20.w, v0
mul r1.xyz, v5.z, c20
mad r1.xyz, r1, r0.x, r2
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 r0.y, v1, v1
rsq r0.y, r0.y
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r4.xyz, r0.y, v1
mul r3.xyz, r0.x, v2
mul r2.xyz, r3.zxyw, r4.yzxw
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r6.xyz, r5, c19.w, -r1
mad r2.xyz, r3.yzxw, r4.zxyw, -r2
mul r5.xyz, r2, v1.w
mov r0, c10
dp4 r7.z, c18, r0
mov r0, c9
mov r2, c8
dp4 r7.x, c18, r2
dp4 r7.y, c18, r0
mad r0.xyz, r7, c19.w, -r1
dp3 oT1.y, r0, r5
dp3 oT2.y, r5, r6
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r3, r0
dp3 oT1.x, r0, r4
dp3 oT2.z, r3, r6
dp3 oT2.x, r4, r6
mov oD0, v5
mad oT0.xy, v3, c21, c21.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkmofachhgiemabedghceebamlkcfjnbaabaaaaaaomalaaaaadaaaaaa
cmaaaaaapeaaaaaalaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcdeakaaaaeaaaabaainacaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaah
bccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaak
hcaabaaaaeaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaa
aeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaa
aaaaaaaabaaaaaahbccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedkcdjdhoaliegbnpmfnoebgledihphlicabaaaaaakebbaaaaaeaaaaaa
daaaaaaaoeafaaaacabaaaaaoibaaaaaebgpgodjkmafaaaakmafaaaaaaacpopp
daafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
afaaabaaaaaaaaaaaaaaalaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaajaaaoaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafbiaaapkaaaaaiadpaaaaaaea
aaaaaalpaaaaialpfbaaaaafbjaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdo
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaae
aaaaadoaadaaoejaagaaoekaagaaookaabaaaaacaaaaapiaajaaoekaafaaaaad
abaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabfaaoeka
aaaappiaaaaaoeiaabaaaaacabaaabiaaoaappkaabaaaaacabaaaciaapaappka
abaaaaacabaaaeiabaaappkaaiaaaaadaaaaaiiaabaaoeiabiaaaakaacaaaaad
abaaaciaaaaappiaafaaaajaacaaaaadabaaaeiaabaaffiaafaaffjaaiaaaaad
abaaabiaaaaaoejaabaakkiaacaaaaadacaaapiaaaaakajaahaaffkaacaaaaad
abaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeiabhaaoekabdaaaaac
abaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiabiaaffkabiaakkkabdaaaaac
abaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiabiaaffkabiaappkacdaaaaac
abaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeiaaeaaaaaeabaaapia
abaaoeiabjaaaakbbjaaffkaafaaaaadabaaapiaabaaoeiaacaaoeiaacaaaaad
abaaahiaabaanniaabaamiiaafaaaaadacaaahiaabaaffiaafaaoekaafaaaaad
acaaahiaacaaoeiaafaakkjaamaaaaadadaaadiaacaaoijbacaaoijaamaaaaad
adaaamiaacaaiejaacaaiejbacaaaaadadaaadiaadaaooibadaaoeiaafaaaaad
abaaaiiaafaaffjabjaakkkaafaaaaadadaaamiaabaappiaacaaiejaafaaaaad
adaaafiaadaaneiaadaapgiaafaaaaadadaaaciaafaakkjabjaappkaaeaaaaae
abaaahiaabaaoeiaadaaoeiaacaaoeiaaeaaaaaeabaaahiaabaaoeiaafaappka
aaaaoejaafaaaaadacaaahiaafaakkjaafaaoekaaeaaaaaeabaaahiaacaaoeia
aaaappiaabaaoeiaaeaaaaaeaaaaahiaaaaaoeiabgaappkaabaaoeibceaaaaac
acaaahiaabaaoejaaiaaaaadacaaaboaacaaoeiaaaaaoeiaceaaaaacadaaahia
acaaoejaafaaaaadaeaaahiaacaamjiaadaanciaaeaaaaaeaeaaahiaadaamjia
acaanciaaeaaoeibafaaaaadaeaaahiaaeaaoeiaabaappjaaiaaaaadacaaacoa
aeaaoeiaaaaaoeiaaiaaaaadacaaaeoaadaaoeiaaaaaoeiaabaaaaacaaaaahia
aiaaoekaafaaaaadafaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakeka
aaaaaaiaafaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaacaaaaad
aaaaahiaaaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeiabgaappkaabaaoeib
aiaaaaadadaaaboaacaaoeiaaaaaoeiaaiaaaaadadaaacoaaeaaoeiaaaaaoeia
aiaaaaadadaaaeoaadaaoeiaaaaaoeiaafaaaaadaaaaapiaabaaffiaapaaoeka
aeaaaaaeaaaaapiaaoaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
abaakkiaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaad
acaaahiaaaaaffiaacaaoekaaeaaaaaeacaaahiaabaaoekaaaaaaaiaacaaoeia
aeaaaaaeaaaaahiaadaaoekaaaaakkiaacaaoeiaaeaaaaaeaeaaahoaaeaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaapiaabaaffiaalaaoekaaeaaaaaeaaaaapia
akaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaabaakkiaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaafaaoeja
ppppaaaafdeieefcdeakaaaaeaaaabaainacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
afaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaa
adaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
adaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaafaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaheccabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaaeaaaaaajgaebaaa
adaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
aeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaakl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [unity_Scale]
Vector 21 [_Wind]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 69 ALU
PARAM c[25] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.22500001, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0.x, c[0];
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
DP3 R2.y, vertex.attrib[14], vertex.attrib[14];
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[17].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[23];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R1, R0;
MAD R0, -R1, c[0].y, c[0].w;
MUL R1, R1, R1;
MUL R0, R1, R0;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[21];
MUL R1.zw, vertex.color.xyyz, c[24].xyzx;
SLT R3.xy, vertex.normal.xzzw, c[24].y;
SLT R1.xy, c[24].y, vertex.normal.xzzw;
ADD R1.xy, R1, -R3;
MUL R3.xy, R1.z, vertex.normal.xzzw;
MUL R1.xz, R3.xyyw, R1.xyyw;
MOV R1.y, R1.w;
RSQ R2.y, R2.y;
MUL R0.xyz, vertex.color.z, R0;
MAD R0.xyz, R2.zwzw, R1, R0;
MAD R1.xyz, R0, c[21].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[21];
MAD R1.xyz, R0, R2.x, R1;
MOV R1.w, vertex.position;
DP3 R2.x, vertex.normal, vertex.normal;
MUL R3.xyz, R2.y, vertex.attrib[14];
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, vertex.normal;
MUL R4.xyz, R2.zxyw, R3.yzxw;
MAD R4.xyz, R2.yzxw, R3.zxyw, -R4;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV R0.xyz, c[18];
MOV R0.w, c[0].x;
MUL R4.xyz, R4, vertex.attrib[14].w;
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[20].w, -R1;
DP3 result.texcoord[2].y, R4, R0;
DP3 result.texcoord[2].z, R2, R0;
DP3 result.texcoord[2].x, R3, R0;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
MOV R1, c[19];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R4;
DP3 result.texcoord[1].z, R2, R0;
DP3 result.texcoord[1].x, R0, R3;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 69 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Wind]
Vector 21 [_MainTex_ST]
"vs_2_0
; 74 ALU
def c22, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c23, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c24, 2.00000000, 3.00000000, 0.22500001, 0.10000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c22.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
dp3 r2.y, v1, v1
add r0.zw, v0.xyxz, c16.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c23
frc r0, r0
mad r0, r0, c22.y, c22.z
frc r0, r0
mad r0, r0, c22.y, c22.w
abs r1, r0
mad r0, -r1, c24.x, c24.y
mul r1, r1, r1
mul r0, r1, r0
add r1.xy, r0.xzzw, r0.ywzw
mul r0.xyz, r1.y, c20
slt r1.zw, -v2.xyxz, v2.xyxz
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r1, r2
mul r0.w, v5.y, c24
mul r1.zw, r0.w, v2.xyxz
mov r0.w, v0
mul r3.xz, r1.zyww, r2.zyww
mul r3.y, v5.z, c24.z
mul r0.xyz, v5.z, r0
mad r0.xyz, r1.xyxw, r3, r0
mad r1.xyz, r0, c20.w, v0
rsq r2.y, r2.y
mul r0.xyz, v5.z, c20
mad r0.xyz, r0, r2.x, r1
dp3 r2.x, v2, v2
mul r3.xyz, r2.y, v1
rsq r2.x, r2.x
mul r2.xyz, r2.x, v2
mul r4.xyz, r2.zxyw, r3.yzxw
mad r4.xyz, r2.yzxw, r3.zxyw, -r4
dp4 r1.w, r0, c7
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
dp4 oT3.y, r1, c13
dp4 oT3.x, r1, c12
mov r1.w, c22.x
mov r1.xyz, c17
dp4 r5.z, r1, c10
dp4 r5.x, r1, c8
dp4 r5.y, r1, c9
mad r1.xyz, r5, c19.w, -r0
mul r4.xyz, r4, v1.w
dp3 oT2.y, r4, r1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov r0, c10
dp4 r5.z, c18, r0
mov r0, c9
dp4 r5.y, c18, r0
dp3 oT2.z, r2, r1
dp3 oT2.x, r3, r1
mov r1, c8
dp4 r5.x, c18, r1
dp3 oT1.y, r5, r4
dp3 oT1.z, r2, r5
dp3 oT1.x, r5, r3
mov oD0, v5
mad oT0.xy, v3, c21, c21.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednmniaafpfhpkmpemadfcmhgfjoaecmaeabaaaaaamaalaaaaadaaaaaa
cmaaaaaapeaaaaaalaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcaiakaaaaeaaaabaaicacaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaabaaaaaaegaabaaa
abaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaa
abaaaaaaagaebaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaacgajbaaaabaaaaaajgaebaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaaeaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaaeaaaaaa
diaaaaajhcaabaaaaeaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaeaaaaaaaaaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaaeaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaia
ebaaaaaaaaaaaaaabaaaaaahbccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaaheccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 112 [_Wind]
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedaooffjlgheipmpkhlaebaaagjdegpjggabaaaaaagebbaaaaaeaaaaaa
daaaaaaanaafaaaaoaapaaaakibaaaaaebgpgodjjiafaaaajiafaaaaaaacpopp
bmafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
afaaabaaaaaaaaaaaaaaalaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaajaaaoaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafbiaaapkaaaaaiadpaaaaaaea
aaaaaalpaaaaialpfbaaaaafbjaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdo
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaae
aaaaadoaadaaoejaagaaoekaagaaookaabaaaaacaaaaapiaajaaoekaafaaaaad
abaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabfaaoeka
aaaappiaaaaaoeiaceaaaaacabaaahiaabaaoejaaiaaaaadacaaaboaabaaoeia
aaaaoeiaceaaaaacacaaahiaacaaoejaafaaaaadadaaahiaabaamjiaacaancia
aeaaaaaeadaaahiaacaamjiaabaanciaadaaoeibafaaaaadadaaahiaadaaoeia
abaappjaaiaaaaadacaaacoaadaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeia
aaaaoeiaabaaaaacaaaaahiaaiaaoekaafaaaaadaeaaahiaaaaaffiabdaaoeka
aeaaaaaeaaaaaliabcaakekaaaaaaaiaaeaakeiaaeaaaaaeaaaaahiabeaaoeka
aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabfaaoekaabaaaaacaeaaabia
aoaappkaabaaaaacaeaaaciaapaappkaabaaaaacaeaaaeiabaaappkaaiaaaaad
aaaaaiiaaeaaoeiabiaaaakaacaaaaadaeaaaciaaaaappiaafaaaajaacaaaaad
abaaaiiaaeaaffiaafaaffjaaiaaaaadaeaaabiaaaaaoejaabaappiaacaaaaad
afaaapiaaaaakajaahaaffkaacaaaaadaeaaapiaaeaafaiaafaaoeiaafaaaaad
aeaaapiaaeaaoeiabhaaoekabdaaaaacaeaaapiaaeaaoeiaaeaaaaaeaeaaapia
aeaaoeiabiaaffkabiaakkkabdaaaaacaeaaapiaaeaaoeiaaeaaaaaeaeaaapia
aeaaoeiabiaaffkabiaappkacdaaaaacaeaaapiaaeaaoeiaafaaaaadafaaapia
aeaaoeiaaeaaoeiaaeaaaaaeaeaaapiaaeaaoeiabjaaaakbbjaaffkaafaaaaad
aeaaapiaaeaaoeiaafaaoeiaacaaaaadaeaaahiaaeaanniaaeaamiiaafaaaaad
afaaahiaaeaaffiaafaaoekaafaaaaadafaaahiaafaaoeiaafaakkjaamaaaaad
agaaadiaacaaoijbacaaoijaamaaaaadagaaamiaacaaiejaacaaiejbacaaaaad
agaaadiaagaaooibagaaoeiaafaaaaadabaaaiiaafaaffjabjaakkkaafaaaaad
agaaamiaabaappiaacaaiejaafaaaaadagaaafiaagaaneiaagaapgiaafaaaaad
agaaaciaafaakkjabjaappkaaeaaaaaeaeaaahiaaeaaoeiaagaaoeiaafaaoeia
aeaaaaaeaeaaahiaaeaaoeiaafaappkaaaaaoejaafaaaaadafaaahiaafaakkja
afaaoekaaeaaaaaeaeaaahiaafaaoeiaaaaappiaaeaaoeiaaeaaaaaeaaaaahia
aaaaoeiabgaappkaaeaaoeibaiaaaaadadaaaboaabaaoeiaaaaaoeiaaiaaaaad
adaaacoaadaaoeiaaaaaoeiaaiaaaaadadaaaeoaacaaoeiaaaaaoeiaafaaaaad
aaaaapiaaeaaffiaapaaoekaaeaaaaaeaaaaapiaaoaaoekaaeaaaaiaaaaaoeia
aeaaaaaeaaaaapiabaaaoekaaeaakkiaaaaaoeiaaeaaaaaeaaaaapiabbaaoeka
aaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaobkaaeaaaaaeaaaaadia
abaaobkaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaobkaaaaakkiaaaaaoeia
aeaaaaaeaaaaamoaaeaabekaaaaappiaaaaaeeiaafaaaaadaaaaapiaaeaaffia
alaaoekaaeaaaaaeaaaaapiaakaaoekaaeaaaaiaaaaaoeiaaeaaaaaeaaaaapia
amaaoekaaeaakkiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaapoaafaaoejappppaaaafdeieefcaiakaaaaeaaaabaaicacaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaahaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaabaaaaaaegaabaaa
abaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaa
abaaaaaaagaebaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaacgajbaaaabaaaaaajgaebaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaaeaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaabaaaaaaheccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaaeaaaaaa
diaaaaajhcaabaaaaeaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaeaaaaaaaaaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaaeaaaaaapgipcaaaadaaaaaabeaaaaaaegacbaia
ebaaaaaaaaaaaaaabaaaaaahbccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaaheccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaa
knaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
# 47 ALU, 3 TEX
PARAM c[7] = { program.local[0..4],
		{ 0.60009766, 2, 1, 0.39990234 },
		{ 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R5, fragment.texcoord[0], texture[1], 2D;
SLT R1.y, R0.w, c[4].x;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
DP3 R2.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.y, R2.y;
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R3.xyz, R2.y, fragment.texcoord[1];
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[2];
ADD R4.xyz, R2, R3;
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
TEX R2.w, R1.x, texture[2], 2D;
KIL -R1.y;
MAD R1.xy, R5.wyzw, c[5].y, -c[5].z;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R1.w, R4, R4;
RSQ R1.w, R1.w;
MUL R4.xyz, R1.w, R4;
ADD R1.z, -R1, c[5];
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.w, R1, R4;
MOV R1.w, c[6].y;
MUL R4.x, R1.w, c[1];
MAX R1.w, R3, c[6].x;
POW R3.w, R1.w, R4.x;
DP3 R1.w, R3, R1;
DP3_SAT R1.x, R2, -R3;
MAD R2.y, R1.w, c[5].x, c[5].w;
MUL R1.y, R5.z, R3.w;
MOV_SAT R3.w, -R1;
ADD R2.x, R1, -R3.w;
MAD R2.x, R2, c[3], R3.w;
MUL R1.w, R2.x, R5.x;
MAX R3.x, R2.y, c[6];
MUL R2.xyz, R1.w, c[2];
ADD R1.w, fragment.color.primary.x, c[5].x;
MUL R1.xyz, R1.y, c[0];
MAD R2.xyz, R2, c[5].y, R3.x;
MUL R0.xyz, R0, R1.w;
MUL R0.xyz, R0, R2;
MAD R0.xyz, R0, c[0], R1;
MUL R0.xyz, R2.w, R0;
MUL result.color.xyz, R0, c[5].y;
END
# 47 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
; 51 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.00000000, 1.00000000, 0.60009766, 0.39990234
def c6, 2.00000000, -1.00000000, 128.00000000, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
add_pp r1.x, r0.w, -c4
cmp r1.x, r1, c5, c5.y
mov_pp r1, -r1.x
dp3 r2.x, t3, t3
mov r2.xy, r2.x
dp3_pp r4.x, t1, t1
dp3_pp r5.x, t2, t2
rsq_pp r4.x, r4.x
rsq_pp r5.x, r5.x
mul_pp r4.xyz, r4.x, t1
mul_pp r5.xyz, r5.x, t2
add_pp r6.xyz, r5, r4
dp3_pp r7.x, r6, r6
rsq_pp r7.x, r7.x
mul_pp r6.xyz, r7.x, r6
mul_pp r0.xyz, r0, v0.w
texkill r1.xyzw
texld r1, t0, s1
texld r2, r2, s2
mov r3.y, r1
mov r3.x, r1.w
mad_pp r8.xy, r3, c6.x, c6.y
mul_pp r3.xy, r8, r8
add_pp_sat r3.x, r3, r3.y
add_pp r3.x, -r3, c5.y
rsq_pp r3.x, r3.x
rcp_pp r8.z, r3.x
mov_pp r3.x, c1
dp3_pp r6.x, r8, r6
mul_pp r3.x, c6.z, r3
max_pp r6.x, r6, c5
pow_pp r7.y, r6.x, r3.x
dp3_pp r6.x, r4, r8
mov_pp r3.x, r7.y
mul_pp r3.x, r1.z, r3
dp3_pp_sat r4.x, r5, -r4
mov_pp_sat r7.x, -r6
add_pp r4.x, r4, -r7
mad_pp r4.x, r4, c3, r7
mul_pp r1.x, r4, r1
mad_pp r5.x, r6, c5.z, c5.w
max_pp r4.x, r5, c5
mul_pp r1.xyz, r1.x, c2
mad_pp r1.xyz, r1, c6.x, r4.x
add_pp r4.x, v0, c5.z
mul_pp r0.xyz, r0, r4.x
mul_pp r3.xyz, r3.x, c0
mul_pp r0.xyz, r0, r1
mad_pp r0.xyz, r0, c0, r3
mul_pp r0.xyz, r2.x, r0
mul_pp r0.xyz, r0, c6.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlmfafmoiilkjfhkhfcplnjeiefgnenjmabaaaaaagmahaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
eiagaaaaeaaaaaaajcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
jcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaamaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabacaaaaiicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
aeaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaa
egaabaaaaeaaaaaaegaabaaaaeaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaeaaaaaabkaabaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadgcaaaag
icaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamlcaabaaa
abaaaaaaegaibaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaea
fgafbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegaibaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegadbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbpdjdbpbgdnbiclimbolgldcfocdecghabaaaaaaaialaaaaaeaaaaaa
daaaaaaamiadaaaabiakaaaaneakaaaaebgpgodjjaadaaaajaadaaaaaaacpppp
dmadaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaaaaaaaaaa
aaaaamaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkajkjjbjdpaaaaaaea
aaaaialpaaaaaaaafbaaaaafafaaapkaaaaaaaedjkjjbjdpmnmmmmdoaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
ecaaaaadaaaacpiaaaaaoelaabaioekaacaaaaadabaacpiaaaaappiaadaaaakb
aiaaaaadacaaaiiaaeaaoelaaeaaoelaabaaaaacacaaadiaacaappiaebaaaaab
abaaapiaecaaaaadabaacpiaaaaaoelaacaioekaecaaaaadacaacpiaacaaoeia
aaaioekaafaaaaadacaacoiaaaaabliaabaapplaacaaaaadadaaciiaabaaaala
aeaaaakaafaaaaadacaacoiaacaaoeiaadaappiaaeaaaaaeadaacbiaabaappia
aeaaffkaaeaakkkaaeaaaaaeadaacciaabaaffiaaeaaffkaaeaakkkafkaaaaae
adaadiiaadaaoeiaadaaoeiaaeaappkaacaaaaadadaaciiaadaappibaeaakkkb
ahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaadadaaciia
acaaoelaacaaoelaahaaaaacadaaciiaadaappiaafaaaaadaeaachiaadaappia
acaaoelaaiaaaaadaeaaciiaadaaoeiaaeaaoeiaabaaaaacabaadciaaeaappib
aeaaaaaeabaaciiaaeaappiaafaaffkaafaakkkaalaaaaadaeaaciiaabaappia
aeaappkaceaaaaacafaachiaadaaoelaaiaaaaadabaadiiaafaaoeiaaeaaoeib
aeaaaaaeaeaachiaacaaoelaadaappiaafaaoeiaceaaaaacafaachiaaeaaoeia
aiaaaaadadaacbiaadaaoeiaafaaoeiaalaaaaadaeaacbiaadaaaaiaaeaappka
bcaaaaaeadaacbiaacaappkaabaappiaabaaffiaafaaaaadabaacbiaabaaaaia
adaaaaiaafaaaaadadaachiaabaaaaiaacaaoekaaeaaaaaeadaachiaadaaoeia
aeaaffkaaeaappiaafaaaaadacaacoiaacaaoeiaadaabliaabaaaaacabaaabia
afaaaakaafaaaaadabaacbiaabaaaaiaabaaaakacaaaaaadadaacbiaaeaaaaia
abaaaaiaafaaaaadabaacbiaabaakkiaadaaaaiaafaaaaadabaachiaabaaaaia
aaaaoekaaeaaaaaeabaachiaacaabliaaaaaoekaabaaoeiaacaaaaadabaaciia
acaaaaiaacaaaaiaafaaaaadaaaachiaabaappiaabaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefceiagaaaaeaaaaaaajcabaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaa
abeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaj
hcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
bacaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahccaabaaaabaaaaaaegaabaaaaeaaaaaaegaabaaaaeaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
aeaaaaaabkaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadgcaaaagicaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaa
mnmmmmdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamlcaabaaaabaaaaaaegaibaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaeafgafbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahlcaabaaaabaaaaaapgapbaaaaaaaaaaaegaibaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegadbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoleaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaknaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
"!!ARBfp1.0
# 41 ALU, 2 TEX
PARAM c[7] = { program.local[0..4],
		{ 0.60009766, 2, 1, 0.39990234 },
		{ 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[4];
DP3 R2.z, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[0], texture[1], 2D;
MAD R2.xy, R1.wyzw, c[5].y, -c[5].z;
RSQ R1.y, R2.z;
MUL R3.xyz, R1.y, fragment.texcoord[2];
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.y, R2.z, R2.w;
ADD R1.w, -R1.y, c[5].z;
ADD R4.xyz, R3, fragment.texcoord[1];
DP3 R1.y, R4, R4;
RSQ R1.w, R1.w;
RSQ R1.y, R1.y;
MUL R4.xyz, R1.y, R4;
RCP R2.z, R1.w;
MOV R1.y, c[6];
DP3 R1.w, R2, R4;
MUL R2.w, R1.y, c[1].x;
MAX R1.y, R1.w, c[6].x;
POW R1.w, R1.y, R2.w;
DP3 R1.y, fragment.texcoord[1], R2;
MUL R2.x, R1.z, R1.w;
MOV_SAT R1.w, -R1.y;
DP3_SAT R1.z, R3, -fragment.texcoord[1];
ADD R1.z, R1, -R1.w;
MAD R1.z, R1, c[3].x, R1.w;
MAD R1.y, R1, c[5].x, c[5].w;
MAX R1.w, R1.y, c[6].x;
MUL R1.x, R1.z, R1;
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[5].y, R1.w;
ADD R1.w, fragment.color.primary.x, c[5].x;
MUL R0.xyz, R0, R1.w;
MUL R2.xyz, R2.x, c[0];
MUL R0.xyz, R0, R1;
MAD R0.xyz, R0, c[0], R2;
MUL result.color.xyz, R0, c[5].y;
END
# 41 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
"ps_2_0
; 46 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 0.60009766, 0.39990234
def c6, 2.00000000, -1.00000000, 128.00000000, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
texld r2, t0, s0
texld r6, t0, s1
add_pp r0.x, r2.w, -c4
cmp r0.x, r0, c5, c5.y
mov_pp r0, -r0.x
mov r1.x, r6.w
mov r1.y, r6
mad_pp r5.xy, r1, c6.x, c6.y
mul_pp r1.xy, r5, r5
mul_pp r2.xyz, r2, v0.w
texkill r0.xyzw
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, t2
add_pp r4.xyz, r3, t1
add_pp_sat r0.x, r1, r1.y
dp3_pp r1.x, r4, r4
add_pp r0.x, -r0, c5.y
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r4
dp3_pp r1.x, r5, r1
mov_pp r0.x, c1
dp3_pp_sat r3.x, r3, -t1
mul_pp r0.x, c6.z, r0
max_pp r1.x, r1, c5
pow_pp r4.y, r1.x, r0.x
mov_pp r0.x, r4.y
dp3_pp r1.x, t1, r5
mov_pp_sat r4.x, -r1
add_pp r3.x, r3, -r4
mad_pp r3.x, r3, c3, r4
mad_pp r1.x, r1, c5.z, c5.w
mul_pp r3.x, r3, r6
mul_pp r0.x, r6.z, r0
mul_pp r3.xyz, r3.x, c2
max_pp r1.x, r1, c5
mad_pp r1.xyz, r3, c6.x, r1.x
mul_pp r3.xyz, r0.x, c0
add_pp r0.x, v0, c5.z
mul_pp r0.xyz, r2, r0.x
mul_pp r0.xyz, r0, r1
mad_pp r0.xyz, r0, c0, r3
mul_pp r0.xyz, r0, c6.x
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Vector 64 [_Color]
Vector 80 [_TranslucencyColor] 3
Float 92 [_TranslucencyViewDependency]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjpbhipinnlpbpcljfbhaibdbgicjoeojabaaaaaaieagaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefchiafaaaaeaaaaaaafoabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
aeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaadaaaaaabacaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaia
ebaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaabkaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaa
egacbaaaadaaaaaaegbcbaaaadaaaaaadgcaaaagicaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
jkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaaeaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaadcaaaaamlcaabaaaabaaaaaaegaibaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaeafgafbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaapgapbaaaaaaaaaaaegaibaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegadbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaa
aaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Vector 64 [_Color]
Vector 80 [_TranslucencyColor] 3
Float 92 [_TranslucencyViewDependency]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfbkmdinmdlffiiohgodjljkgecpmlmmiabaaaaaamiajaaaaaeaaaaaa
daaaaaaahaadaaaapaaiaaaajeajaaaaebgpgodjdiadaaaadiadaaaaaaacpppp
oiacaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaacaaabaaaaaaaaaaaaaaaiaa
abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkajkjjbjdpaaaaaaeaaaaaialp
aaaaaaaafbaaaaafafaaapkaaaaaaaedjkjjbjdpmnmmmmdoaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappia
adaaaakbebaaaaababaaapiaecaaaaadabaacpiaaaaaoelaabaioekaafaaaaad
acaachiaaaaaoeiaabaapplaacaaaaadacaaciiaabaaaalaaeaaaakaafaaaaad
acaachiaacaappiaacaaoeiaaiaaaaadacaaciiaadaaoelaadaaoelaahaaaaac
acaaciiaacaappiaafaaaaadadaachiaacaappiaadaaoelaabaaaaacaeaaahia
adaaoelaaeaaaaaeaeaachiaaeaaoeiaacaappiaacaaoelaceaaaaacafaachia
aeaaoeiaaiaaaaadacaadiiaadaaoeiaacaaoelbaeaaaaaeadaacbiaabaappia
aeaaffkaaeaakkkaaeaaaaaeadaacciaabaaffiaaeaaffkaaeaakkkafkaaaaae
adaadiiaadaaoeiaadaaoeiaaeaappkaacaaaaadadaaciiaadaappibaeaakkkb
ahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaadadaaciia
adaaoeiaacaaoelaaiaaaaadabaacciaadaaoeiaafaaoeiaalaaaaadadaacbia
abaaffiaaeaappkaabaaaaacabaadciaadaappibaeaaaaaeabaaciiaadaappia
afaaffkaafaakkkaalaaaaadadaacciaabaappiaaeaappkabcaaaaaeadaaceia
acaappkaacaappiaabaaffiaafaaaaadacaaciiaabaaaaiaadaakkiaafaaaaad
aeaachiaacaappiaacaaoekaaeaaaaaeadaacoiaaeaabliaaeaaffkaadaaffia
afaaaaadacaachiaacaaoeiaadaabliaabaaaaacacaaaiiaafaaaakaafaaaaad
acaaciiaacaappiaabaaaakacaaaaaadabaacbiaadaaaaiaacaappiaafaaaaad
acaaciiaabaakkiaabaaaaiaafaaaaadabaachiaacaappiaaaaaoekaaeaaaaae
abaachiaacaaoeiaaaaaoekaabaaoeiaacaaaaadaaaachiaabaaoeiaabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchiafaaaaeaaaaaaafoabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaa
abeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaa
aeaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabacaaaaiicaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaabkaabaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegbcbaaaadaaaaaadgcaaaag
icaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
aeaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaamlcaabaaa
abaaaaaaegaibaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaea
fgafbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegaibaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegadbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheojmaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapajaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"!!ARBfp1.0
# 53 ALU, 4 TEX
PARAM c[7] = { program.local[0..4],
		{ 0, 0.5, 0.60009766, 2 },
		{ 1, 0.39990234, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[0], texture[1], 2D;
SLT R0.w, R2, c[4].x;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.x, fragment.texcoord[3].w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
MUL R4.xyz, R1.x, fragment.texcoord[1];
MOV R6.xyz, c[6];
MAD R0.xy, fragment.texcoord[3], R0.x, c[5].y;
MUL R2.xyz, R2, fragment.color.primary.w;
MOV result.color.w, R2;
TEX R1.w, R0.z, texture[3], 2D;
KIL -R0.w;
TEX R0.w, R0, texture[2], 2D;
MAD R0.xy, R3.wyzw, c[5].w, -R6.x;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.z;
MUL R1.xyz, R0.z, fragment.texcoord[2];
MUL R3.yw, R0.xxzy, R0.xxzy;
ADD_SAT R0.z, R3.y, R3.w;
ADD R5.xyz, R1, R4;
DP3 R3.y, R5, R5;
RSQ R3.y, R3.y;
ADD R0.z, -R0, c[6].x;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MUL R5.xyz, R3.y, R5;
DP3 R3.y, R0, R5;
MAX R3.y, R3, c[5].x;
MUL R3.w, R6.z, c[1].x;
POW R3.w, R3.y, R3.w;
DP3 R3.y, R4, R0;
DP3_SAT R0.x, R1, -R4;
MUL R0.y, R3.z, R3.w;
MOV_SAT R3.z, -R3.y;
ADD R1.x, R0, -R3.z;
MAD R1.x, R1, c[3], R3.z;
MUL R0.xyz, R0.y, c[0];
MUL R1.x, R1, R3;
MAD R1.y, R3, c[5].z, R6;
MAX R3.x, R1.y, c[5];
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[5].w, R3.x;
ADD R3.x, fragment.color.primary, c[5].z;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R2, R1;
MAD R1.xyz, R1, c[0], R0;
SLT R0.x, c[5], fragment.texcoord[3].z;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[5].w;
END
# 53 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_2_0
; 56 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 0.00000000, 1.00000000, 0.50000000, 0.60009766
def c6, 2.00000000, -1.00000000, 0.60009766, 0.39990234
def c7, 128.00000000, 0, 0, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
dcl t3
texld r0, t0, s0
add_pp r1.x, r0.w, -c4
cmp r1.x, r1, c5, c5.y
mov_pp r1, -r1.x
dp3 r2.x, t3, t3
rcp r3.x, t3.w
mov r2.xy, r2.x
dp3_pp r4.x, t1, t1
dp3_pp r5.x, t2, t2
rsq_pp r4.x, r4.x
rsq_pp r5.x, r5.x
mul_pp r4.xyz, r4.x, t1
mul_pp r5.xyz, r5.x, t2
add_pp r6.xyz, r5, r4
dp3_pp r7.x, r6, r6
rsq_pp r7.x, r7.x
mad r3.xy, t3, r3.x, c5.z
mul_pp r6.xyz, r7.x, r6
mul_pp r0.xyz, r0, v0.w
texkill r1.xyzw
texld r1, r3, s2
texld r3, t0, s1
texld r2, r2, s3
mov r1.y, r3
mov r1.x, r3.w
mad_pp r8.xy, r1, c6.x, c6.y
mul_pp r1.xy, r8, r8
add_pp_sat r1.x, r1, r1.y
add_pp r1.x, -r1, c5.y
rsq_pp r1.x, r1.x
rcp_pp r8.z, r1.x
mov_pp r1.x, c1
dp3_pp r6.x, r8, r6
mul_pp r1.x, c7, r1
max_pp r6.x, r6, c5
pow_pp r7.y, r6.x, r1.x
dp3_pp r6.x, r4, r8
mov_pp r1.x, r7.y
mul_pp r1.x, r3.z, r1
mul_pp r1.xyz, r1.x, c0
dp3_pp_sat r4.x, r5, -r4
mov_pp_sat r7.x, -r6
add_pp r4.x, r4, -r7
mad_pp r4.x, r4, c3, r7
mul_pp r3.x, r4, r3
mad_pp r5.x, r6, c6.z, c6.w
max_pp r4.x, r5, c5
mul_pp r3.xyz, r3.x, c2
mad_pp r3.xyz, r3, c6.x, r4.x
add_pp r4.x, v0, c5.w
mul_pp r0.xyz, r0, r4.x
mul_pp r0.xyz, r0, r3
mad_pp r0.xyz, r0, c0, r1
cmp r1.x, -t3.z, c5, c5.y
mul_pp r1.x, r1, r1.w
mul_pp r1.x, r1, r2
mul_pp r0.xyz, r1.x, r0
mul_pp r0.xyz, r0, c6.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpTransSpecMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpojkbnehdkaoddpbepgkhjafiphlofpfabaaaaaaeeaiaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
caahaaaaeaaaaaaamiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadjcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
pcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
amaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabacaaaaiicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaaeaaaaaa
hgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaaegaabaaa
aeaaaaaaegaabaaaaeaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaeaaaaaabkaabaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadgcaaaagicaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkiacaaa
aaaaaaaaajaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamlcaabaaaabaaaaaa
egaibaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaeafgafbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaibaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egadbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpTransSpecMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedafcfhimmpnemjgpancknmdcipcjonpoeabaaaaaaeeamaaaaaeaaaaaa
daaaaaaacmaeaaaafealaaaabaamaaaaebgpgodjpeadaaaapeadaaaaaaacpppp
jmadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaacaaaaaa
adababaaaaacacaaabadadaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaa
aaaaaaaaaaaaamaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkajkjjbjdp
aaaaaaeaaaaaialpaaaaaaaafbaaaaafafaaapkaaaaaaadpaaaaaaedjkjjbjdp
mnmmmmdobpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaacplabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpiaaaaaoelaacaioeka
acaaaaadabaacpiaaaaappiaadaaaakbagaaaaacacaaaiiaaeaapplaaeaaaaae
acaaadiaaeaaoelaacaappiaafaaaakaaiaaaaadadaaaiiaaeaaoelaaeaaoela
abaaaaacadaaadiaadaappiaebaaaaababaaapiaecaaaaadabaacpiaaaaaoela
adaioekaecaaaaadacaacpiaacaaoeiaaaaioekaecaaaaadadaacpiaadaaoeia
abaioekaafaaaaadacaachiaaaaaoeiaabaapplaacaaaaadadaacciaabaaaala
aeaaaakaafaaaaadacaachiaacaaoeiaadaaffiaaeaaaaaeaeaacbiaabaappia
aeaaffkaaeaakkkaaeaaaaaeaeaacciaabaaffiaaeaaffkaaeaakkkafkaaaaae
aeaadiiaaeaaoeiaaeaaoeiaaeaappkaacaaaaadaeaaciiaaeaappibaeaakkkb
ahaaaaacaeaaciiaaeaappiaagaaaaacaeaaceiaaeaappiaaiaaaaadaeaaciia
acaaoelaacaaoelaahaaaaacaeaaciiaaeaappiaafaaaaadafaachiaaeaappia
acaaoelaaiaaaaadafaaciiaaeaaoeiaafaaoeiaabaaaaacabaadciaafaappib
aeaaaaaeabaaciiaafaappiaafaakkkaafaappkaalaaaaadafaaciiaabaappia
aeaappkaceaaaaacagaachiaadaaoelaaiaaaaadabaadiiaagaaoeiaafaaoeib
aeaaaaaeafaachiaacaaoelaaeaappiaagaaoeiaceaaaaacagaachiaafaaoeia
aiaaaaadadaacciaaeaaoeiaagaaoeiaalaaaaadaeaacbiaadaaffiaaeaappka
bcaaaaaeadaacciaacaappkaabaappiaabaaffiaafaaaaadabaacbiaabaaaaia
adaaffiaafaaaaadadaacoiaabaaaaiaacaablkaaeaaaaaeadaacoiaadaaoeia
aeaaffkaafaappiaafaaaaadacaachiaacaaoeiaadaabliaabaaaaacabaaacia
afaaffkaafaaaaadabaacbiaabaaffiaabaaaakacaaaaaadadaacciaaeaaaaia
abaaaaiaafaaaaadabaacbiaabaakkiaadaaffiaafaaaaadabaachiaabaaaaia
aaaaoekaaeaaaaaeabaachiaacaaoeiaaaaaoekaabaaoeiaafaaaaadabaaciia
acaappiaadaaaaiafiaaaaaeabaaciiaaeaakklbaeaappkaabaappiaacaaaaad
abaaciiaabaappiaabaappiaafaaaaadaaaachiaabaappiaabaaoeiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefccaahaaaaeaaaaaaamiabaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaa
abeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaj
hcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
bacaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahccaabaaaabaaaaaaegaabaaaaeaaaaaaegaabaaaaeaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
aeaaaaaabkaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadgcaaaagicaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaa
mnmmmmdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamlcaabaaaabaaaaaaegaibaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaeafgafbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahlcaabaaaabaaaaaapgapbaaaaaaaaaaaegaibaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegadbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaa
abaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaa
aaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"!!ARBfp1.0
# 49 ALU, 4 TEX
PARAM c[7] = { program.local[0..4],
		{ 0.60009766, 2, 1, 0.39990234 },
		{ 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[0], texture[1], 2D;
TEX R1.w, fragment.texcoord[3], texture[3], CUBE;
SLT R0.y, R2.w, c[4].x;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
MUL R4.xyz, R1.x, fragment.texcoord[1];
RSQ R0.z, R0.z;
MUL R1.xyz, R0.z, fragment.texcoord[2];
ADD R5.xyz, R1, R4;
MUL R2.xyz, R2, fragment.color.primary.w;
MOV result.color.w, R2;
TEX R0.w, R0.x, texture[2], 2D;
KIL -R0.y;
MAD R0.xy, R3.wyzw, c[5].y, -c[5].z;
MUL R3.yw, R0.xxzy, R0.xxzy;
ADD_SAT R0.z, R3.y, R3.w;
DP3 R3.y, R5, R5;
RSQ R3.y, R3.y;
MUL R5.xyz, R3.y, R5;
MOV R3.y, c[6];
ADD R0.z, -R0, c[5];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R3.w, R0, R5;
MUL R4.w, R3.y, c[1].x;
MAX R3.y, R3.w, c[6].x;
POW R3.w, R3.y, R4.w;
DP3 R3.y, R4, R0;
DP3_SAT R0.x, R1, -R4;
MUL R0.y, R3.z, R3.w;
MOV_SAT R3.z, -R3.y;
ADD R1.x, R0, -R3.z;
MAD R1.x, R1, c[3], R3.z;
MUL R0.xyz, R0.y, c[0];
MUL R1.x, R1, R3;
MAD R1.y, R3, c[5].x, c[5].w;
MAX R3.x, R1.y, c[6];
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[5].y, R3.x;
ADD R3.x, fragment.color.primary, c[5];
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R2, R1;
MAD R1.xyz, R1, c[0], R0;
MUL R0.x, R0.w, R1.w;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[5].y;
END
# 49 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"ps_2_0
; 52 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c5, 0.00000000, 1.00000000, 0.60009766, 0.39990234
def c6, 2.00000000, -1.00000000, 128.00000000, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
texld r3, t3, s3
add_pp r1.x, r0.w, -c4
cmp r1.x, r1, c5, c5.y
mov_pp r1, -r1.x
dp3 r2.x, t3, t3
dp3_pp r4.x, t1, t1
dp3_pp r5.x, t2, t2
rsq_pp r4.x, r4.x
rsq_pp r5.x, r5.x
mul_pp r4.xyz, r4.x, t1
mul_pp r5.xyz, r5.x, t2
add_pp r6.xyz, r5, r4
dp3_pp r7.x, r6, r6
rsq_pp r7.x, r7.x
mov r2.xy, r2.x
mul_pp r6.xyz, r7.x, r6
mul_pp r0.xyz, r0, v0.w
texkill r1.xyzw
texld r1, r2, s2
texld r2, t0, s1
mov r3.y, r2
mov r3.x, r2.w
mad_pp r8.xy, r3, c6.x, c6.y
mul_pp r3.xy, r8, r8
add_pp_sat r3.x, r3, r3.y
add_pp r3.x, -r3, c5.y
rsq_pp r3.x, r3.x
rcp_pp r8.z, r3.x
mov_pp r3.x, c1
dp3_pp r6.x, r8, r6
mul_pp r3.x, c6.z, r3
max_pp r6.x, r6, c5
pow_pp r7.y, r6.x, r3.x
dp3_pp r6.x, r4, r8
mov_pp r3.x, r7.y
mul_pp r3.x, r2.z, r3
dp3_pp_sat r4.x, r5, -r4
mov_pp_sat r7.x, -r6
mul_pp r3.xyz, r3.x, c0
add_pp r4.x, r4, -r7
mad_pp r4.x, r4, c3, r7
mul_pp r2.x, r4, r2
mad_pp r5.x, r6, c5.z, c5.w
max_pp r4.x, r5, c5
mul_pp r2.xyz, r2.x, c2
mad_pp r2.xyz, r2, c6.x, r4.x
add_pp r4.x, v0, c5.z
mul_pp r0.xyz, r0, r4.x
mul_pp r0.xyz, r0, r2
mad_pp r0.xyz, r0, c0, r3
mul r1.x, r1, r3.w
mul_pp r0.xyz, r1.x, r0
mul_pp r0.xyz, r0, c6.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpTransSpecMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpibfboeaepmpfjkaflfdadhlibjnmedeabaaaaaakmahaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
iiagaaaaeaaaaaaakcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafidaaaae
aahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadjcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
amaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabacaaaaiicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaaeaaaaaa
hgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaaegaabaaa
aeaaaaaaegaabaaaaeaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaeaaaaaabkaabaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadgcaaaagicaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkiacaaa
aaaaaaaaajaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamlcaabaaaabaaaaaa
egaibaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaeafgafbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaibaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egadbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaafaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaa
abaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpTransSpecMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjaonbcfgfolmolnlpfgjemheahgalgljabaaaaaahialaaaaaeaaaaaa
daaaaaaapiadaaaaiiakaaaaeealaaaaebgpgodjmaadaaaamaadaaaaaaacpppp
giadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaadaaaaaa
acababaaaaacacaaabadadaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaa
aaaaaaaaaaaaamaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkajkjjbjdp
aaaaaaeaaaaaialpaaaaaaaafbaaaaafafaaapkaaaaaaaedjkjjbjdpmnmmmmdo
aaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaacplabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahla
bpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpiaaaaaoelaacaioeka
acaaaaadabaacpiaaaaappiaadaaaakbaiaaaaadacaaaiiaaeaaoelaaeaaoela
abaaaaacacaaadiaacaappiaebaaaaababaaapiaecaaaaadabaacpiaaaaaoela
adaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaadadaaapiaaeaaoela
aaaioekaafaaaaadacaacoiaaaaabliaabaapplaacaaaaadadaacbiaabaaaala
aeaaaakaafaaaaadacaacoiaacaaoeiaadaaaaiaaeaaaaaeadaacbiaabaappia
aeaaffkaaeaakkkaaeaaaaaeadaacciaabaaffiaaeaaffkaaeaakkkafkaaaaae
abaadciaadaaoeiaadaaoeiaaeaappkaacaaaaadabaacciaabaaffibaeaakkkb
ahaaaaacabaacciaabaaffiaagaaaaacadaaceiaabaaffiaaiaaaaadabaaccia
acaaoelaacaaoelaahaaaaacabaacciaabaaffiaafaaaaadaeaachiaabaaffia
acaaoelaaiaaaaadabaaciiaadaaoeiaaeaaoeiaabaaaaacaeaadiiaabaappib
aeaaaaaeabaaciiaabaappiaafaaffkaafaakkkaalaaaaadafaaciiaabaappia
aeaappkaceaaaaacafaachiaadaaoelaaiaaaaadabaadiiaafaaoeiaaeaaoeib
aeaaaaaeaeaachiaacaaoelaabaaffiaafaaoeiaceaaaaacafaachiaaeaaoeia
aiaaaaadabaacciaadaaoeiaafaaoeiaalaaaaadadaacbiaabaaffiaaeaappka
bcaaaaaeadaacciaacaappkaabaappiaaeaappiaafaaaaadabaacbiaabaaaaia
adaaffiaafaaaaadaeaachiaabaaaaiaacaaoekaaeaaaaaeaeaachiaaeaaoeia
aeaaffkaafaappiaafaaaaadacaacoiaacaaoeiaaeaabliaabaaaaacabaaabia
afaaaakaafaaaaadabaacbiaabaaaaiaabaaaakacaaaaaadaeaacbiaadaaaaia
abaaaaiaafaaaaadabaacbiaabaakkiaaeaaaaiaafaaaaadabaachiaabaaaaia
aaaaoekaaeaaaaaeabaachiaacaabliaaaaaoekaabaaoeiaafaaaaadabaaciia
acaaaaiaadaappiaacaaaaadabaaciiaabaappiaabaappiaafaaaaadaaaachia
abaappiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefciiagaaaa
eaaaaaaakcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabacaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaaegaabaaaaeaaaaaa
egaabaaaaeaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaeaaaaaabkaabaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadgcaaaagicaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamlcaabaaaabaaaaaaegaibaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaeafgafbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaapgapbaaaaaaaaaaa
egaibaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegadbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaafaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaa
pgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_ShadowStrength]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
# 45 ALU, 3 TEX
PARAM c[8] = { program.local[0..5],
		{ 0.60009766, 2, 1, 0.39990234 },
		{ 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.w, fragment.texcoord[3], texture[2], 2D;
SLT R1.x, R0.w, c[5];
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.z, R2.x;
MUL R3.xyz, R2.z, fragment.texcoord[2];
ADD R4.xyz, R3, fragment.texcoord[1];
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[0], texture[1], 2D;
MAD R2.xy, R1.wyzw, c[6].y, -c[6].z;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.y, R2.z, R2.w;
DP3 R1.w, R4, R4;
RSQ R1.w, R1.w;
ADD R1.y, -R1, c[6].z;
RSQ R1.y, R1.y;
RCP R2.z, R1.y;
MUL R4.xyz, R1.w, R4;
DP3 R1.w, R2, R4;
DP3 R2.x, fragment.texcoord[1], R2;
MOV R1.y, c[7];
MOV_SAT R2.y, -R2.x;
MUL R1.y, R1, c[1].x;
MAX R1.w, R1, c[7].x;
POW R1.w, R1.w, R1.y;
MUL R1.w, R1.z, R1;
MAD R1.z, R2.x, c[6].x, c[6].w;
DP3_SAT R1.y, R3, -fragment.texcoord[1];
ADD R1.y, R1, -R2;
MAD R1.y, R1, c[3].x, R2;
MAX R2.x, R1.z, c[7];
MUL R1.x, R1.y, R1;
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[6].y, R2.x;
ADD R2.x, fragment.color.primary, c[6];
MUL R0.xyz, R0, R2.x;
MUL R0.xyz, R0, R1;
MUL R1.xyz, R1.w, c[0];
MOV R1.w, c[6].y;
MAD R2.x, R3.w, c[6].y, -c[6].y;
MAD R1.w, R2.x, c[4].x, R1;
MAD R0.xyz, R0, c[0], R1;
MUL result.color.xyz, R0, R1.w;
END
# 45 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_TranslucencyColor]
Float 3 [_TranslucencyViewDependency]
Float 4 [_ShadowStrength]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
; 49 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 0.00000000, 1.00000000, 0.60009766, 0.39990234
def c7, 2.00000000, -1.00000000, 128.00000000, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
texld r2, t0, s0
texld r6, t0, s1
add_pp r0.x, r2.w, -c5
cmp r0.x, r0, c6, c6.y
mov_pp r0, -r0.x
mov r1.x, r6.w
mov r1.y, r6
mad_pp r4.xy, r1, c7.x, c7.y
mul_pp r1.xy, r4, r4
mul_pp r2.xyz, r2, v0.w
texkill r0.xyzw
texld r0, t3, s2
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, t2
add_pp_sat r0.x, r1, r1.y
add_pp r5.xyz, r3, t1
dp3_pp r1.x, r5, r5
add_pp r0.x, -r0, c6.y
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r5
dp3_pp r1.x, r4, r1
mov_pp r0.x, c1
mul_pp r0.x, c7.z, r0
max_pp r1.x, r1, c6
pow_pp r5.x, r1.x, r0.x
dp3_pp r1.x, t1, r4
mov_pp_sat r4.x, -r1
dp3_pp_sat r0.x, r3, -t1
add_pp r3.x, r0, -r4
mov_pp r0.x, r5.x
mul_pp r0.x, r6.z, r0
mad_pp r3.x, r3, c3, r4
mad_pp r1.x, r1, c6.z, c6.w
mul_pp r3.x, r3, r6
max_pp r1.x, r1, c6
mul_pp r3.xyz, r3.x, c2
mad_pp r3.xyz, r3, c7.x, r1.x
add_pp r1.x, v0, c6.z
mul_pp r1.xyz, r2, r1.x
mul_pp r2.xyz, r1, r3
mad_pp r1.x, r0.w, c7, -c7
mul_pp r3.xyz, r0.x, c0
mov_pp r0.x, c7
mad_pp r0.x, r1, c4, r0
mad_pp r1.xyz, r2, c0, r3
mul_pp r0.xyz, r1, r0.x
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 160 [_ShadowStrength]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmaeeiclhfbnednbeagcbhgjiaiiejndfabaaaaaadeahaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaknaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapajaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
baagaaaaeaaaaaaaieabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaamaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaajkjjbjdpdiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
aeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaadaaaaaabacaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaia
ebaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaabkaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaa
egacbaaaadaaaaaaegbcbaaaadaaaaaadgcaaaagicaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
jkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaaeaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaamlcaabaaaabaaaaaaegaibaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaeafgafbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaapgapbaaaaaaaaaaaegaibaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegadbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaaamadcaaaaakicaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaeadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 128 [_Color]
Vector 144 [_TranslucencyColor] 3
Float 156 [_TranslucencyViewDependency]
Float 160 [_ShadowStrength]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedghllbepgffmjajdhjlokkmkfjbajjjpgabaaaaaapaakaaaaaeaaaaaa
daaaaaaaoiadaaaaaaakaaaalmakaaaaebgpgodjlaadaaaalaadaaaaaaacpppp
fmadaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaadaaabaaaaaaaaaa
aaaaamaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkajkjjbjdpaaaaaaea
aaaaialpaaaaaaaafbaaaaafagaaapkaaaaaaaedjkjjbjdpmnmmmmdoaaaaaaaa
fbaaaaafahaaapkaaaaaaaeaaaaaaamaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaacaaaaad
abaacpiaaaaappiaaeaaaakbabaaaaacacaaadiaaaaabllaebaaaaababaaapia
ecaaaaadabaacpiaaaaaoelaacaioekaecaaaaadacaacpiaacaaoeiaaaaioeka
afaaaaadacaachiaaaaaoeiaabaapplaacaaaaadadaaciiaabaaaalaafaaaaka
afaaaaadacaachiaacaaoeiaadaappiaaiaaaaadadaacbiaadaaoelaadaaoela
ahaaaaacadaacbiaadaaaaiaafaaaaadaeaachiaadaaaaiaadaaoelaabaaaaac
afaaahiaadaaoelaaeaaaaaeadaachiaafaaoeiaadaaaaiaacaaoelaceaaaaac
afaachiaadaaoeiaaiaaaaadafaadiiaaeaaoeiaacaaoelbaeaaaaaeadaacbia
abaappiaafaaffkaafaakkkaaeaaaaaeadaacciaabaaffiaafaaffkaafaakkka
fkaaaaaeadaadiiaadaaoeiaadaaoeiaafaappkaacaaaaadadaaciiaadaappib
afaakkkbahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaad
adaaciiaadaaoeiaacaaoelaaiaaaaadabaacciaadaaoeiaafaaoeiaalaaaaad
adaacbiaabaaffiaafaappkaabaaaaacabaadciaadaappibaeaaaaaeabaaciia
adaappiaagaaffkaagaakkkaalaaaaadadaacciaabaappiaafaappkabcaaaaae
adaaceiaacaappkaafaappiaabaaffiaafaaaaadabaacbiaabaaaaiaadaakkia
afaaaaadaeaachiaabaaaaiaacaaoekaaeaaaaaeadaacoiaaeaabliaafaaffka
adaaffiaafaaaaadacaachiaacaaoeiaadaabliaabaaaaacabaaabiaagaaaaka
afaaaaadabaacbiaabaaaaiaabaaaakacaaaaaadaeaacbiaadaaaaiaabaaaaia
afaaaaadabaacbiaabaakkiaaeaaaaiaafaaaaadabaachiaabaaaaiaaaaaoeka
aeaaaaaeabaachiaacaaoeiaaaaaoekaabaaoeiaaeaaaaaeabaaciiaacaappia
ahaaaakaahaaffkaabaaaaacacaaaciaafaaffkaaeaaaaaeabaaciiaadaaaaka
abaappiaacaaffiaafaaaaadaaaachiaabaappiaabaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbaagaaaaeaaaaaaaieabaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadjcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaa
abeaaaaajkjjbjdpdiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaa
aeaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabacaaaaiicaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahccaabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaabkaabaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegbcbaaaadaaaaaadgcaaaag
icaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaajkjjbjdpabeaaaaamnmmmmdodeaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
aeaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamlcaabaaa
abaaaaaaegaibaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaea
fgafbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahlcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegaibaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegadbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaamadcaaaaakicaabaaa
aaaaaaaaakiacaaaaaaaaaaaakaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaea
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaknaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapajaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "IGNOREPROJECTOR"="True" "RenderType"="AtsFoliage" }
  Cull Off
  Fog { Mode Off }
  Offset 1, 1
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [unity_LightShadowBias]
Vector 11 [_Wind]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 44 ALU
PARAM c[15] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..12],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[9].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[13];
FRC R0, R0;
MUL R0, R0, c[14].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[14].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[14].x, c[14].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[11];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[14].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[11].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[11];
MAD R0.xyz, R0, R2.x, R1;
MOV R0.w, vertex.position;
DP4 R1.x, R0, c[4];
DP4 R1.y, R0, c[3];
ADD R1.y, R1, c[10].x;
MAX R1.z, R1.y, -R1.x;
ADD R1.z, R1, -R1.y;
MAD result.position.z, R1, c[10].y, R1.y;
MOV result.position.w, R1.x;
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
END
# 44 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [unity_LightShadowBias]
Vector 10 [_Wind]
Vector 11 [_MainTex_ST]
"vs_2_0
; 46 ALU
def c12, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c13, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c14, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c15, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c12.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c8.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c13
frc r0, r0
mad r0, r0, c12.y, c12.z
frc r0, r0
mad r0, r0, c12.y, c12.w
abs r0, r0
mad r1, -r0, c14.x, c14.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c10
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c14.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c14.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c10.w, v0
mul r0.xyz, v5.z, c10
mad r0.xyz, r0, r2.x, r1
mov r0.w, v0
dp4 r1.x, r0, c2
add r1.x, r1, c9
max r1.y, r1.x, c15.x
add r1.y, r1, -r1.x
mad r1.z, r1.y, c9.y, r1.x
dp4 r1.w, r0, c3
dp4 r1.x, r0, c0
dp4 r1.y, r0, c1
mov oPos, r1
mov oT0, r1
mad oT1.xy, v3, c11, c11.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityShadows" 416
Vector 80 [unity_LightShadowBias]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkgkgkhheijmlidcoihjoacbfbjncjljfabaaaaaageahaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbaagaaaaeaaaabaaieabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaagaaaaaafjaaaaaeegiocaaaadaaaaaaapaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadhcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaa
agbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
agafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaaba
pcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaa
fgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaah
mcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaa
adaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
fgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaacaaaaaaafaaaaaadgaaaaaf
lccabaaaaaaaaaaaegambaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaabkiacaaaacaaaaaa
afaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityShadows" 416
Vector 80 [unity_LightShadowBias]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedhhmhgilhnbhjkamhpgpilikegfcnmeeaabaaaaaadmalaaaaaeaaaaaa
daaaaaaaaeaeaaaabmakaaaaoeakaaaaebgpgodjmmadaaaammadaaaaaaacpopp
fmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
acaaafaaabaaaeaaaaaaaaaaadaaaaaaaeaaafaaaaaaaaaaadaaamaaadaaajaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafamaaapkamnmmpmdpamaceldpaaaamado
mlkbefdofbaaaaafanaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaaf
aoaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdofbaaaaafapaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaabaaaaacaaaaabiaajaappkaabaaaaac
aaaaaciaakaappkaabaaaaacaaaaaeiaalaappkaaiaaaaadaaaaabiaaaaaoeia
anaaaakaacaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaabaaffia
afaaffjaaiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaadacaaapiaaaaakaja
adaaffkaacaaaaadabaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeia
amaaoekabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaanaaffka
anaakkkabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaanaaffka
anaappkacdaaaaacabaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeia
aeaaaaaeabaaapiaabaaoeiaaoaaaakbaoaaffkaafaaaaadabaaapiaabaaoeia
acaaoeiaacaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaadabaaahiaaaaakkia
abaaoekaafaaaaadabaaahiaabaaoeiaafaakkjaamaaaaadacaaadiaacaaoijb
acaaoijaamaaaaadacaaamiaacaaiejaacaaiejbacaaaaadacaaadiaacaaooib
acaaoeiaafaaaaadabaaaiiaafaaffjaaoaakkkaafaaaaadacaaamiaabaappia
acaaiejaafaaaaadacaaafiaacaaneiaacaapgiaafaaaaadacaaaciaafaakkja
aoaappkaaeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaiaaeaaaaaeaaaaaoia
aaaaoeiaabaappkaaaaajajaafaaaaadabaaahiaafaakkjaabaaoekaaeaaaaae
aaaaahiaabaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaapiaaaaaffiaagaaoeka
aeaaaaaeabaaapiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaacaaaaad
aaaaaeiaaaaakkiaaeaaaakaalaaaaadabaaabiaaaaakkiaapaaaakaacaaaaad
abaaabiaaaaakkibabaaaaiaaeaaaaaeaaaaaemaaeaaffkaabaaaaiaaaaakkia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaaimaaaaappia
ppppaaaafdeieefcbaagaaaaeaaaabaaieabaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
agaaaaaafjaaaaaeegiocaaaadaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
aaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaa
abaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaa
fgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
mnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalp
bkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaia
ibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaa
egaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaa
abaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
kgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaa
acaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaa
aceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaa
agaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaa
acaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaa
fgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaa
aaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakiacaaaacaaaaaaafaaaaaadgaaaaaflccabaaaaaaaaaaa
egambaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakeccabaaaaaaaaaaabkiacaaaacaaaaaaafaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahafaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapahaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_LightPositionRange]
Vector 11 [_Wind]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 43 ALU
PARAM c[15] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..12],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[9].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[13];
FRC R0, R0;
MUL R0, R0, c[14].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[14].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[14].x, c[14].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[11];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[14].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[11].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[11];
MAD R0.xyz, R0, R2.x, R1;
MOV R0.w, vertex.position;
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
ADD result.texcoord[0].xyz, R1, -c[10];
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
END
# 43 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [_LightPositionRange]
Vector 10 [_Wind]
Vector 11 [_MainTex_ST]
"vs_2_0
; 44 ALU
def c12, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c13, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c14, 2.00000000, 3.00000000, 0.10000000, 0.22500001
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c12.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c8.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c13
frc r0, r0
mad r0, r0, c12.y, c12.z
frc r0, r0
mad r0, r0, c12.y, c12.w
abs r0, r0
mad r1, -r0, c14.x, c14.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c10
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c14.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c14.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c10.w, v0
mul r0.xyz, v5.z, c10
mad r0.xyz, r0, r2.x, r1
mov r0.w, v0
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
add oT0.xyz, r1, -c9
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT1.xy, v3, c11, c11.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbipkljdjdbmebcbjnoohehleflkmpgohabaaaaaakmahaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceaagaaaaeaaaabaajaabaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaa
dkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaak
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaa
acaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaaj
pcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaa
dcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaea
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaa
adaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaa
diaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaah
kcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaa
aaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaak
ocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedhajalnapkddpmahfmbilpjfgmclimjomabaaaaaaiealaaaaaeaaaaaa
daaaaaaaaeaeaaaaemakaaaabealaaaaebgpgodjmmadaaaammadaaaaaaacpopp
fmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
acaaabaaabaaaeaaaaaaaaaaadaaaaaaaeaaafaaaaaaaaaaadaaamaaaeaaajaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkamnmmpmdpamaceldpaaaamado
mlkbefdofbaaaaafaoaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaaf
apaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafia
afaaapjaaeaaaaaeabaaadoaadaaoejaacaaoekaacaaookaabaaaaacaaaaabia
ajaappkaabaaaaacaaaaaciaakaappkaabaaaaacaaaaaeiaalaappkaaiaaaaad
aaaaabiaaaaaoeiaaoaaaakaacaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaad
aaaaaciaabaaffiaafaaffjaaiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaad
acaaapiaaaaakajaadaaffkaacaaaaadabaaapiaabaafaiaacaaoeiaafaaaaad
abaaapiaabaaoeiaanaaoekabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaaoaaffkaaoaakkkabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaaoaaffkaaoaappkacdaaaaacabaaapiaabaaoeiaafaaaaadacaaapia
abaaoeiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaapaaaakbapaaffkaafaaaaad
abaaapiaabaaoeiaacaaoeiaacaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaad
abaaahiaaaaakkiaabaaoekaafaaaaadabaaahiaabaaoeiaafaakkjaamaaaaad
acaaadiaacaaoijbacaaoijaamaaaaadacaaamiaacaaiejaacaaiejbacaaaaad
acaaadiaacaaooibacaaoeiaafaaaaadabaaaiiaafaaffjaapaakkkaafaaaaad
acaaamiaabaappiaacaaiejaafaaaaadacaaafiaacaaneiaacaapgiaafaaaaad
acaaaciaafaakkjaapaappkaaeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaia
aeaaaaaeaaaaaoiaaaaaoeiaabaappkaaaaajajaafaaaaadabaaahiaafaakkja
abaaoekaaeaaaaaeaaaaahiaabaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaahia
aaaaffiaakaaoekaaeaaaaaeabaaahiaajaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaahiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeabaaahiaamaaoekaaaaappja
abaaoeiaacaaaaadaaaaahoaabaaoeiaaeaaoekbafaaaaadabaaapiaaaaaffia
agaaoekaaeaaaaaeabaaapiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapia
ahaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefceaagaaaaeaaaabaajaabaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaa
dkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaak
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaa
acaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaaj
pcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaa
dcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaea
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaah
ocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaa
adaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaa
diaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaah
kcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaa
aaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaak
ocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[1], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xy
texld r0, t1, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t0.w
mul r0.x, t0.z, r0
mov r0, r0.x
mov oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbjglihenigcaenjjkckflhoeflnljfmgabaaaaaakiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaaaaaa
eaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_DEPTH" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedeijkjbhbnkmnfbmdjigmfjeffojiinjmabaaaaaagaacaaaaaeaaaaaa
daaaaaaaoeaaaaaaneabaaaacmacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
hiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaiaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadaaaacpiaaaaappiaaaaaaakb
ebaaaaabaaaaapiaabaaaaacaaaaapiaabaaaakaabaaaaacaaaiapiaaaaaoeia
ppppaaaafdeieefcoiaaaaaaeaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[4] = { program.local[0..1],
		{ 1, 255, 65025, 1.6058138e+008 },
		{ 0.99900001, 0.0039215689 } };
TEMP R0;
TEX R0.w, fragment.texcoord[1], texture[0], 2D;
SLT R0.x, R0.w, c[1];
KIL -R0.x;
DP3 R0.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[0].w;
MIN R0.x, R0, c[3];
MUL R0, R0.x, c[2];
FRC R0, R0;
MAD result.color, -R0.yzww, c[3].y, R0;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c2, 0.00000000, 1.00000000, 0.99900001, 0.00392157
def c3, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl t0.xyz
dcl t1.xy
texld r0, t1, s0
add_pp r0.x, r0.w, -c1
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
texkill r0.xyzw
dp3 r0.x, t0, t0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c0.w
min r0.x, r0, c2.z
mul r0, r0.x, c3
frc r1, r0
mov r0.z, -r1.w
mov r0.xyw, -r1.yzxw
mad r0, r0, c2.w, r1
mov oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Float 128 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecednepbdmbkbnbgkncbejbhoahepblihmpeabaaaaaajiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaabaaaaeaaaaaaahaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
hhlohpdpdiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaaaceaaaaaibiaiadl
ibiaiadlibiaiadlibiaiadlegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Float 128 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedfnpimkacojinkengnkebghbphgbkocgeabaaaaaadmaeaaaaaeaaaaaa
daaaaaaanaabaaaajiadaaaaaiaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
fiabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaaiaaabaaaaaaaaaaaaaaabaaabaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaibiaiadlaaaaaaaaaaaaaaaaaaaaaaaafbaaaaafadaaapkahhlohplp
aaljdolpaaaahklpaaaaaaiafbaaaaafaeaaapkaaaaaiadpaaaahpedaaabhoeh
hacebjenbpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaadlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaacaaaaadaaaacpia
aaaappiaaaaaaakbebaaaaabaaaaapiaaiaaaaadaaaaabiaaaaaoelaaaaaoela
ahaaaaacaaaaabiaaaaaaaiaagaaaaacaaaaabiaaaaaaaiaafaaaaadaaaaacia
aaaaaaiaabaappkaabaaaaacabaaaiiaadaaaakaaeaaaaaeaaaaabiaaaaaaaia
abaappkaabaappiaafaaaaadabaaapiaaaaaffiaaeaaoekabdaaaaacabaaapia
abaaoeiafiaaaaaeaaaaapiaaaaaaaiaadaaoekbabaaoeiaaeaaaaaeabaaalia
aaaamjiaacaaaakbaaaaoeiaaeaaaaaeabaaaeiaaaaappiaacaaaakbaaaakkia
abaaaaacaaaiapiaabaaoeiappppaaaafdeieefcmaabaaaaeaaaaaaahaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
hhlohpdpdiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaaaceaaaaaibiaiadl
ibiaiadlibiaiadlibiaiadlegaobaaaaaaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "IGNOREPROJECTOR"="True" "RenderType"="AtsFoliage" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
Vector 29 [_Time]
Vector 30 [unity_Scale]
Vector 31 [_Wind]
Vector 32 [_MainTex_ST]
"!!ARBvp1.0
# 70 ALU
PARAM c[35] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..32],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[28];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[29].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[33];
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[34].x, c[34].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[31];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[34].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[31].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[31];
MAD R2.xyz, R0, R2.x, R1;
MOV R2.w, vertex.position;
DP4 R0.w, R2, c[3];
DP4 R1.w, R2, c[28];
DP4 R0.z, R2, c[27];
DP4 R0.x, R2, c[25];
DP4 R0.y, R2, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
MOV result.texcoord[4], R0;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, vertex.normal;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MUL R0.xyz, R0, c[30].w;
DP3 R1.x, R0, c[25];
DP3 R1.y, R0, c[26];
MOV R1.w, c[0].z;
DP3 R1.z, R0, c[27];
DP4 result.position.w, R2, c[8];
DP4 result.position.z, R2, c[7];
DP4 result.position.y, R2, c[6];
DP4 result.position.x, R2, c[5];
DP4 result.texcoord[6].z, R1, c[11];
DP4 result.texcoord[6].y, R1, c[10];
DP4 result.texcoord[6].x, R1, c[9];
MAD result.texcoord[5].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 70 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Vector 28 [_Time]
Vector 29 [unity_Scale]
Vector 30 [_Wind]
Vector 31 [_MainTex_ST]
"vs_2_0
; 71 ALU
def c32, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c33, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c34, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c35, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c27
dp3 r2.x, c32.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c28.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c33
frc r0, r0
mad r0, r0, c32.y, c32.z
frc r0, r0
mad r0, r0, c32.y, c32.w
abs r0, r0
mad r1, -r0, c34.x, c34.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c30
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c34.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c34.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c30.w, v0
mul r0.xyz, v5.z, c30
mad r2.xyz, r0, r2.x, r1
mov r2.w, v0
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
mov oT4, r0
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r0.xyz, r0.x, v2
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mul r0.xyz, r0, c29.w
dp3 r1.x, r0, c24
dp3 r1.y, r0, c25
mov r1.w, c35.x
dp3 r1.z, r0, c26
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
dp4 oT6.z, r1, c10
dp4 oT6.y, r1, c9
dp4 oT6.x, r1, c8
mad oT5.xy, v3, c31, c31.zwzw
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
Vector 29 [_Time]
Vector 30 [unity_Scale]
Vector 31 [_Wind]
Vector 32 [_MainTex_ST]
"!!ARBvp1.0
# 70 ALU
PARAM c[35] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..32],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[28];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[29].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[33];
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[34].x, c[34].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[31];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[34].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[31].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[31];
MAD R2.xyz, R0, R2.x, R1;
MOV R2.w, vertex.position;
DP4 R0.w, R2, c[3];
DP4 R1.w, R2, c[28];
DP4 R0.z, R2, c[27];
DP4 R0.x, R2, c[25];
DP4 R0.y, R2, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
MOV result.texcoord[4], R0;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, vertex.normal;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MUL R0.xyz, R0, c[30].w;
DP3 R1.x, R0, c[25];
DP3 R1.y, R0, c[26];
MOV R1.w, c[0].z;
DP3 R1.z, R0, c[27];
DP4 result.position.w, R2, c[8];
DP4 result.position.z, R2, c[7];
DP4 result.position.y, R2, c[6];
DP4 result.position.x, R2, c[5];
DP4 result.texcoord[6].z, R1, c[11];
DP4 result.texcoord[6].y, R1, c[10];
DP4 result.texcoord[6].x, R1, c[9];
MAD result.texcoord[5].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 70 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Vector 28 [_Time]
Vector 29 [unity_Scale]
Vector 30 [_Wind]
Vector 31 [_MainTex_ST]
"vs_2_0
; 71 ALU
def c32, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c33, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c34, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c35, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c27
dp3 r2.x, c32.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c28.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c33
frc r0, r0
mad r0, r0, c32.y, c32.z
frc r0, r0
mad r0, r0, c32.y, c32.w
abs r0, r0
mad r1, -r0, c34.x, c34.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c30
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c34.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c34.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c30.w, v0
mul r0.xyz, v5.z, c30
mad r2.xyz, r0, r2.x, r1
mov r2.w, v0
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
mov oT4, r0
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r0.xyz, r0.x, v2
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mul r0.xyz, r0, c29.w
dp3 r1.x, r0, c24
dp3 r1.y, r0, c25
mov r1.w, c35.x
dp3 r1.z, r0, c26
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
dp4 oT6.z, r1, c10
dp4 oT6.y, r1, c9
dp4 oT6.x, r1, c8
mad oT5.xy, v3, c31, c31.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjllkadboehbcdnohokjiohohiddnaneeabaaaaaakmamaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
miakaaaaeaaaabaalcacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabiaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
aaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaa
abaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaa
fgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
mnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalp
bkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaia
ibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaa
egaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaa
abaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
kgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaa
acaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaa
aceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaa
agaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaa
acaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaa
fgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaa
aaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaacaaaaaaajaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaakaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaacaaaaaaalaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
bdaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiccaaaacaaaaaabfaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaabeaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaabgaaaaaakgakbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaabhaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
afaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaahaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedjblfpocnfpaigcandbbebcigcghkbhahabaaaaaakabcaaaaaeaaaaaa
daaaaaaacaagaaaapabaaaaalibbaaaaebgpgodjoiafaaaaoiafaaaaaaacpopp
gmafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
acaaaiaabaaaaeaaaaaaaaaaadaaaaaaaiaabeaaaaaaaaaaadaaamaaaeaabmaa
aaaaaaaaadaabeaaabaacaaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafccaaapkaaaaaiadpaaaaaaea
aaaaaalpaaaaialpfbaaaaafcdaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdo
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeafaaadoaadaaoejaacaaoeka
acaaookaceaaaaacaaaaahiaacaaoejaafaaaaadaaaaahiaaaaaoeiacaaappka
afaaaaadabaaahiaaaaaffiabnaaoekaaeaaaaaeaaaaaliabmaakekaaaaaaaia
abaakeiaaeaaaaaeaaaaahiaboaaoekaaaaakkiaaaaapeiaafaaaaadabaaahia
aaaaffiaafaaoekaaeaaaaaeaaaaaliaaeaakekaaaaaaaiaabaakeiaaeaaaaae
agaaahoaagaaoekaaaaakkiaaaaapeiaabaaaaacaaaaabiabmaappkaabaaaaac
aaaaaciabnaappkaabaaaaacaaaaaeiaboaappkaaiaaaaadaaaaabiaaaaaoeia
ccaaaakaacaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaabaaffia
afaaffjaaiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaadacaaapiaaaaakaja
adaaffkaacaaaaadabaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeia
cbaaoekabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaccaaffka
ccaakkkabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaccaaffka
ccaappkacdaaaaacabaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeia
aeaaaaaeabaaapiaabaaoeiacdaaaakbcdaaffkaafaaaaadabaaapiaabaaoeia
acaaoeiaacaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaadabaaahiaaaaakkia
abaaoekaafaaaaadabaaahiaabaaoeiaafaakkjaamaaaaadacaaadiaacaaoijb
acaaoijaamaaaaadacaaamiaacaaiejaacaaiejbacaaaaadacaaadiaacaaooib
acaaoeiaafaaaaadabaaaiiaafaaffjacdaakkkaafaaaaadacaaamiaabaappia
acaaiejaafaaaaadacaaafiaacaaneiaacaapgiaafaaaaadacaaaciaafaakkja
cdaappkaaeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaiaaeaaaaaeaaaaaoia
aaaaoeiaabaappkaaaaajajaafaaaaadabaaahiaafaakkjaabaaoekaaeaaaaae
aaaaahiaabaaoeiaaaaaaaiaaaaapjiaafaaaaadaaaaaiiaaaaaffiabjaakkka
aeaaaaaeaaaaaiiabiaakkkaaaaaaaiaaaaappiaaeaaaaaeaaaaaiiabkaakkka
aaaakkiaaaaappiaaeaaaaaeaaaaaiiablaakkkaaaaappjaaaaappiaabaaaaac
aeaaaioaaaaappibafaaaaadabaaapiaaaaaffiabnaaoekaaeaaaaaeabaaapia
bmaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaboaaoekaaaaakkiaabaaoeia
aeaaaaaeabaaapiabpaaoekaaaaappjaabaaoeiaafaaaaadacaaahiaabaaffia
afaaoekaaeaaaaaeacaaahiaaeaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaahia
agaaoekaabaakkiaacaaoeiaaeaaaaaeaaaaahoaahaaoekaabaappiaacaaoeia
afaaaaadacaaahiaabaaffiaajaaoekaaeaaaaaeacaaahiaaiaaoekaabaaaaia
acaaoeiaaeaaaaaeacaaahiaakaaoekaabaakkiaacaaoeiaaeaaaaaeabaaahoa
alaaoekaabaappiaacaaoeiaafaaaaadacaaahiaabaaffiaanaaoekaaeaaaaae
acaaahiaamaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaahiaaoaaoekaabaakkia
acaaoeiaaeaaaaaeacaaahoaapaaoekaabaappiaacaaoeiaafaaaaadacaaahia
abaaffiabbaaoekaaeaaaaaeacaaahiabaaaoekaabaaaaiaacaaoeiaaeaaaaae
acaaahiabcaaoekaabaakkiaacaaoeiaaeaaaaaeadaaahoabdaaoekaabaappia
acaaoeiaabaaaaacaeaaahoaabaaoeiaafaaaaadabaaapiaaaaaffiabfaaoeka
aeaaaaaeabaaapiabeaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiabgaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcmiakaaaaeaaaabaalcacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabiaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaa
egaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaa
abaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaa
fgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
agbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
dcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaaf
dcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaa
afaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaa
acaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaa
agaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaa
aaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaaiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaabaaaaaaegiccaaaacaaaaaaalaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaapaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaa
kgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
acaaaaaabdaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabfaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaabeaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabgaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaabhaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
iccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaagaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
Vector 29 [_Time]
Vector 30 [unity_Scale]
Vector 31 [_Wind]
Vector 32 [_MainTex_ST]
"!!ARBvp1.0
# 70 ALU
PARAM c[35] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..32],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[28];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[29].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[33];
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[34].x, c[34].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[31];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[34].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[31].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[31];
MAD R2.xyz, R0, R2.x, R1;
MOV R2.w, vertex.position;
DP4 R0.w, R2, c[3];
DP4 R1.w, R2, c[28];
DP4 R0.z, R2, c[27];
DP4 R0.x, R2, c[25];
DP4 R0.y, R2, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
MOV result.texcoord[4], R0;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, vertex.normal;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MUL R0.xyz, R0, c[30].w;
DP3 R1.x, R0, c[25];
DP3 R1.y, R0, c[26];
MOV R1.w, c[0].z;
DP3 R1.z, R0, c[27];
DP4 result.position.w, R2, c[8];
DP4 result.position.z, R2, c[7];
DP4 result.position.y, R2, c[6];
DP4 result.position.x, R2, c[5];
DP4 result.texcoord[6].z, R1, c[11];
DP4 result.texcoord[6].y, R1, c[10];
DP4 result.texcoord[6].x, R1, c[9];
MAD result.texcoord[5].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 70 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Vector 28 [_Time]
Vector 29 [unity_Scale]
Vector 30 [_Wind]
Vector 31 [_MainTex_ST]
"vs_2_0
; 71 ALU
def c32, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c33, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c34, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c35, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c27
dp3 r2.x, c32.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c28.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c33
frc r0, r0
mad r0, r0, c32.y, c32.z
frc r0, r0
mad r0, r0, c32.y, c32.w
abs r0, r0
mad r1, -r0, c34.x, c34.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c30
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c34.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c34.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c30.w, v0
mul r0.xyz, v5.z, c30
mad r2.xyz, r0, r2.x, r1
mov r2.w, v0
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
mov oT4, r0
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r0.xyz, r0.x, v2
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mul r0.xyz, r0, c29.w
dp3 r1.x, r0, c24
dp3 r1.y, r0, c25
mov r1.w, c35.x
dp3 r1.z, r0, c26
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
dp4 oT6.z, r1, c10
dp4 oT6.y, r1, c9
dp4 oT6.x, r1, c8
mad oT5.xy, v3, c31, c31.zwzw
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
Vector 29 [_Time]
Vector 30 [unity_Scale]
Vector 31 [_Wind]
Vector 32 [_MainTex_ST]
"!!ARBvp1.0
# 70 ALU
PARAM c[35] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..32],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[28];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[29].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[33];
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[34].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[34].x, c[34].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[31];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[34].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[31].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[31];
MAD R2.xyz, R0, R2.x, R1;
MOV R2.w, vertex.position;
DP4 R0.w, R2, c[3];
DP4 R1.w, R2, c[28];
DP4 R0.z, R2, c[27];
DP4 R0.x, R2, c[25];
DP4 R0.y, R2, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
MOV result.texcoord[4], R0;
DP3 R0.x, vertex.normal, vertex.normal;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, vertex.normal;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MUL R0.xyz, R0, c[30].w;
DP3 R1.x, R0, c[25];
DP3 R1.y, R0, c[26];
MOV R1.w, c[0].z;
DP3 R1.z, R0, c[27];
DP4 result.position.w, R2, c[8];
DP4 result.position.z, R2, c[7];
DP4 result.position.y, R2, c[6];
DP4 result.position.x, R2, c[5];
DP4 result.texcoord[6].z, R1, c[11];
DP4 result.texcoord[6].y, R1, c[10];
DP4 result.texcoord[6].x, R1, c[9];
MAD result.texcoord[5].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 70 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Vector 28 [_Time]
Vector 29 [unity_Scale]
Vector 30 [_Wind]
Vector 31 [_MainTex_ST]
"vs_2_0
; 71 ALU
def c32, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c33, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c34, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c35, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c27
dp3 r2.x, c32.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c28.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c33
frc r0, r0
mad r0, r0, c32.y, c32.z
frc r0, r0
mad r0, r0, c32.y, c32.w
abs r0, r0
mad r1, -r0, c34.x, c34.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c30
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c34.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c34.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c30.w, v0
mul r0.xyz, v5.z, c30
mad r2.xyz, r0, r2.x, r1
mov r2.w, v0
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
mov oT4, r0
dp3 r0.x, v2, v2
rsq r0.x, r0.x
mul r0.xyz, r0.x, v2
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mul r0.xyz, r0, c29.w
dp3 r1.x, r0, c24
dp3 r1.y, r0, c25
mov r1.w, c35.x
dp3 r1.z, r0, c26
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
dp4 oT6.z, r1, c10
dp4 oT6.y, r1, c9
dp4 oT6.x, r1, c8
mad oT5.xy, v3, c31, c31.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjllkadboehbcdnohokjiohohiddnaneeabaaaaaakmamaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
miakaaaaeaaaabaalcacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabiaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
aaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaa
abaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaa
fgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
mnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalp
bkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaia
ibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaa
egaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaa
abaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
kgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaa
acaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaa
aceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaa
agaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaa
acaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaa
fgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaa
aaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaacaaaaaaajaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaakaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaacaaaaaaalaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
bdaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiccaaaacaaaaaabfaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaabeaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaabgaaaaaakgakbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaabhaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
afaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaahaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Wind]
Vector 112 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedjblfpocnfpaigcandbbebcigcghkbhahabaaaaaakabcaaaaaeaaaaaa
daaaaaaacaagaaaapabaaaaalibbaaaaebgpgodjoiafaaaaoiafaaaaaaacpopp
gmafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
abaaabaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
acaaaiaabaaaaeaaaaaaaaaaadaaaaaaaiaabeaaaaaaaaaaadaaamaaaeaabmaa
aaaaaaaaadaabeaaabaacaaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafccaaapkaaaaaiadpaaaaaaea
aaaaaalpaaaaialpfbaaaaafcdaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdo
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeafaaadoaadaaoejaacaaoeka
acaaookaceaaaaacaaaaahiaacaaoejaafaaaaadaaaaahiaaaaaoeiacaaappka
afaaaaadabaaahiaaaaaffiabnaaoekaaeaaaaaeaaaaaliabmaakekaaaaaaaia
abaakeiaaeaaaaaeaaaaahiaboaaoekaaaaakkiaaaaapeiaafaaaaadabaaahia
aaaaffiaafaaoekaaeaaaaaeaaaaaliaaeaakekaaaaaaaiaabaakeiaaeaaaaae
agaaahoaagaaoekaaaaakkiaaaaapeiaabaaaaacaaaaabiabmaappkaabaaaaac
aaaaaciabnaappkaabaaaaacaaaaaeiaboaappkaaiaaaaadaaaaabiaaaaaoeia
ccaaaakaacaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaabaaffia
afaaffjaaiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaadacaaapiaaaaakaja
adaaffkaacaaaaadabaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeia
cbaaoekabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaccaaffka
ccaakkkabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaccaaffka
ccaappkacdaaaaacabaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeia
aeaaaaaeabaaapiaabaaoeiacdaaaakbcdaaffkaafaaaaadabaaapiaabaaoeia
acaaoeiaacaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaadabaaahiaaaaakkia
abaaoekaafaaaaadabaaahiaabaaoeiaafaakkjaamaaaaadacaaadiaacaaoijb
acaaoijaamaaaaadacaaamiaacaaiejaacaaiejbacaaaaadacaaadiaacaaooib
acaaoeiaafaaaaadabaaaiiaafaaffjacdaakkkaafaaaaadacaaamiaabaappia
acaaiejaafaaaaadacaaafiaacaaneiaacaapgiaafaaaaadacaaaciaafaakkja
cdaappkaaeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaiaaeaaaaaeaaaaaoia
aaaaoeiaabaappkaaaaajajaafaaaaadabaaahiaafaakkjaabaaoekaaeaaaaae
aaaaahiaabaaoeiaaaaaaaiaaaaapjiaafaaaaadaaaaaiiaaaaaffiabjaakkka
aeaaaaaeaaaaaiiabiaakkkaaaaaaaiaaaaappiaaeaaaaaeaaaaaiiabkaakkka
aaaakkiaaaaappiaaeaaaaaeaaaaaiiablaakkkaaaaappjaaaaappiaabaaaaac
aeaaaioaaaaappibafaaaaadabaaapiaaaaaffiabnaaoekaaeaaaaaeabaaapia
bmaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaboaaoekaaaaakkiaabaaoeia
aeaaaaaeabaaapiabpaaoekaaaaappjaabaaoeiaafaaaaadacaaahiaabaaffia
afaaoekaaeaaaaaeacaaahiaaeaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaahia
agaaoekaabaakkiaacaaoeiaaeaaaaaeaaaaahoaahaaoekaabaappiaacaaoeia
afaaaaadacaaahiaabaaffiaajaaoekaaeaaaaaeacaaahiaaiaaoekaabaaaaia
acaaoeiaaeaaaaaeacaaahiaakaaoekaabaakkiaacaaoeiaaeaaaaaeabaaahoa
alaaoekaabaappiaacaaoeiaafaaaaadacaaahiaabaaffiaanaaoekaaeaaaaae
acaaahiaamaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaahiaaoaaoekaabaakkia
acaaoeiaaeaaaaaeacaaahoaapaaoekaabaappiaacaaoeiaafaaaaadacaaahia
abaaffiabbaaoekaaeaaaaaeacaaahiabaaaoekaabaaaaiaacaaoeiaaeaaaaae
acaaahiabcaaoekaabaakkiaacaaoeiaaeaaaaaeadaaahoabdaaoekaabaappia
acaaoeiaabaaaaacaeaaahoaabaaoeiaafaaaaadabaaapiaaaaaffiabfaaoeka
aeaaaaaeabaaapiabeaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiabgaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcmiakaaaaeaaaabaalcacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabiaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaadkiacaaaadaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaa
egaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaa
abaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaa
fgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
agbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
dcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaaf
dcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaa
afaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaa
acaaaaaaagaabaaaadaaaaaaagbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaa
agaebaaaacaaaaaakgaobaaaacaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaa
aaaaaaaafgaobaaaadaaaaaaagajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaaiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaabaaaaaaegiccaaaacaaaaaaalaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaapaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaa
kgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
acaaaaaabdaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabfaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaabeaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabgaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaabhaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
iccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaagaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_ShadowOffsetScale]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 30 ALU, 3 TEX
PARAM c[7] = { program.local[0..5],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
TEX R0.z, fragment.texcoord[5], texture[1], 2D;
MUL R3.xyz, fragment.texcoord[6], c[4].x;
SLT R0.w, R0, c[5].x;
MAD R4.xyz, R3, R0.z, fragment.texcoord[1];
SLT R2, fragment.texcoord[4].w, c[2];
SGE R1, fragment.texcoord[4].w, c[1];
MUL R1, R1, R2;
MAD R2.xyz, R3, R0.z, fragment.texcoord[0];
MUL R4.xyz, R1.y, R4;
MAD R4.xyz, R1.x, R2, R4;
MAD R2.xyz, R3, R0.z, fragment.texcoord[2];
MAD R1.xyz, R1.z, R2, R4;
MAD R0.xyz, R3, R0.z, fragment.texcoord[3];
MAD R0.xyz, R0, R1.w, R1;
MAD_SAT R1.y, fragment.texcoord[4].w, c[3].z, c[3].w;
MOV result.color.y, c[6].x;
TEX R0.x, R0, texture[2], 2D;
KIL -R0.w;
ADD R0.z, R0.x, -R0;
MOV R0.x, c[6];
CMP R1.x, R0.z, c[3], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[6].x;
MUL R0.xy, R0.y, c[6];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[6].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 30 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_ShadowOffsetScale]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
; 32 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
dcl t5.xy
dcl t6.xyz
texld r1, t5, s0
texld r4, t5, s1
mul r1.xyz, t6, c4.x
add r2, t4.w, -c2
add r0, t4.w, -c1
mad r3.xyz, r1, r4.z, t1
cmp r2, r2, c6.x, c6.y
cmp r0, r0, c6.y, c6.x
mul r0, r0, r2
mul r3.xyz, r0.y, r3
mad r2.xyz, r1, r4.z, t0
mad r2.xyz, r0.x, r2, r3
mad r3.xyz, r1, r4.z, t2
add_pp r0.x, r1.w, -c5
mad r2.xyz, r0.z, r3, r2
mad r1.xyz, r1, r4.z, t3
mad r2.xyz, r1, r0.w, r2
cmp r0.x, r0, c6, c6.y
mov_pp r1, -r0.x
texld r0, r2, s2
texkill r1.xyzw
mul r1.x, -t4.w, c0.w
mov r2.x, c3
add r0.x, r0, -r2.z
cmp r0.x, r0, c6.y, r2
add r1.x, r1, c6.y
mul r2.xy, r1.x, c6.yzxw
mad_sat r1.x, t4.w, c3.z, c3.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c6.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c6
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_ShadowOffsetScale]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 30 ALU, 3 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[7] = { program.local[0..5],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
TEX R0.z, fragment.texcoord[5], texture[1], 2D;
MUL R3.xyz, fragment.texcoord[6], c[4].x;
SLT R0.w, R0, c[5].x;
MAD R4.xyz, R3, R0.z, fragment.texcoord[1];
SLT R2, fragment.texcoord[4].w, c[2];
SGE R1, fragment.texcoord[4].w, c[1];
MUL R1, R1, R2;
MUL R2.xyz, R1.y, R4;
MAD R4.xyz, R3, R0.z, fragment.texcoord[0];
MAD R4.xyz, R1.x, R4, R2;
MAD R2.xyz, R3, R0.z, fragment.texcoord[2];
MAD R1.xyz, R1.z, R2, R4;
MAD R0.xyz, R3, R0.z, fragment.texcoord[3];
MAD R0.xyz, R0, R1.w, R1;
MAD_SAT R1.y, fragment.texcoord[4].w, c[3].z, c[3].w;
MOV result.color.y, c[6].x;
TEX R0.x, R0, texture[2], SHADOW2D;
KIL -R0.w;
MOV R0.y, c[6].x;
ADD R0.w, R0.y, -c[3].x;
MAD R1.x, R0, R0.w, c[3];
MUL R0.z, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0.z, c[6].x;
MUL R0.xy, R0.y, c[6];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[6].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 30 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_ShadowOffsetScale]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
; 32 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
dcl t5.xy
dcl t6.xyz
texld r1, t5, s0
texld r4, t5, s1
mul r1.xyz, t6, c4.x
add r2, t4.w, -c2
add r0, t4.w, -c1
mad r3.xyz, r1, r4.z, t1
cmp r2, r2, c6.x, c6.y
cmp r0, r0, c6.y, c6.x
mul r0, r0, r2
mul r3.xyz, r0.y, r3
mad r2.xyz, r1, r4.z, t0
mad r2.xyz, r0.x, r2, r3
mad r3.xyz, r1, r4.z, t2
add_pp r0.x, r1.w, -c5
mad r2.xyz, r0.z, r3, r2
mad r1.xyz, r1, r4.z, t3
mad r2.xyz, r1, r0.w, r2
cmp r0.x, r0, c6, c6.y
mov_pp r1, -r0.x
texld r0, r2, s2
texkill r1.xyzw
mov r2.x, c3
add r2.x, c6.y, -r2
mul r1.x, -t4.w, c0.w
mad r0.x, r0, r2, c3
add r1.x, r1, c6.y
mul r2.xy, r1.x, c6.yzxw
mad_sat r1.x, t4.w, c3.z, c3.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c6.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c6
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 144
Float 100 [_ShadowOffsetScale]
Float 128 [_Cutoff]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 96 [_LightSplitsNear]
Vector 112 [_LightSplitsFar]
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedcgnfpacgkmcbobljpnmbidnibkldodjpabaaaaaadiagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoiaeaaaaeaaaaaaadkabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadicbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabnaaaaaipcaabaaaaaaaaaaa
pgbpbaaaafaaaaaaegiocaaaacaaaaaaagaaaaaaabaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdbaaaaai
pcaabaaaabaaaaaapgbpbaaaafaaaaaaegiocaaaacaaaaaaahaaaaaaabaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaahaaaaaafgifcaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajlcaabaaaacaaaaaaegaibaaaabaaaaaakgakbaaaacaaaaaa
egbibaaaacaaaaaadiaaaaahlcaabaaaacaaaaaafgafbaaaaaaaaaaaegambaaa
acaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaabaaaaaakgakbaaaacaaaaaa
egbcbaaaabaaaaaadcaaaaajlcaabaaaacaaaaaaegaibaaaadaaaaaaagaabaaa
aaaaaaaaegambaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaabaaaaaa
kgakbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaakgakbaaaacaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaadaaaaaakgakbaaaaaaaaaaaegadbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaehaaaaal
bcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaacaaaaaa
biaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaadccaaaalccaabaaaaaaaaaaa
dkbabaaaafaaaaaackiacaaaacaaaaaabiaaaaaadkiacaaaacaaaaaabiaaaaaa
aacaaaahbccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaadkbabaiaebaaaaaaafaaaaaadkiacaaaabaaaaaaafaaaaaa
abeaaaaaaaaaiadpdiaaaaakdcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaahpedaaaaaaaaaaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakeccabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
ibiaiadlakaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafcccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 144
Float 100 [_ShadowOffsetScale]
Float 128 [_Cutoff]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 96 [_LightSplitsNear]
Vector 112 [_LightSplitsFar]
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
"ps_4_0_level_9_1
eefiecedlcdabdldcgmimhcbfgpemffhjoocnnlfabaaaaaaeeajaaaaafaaaaaa
deaaaaaaciadaaaabiaiaaaaciaiaaaabaajaaaaebgpgodjomacaaaaomacaaaa
aaacppppiaacaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaa
acaaaaaaaaababaaabacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaaiaaabaaabaa
aaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaagaaacaaadaaaaaaaaaaacaabiaa
abaaafaaaaaaaaaaaaacppppfbaaaaafagaaapkaaaaaaaaaaaaaiadpaaaahped
ibiaiadlbpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaaiaafaaadlabpaaaaacaaaaaaiaagaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaad
aaaacpiaafaaoelaabaioekaecaaaaadabaaapiaafaaoelaacaioekaacaaaaad
aaaacpiaaaaappiaabaaaakbacaaaaadacaaapiaaeaapplaaeaaoekbfiaaaaae
acaaapiaacaaoeiaagaaaakaagaaffkaacaaaaadadaaapiaaeaapplaadaaoekb
fiaaaaaeacaaapiaadaaoeiaacaaoeiaagaaaakaafaaaaadadaaahiaagaaoela
aaaaffkaaeaaaaaeaeaaahiaadaaoeiaabaakkiaabaaoelaafaaaaadaeaaahia
acaaffiaaeaaoeiaaeaaaaaeafaaahiaadaaoeiaabaakkiaaaaaoelaaeaaaaae
aeaaahiaafaaoeiaacaaaaiaaeaaoeiaaeaaaaaeafaaahiaadaaoeiaabaakkia
acaaoelaaeaaaaaeabaaahiaadaaoeiaabaakkiaadaaoelaaeaaaaaeacaaahia
afaaoeiaacaakkiaaeaaoeiaaeaaaaaeabaaahiaabaaoeiaacaappiaacaaoeia
ebaaaaabaaaaapiaecaaaaadaaaacpiaabaaoeiaaaaioekaabaaaaacaaaaacia
agaaffkabcaaaaaeabaacbiaaaaaaaiaaaaaffiaafaaaakaaeaaaaaeaaaabbia
aeaapplaafaakkkaafaappkaacaaaaadabaadbiaaaaaaaiaabaaaaiaaeaaaaae
aaaaabiaaeaapplaacaappkbaaaaffiaafaaaaadaaaaadiaaaaaaaiaagaamjka
bdaaaaacaaaaadiaaaaaoeiaaeaaaaaeabaaceiaaaaaffiaagaappkbaaaaaaia
abaaaaacabaaciiaaaaaffiaabaaaaacabaaaciaagaaffkaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcoiaeaaaaeaaaaaaadkabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadicbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabnaaaaaipcaabaaaaaaaaaaa
pgbpbaaaafaaaaaaegiocaaaacaaaaaaagaaaaaaabaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdbaaaaai
pcaabaaaabaaaaaapgbpbaaaafaaaaaaegiocaaaacaaaaaaahaaaaaaabaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaahaaaaaafgifcaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajlcaabaaaacaaaaaaegaibaaaabaaaaaakgakbaaaacaaaaaa
egbibaaaacaaaaaadiaaaaahlcaabaaaacaaaaaafgafbaaaaaaaaaaaegambaaa
acaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaabaaaaaakgakbaaaacaaaaaa
egbcbaaaabaaaaaadcaaaaajlcaabaaaacaaaaaaegaibaaaadaaaaaaagaabaaa
aaaaaaaaegambaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaabaaaaaa
kgakbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaakgakbaaaacaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaadaaaaaakgakbaaaaaaaaaaaegadbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaehaaaaal
bcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaacaaaaaa
biaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaadccaaaalccaabaaaaaaaaaaa
dkbabaaaafaaaaaackiacaaaacaaaaaabiaaaaaadkiacaaaacaaaaaabiaaaaaa
aacaaaahbccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaadkbabaiaebaaaaaaafaaaaaadkiacaaaabaaaaaaafaaaaaa
abeaaaaaaaaaiadpdiaaaaakdcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaahpedaaaaaaaaaaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakeccabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
ibiaiadlakaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafcccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaa
iaaaaaaaaaaaaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
neaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaadadaaaa
neaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_ShadowOffsetScale]
Float 9 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 41 ALU, 3 TEX
PARAM c[11] = { program.local[0..9],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
TEX R0.z, fragment.texcoord[5], texture[1], 2D;
ADD R1.xyz, fragment.texcoord[4], -c[1];
ADD R3.xyz, fragment.texcoord[4], -c[4];
SLT R0.w, R0, c[9].x;
DP3 R1.x, R1, R1;
ADD R2.xyz, fragment.texcoord[4], -c[2];
DP3 R1.y, R2, R2;
ADD R2.xyz, fragment.texcoord[4], -c[3];
DP3 R1.z, R2, R2;
DP3 R1.w, R3, R3;
MUL R2.xyz, fragment.texcoord[6], c[8].x;
SLT R1, R1, c[5];
MAD R3.xyz, R2, R0.z, fragment.texcoord[1];
ADD_SAT R1.yzw, R1, -R1.xxyz;
MUL R4.xyz, R1.y, R3;
MAD R3.xyz, R2, R0.z, fragment.texcoord[0];
MAD R4.xyz, R1.x, R3, R4;
MAD R3.xyz, R2, R0.z, fragment.texcoord[2];
MAD R0.xyz, R2, R0.z, fragment.texcoord[3];
MAD R1.xyz, R1.z, R3, R4;
MAD R0.xyz, R0, R1.w, R1;
ADD R2.xyz, -fragment.texcoord[4], c[7];
MOV result.color.y, c[10].x;
TEX R0.x, R0, texture[2], 2D;
KIL -R0.w;
ADD R0.y, R0.x, -R0.z;
MOV R0.x, c[10];
CMP R1.x, R0.y, c[6], R0;
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
RCP R0.z, R0.y;
MAD_SAT R1.y, R0.z, c[6].z, c[6].w;
MUL R0.x, -fragment.texcoord[4].w, c[0].w;
ADD R0.x, R0, c[10];
MUL R0.xy, R0.x, c[10];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[10].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 41 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_ShadowOffsetScale]
Float 9 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
; 45 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c10, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
dcl t5.xy
dcl t6.xyz
texld r1, t5, s0
texld r5, t5, s1
add r2.xyz, t4, -c4
add r0.xyz, t4, -c1
dp3 r0.w, r2, r2
dp3 r0.x, r0, r0
add r1.xyz, t4, -c2
dp3 r0.y, r1, r1
add r1.xyz, t4, -c3
dp3 r0.z, r1, r1
mul r1.xyz, t6, c8.x
add r0, r0, -c5
cmp r0, r0, c10.x, c10.y
mad r3.xyz, r1, r5.z, t1
mov r2.x, r0.y
mov r2.y, r0.z
mov r2.z, r0.w
add_sat r2.xyz, r2, -r0
mul r4.xyz, r2.x, r3
mad r3.xyz, r1, r5.z, t0
mad r3.xyz, r0.x, r3, r4
mad r4.xyz, r1, r5.z, t2
add_pp r0.x, r1.w, -c9
cmp r0.x, r0, c10, c10.y
mad r1.xyz, r1, r5.z, t3
mad r3.xyz, r2.y, r4, r3
mad r2.xyz, r1, r2.z, r3
mov_pp r1, -r0.x
texld r0, r2, s2
texkill r1.xyzw
add r0.x, r0, -r2.z
mov r1.x, c6
add r2.xyz, -t4, c7
cmp r0.x, r0, c10.y, r1
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c10.y
rcp r1.x, r1.x
mad_sat r1.x, r1, c6.z, c6.w
mul r2.xy, r2.x, c10.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c10.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c10
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_ShadowOffsetScale]
Float 9 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 41 ALU, 3 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[11] = { program.local[0..9],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
TEX R0.z, fragment.texcoord[5], texture[1], 2D;
ADD R1.xyz, fragment.texcoord[4], -c[1];
ADD R3.xyz, fragment.texcoord[4], -c[4];
SLT R0.w, R0, c[9].x;
DP3 R1.x, R1, R1;
ADD R2.xyz, fragment.texcoord[4], -c[2];
DP3 R1.y, R2, R2;
ADD R2.xyz, fragment.texcoord[4], -c[3];
DP3 R1.z, R2, R2;
MUL R2.xyz, fragment.texcoord[6], c[8].x;
DP3 R1.w, R3, R3;
SLT R1, R1, c[5];
ADD_SAT R1.yzw, R1, -R1.xxyz;
MAD R3.xyz, R2, R0.z, fragment.texcoord[1];
MUL R3.xyz, R1.y, R3;
MAD R4.xyz, R2, R0.z, fragment.texcoord[0];
MAD R4.xyz, R1.x, R4, R3;
MAD R3.xyz, R2, R0.z, fragment.texcoord[2];
MAD R1.xyz, R1.z, R3, R4;
MAD R0.xyz, R2, R0.z, fragment.texcoord[3];
MAD R0.xyz, R0, R1.w, R1;
ADD R1.xyz, -fragment.texcoord[4], c[7];
MOV result.color.y, c[10].x;
TEX R0.x, R0, texture[2], SHADOW2D;
KIL -R0.w;
MOV R0.y, c[10].x;
ADD R0.y, R0, -c[6].x;
MAD R1.w, R0.x, R0.y, c[6].x;
DP3 R0.y, R1, R1;
RSQ R0.y, R0.y;
RCP R0.z, R0.y;
MAD_SAT R1.x, R0.z, c[6].z, c[6].w;
MUL R0.x, -fragment.texcoord[4].w, c[0].w;
ADD R0.x, R0, c[10];
MUL R0.xy, R0.x, c[10];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[10].z, R0.z;
ADD_SAT result.color.x, R1.w, R1;
MOV result.color.zw, R0.xyxy;
END
# 41 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_ShadowOffsetScale]
Float 9 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpTransSpecMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
; 45 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c10, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
dcl t5.xy
dcl t6.xyz
texld r1, t5, s0
texld r5, t5, s1
add r2.xyz, t4, -c4
add r0.xyz, t4, -c1
dp3 r0.w, r2, r2
dp3 r0.x, r0, r0
add r1.xyz, t4, -c2
dp3 r0.y, r1, r1
add r1.xyz, t4, -c3
dp3 r0.z, r1, r1
mul r1.xyz, t6, c8.x
add r0, r0, -c5
cmp r0, r0, c10.x, c10.y
mad r3.xyz, r1, r5.z, t1
mov r2.x, r0.y
mov r2.y, r0.z
mov r2.z, r0.w
add_sat r2.xyz, r2, -r0
mul r4.xyz, r2.x, r3
mad r3.xyz, r1, r5.z, t0
mad r3.xyz, r0.x, r3, r4
mad r4.xyz, r1, r5.z, t2
add_pp r0.x, r1.w, -c9
cmp r0.x, r0, c10, c10.y
mad r1.xyz, r1, r5.z, t3
mad r3.xyz, r2.y, r4, r3
mad r2.xyz, r1, r2.z, r3
mov_pp r1, -r0.x
texld r0, r2, s2
texkill r1.xyzw
mov r1.x, c6
add r1.x, c10.y, -r1
add r2.xyz, -t4, c7
mad r0.x, r0, r1, c6
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c10.y
rcp r1.x, r1.x
mad_sat r1.x, r1, c6.z, c6.w
mul r2.xy, r2.x, c10.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c10.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c10
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 144
Float 100 [_ShadowOffsetScale]
Float 128 [_Cutoff]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 0 [unity_ShadowSplitSpheres0]
Vector 16 [unity_ShadowSplitSpheres1]
Vector 32 [unity_ShadowSplitSpheres2]
Vector 48 [unity_ShadowSplitSpheres3]
Vector 64 [unity_ShadowSplitSqRadii]
Vector 384 [_LightShadowData]
Vector 400 [unity_ShadowFadeCenterAndType]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedccmbgabfbnbdkdpkejklmajfafhnikiaabaaaaaakiahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfiagaaaaeaaaaaaajgabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabkaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaacaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadbaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaacaaaaaaaeaaaaaadhaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaceaaaaa
aaaaaaiaaaaaaaiaaaaaaaiaaaaaaaaaabaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaadeaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaahaaaaaafgifcaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaagaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaajlcaabaaaacaaaaaaegaibaaaabaaaaaakgakbaaaacaaaaaaegbibaaa
acaaaaaadiaaaaahlcaabaaaacaaaaaafgafbaaaaaaaaaaaegambaaaacaaaaaa
dcaaaaajhcaabaaaadaaaaaaegacbaaaabaaaaaakgakbaaaacaaaaaaegbcbaaa
abaaaaaadcaaaaajlcaabaaaacaaaaaaegaibaaaadaaaaaaagaabaaaaaaaaaaa
egambaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaabaaaaaakgakbaaa
acaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
kgakbaaaacaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
adaaaaaakgakbaaaaaaaaaaaegadbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaehaaaaalbcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaacaaaaaabiaaaaaa
abeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaacaaaaaabiaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaaa
afaaaaaaagijcaiaebaaaaaaacaaaaaabjaaaaaabaaaaaahccaabaaaaaaaaaaa
jgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadccaaaalccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaacaaaaaa
biaaaaaadkiacaaaacaaaaaabiaaaaaaaacaaaahbccabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaadkbabaiaebaaaaaa
afaaaaaadkiacaaaabaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaakdcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaahpedaaaaaaaaaaaaaaaa
bkaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaibiaiadlakaabaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpTransSpecMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 144
Float 100 [_ShadowOffsetScale]
Float 128 [_Cutoff]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 0 [unity_ShadowSplitSpheres0]
Vector 16 [unity_ShadowSplitSpheres1]
Vector 32 [unity_ShadowSplitSpheres2]
Vector 48 [unity_ShadowSplitSpheres3]
Vector 64 [unity_ShadowSplitSqRadii]
Vector 384 [_LightShadowData]
Vector 400 [unity_ShadowFadeCenterAndType]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
"ps_4_0_level_9_1
eefiecedhjcfbchipiiehedheohfgmhjnfjnckmmabaaaaaakealaaaaafaaaaaa
deaaaaaabiaeaaaahiakaaaaiiakaaaahaalaaaaebgpgodjnmadaaaanmadaaaa
aaacpppphaadaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaa
acaaaaaaaaababaaabacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaaiaaabaaabaa
aaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaafaaadaaaaaaaaaaacaabiaa
acaaaiaaaaaaaaaaaaacppppfbaaaaafakaaapkaaaaaiadpaaaahpedibiaiadl
aaaaaaaafbaaaaafalaaapkaaaaaaaaaaaaaiadpaaaaaaiaaaaaialpbpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaahla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaia
afaaadlabpaaaaacaaaaaaiaagaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaafaaoela
abaioekaecaaaaadabaaapiaafaaoelaacaioekaacaaaaadaaaacpiaaaaappia
abaaaakbacaaaaadacaaahiaaeaaoelaadaaoekbaiaaaaadacaaabiaacaaoeia
acaaoeiaacaaaaadadaaahiaaeaaoelaaeaaoekbaiaaaaadacaaaciaadaaoeia
adaaoeiaacaaaaadadaaahiaaeaaoelaafaaoekbaiaaaaadacaaaeiaadaaoeia
adaaoeiaacaaaaadadaaahiaaeaaoelaagaaoekbaiaaaaadacaaaiiaadaaoeia
adaaoeiaacaaaaadacaaapiaacaaoeiaahaaoekbfiaaaaaeadaaahiaacaaoeia
alaakkkaalaappkafiaaaaaeacaaapiaacaaoeiaalaaaakaalaaffkaacaaaaad
aeaaadiaadaaoeiaacaamjiaacaaaaadaeaaaeiaadaakkiaacaappiaalaaaaad
acaaaoiaaeaabliaalaaaakaafaaaaadadaaahiaagaaoelaaaaaffkaaeaaaaae
aeaaahiaadaaoeiaabaakkiaabaaoelaafaaaaadaeaaahiaacaappiaaeaaoeia
aeaaaaaeafaaahiaadaaoeiaabaakkiaaaaaoelaaeaaaaaeaeaaahiaafaaoeia
acaaaaiaaeaaoeiaaeaaaaaeafaaahiaadaaoeiaabaakkiaacaaoelaaeaaaaae
abaaahiaadaaoeiaabaakkiaadaaoelaaeaaaaaeadaaahiaafaaoeiaacaakkia
aeaaoeiaaeaaaaaeabaaahiaabaaoeiaacaaffiaadaaoeiaebaaaaabaaaaapia
ecaaaaadaaaacpiaabaaoeiaaaaioekaabaaaaacaaaaaciaalaaffkabcaaaaae
abaacbiaaaaaaaiaaaaaffiaaiaaaakaacaaaaadacaaahiaaeaaoelaajaaoekb
aiaaaaadaaaaabiaacaaoeiaacaaoeiaahaaaaacaaaaabiaaaaaaaiaagaaaaac
aaaaabiaaaaaaaiaaeaaaaaeaaaabbiaaaaaaaiaaiaakkkaaiaappkaacaaaaad
abaadbiaaaaaaaiaabaaaaiaaeaaaaaeaaaaabiaaeaapplaacaappkbaaaaffia
afaaaaadaaaaadiaaaaaaaiaakaaoekabdaaaaacaaaaadiaaaaaoeiaaeaaaaae
abaaceiaaaaaffiaakaakkkbaaaaaaiaabaaaaacabaaciiaaaaaffiaabaaaaac
abaacciaalaaffkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcfiagaaaa
eaaaaaaajgabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafkaiaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
pcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaafaaaaaaegiccaiaebaaaaaa
acaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaaegiccaiaebaaaaaa
acaaaaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaaegiccaiaebaaaaaa
acaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaaegiccaiaebaaaaaa
acaaaaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadbaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaacaaaaaa
aeaaaaaadhaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaaceaaaaaaaaaaaiaaaaaaaiaaaaaaaiaaaaaaaaa
abaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaaaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgaobaaa
aaaaaaaadeaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaahaaaaaa
fgifcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajlcaabaaaacaaaaaaegaibaaa
abaaaaaakgakbaaaacaaaaaaegbibaaaacaaaaaadiaaaaahlcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegambaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
abaaaaaakgakbaaaacaaaaaaegbcbaaaabaaaaaadcaaaaajlcaabaaaacaaaaaa
egaibaaaadaaaaaaagaabaaaaaaaaaaaegambaaaacaaaaaadcaaaaajhcaabaaa
adaaaaaaegacbaaaabaaaaaakgakbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaacaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaadaaaaaakgakbaaaaaaaaaaaegadbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaa
acaaaaaaaagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
akiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaa
aaaaaaajocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaiaebaaaaaaacaaaaaa
bjaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackiacaaaacaaaaaabiaaaaaadkiacaaaacaaaaaabiaaaaaa
aacaaaahbccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaadkbabaiaebaaaaaaafaaaaaadkiacaaaabaaaaaaafaaaaaa
abeaaaaaaaaaiadpdiaaaaakdcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaahpedaaaaaaaaaaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakeccabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
ibiaiadlakaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafcccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaa
iaaaaaaaaaaaaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
neaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaadadaaaa
neaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="AtsFoliage" }
 Pass {
  Tags { "RenderType"="AtsFoliage" }
  Lighting On
  Material {
   Ambient (1,1,1,1)
   Diffuse (1,1,1,1)
  }
  AlphaTest Greater [_Cutoff]
  ColorMask RGB
  SetTexture [_MainTex] { combine texture * primary double, texture alpha }
  SetTexture [_MainTex] { ConstantColor [_Color] combine previous * constant, previous alpha }
 }
}
}