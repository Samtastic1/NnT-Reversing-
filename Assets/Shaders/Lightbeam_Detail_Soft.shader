Shader "Lightbeam/Lightbeam Detail Soft" {
Properties {
 _Color ("Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _DetailTex ("Detail Texture", 2D) = "white" {}
 _Width ("Width", Float) = 8.71
 _Tweak ("Tweak", Float) = 0.65
 _DetailContrast ("Detail Strength", Range(0,1)) = 0.5
 _DetailAnim ("Detail Animation", Vector) = (0,0,0,0)
 _SoftEdge ("Soft Edge", Float) = 0.8
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
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_ProjectionParams]
Vector 16 [unity_Scale]
Vector 17 [_DetailTex_ST]
Float 18 [_Width]
Float 19 [_Tweak]
Vector 20 [_DetailAnim]
"!!ARBvp1.0
# 37 ALU
PARAM c[21] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.w, c[0].x;
MOV R1.xyz, c[14];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[16].w, -vertex.position;
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
ADD R0.w, R0, c[19].x;
MUL R0.w, R0, c[18].x;
RSQ R2.x, R0.w;
MAD result.texcoord[1].xz, R0.z, R2.x, c[0].y;
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.z, vertex.position, c[7];
MAD result.texcoord[1].w, R2.x, R1.x, c[0].y;
MUL R1.xyz, R0.xyww, c[0].y;
MOV result.position, R0;
MUL R1.y, R1, c[15].x;
MOV R0.x, c[13];
MAD R0.zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, R0.x, c[20], R0.zwzw;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.texcoord[1].y, vertex.texcoord[0];
MOV result.texcoord[2].z, -R0.x;
MOV result.texcoord[2].w, R1;
END
# 37 instructions, 3 R-regs
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
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [unity_Scale]
Vector 17 [_DetailTex_ST]
Float 18 [_Width]
Float 19 [_Tweak]
Vector 20 [_DetailAnim]
"vs_2_0
; 38 ALU
def c21, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c21.x
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c16.w, -v0
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
add r0.w, r0, c19.x
mul r0.w, r0, c18.x
rsq r0.z, r0.w
mad oT1.w, r0.z, r0.x, c21.y
dp3 r2.x, v1, r1
mad oT1.xz, r2.x, r0.z, c21.y
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c21.y
dp4 r0.z, v0, c6
mov oPos, r0
mul r1.y, r1, c14.x
mov r0.xy, c20
mad r0.zw, v3.xyxy, c17.xyxy, c17
mad oT0.xy, c12.x, r0, r0.zwzw
dp4 r0.x, v0, c2
mad oT2.xy, r1.z, c15.zwzw, r1
mov oT1.y, v3
mov oT2.z, -r0.x
mov oT2.w, r1
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_DetailContrast]
Float 3 [_SoftEdge]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"!!ARBfp1.0
# 19 ALU, 4 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 0.2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[2].xyzz, texture[2], 2D;
TEX R2, fragment.texcoord[0], texture[1], 2D;
TEX R0.y, fragment.texcoord[1].zwzw, texture[0], 2D;
TEX R0.x, fragment.texcoord[1], texture[0], 2D;
ADD R2, R2, -c[4].x;
MUL R2, R2, c[2].x;
MUL R0.x, R0, R0.y;
MAD R0.z, R1.x, c[0], c[0].w;
RCP R0.y, R0.z;
MUL R1.x, R0, c[1].w;
ADD R0.x, R0.y, -fragment.texcoord[2].z;
ADD R2, R2, c[4].x;
MOV R1.yzw, c[1].xxyz;
MUL R1, R1.yzwx, R2;
MUL_SAT R0.x, R0, c[3];
MUL_SAT R0.y, fragment.texcoord[2].z, c[4];
MUL R0.x, R1.w, R0;
MUL result.color.w, R0.x, R0.y;
MOV result.color.xyz, R1;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_DetailContrast]
Float 3 [_SoftEdge]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_2_0
; 21 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, -1.00000000, 1.00000000, 0.20000000, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r2, t1, s0
mov r0.x, t2
mov r0.w, t2.z
mov r0.y, t2
mov r1.y, t1.w
mov r1.x, t1.z
texldp r3, r0, s2
texld r1, r1, s0
texld r0, t0, s1
mul_pp r1.x, r2, r1.y
mul r1.w, r1.x, c1
add r2, r0, c4.x
mad r0.x, r3, c0.z, c0.w
mul r2, r2, c2.x
rcp r0.x, r0.x
add r2, r2, c4.y
mov r1.xyz, c1
mul r1, r1, r2
add r0.x, r0, -t2.z
mov r2.xyz, r1
mul_sat r1.x, r0, c3
mul_sat r0.x, t2.z, c4.z
mul r1.x, r1.w, r1
mul r2.w, r1.x, r0.x
mov_pp oC0, r2
"
}
}
 }
}
Fallback "Lightbeam/Lightbeam Detail"
}