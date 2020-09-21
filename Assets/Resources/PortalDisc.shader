Shader "JAW/FX/PortalDisc" {
Properties {
 noiseTexture ("Noise Texture", 2D) = "" {}
 portalColor ("Portal Color", Color) = (1,0,0,1)
 invPortalSize ("Inverse Portal Size", Float) = 0
 portalArcSpeed ("Arc Speed", Float) = 0.7
 portalArcScale ("Arc Scale", Float) = 0.3
 portalFadeRadius ("Fade Radius", Float) = 1
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Front
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Vector 5 [_Time]
Float 6 [portalArcSpeed]
Float 7 [portalArcScale]
"3.0-!!ARBvp1.0
# 78 ALU
PARAM c[12] = { { 2, 0.15915491, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..7],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 0.80000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0.x, c[5].y;
MUL R0.w, R0.x, -c[6].x;
MUL R0.x, R0.w, c[0].y;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[11].z;
FRC R2.w, R0.y;
ADD R1.xyz, -R1.w, c[8];
MUL R1.xyz, R1, R1;
MUL R2.xyz, R1, c[0].zwzw;
ADD R0.xyz, -R2.w, c[8];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[9].xyxw;
MAD R3.xyz, R3, R0, c[9].zwzw;
MAD R3.xyz, R3, R0, c[10].xyxw;
MAD R3.xyz, R3, R0, c[10].zwzw;
ADD R2.xyz, R2, c[9].xyxw;
MAD R2.xyz, R2, R1, c[9].zwzw;
MAD R2.xyz, R2, R1, c[10].xyxw;
MAD R2.xyz, R2, R1, c[10].zwzw;
MAD R2.xyz, R2, R1, c[8].wzww;
MAD R3.xyz, R3, R0, c[8].wzww;
SLT R1.x, R1.w, c[11].z;
SGE R1.yz, R1.w, c[11].xxyw;
SLT R4.x, R2.w, c[11].z;
SGE R4.yz, R2.w, c[11].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[8].wzww;
DP3 R0.x, R3, -R0;
MOV R3.xz, R1;
DP3 R3.y, R1, c[8].wzww;
DP3 R0.z, R2, -R3;
MUL R5.xy, vertex.position.xzzw, c[7].x;
MOV R0.y, R0.z;
MUL R1.xy, R5, c[0].x;
MUL R1.zw, R1.y, R0.xyxy;
MUL R0.y, -R0.w, c[11].w;
MOV R0.w, -R0.x;
MAD result.texcoord[0].zw, R1.x, R0, R1;
MUL R0.x, R0.y, c[0].y;
FRC R1.w, R0.x;
ADD R0.w, R0.x, -c[11].z;
FRC R0.w, R0;
ADD R0.xyz, -R1.w, c[8];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R2.xyz, -R0.w, c[8];
MUL R2.xyz, R2, R2;
MUL R3.xyz, R2, c[0].zwzw;
ADD R1.xyz, R1, c[9].xyxw;
MAD R1.xyz, R1, R0, c[9].zwzw;
MAD R1.xyz, R1, R0, c[10].xyxw;
MAD R1.xyz, R1, R0, c[10].zwzw;
ADD R3.xyz, R3, c[9].xyxw;
MAD R3.xyz, R3, R2, c[9].zwzw;
MAD R1.xyz, R1, R0, c[8].wzww;
SLT R4.x, R1.w, c[11].z;
SGE R4.yz, R1.w, c[11].xxyw;
DP3 R0.y, R4, c[8].wzww;
MOV R0.xz, R4;
DP3 R4.x, R1, -R0;
MAD R3.xyz, R3, R2, c[10].xyxw;
MAD R0.xyz, R3, R2, c[10].zwzw;
MAD R1.xyz, R0, R2, c[8].wzww;
SLT R0.x, R0.w, c[11].z;
SGE R0.yz, R0.w, c[11].xxyw;
MOV R2.xz, R0;
DP3 R2.y, R0, c[8].wzww;
DP3 R1.z, R1, -R2;
MOV R1.w, R4.x;
MUL R0.xy, R5.y, R1.zwzw;
MOV R4.y, -R1.z;
MAD result.texcoord[0].xy, R5.x, R4, R0;
MOV result.texcoord[1].xy, vertex.position.xzzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 78 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Time]
Float 5 [portalArcSpeed]
Float 6 [portalArcScale]
"vs_3_0
; 44 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 2.00000000, 0.15915491, 0.50000000, 0.80000001
def c8, 6.28318501, -3.14159298, 0, 0
dcl_position0 v0
mov r0.x, c5
mul r0.x, c4.y, -r0
mul r0.y, -r0.x, c7.w
mad r0.x, r0, c7.y, c7.z
mad r0.y, r0, c7, c7.z
frc r0.y, r0
mad r1.y, r0, c8.x, c8
frc r1.x, r0
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.x, c8.y
sincos r1.xy, r0.z
mul r0.zw, v0.xyxz, c6.x
mul r1.zw, r0, c7.x
mul r2.zw, r1.w, r1.xyyx
mov r2.x, r1
mov r2.y, -r1
mad o1.zw, r1.z, r2.xyxy, r2
mov r1.x, r0
mul r1.zw, r0.w, r0.xyyx
mov r1.y, -r0
mad o1.xy, r0.z, r1, r1.zwzw
mov o2.xy, v0.xzzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "$Globals" 48
Float 32 [portalArcSpeed]
Float 36 [portalArcScale]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedilmjfaicladgomcpikhclcjdbckfjknnabaaaaaaaiaeaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefcpaacaaaaeaaaabaalmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaacaaaaaabkiacaaa
abaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
mnmmemdpenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaa
dgaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaadgaaaaafccaabaaaacaaaaaa
akaabaaaabaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaaidcaabaaaaaaaaaaaigbabaaaaaaaaaaafgifcaaaaaaaaaaaacaaaaaa
apaaaaahbccabaaaabaaaaaaegaabaaaaaaaaaaajgafbaaaacaaaaaaapaaaaah
cccabaaaabaaaaaaegaabaaaaaaaaaaaegaabaaaacaaaaaaaaaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaakecaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaacaaaaaabkiacaaaabaaaaaaaaaaaaaaenaaaaah
bcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafccaabaaaadaaaaaaakaabaaaacaaaaaa
dgaaaaagbcaabaaaadaaaaaaakaabaiaebaaaaaaabaaaaaaapaaaaahiccabaaa
abaaaaaaegaabaaaaaaaaaaaegaabaaaadaaaaaaapaaaaaheccabaaaabaaaaaa
egaabaaaaaaaaaaajgafbaaaadaaaaaadgaaaaafdccabaaaacaaaaaaigbabaaa
aaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [portalColor]
Float 1 [invPortalSize]
Float 2 [portalFadeRadius]
SetTexture 0 [noiseTexture] 2D 0
"3.0-!!ARBfp1.0
# 20 ALU, 2 TEX
PARAM c[5] = { program.local[0..2],
		{ 2.718282, 1, 2, 0.25 },
		{ 4, 1.1 } };
TEMP R0;
TEMP R1;
MUL R0.xy, fragment.texcoord[1], fragment.texcoord[1];
ADD R0.x, R0, R0.y;
RSQ R0.x, R0.x;
RCP R0.z, R0.x;
MUL R0.z, -R0, c[1].x;
ADD R0.z, R0, c[2].x;
MUL R0.z, -R0, c[4].x;
TEX R1.xy, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R0.xy, fragment.texcoord[0], texture[0], 2D;
ADD R0.xy, R0, R1;
ADD R0.x, R0, -c[3].y;
MUL R0.y, R0, c[3].w;
ABS R0.x, R0;
MAD R0.x, R0, c[3].z, R0.y;
POW R0.z, c[3].x, R0.z;
ADD R0.y, -R0.z, c[3];
POW R0.x, c[3].x, -R0.x;
MUL R0.x, R0, R0.y;
MUL_SAT result.color.w, R0.x, c[4].y;
MOV result.color.xyz, c[0];
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [portalColor]
Float 1 [invPortalSize]
Float 2 [portalFadeRadius]
SetTexture 0 [noiseTexture] 2D 0
"ps_3_0
; 23 ALU, 2 TEX
dcl_2d s0
def c3, -1.00000000, 0.25000000, 2.00000000, 2.71828198
def c4, 4.00000000, 1.00000000, 1.10000002, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
mul r0.xy, v1, v1
add r0.x, r0, r0.y
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, -r0, c1
add r0.x, r0, c2
mul r1.z, -r0.x, c4.x
texld r0.xy, v0, s0
texld r1.xy, v0.zwzw, s0
add r1.xy, r0, r1
pow r0, c3.w, r1.z
add r0.y, r1.x, c3.x
mul r0.z, r1.y, c3.y
abs r0.y, r0
mad r0.y, r0, c3.z, r0.z
pow r1, c3.w, -r0.y
add r0.x, -r0, c4.y
mov r0.y, r1.x
mul r0.x, r0.y, r0
mul_sat oC0.w, r0.x, c4.z
mov oC0.xyz, c0
"
}
SubProgram "d3d11 " {
SetTexture 0 [noiseTexture] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [portalColor] 3
Float 28 [invPortalSize]
Float 40 [portalFadeRadius]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfgocahfjbameecnmfeamnbfkliodcmnabaaaaaadeadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaialpaaaaaaajbcaabaaa
aaaaaaaaakaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadoakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaaegbabaaa
acaaaaaaegbabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaamccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaa
abaaaaaackiacaaaaaaaaaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklimabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaamnmmimdpdgaaaaaghccabaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}