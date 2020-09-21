Shader "JAW/Emissive2" {
Properties {
 _Diffuse ("_Diffuse", 2D) = "black" {}
 _Normal ("_Normal", 2D) = "black" {}
 _Specular ("_Specular", 2D) = "black" {}
 _Glossiness ("_Glossiness", Range(0.1,1)) = 0.737
 _Emissive_Colour ("_Emissive_Colour", Color) = (0.11194,0.11194,0.11194,1)
 _Emissive_Intensity ("_Emissive_Intensity", Range(0,5)) = 1.12
 _Specular_Intensity ("_Specular_Intensity", Range(0,2)) = 0
 _Emissive ("Emissive", 2D) = "black" {}
}
SubShader { 
 Tags { "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
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
Vector 23 [_Diffuse_ST]
Vector 24 [_Normal_ST]
Vector 25 [_Emissive_ST]
Vector 26 [_Specular_ST]
"!!ARBvp1.0
# 46 ALU
PARAM c[27] = { { 1 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[21];
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[22].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[14];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 46 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [unity_Scale]
Vector 22 [_Diffuse_ST]
Vector 23 [_Normal_ST]
Vector 24 [_Emissive_ST]
Vector 25 [_Specular_ST]
"vs_2_0
; 49 ALU
def c26, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c26.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r1.xyz, r0.w, c20
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r0.w, c26.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c21.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c13, r0
dp4 r4.x, c13, r1
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT0.zw, v3.xyxy, c23.xyxy, c23
mad oT0.xy, v3, c22, c22.zwzw
mad oT1.zw, v3.xyxy, c25.xyxy, c25
mad oT1.xy, v3, c24, c24.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 14 [unity_LightmapST]
Vector 15 [_Diffuse_ST]
Vector 16 [_Normal_ST]
Vector 17 [_Emissive_ST]
Vector 18 [_Specular_ST]
"!!ARBvp1.0
# 9 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_Diffuse_ST]
Vector 14 [_Normal_ST]
Vector 15 [_Emissive_ST]
Vector 16 [_Specular_ST]
"vs_2_0
; 9 ALU
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT1.zw, v3.xyxy, c16.xyxy, c16
mad oT1.xy, v3, c15, c15.zwzw
mad oT2.xy, v4, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_Diffuse_ST]
Vector 25 [_Normal_ST]
Vector 26 [_Emissive_ST]
Vector 27 [_Specular_ST]
"!!ARBvp1.0
# 51 ALU
PARAM c[28] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[27].xyxy, c[27];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 51 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_Diffuse_ST]
Vector 25 [_Normal_ST]
Vector 26 [_Emissive_ST]
Vector 27 [_Specular_ST]
"vs_2_0
; 54 ALU
def c28, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c28.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c21
dp4 r0.y, r1, c20
dp4 r0.x, r1, c19
mul r1.xyz, r0.w, c22
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r0.w, c28.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c23.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c28.y
mul r1.y, r1, c13.x
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT5.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mad oT0.zw, v3.xyxy, c25.xyxy, c25
mad oT0.xy, v3, c24, c24.zwzw
mad oT1.zw, v3.xyxy, c27.xyxy, c27
mad oT1.xy, v3, c26, c26.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Normal_ST]
Vector 18 [_Emissive_ST]
Vector 19 [_Specular_ST]
"!!ARBvp1.0
# 14 ALU
PARAM c[20] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_LightmapST]
Vector 15 [_Diffuse_ST]
Vector 16 [_Normal_ST]
Vector 17 [_Emissive_ST]
Vector 18 [_Specular_ST]
"vs_2_0
; 14 ALU
def c19, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.x
mul r1.y, r1, c12.x
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.zw, v3.xyxy, c18.xyxy, c18
mad oT1.xy, v3, c17, c17.zwzw
mad oT2.xy, v4, c14, c14.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
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
Vector 31 [_Diffuse_ST]
Vector 32 [_Normal_ST]
Vector 33 [_Emissive_ST]
Vector 34 [_Specular_ST]
"!!ARBvp1.0
# 77 ALU
PARAM c[35] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..34] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[29];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[30].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[14];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[4].y, R0, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[34].xyxy, c[34];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[33], c[33].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 77 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [unity_Scale]
Vector 30 [_Diffuse_ST]
Vector 31 [_Normal_ST]
Vector 32 [_Emissive_ST]
Vector 33 [_Specular_ST]
"vs_2_0
; 80 ALU
def c34, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r1.w, c34.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c29.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c13, r1
dp4 r4.x, c13, r0
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT0.zw, v3.xyxy, c31.xyxy, c31
mad oT0.xy, v3, c30, c30.zwzw
mad oT1.zw, v3.xyxy, c33.xyxy, c33
mad oT1.xy, v3, c32, c32.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
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
Vector 32 [_Diffuse_ST]
Vector 33 [_Normal_ST]
Vector 34 [_Emissive_ST]
Vector 35 [_Specular_ST]
"!!ARBvp1.0
# 82 ALU
PARAM c[36] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..35] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[31].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[4].y, R0, R2;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[35].xyxy, c[35];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 82 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
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
Vector 32 [_Diffuse_ST]
Vector 33 [_Normal_ST]
Vector 34 [_Emissive_ST]
Vector 35 [_Specular_ST]
"vs_2_0
; 85 ALU
def c36, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c36.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c36.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c36.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r1.w, c36.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c31.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c8
dp4 r4.x, c15, r0
mov r1, c9
dp4 r4.y, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c36.z
mul r1.y, r1, c13.x
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT5.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mad oT0.zw, v3.xyxy, c33.xyxy, c33
mad oT0.xy, v3, c32, c32.zwzw
mad oT1.zw, v3.xyxy, c35.xyxy, c35
mad oT1.xy, v3, c34, c34.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Vector 2 [_Emissive_Colour]
Float 3 [_Emissive_Intensity]
Float 4 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
"!!ARBfp1.0
# 41 ALU, 4 TEX
PARAM c[7] = { program.local[0..4],
		{ 2, 1, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R1.xy, R1.wyzw, c[5].x, -c[5].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.w, R1.z, R1;
ADD R0.w, -R0, c[5].y;
DP3 R1.z, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
RSQ R1.z, R1.z;
MOV R4.xyz, fragment.texcoord[2];
MAD R4.xyz, R1.z, fragment.texcoord[4], R4;
RCP R1.z, R0.w;
DP3 R1.w, R4, R4;
DP3 R0.w, R1, R1;
RSQ R1.w, R1.w;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
MUL R4.xyz, R1.w, R4;
DP3 R1.w, R1, R4;
DP3 R1.y, R1, fragment.texcoord[2];
MOV R0.w, c[5];
MUL R2.w, R0, c[1].x;
MAX R0.w, R1, c[5].z;
MOV R4.xyz, c[6];
DP3 R1.x, R4, c[0];
POW R0.w, R0.w, R2.w;
MUL R1.w, R0, R1.x;
MAX R1.y, R1, c[5].z;
MUL R1.xyz, R1.y, c[0];
MUL R1, R1, c[5].x;
MUL R2.xyz, R2, c[4].x;
MUL R2.xyz, R1.w, R2;
MUL R2.xyz, R1, R2;
MAD R1.xyz, R0, R1, R2;
MUL R3.xyz, R3, c[2];
MUL R2.xyz, R3, c[3].x;
MAD R0.xyz, R0, fragment.texcoord[3], R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[5].y;
END
# 41 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Vector 2 [_Emissive_Colour]
Float 3 [_Emissive_Intensity]
Float 4 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
"ps_2_0
; 50 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r4, t0, s0
texld r2, t1, s2
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
texld r3, r1, s3
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r6.xy, r0, c5.x, c5.y
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r6.z, r0.x
dp3_pp r0.x, t4, t4
mov_pp r1.xyz, t2
rsq_pp r0.x, r0.x
mad_pp r5.xyz, r0.x, t4, r1
dp3_pp r1.x, r6, r6
dp3_pp r0.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r6.xyz, r1.x, r6
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r1.x, r6, r1
mov_pp r0.x, c1
mul_pp r0.x, c6, r0
max_pp r1.x, r1, c5.w
pow r5.w, r1.x, r0.x
mov r0.x, r5.w
mov_pp r5.xyz, c0
mov r1.y, c6.z
mov r1.z, c6.w
mov r1.x, c6.y
dp3_pp r1.x, r1, r5
mul r0.w, r0.x, r1.x
dp3_pp r5.x, r6, t2
max_pp r0.x, r5, c5.w
mul_pp r0.xyz, r0.x, c0
mul_pp r0, r0, c5.x
mul r1.xyz, r3, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r4, r0, r1
mul r1.xyz, r2, c2
mad_pp r0.xyz, r4, t3, r0
mul r1.xyz, r1, c3.x
mov_pp r0.w, c5.z
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
# 9 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[2], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[0];
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R2, c[1].x;
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[2].y, R2;
MOV result.color.w, c[2].x;
END
# 9 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
; 7 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c2, 8.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
texld r2, t0, s0
texld r1, t1, s2
texld r0, t2, s3
mul_pp r0.xyz, r0.w, r0
mul r1.xyz, r1, c0
mul_pp r0.xyz, r0, r2
mul r1.xyz, r1, c1.x
mov_pp r0.w, c2.y
mad_pp r0.xyz, r0, c2.x, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Vector 2 [_Emissive_Colour]
Float 3 [_Emissive_Intensity]
Float 4 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_ShadowMapTexture] 2D 4
"!!ARBfp1.0
# 43 ALU, 5 TEX
PARAM c[7] = { program.local[0..4],
		{ 2, 1, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TXP R4.x, fragment.texcoord[5], texture[4], 2D;
MAD R4.yz, R1.xwyw, c[5].x, -c[5].y;
MUL R1.xy, R4.yzzw, R4.yzzw;
ADD_SAT R0.w, R1.x, R1.y;
ADD R0.w, -R0, c[5].y;
RSQ R0.w, R0.w;
RCP R4.w, R0.w;
DP3 R0.w, R4.yzww, R4.yzww;
RSQ R0.w, R0.w;
MUL R4.yzw, R0.w, R4;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.w, R1.w;
MOV R1.xyz, fragment.texcoord[2];
MAD R1.xyz, R1.w, fragment.texcoord[4], R1;
DP3 R1.w, R1, R1;
RSQ R1.w, R1.w;
MUL R1.xyz, R1.w, R1;
DP3 R1.w, R4.yzww, fragment.texcoord[2];
DP3 R1.x, R4.yzww, R1;
MOV R0.w, c[5];
MUL R1.y, R0.w, c[1].x;
MAX R0.w, R1.x, c[5].z;
POW R0.w, R0.w, R1.y;
MOV R1.xyz, c[6];
MAX R2.w, R1, c[5].z;
DP3 R1.w, R1, c[0];
MUL R1.w, R0, R1;
MUL R1.xyz, R2.w, c[0];
MUL R1, R4.x, R1;
MUL R4.xyz, R0, c[4].x;
MUL R0, R1, c[5].x;
MUL R1.xyz, R0.w, R4;
MUL R1.xyz, R0, R1;
MAD R0.xyz, R3, R0, R1;
MUL R2.xyz, R2, c[2];
MUL R1.xyz, R2, c[3].x;
MAD R0.xyz, R3, fragment.texcoord[3], R0;
ADD result.color.xyz, R0, R1;
MOV result.color.w, c[5].y;
END
# 43 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Vector 2 [_Emissive_Colour]
Float 3 [_Emissive_Intensity]
Float 4 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_ShadowMapTexture] 2D 4
"ps_2_0
; 51 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5
texld r4, t0, s0
texld r2, t1, s2
texldp r7, t5, s4
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
texld r3, r1, s3
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r6.xy, r0, c5.x, c5.y
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r6.z, r0.x
dp3_pp r0.x, t4, t4
mov_pp r1.xyz, t2
rsq_pp r0.x, r0.x
mad_pp r5.xyz, r0.x, t4, r1
dp3_pp r1.x, r6, r6
dp3_pp r0.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r6.xyz, r1.x, r6
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r1.x, r6, r1
mov_pp r0.x, c1
mul_pp r0.x, c6, r0
max_pp r1.x, r1, c5.w
pow r5.w, r1.x, r0.x
dp3_pp r1.x, r6, t2
mov r0.x, r5.w
max_pp r1.x, r1, c5.w
mov_pp r6.xyz, c0
mov r5.x, c6.y
mov r5.y, c6.z
mov r5.z, c6.w
dp3_pp r5.x, r5, r6
mul r0.w, r0.x, r5.x
mul_pp r0.xyz, r1.x, c0
mul_pp r0, r7.x, r0
mul_pp r0, r0, c5.x
mul r1.xyz, r3, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r4, r0, r1
mul r1.xyz, r2, c2
mad_pp r0.xyz, r4, t3, r0
mul r1.xyz, r1, c3.x
mov_pp r0.w, c5.z
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"!!ARBfp1.0
# 15 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[2], texture[4], 2D;
TXP R3.x, fragment.texcoord[3], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R3.yzw, R0.xxyz, R3.x;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1, c[0];
MUL R0.xyz, R0, c[2].y;
MUL R3.yzw, R3, c[2].z;
MIN R3.yzw, R0.xxyz, R3;
MUL R0.xyz, R0, R3.x;
MUL R1.xyz, R1, c[1].x;
MAX R0.xyz, R3.yzww, R0;
MAD result.color.xyz, R2, R0, R1;
MOV result.color.w, c[2].x;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"ps_2_0
; 12 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c2, 8.00000000, 2.00000000, 1.00000000, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3
texld r2, t0, s0
texld r1, t1, s2
texldp r4, t3, s3
texld r0, t2, s4
mul r1.xyz, r1, c0
mul_pp r3.xyz, r0, r4.x
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2.x
mul_pp r3.xyz, r3, c2.y
min_pp r3.xyz, r0, r3
mul_pp r0.xyz, r0, r4.x
max_pp r0.xyz, r3, r0
mul r1.xyz, r1, c1.x
mov_pp r0.w, c2.z
mad_pp r0.xyz, r2, r0, r1
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 38 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 oT2.y, r0, r2
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT3.y, r2, r3
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
Vector 12 [_Diffuse_ST]
Vector 13 [_Normal_ST]
Vector 14 [_Specular_ST]
"!!ARBvp1.0
# 27 ALU
PARAM c[15] = { { 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[11].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[10];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_Diffuse_ST]
Vector 12 [_Normal_ST]
Vector 13 [_Specular_ST]
"vs_2_0
; 30 ALU
def c14, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c14.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c9, r0
dp4 r4.x, c9, r1
dp3 oT2.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT0.zw, v3.xyxy, c12.xyxy, c12
mad oT0.xy, v3, c11, c11.zwzw
mad oT1.xy, v3, c13, c13.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 36 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 39 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 oT2.y, r0, r2
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT3.y, r2, r3
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.w, r0, c15
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 38 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 oT2.y, r0, r2
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT3.y, r2, r3
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 33 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 33 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 36 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"!!ARBfp1.0
# 41 ALU, 4 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R2.xy, R2.wyzw, c[3].y, -c[3].z;
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R3.x, R1.w;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.w, R2.z, R2;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
ADD R1.w, -R1, c[3].z;
DP3 R2.z, fragment.texcoord[3], fragment.texcoord[3];
MUL R3.xyz, R3.x, fragment.texcoord[2];
RSQ R2.z, R2.z;
MAD R4.xyz, R2.z, fragment.texcoord[3], R3;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R2.w, R4, R4;
DP3 R1.w, R2, R2;
RSQ R2.w, R2.w;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
MOV R1.w, c[3];
MUL R4.xyz, R2.w, R4;
DP3 R2.w, R2, R4;
MUL R3.w, R1, c[1].x;
MAX R1.w, R2, c[3].x;
DP3 R2.w, R2, R3;
MOV R2.xyz, c[4];
MAX R3.x, R2.w, c[3];
DP3 R2.w, R2, c[0];
POW R1.w, R1.w, R3.w;
MUL R2.xyz, R3.x, c[0];
MUL R2.w, R1, R2;
MUL R1.xyz, R1, c[2].x;
MOV result.color.w, c[3].x;
TEX R0.w, R0.w, texture[3], 2D;
MUL R2, R0.w, R2;
MUL R2, R2, c[3].y;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R2, R1;
END
# 41 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_2_0
; 48 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c4, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r3, t0, s0
texld r2, t1, s2
dp3 r1.x, t4, t4
mov r1.xy, r1.x
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
texld r7, r1, s3
mov r0.x, r0.w
mad_pp r6.xy, r0, c3.x, c3.y
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.z
rsq_pp r1.x, r0.x
rcp_pp r6.z, r1.x
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
mul_pp r4.xyz, r1.x, t2
dp3_pp r1.x, r6, r6
rsq_pp r1.x, r1.x
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mad_pp r5.xyz, r0.x, t3, r4
dp3_pp r0.x, r5, r5
mul_pp r6.xyz, r1.x, r6
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r1.x, r6, r1
mov_pp r0.x, c1
mul_pp r0.x, c4, r0
max_pp r1.x, r1, c3.w
pow r5.w, r1.x, r0.x
dp3_pp r1.x, r6, r4
mov r0.x, r5.w
max_pp r1.x, r1, c3.w
mov_pp r5.xyz, c0
mov r4.x, c4.y
mov r4.y, c4.z
mov r4.z, c4.w
dp3_pp r4.x, r4, r5
mul r0.w, r0.x, r4.x
mul_pp r0.xyz, r1.x, c0
mul_pp r0, r7.x, r0
mul_pp r0, r0, c3.x
mul r1.xyz, r2, c2.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mov_pp r0.w, c3
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
"!!ARBfp1.0
# 36 ALU, 3 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R2.xy, R2.wyzw, c[3].y, -c[3].z;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R0.w, R2.z, R2;
ADD R0.w, -R0, c[3].z;
RSQ R0.w, R0.w;
RCP R2.z, R0.w;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R2;
MOV R0.w, c[3];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R2.w, R0, c[1].x;
RSQ R1.w, R1.w;
MOV R3.xyz, fragment.texcoord[2];
MAD R3.xyz, R1.w, fragment.texcoord[3], R3;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
DP3 R1.w, R2, R3;
DP3 R2.x, R2, fragment.texcoord[2];
MAX R0.w, R1, c[3].x;
MOV R3.xyz, c[4];
MAX R2.x, R2, c[3];
POW R0.w, R0.w, R2.w;
DP3 R1.w, R3, c[0];
MUL R2.w, R0, R1;
MUL R2.xyz, R2.x, c[0];
MUL R2, R2, c[3].y;
MUL R1.xyz, R1, c[2].x;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[3].x;
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
"ps_2_0
; 43 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c4, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
texld r2, t1, s2
mov_pp r1.xyz, t2
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r5.xy, r0, c3.x, c3.y
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.z
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mad_pp r4.xyz, r0.x, t3, r1
dp3_pp r1.x, r5, r5
dp3_pp r0.x, r4, r4
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, r5
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r4
dp3_pp r1.x, r5, r1
mov_pp r0.x, c1
mul_pp r0.x, c4, r0
max_pp r1.x, r1, c3.w
pow r4.w, r1.x, r0.x
mov r0.x, r4.w
mov_pp r4.xyz, c0
mov r1.y, c4.z
mov r1.z, c4.w
mov r1.x, c4.y
dp3_pp r1.x, r1, r4
mul r0.w, r0.x, r1.x
dp3_pp r4.x, r5, t2
max_pp r0.x, r4, c3.w
mul_pp r0.xyz, r0.x, c0
mul_pp r0, r0, c3.x
mul r1.xyz, r2, c2.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mov_pp r0.w, c3
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"!!ARBfp1.0
# 46 ALU, 5 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 0.5, 2, 1 },
		{ 128, 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
RCP R0.x, fragment.texcoord[4].w;
MAD R2.xy, fragment.texcoord[4], R0.x, c[3].y;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R1.xyz, R1, c[2].x;
MOV result.color.w, c[3].x;
TEX R0.w, R2, texture[3], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, R1.w, texture[4], 2D;
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.z, R2.x;
MAD R3.xy, R2.wyzw, c[3].z, -c[3].w;
MUL R2.xy, R3, R3;
ADD_SAT R2.x, R2, R2.y;
ADD R2.w, -R2.x, c[3];
DP3 R2.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.w, R2.w;
RCP R3.z, R2.w;
MUL R4.xyz, R2.z, fragment.texcoord[2];
RSQ R2.x, R2.y;
MAD R2.xyz, R2.x, fragment.texcoord[3], R4;
DP3 R3.w, R2, R2;
RSQ R3.w, R3.w;
DP3 R2.w, R3, R3;
MUL R5.xyz, R3.w, R2;
RSQ R3.w, R2.w;
MOV R2, c[4];
MUL R3.xyz, R3.w, R3;
DP3 R3.w, R3, R5;
MUL R4.w, R2.x, c[1].x;
MAX R2.x, R3.w, c[3];
DP3 R2.y, R2.yzww, c[0];
POW R2.x, R2.x, R4.w;
DP3 R3.x, R3, R4;
MAX R2.z, R3.x, c[3].x;
MUL R2.w, R2.x, R2.y;
SLT R3.x, c[3], fragment.texcoord[4].z;
MUL R0.w, R3.x, R0;
MUL R2.xyz, R2.z, c[0];
MUL R0.w, R0, R1;
MUL R2, R0.w, R2;
MUL R2, R2, c[3].z;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R2, R1;
END
# 46 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"ps_2_0
; 51 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 0.00000000, 1.00000000, 0.50000000, 128.00000000
def c4, 2.00000000, -1.00000000, 0, 0
def c5, 0.21997070, 0.70703125, 0.07098389, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r3, t0, s0
texld r2, t1, s2
dp3 r0.x, t4, t4
mov r4.xy, r0.x
rcp r0.x, t4.w
mad r0.xy, t4, r0.x, c3.z
mov r1.y, t0.w
mov r1.x, t0.z
texld r1, r1, s1
texld r7, r4, s4
texld r0, r0, s3
mov r0.y, r1
mov r0.x, r1.w
mad_pp r6.xy, r0, c4.x, c4.y
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.y
rsq_pp r1.x, r0.x
rcp_pp r6.z, r1.x
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
mul_pp r4.xyz, r1.x, t2
dp3_pp r1.x, r6, r6
rsq_pp r1.x, r1.x
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mad_pp r5.xyz, r0.x, t3, r4
mul_pp r6.xyz, r1.x, r6
dp3_pp r0.x, r5, r5
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r1.x, r6, r1
mov_pp r0.x, c1
dp3_pp r4.x, r6, r4
mul_pp r0.x, c3.w, r0
max_pp r1.x, r1, c3
pow r5.x, r1.x, r0.x
mov_pp r1.xyz, c0
mov r0.x, r5.x
dp3_pp r1.x, c5, r1
mul r1.w, r0.x, r1.x
max_pp r4.x, r4, c3
cmp r0.x, -t4.z, c3, c3.y
mul_pp r0.x, r0, r0.w
mul_pp r1.xyz, r4.x, c0
mul_pp r0.x, r0, r7
mul_pp r0, r0.x, r1
mul_pp r0, r0, c4.x
mul r1.xyz, r2, c2.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"!!ARBfp1.0
# 43 ALU, 5 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[4], texture[4], CUBE;
MAD R2.xy, R2.wyzw, c[3].y, -c[3].z;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.z, R2, R2.w;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R3.x, R3.x;
ADD R2.z, -R2, c[3];
DP3 R2.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.z, R2.z;
MUL R3.xyz, R3.x, fragment.texcoord[2];
RSQ R2.w, R2.w;
MAD R4.xyz, R2.w, fragment.texcoord[3], R3;
RCP R2.z, R2.z;
DP3 R3.w, R4, R4;
DP3 R2.w, R2, R2;
RSQ R3.w, R3.w;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
MUL R4.xyz, R3.w, R4;
DP3 R3.w, R2, R4;
DP3 R2.y, R2, R3;
MOV R2.w, c[3];
MUL R4.x, R2.w, c[1];
MAX R2.w, R3, c[3].x;
POW R2.w, R2.w, R4.x;
MOV R4.xyz, c[4];
DP3 R2.x, R4, c[0];
MUL R2.w, R2, R2.x;
MAX R2.y, R2, c[3].x;
MUL R2.xyz, R2.y, c[0];
MUL R1.xyz, R1, c[2].x;
MOV result.color.w, c[3].x;
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.w, R0, R1;
MUL R2, R0.w, R2;
MUL R2, R2, c[3].y;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R2, R1;
END
# 43 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"ps_2_0
; 50 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c3, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c4, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r3, t0, s0
texld r2, t1, s2
dp3 r1.x, t4, t4
mov r1.xy, r1.x
mov r0.y, t0.w
mov r0.x, t0.z
texld r7, r1, s3
texld r1, r0, s1
texld r0, t4, s4
mov r0.y, r1
mov r0.x, r1.w
mad_pp r6.xy, r0, c3.x, c3.y
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.z
rsq_pp r1.x, r0.x
rcp_pp r6.z, r1.x
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
mul_pp r4.xyz, r1.x, t2
dp3_pp r1.x, r6, r6
rsq_pp r1.x, r1.x
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mad_pp r5.xyz, r0.x, t3, r4
dp3_pp r0.x, r5, r5
mul_pp r6.xyz, r1.x, r6
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r1.x, r6, r1
mov_pp r0.x, c1
mul_pp r0.x, c4, r0
max_pp r1.x, r1, c3.w
pow r5.w, r1.x, r0.x
dp3_pp r1.x, r6, r4
mov r0.x, r5.w
max_pp r1.x, r1, c3.w
mul_pp r1.xyz, r1.x, c0
mov_pp r5.xyz, c0
mov r4.x, c4.y
mov r4.y, c4.z
mov r4.z, c4.w
dp3_pp r4.x, r4, r5
mul r1.w, r0.x, r4.x
mul r0.x, r7, r0.w
mul_pp r0, r0.x, r1
mul_pp r0, r0, c3.x
mul r1.xyz, r2, c2.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mov_pp r0.w, c3
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"!!ARBfp1.0
# 38 ALU, 4 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0.w, fragment.texcoord[4], texture[3], 2D;
MAD R2.xy, R2.wyzw, c[3].y, -c[3].z;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.w, R2.z, R2;
ADD R1.w, -R1, c[3].z;
DP3 R2.z, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
RSQ R2.z, R2.z;
MOV R3.xyz, fragment.texcoord[2];
MAD R3.xyz, R2.z, fragment.texcoord[3], R3;
RCP R2.z, R1.w;
DP3 R2.w, R3, R3;
DP3 R1.w, R2, R2;
RSQ R2.w, R2.w;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
MUL R3.xyz, R2.w, R3;
DP3 R2.w, R2, R3;
MOV R1.w, c[3];
MUL R3.x, R1.w, c[1];
MAX R1.w, R2, c[3].x;
DP3 R2.w, R2, fragment.texcoord[2];
POW R1.w, R1.w, R3.x;
MOV R2.xyz, c[4];
MAX R3.x, R2.w, c[3];
DP3 R2.w, R2, c[0];
MUL R2.xyz, R3.x, c[0];
MUL R2.w, R1, R2;
MUL R2, R0.w, R2;
MUL R2, R2, c[3].y;
MUL R1.xyz, R1, c[2].x;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[3].x;
END
# 38 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Glossiness]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 1 [_Normal] 2D 1
SetTexture 2 [_Specular] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_2_0
; 46 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c4, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xy
texld r3, t0, s0
texld r2, t1, s2
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
texld r1, r1, s1
texld r0, t4, s3
mov r0.y, r1
mov r0.x, r1.w
mad_pp r5.xy, r0, c3.x, c3.y
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.z
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r0.x, t3, t3
mov_pp r1.xyz, t2
rsq_pp r0.x, r0.x
mad_pp r4.xyz, r0.x, t3, r1
dp3_pp r1.x, r5, r5
dp3_pp r0.x, r4, r4
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, r5
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r4
dp3_pp r1.x, r5, r1
mov_pp r0.x, c1
mul_pp r0.x, c4, r0
max_pp r1.x, r1, c3.w
pow r4.w, r1.x, r0.x
mov r0.x, r4.w
dp3_pp r1.x, r5, t2
max_pp r1.x, r1, c3.w
mul_pp r1.xyz, r1.x, c0
mov_pp r5.xyz, c0
mov r4.x, c4.y
mov r4.y, c4.z
mov r4.z, c4.w
dp3_pp r4.x, r4, r5
mul r1.w, r0.x, r4.x
mul_pp r0, r0.w, r1
mul_pp r0, r0, c3.x
mul r1.xyz, r2, c2.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mov_pp r0.w, c3
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_Normal_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_Normal_ST]
"vs_2_0
; 22 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul oT1.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul oT2.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c8.w
mad oT0.xy, v3, c9, c9.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Glossiness]
SetTexture 0 [_Normal] 2D 0
"!!ARBfp1.0
# 15 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[1].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
DP3 R0.z, fragment.texcoord[3], R1;
DP3 R0.x, R1, fragment.texcoord[1];
DP3 R0.y, R1, fragment.texcoord[2];
MAD result.color.xyz, R0, c[1].z, c[1].z;
MOV result.color.w, c[0].x;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Glossiness]
SetTexture 0 [_Normal] 2D 0
"ps_2_0
; 16 ALU, 1 TEX
dcl_2d s0
def c1, 2.00000000, -1.00000000, 1.00000000, 0.50000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
mov r0.x, r0.w
mad_pp r1.xy, r0, c1.x, c1.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c1.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3 r0.z, t3, r1
dp3 r0.x, r1, t1
dp3 r0.y, r1, t2
mad_pp r0.xyz, r0, c1.w, c1.w
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Emissive_ST]
Vector 20 [_Specular_ST]
"!!ARBvp1.0
# 30 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[3].xyz, R3, R2;
ADD result.texcoord[2].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 30 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Emissive_ST]
Vector 20 [_Specular_ST]
"vs_2_0
; 30 ALU
def c21, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c21.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c21.x
mul r0.y, r0, c8.x
add oT3.xyz, r3, r2
mad oT2.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT2.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.xy, v2, c20, c20.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Emissive_ST]
Vector 18 [_Specular_ST]
"!!ARBvp1.0
# 22 ALU
PARAM c[19] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 22 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Emissive_ST]
Vector 18 [_Specular_ST]
"vs_2_0
; 22 ALU
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c19.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c19, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT2.zw, r0
mul oT4.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT1.xy, v1, c18, c18.zwzw
mad oT3.xy, v2, c15, c15.zwzw
mul oT4.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Emissive_ST]
Vector 20 [_Specular_ST]
"!!ARBvp1.0
# 30 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[3].xyz, R3, R2;
ADD result.texcoord[2].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 30 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Emissive_ST]
Vector 20 [_Specular_ST]
"vs_2_0
; 30 ALU
def c21, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c21.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c21.x
mul r0.y, r0, c8.x
add oT3.xyz, r3, r2
mad oT2.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT2.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.xy, v2, c20, c20.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Emissive_ST]
Vector 18 [_Specular_ST]
"!!ARBvp1.0
# 22 ALU
PARAM c[19] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 22 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Emissive_ST]
Vector 18 [_Specular_ST]
"vs_2_0
; 22 ALU
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c19.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c19, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT2.zw, r0
mul oT4.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT1.xy, v1, c18, c18.zwzw
mad oT3.xy, v2, c15, c15.zwzw
mul oT4.w, -r0.x, r0.y
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
"!!ARBfp1.0
# 17 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R0, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R3.xyz, R3, c[0];
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[3];
MUL R2.xyz, R2, c[2].x;
LG2 R0.w, R0.w;
MUL R2.xyz, -R0.w, R2;
MUL R2.xyz, R0, R2;
MUL R3.xyz, R3, c[1].x;
MAD R0.xyz, R1, R0, R2;
ADD result.color.xyz, R0, R3;
MOV result.color.w, c[3].x;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
"ps_2_0
; 16 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 1.00000000, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xyz
texld r3, t0, s0
texld r1, t1, s3
mov r0.y, t0.w
mov r0.x, t0.z
mul r1.xyz, r1, c2.x
texld r2, r0, s2
texldp r0, t2, s4
log_pp r4.x, r0.w
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, t3
mul_pp r1.xyz, -r4.x, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mul r2.xyz, r2, c0
mul r1.xyz, r2, c1.x
mov_pp r0.w, c3.x
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
SetTexture 6 [unity_LightmapInd] 2D 6
"!!ARBfp1.0
# 28 ALU, 6 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TXP R0, fragment.texcoord[2], texture[4], 2D;
TEX R1, fragment.texcoord[3], texture[6], 2D;
TEX R2, fragment.texcoord[3], texture[5], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R5.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[4].y;
DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[4].y, -R1;
MAD_SAT R1.w, R1, c[3].z, c[3];
MAD R1.xyz, R1.w, R2, R1;
MUL R2.xyz, R5, c[0];
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R1;
MUL R1.xyz, R4, c[2].x;
LG2 R0.w, R0.w;
MUL R1.xyz, -R0.w, R1;
MUL R1.xyz, R0, R1;
MUL R2.xyz, R2, c[1].x;
MAD R0.xyz, R3, R0, R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[4].x;
END
# 28 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
SetTexture 6 [unity_LightmapInd] 2D 6
"ps_2_0
; 25 ALU, 6 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c4, 8.00000000, 1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xy
dcl t4
texld r4, t0, s0
texld r2, t1, s3
texldp r1, t2, s4
texld r5, t3, s6
mul_pp r5.xyz, r5.w, r5
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r5.xyz, r5, c4.x
mul r2.xyz, r2, c2.x
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
texld r3, r0, s2
texld r0, t3, s5
mul_pp r6.xyz, r0.w, r0
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r6.xyz, r6, c4.x, -r5
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r0.xyz, r0.x, r6, r5
add_pp r1.xyz, -r1, r0
log_pp r0.x, r1.w
mul_pp r0.xyz, -r0.x, r2
mul_pp r0.xyz, r1, r0
mad_pp r0.xyz, r4, r1, r0
mul r2.xyz, r3, c0
mul r1.xyz, r2, c1.x
mov_pp r0.w, c4.y
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
"!!ARBfp1.0
# 13 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R0, fragment.texcoord[2], texture[4], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[3], 2D;
TEX R3.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[2].x;
MUL R3.xyz, R3, c[0];
ADD R0.xyz, R0, fragment.texcoord[3];
MUL R2.xyz, R0.w, R2;
MUL R2.xyz, R0, R2;
MUL R3.xyz, R3, c[1].x;
MAD R0.xyz, R1, R0, R2;
ADD result.color.xyz, R0, R3;
MOV result.color.w, c[3].x;
END
# 13 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
"ps_2_0
; 12 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 1.00000000, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xyz
texld r3, t0, s0
texld r1, t1, s3
mov r0.y, t0.w
mov r0.x, t0.z
mul r1.xyz, r1, c2.x
texld r2, r0, s2
texldp r0, t2, s4
mul_pp r1.xyz, r0.w, r1
add_pp r0.xyz, r0, t3
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r3, r0, r1
mul r2.xyz, r2, c0
mul r1.xyz, r2, c1.x
mov_pp r0.w, c3.x
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
SetTexture 6 [unity_LightmapInd] 2D 6
"!!ARBfp1.0
# 24 ALU, 6 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1, fragment.texcoord[3], texture[6], 2D;
TEX R2, fragment.texcoord[3], texture[5], 2D;
TXP R0, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R5.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[4].y;
DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[4].y, -R1;
MAD_SAT R1.w, R1, c[3].z, c[3];
MAD R1.xyz, R1.w, R2, R1;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R4, c[2].x;
MUL R1.xyz, R0.w, R2;
MUL R2.xyz, R5, c[0];
MUL R1.xyz, R0, R1;
MUL R2.xyz, R2, c[1].x;
MAD R0.xyz, R3, R0, R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[4].x;
END
# 24 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Emissive_Colour]
Float 1 [_Emissive_Intensity]
Float 2 [_Specular_Intensity]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D 0
SetTexture 2 [_Emissive] 2D 2
SetTexture 3 [_Specular] 2D 3
SetTexture 4 [_LightBuffer] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
SetTexture 6 [unity_LightmapInd] 2D 6
"ps_2_0
; 21 ALU, 6 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c4, 8.00000000, 1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xy
dcl t4
texld r5, t0, s0
texldp r1, t2, s4
texld r2, t1, s3
texld r3, t3, s6
mul_pp r3.xyz, r3.w, r3
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r3.xyz, r3, c4.x
mul r2.xyz, r2, c2.x
texld r4, r0, s2
texld r0, t3, s5
mul_pp r6.xyz, r0.w, r0
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r6.xyz, r6, c4.x, -r3
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r0.xyz, r0.x, r6, r3
add_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1.w, r2
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r5, r0, r1
mul r2.xyz, r4, c0
mul r1.xyz, r2, c1.x
mov_pp r0.w, c4.y
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Diffuse"
}