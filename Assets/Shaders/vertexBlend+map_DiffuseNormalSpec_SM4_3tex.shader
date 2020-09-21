Shader "vertexPainter/vertexBlend+map_DiffuseNormalSpec_SM4_3tex" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Float) = 1
 _Tile ("Texture Tiling Factor", Float) = 1
 _blendPower ("Blend Factor", Float) = 1
 _MainTex1 ("Base1 (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap1 ("Bumpmap (RGB)", 2D) = "bump" {}
 _MainTex2 ("Base2 (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap2 ("Bumpmap1 (RGB)", 2D) = "bump" {}
 _MainTex3 ("Base2 (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap3 ("Bumpmap1 (RGB)", 2D) = "bump" {}
 _BlendMap ("Blend Map", 2D) = "white" {}
}
SubShader { 
 LOD 500
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
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
Vector 23 [_MainTex1_ST]
Vector 24 [_MainTex2_ST]
Vector 25 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 46 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
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
ADD result.texcoord[4].xyz, R0, R1;
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
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[5].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
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
Bind "color" Color
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
Vector 22 [_MainTex1_ST]
Vector 23 [_MainTex2_ST]
Vector 24 [_MainTex3_ST]
"vs_3_0
; 49 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c25.x
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
add o5.xyz, r0, r1
mov r0.w, c25.x
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
dp3 o4.y, r4, r2
dp3 o6.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
mov o3, v4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.xy, v3, c24, c24.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex1_ST]
Vector 16 [_MainTex2_ST]
Vector 17 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 9 ALU
PARAM c[18] = { program.local[0],
		state.matrix.mvp,
		program.local[5..17] };
MOV result.texcoord[2], vertex.color;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[14], c[14].zwzw;
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
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex1_ST]
Vector 14 [_MainTex2_ST]
Vector 15 [_MainTex3_ST]
"vs_3_0
; 9 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov o3, v5
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o2.xy, v3, c15, c15.zwzw
mad o4.xy, v4, c12, c12.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex1_ST]
Vector 18 [_MainTex2_ST]
Vector 19 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 22 ALU
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[4].y, R0, R1;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, R0, vertex.attrib[14];
MOV result.texcoord[2], vertex.color;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 22 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex1_ST]
Vector 16 [_MainTex2_ST]
Vector 17 [_MainTex3_ST]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c18, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c18.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o5.y, r0, r1
dp3 o5.z, v2, r0
dp3 o5.x, r0, v1
mov o3, v5
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o2.xy, v3, c17, c17.zwzw
mad o4.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
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
Vector 24 [_MainTex1_ST]
Vector 25 [_MainTex2_ST]
Vector 26 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 51 ALU
PARAM c[27] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..26] };
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
ADD result.texcoord[4].xyz, R0, R1;
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
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[5].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 51 instructions, 4 R-regs
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
Vector 24 [_MainTex1_ST]
Vector 25 [_MainTex2_ST]
Vector 26 [_MainTex3_ST]
"vs_3_0
; 54 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c27.x
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
add o5.xyz, r0, r1
mov r0.w, c27.x
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
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c13.x
dp3 o4.y, r4, r2
dp3 o6.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3, v4
mov o7.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
mad o2.xy, v3, c26, c26.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex1_ST]
Vector 17 [_MainTex2_ST]
Vector 18 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[19] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex1_ST]
Vector 16 [_MainTex2_ST]
Vector 17 [_MainTex3_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c18, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad o5.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o3, v5
mov o5.zw, r0
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o2.xy, v3, c17, c17.zwzw
mad o4.xy, v4, c14, c14.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex1_ST]
Vector 19 [_MainTex2_ST]
Vector 20 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 27 ALU
PARAM c[21] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[4].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, R2, vertex.attrib[14];
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 27 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex1_ST]
Vector 18 [_MainTex2_ST]
Vector 19 [_MainTex3_ST]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c20, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c20.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o5.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.y
mul r1.y, r1, c13.x
dp3 o5.z, v2, r2
dp3 o5.x, r2, v1
mad o6.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3, v5
mov o6.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o2.xy, v3, c19, c19.zwzw
mad o4.xy, v4, c16, c16.zwzw
"
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
Vector 31 [_MainTex1_ST]
Vector 32 [_MainTex2_ST]
Vector 33 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 77 ALU
PARAM c[34] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..33] };
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
ADD result.texcoord[4].xyz, R0, R1;
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
DP3 result.texcoord[3].y, R3, R0;
DP3 result.texcoord[5].y, R0, R2;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
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
Bind "color" Color
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
Vector 30 [_MainTex1_ST]
Vector 31 [_MainTex2_ST]
Vector 32 [_MainTex3_ST]
"vs_3_0
; 80 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c33, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
mov r4.w, c33.x
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
add r1, r2, c33.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c33.y
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
add o5.xyz, r0, r1
mov r1.w, c33.x
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
dp3 o4.y, r4, r2
dp3 o6.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
mov o3, v4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
mad o2.xy, v3, c32, c32.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
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
Vector 32 [_MainTex1_ST]
Vector 33 [_MainTex2_ST]
Vector 34 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 82 ALU
PARAM c[35] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..34] };
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
ADD result.texcoord[4].xyz, R0, R1;
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
DP3 result.texcoord[3].y, R3, R0;
DP3 result.texcoord[5].y, R0, R2;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 82 instructions, 5 R-regs
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
Vector 32 [_MainTex1_ST]
Vector 33 [_MainTex2_ST]
Vector 34 [_MainTex3_ST]
"vs_3_0
; 85 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c35, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
mov r4.w, c35.x
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
add r1, r2, c35.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c35.y
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
add o5.xyz, r0, r1
mov r1.w, c35.x
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
mul r1.xyz, r0.xyww, c35.z
mul r1.y, r1, c13.x
dp3 o4.y, r4, r2
dp3 o6.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3, v4
mov o7.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
mad o2.xy, v3, c34, c34.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
"3.0-!!ARBfp1.0
# 74 ALU, 6 TEX
PARAM c[8] = { program.local[0..5],
		{ 1, 20, 2, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R5.xy, fragment.texcoord[1], c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R2, R3.zwzw, texture[0], 2D;
TEX R4, R5, texture[4], 2D;
TEX R0, R3, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[6];
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[4], R1.y;
ADD R0, R0, -R2;
POW_SAT R5.z, R1.x, c[6].y;
MAD R0, R5.z, R0, R2;
ADD R1, R4, -R0;
TEX R4.yw, R5, texture[5], 2D;
TEX R5.yw, R3.zwzw, texture[1], 2D;
MAD R2.xy, R5.wyzw, c[6].z, -c[6].x;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].z, -c[6].x;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R3, R3.w;
MUL R5.xy, R2, R2;
ADD_SAT R4.x, R5, R5.y;
ADD R3.z, -R4.x, c[6].x;
RSQ R3.w, R3.z;
ADD R2.z, -R2, c[6].x;
RSQ R3.z, R2.z;
RCP R2.z, R3.w;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R2.xyz, R5.z, R3, R2;
MAD R4.xy, R4.wyzw, c[6].z, -c[6].x;
MUL R3.xy, R4, R4;
ADD_SAT R3.y, R3.x, R3;
ADD R3.x, -fragment.texcoord[2].z, c[6];
ADD R3.y, -R3, c[6].x;
MUL R3.z, R4, fragment.texcoord[2];
MAD R3.x, R4.z, R3, fragment.texcoord[2].z;
RSQ R3.y, R3.y;
MAD R3.w, R3.z, c[4].x, R3.x;
POW_SAT R3.w, R3.w, c[6].y;
MAD R1, R3.w, R1, R0;
MUL R0.xyz, R1, c[5];
RCP R4.z, R3.y;
ADD R3.xyz, R4, -R2;
ADD R4.x, R0.w, -R2.w;
MAD R2.xyz, R3.w, R3, R2;
DP3 R3.x, R2, fragment.texcoord[3];
MAD R2.w, R5.z, R4.x, R2;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
ADD R4.x, R1.w, -R2.w;
MAX R3.x, R3, c[6].w;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R1, R3.x;
RSQ R0.w, R0.w;
MOV R3.xyz, fragment.texcoord[3];
MAD R3.xyz, R0.w, fragment.texcoord[5], R3;
DP3 R0.w, R3, R3;
RSQ R1.w, R0.w;
MUL R3.xyz, R1.w, R3;
DP3 R2.x, R2, R3;
MOV R1.w, c[7].x;
MUL R2.y, R1.w, c[2].x;
MAX R1.w, R2.x, c[6];
POW R1.w, R1.w, R2.y;
MAD R0.w, R3, R4.x, R2;
MOV R2, c[1];
MUL R0.w, R1, R0;
MUL R2.xyz, R2, c[0];
MAD R1.xyz, R2, R0.w, R1;
MUL R1.xyz, R1, c[6].z;
MUL R1.w, R2, c[0];
MAD result.color.xyz, R0, fragment.texcoord[4], R1;
MUL result.color.w, R0, R1;
END
# 74 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
"ps_3_0
; 78 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r6.xy, v0, c3.x
texld r2, r6, s0
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mov_pp r4.w, r4.x
mad_pp r3, r4.w, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r5.yw, r5, s3
mad_pp r4.xy, r5.wyzw, c6.z, c6.w
texld r7.yw, r7, s5
add_pp r1, r1, -r3
mov_pp r5.z, r0.x
mad_pp r0, r5.z, r1, r3
mul_pp r5.xy, r4, r4
mul_pp r0.xyz, r0, c5
texld r6.yw, r6, s1
mad_pp r3.xy, r6.wyzw, c6.z, c6.w
mul_pp r6.xy, r3, r3
add_pp_sat r1.w, r5.x, r5.y
mad_pp r2.xy, r7.wyzw, c6.z, c6.w
add_pp_sat r2.z, r6.x, r6.y
add_pp r2.z, -r2, c6.x
rsq_pp r2.z, r2.z
rcp_pp r3.z, r2.z
add_pp r1.w, -r1, c6.x
rsq_pp r1.w, r1.w
rcp_pp r4.z, r1.w
add_pp r4.xyz, r4, -r3
mad_pp r3.xyz, r4.w, r4, r3
mul_pp r5.xy, r2, r2
add_pp_sat r1.w, r5.x, r5.y
add_pp r1.w, -r1, c6.x
dp3_pp r2.z, v5, v5
mul_pp r1.xyz, r0, c0
rsq_pp r1.w, r1.w
rsq_pp r2.z, r2.z
mov_pp r4.xyz, v3
mad_pp r4.xyz, r2.z, v5, r4
rcp_pp r2.z, r1.w
add_pp r2.xyz, r2, -r3
mad_pp r2.xyz, r5.z, r2, r3
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r4
dp3_pp r1.w, r2, r3
dp3_pp r5.x, r2, v3
max_pp r4.x, r5, c7
mul_pp r2.xyz, r1, r4.x
add_pp r1.y, r3.w, -r2.w
mad_pp r2.w, r4, r1.y, r2
mov_pp r1.x, c2
add_pp r0.w, r0, -r2
max_pp r3.x, r1.w, c7
mul_pp r3.y, c7, r1.x
pow r1, r3.x, r3.y
mad_pp r1.w, r5.z, r0, r2
mov r0.w, r1.x
mul r0.w, r0, r1
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mad r1.xyz, r1, r0.w, r2
mov_pp r1.w, c0
mul r1.xyz, r1, c6.z
mul_pp r1.w, c1, r1
mad_pp oC0.xyz, r0, v4, r1
mul oC0.w, r0, r1
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Tile]
Float 1 [_blendPower]
Vector 2 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [unity_Lightmap] 2D 6
"3.0-!!ARBfp1.0
# 26 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 1, 20, 8 } };
TEMP R0;
TEMP R1;
MUL R0.xy, fragment.texcoord[0], c[0].x;
TEX R1.xyz, R0, texture[0], 2D;
MUL R0.xy, fragment.texcoord[0].zwzw, c[0].x;
TEX R0.xyz, R0, texture[2], 2D;
ADD R0.w, -fragment.texcoord[2].y, c[3].y;
MAD R1.w, R0.y, R0, fragment.texcoord[2].y;
MUL R0.w, fragment.texcoord[2].y, R0.y;
MAD R0.w, R0, c[1].x, R1;
ADD R0.xyz, R0, -R1;
POW_SAT R0.w, R0.w, c[3].z;
MAD R1.xyz, R0.w, R0, R1;
MUL R0.xy, fragment.texcoord[1], c[0].x;
TEX R0.xyz, R0, texture[4], 2D;
ADD R0.w, -fragment.texcoord[2].z, c[3].y;
MAD R1.w, R0.z, R0, fragment.texcoord[2].z;
MUL R0.w, R0.z, fragment.texcoord[2].z;
MAD R0.w, R0, c[1].x, R1;
ADD R0.xyz, R0, -R1;
POW_SAT R0.w, R0.w, c[3].z;
MAD R1.xyz, R0.w, R0, R1;
TEX R0, fragment.texcoord[3], texture[6], 2D;
MUL R1.xyz, R1, c[2];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[3].w;
MOV result.color.w, c[3].x;
END
# 26 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Tile]
Float 1 [_blendPower]
Vector 2 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [unity_Lightmap] 2D 6
"ps_3_0
; 27 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s4
dcl_2d s6
def c3, 1.00000000, 20.00000000, 8.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mul r0.xy, v0, c0.x
texld r2.xyz, r0, s0
mul r0.xy, v0.zwzw, c0.x
texld r0.xyz, r0, s2
add_pp r3.xyz, r0, -r2
add_pp r0.w, -v2.y, c3.x
mad_pp r1.x, r0.y, r0.w, v2.y
mul_pp r0.w, v2.y, r0.y
mad_pp r0.w, r0, c1.x, r1.x
mul r0.xy, v1, c0.x
texld r1.xyz, r0, s4
pow_pp_sat r4, r0.w, c3.y
add_pp r0.z, -v2, c3.x
mad_pp r0.y, r1.z, r0.z, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r1.w, r0.x, c1.x, r0.y
pow_pp_sat r0, r1.w, c3.y
mov_pp r0.y, r4.x
mad_pp r2.xyz, r0.y, r3, r2
add_pp r1.xyz, r1, -r2
mad_pp r1.xyz, r0.x, r1, r2
texld r0, v3, s6
mul_pp r1.xyz, r1, c2
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c3.z
mov_pp oC0.w, c3
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
"3.0-!!ARBfp1.0
# 83 ALU, 8 TEX
PARAM c[9] = { program.local[0..4],
		{ 0, 1, 20, 2 },
		{ -0.40824828, -0.70710677, 0.57735026, 8 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
MUL R6.xy, fragment.texcoord[0], c[2].x;
TEX R1.yw, R6, texture[1], 2D;
MAD R2.xy, R1.wyzw, c[5].w, -c[5].y;
MUL R4.xy, fragment.texcoord[0].zwzw, c[2].x;
TEX R0.yw, R4, texture[3], 2D;
MAD R0.xy, R0.wyzw, c[5].w, -c[5].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
MUL R1.xy, R2, R2;
ADD_SAT R0.z, R0, R0.w;
ADD_SAT R1.x, R1, R1.y;
ADD R0.w, -R1.x, c[5].y;
RSQ R0.w, R0.w;
ADD R0.z, -R0, c[5].y;
RSQ R0.z, R0.z;
TEX R1, R4, texture[2], 2D;
RCP R2.z, R0.w;
RCP R0.z, R0.z;
ADD R3.xyz, R0, -R2;
ADD R0.x, -fragment.texcoord[2].y, c[5].y;
MAD R0.y, R1, R0.x, fragment.texcoord[2];
MUL R0.x, fragment.texcoord[2].y, R1.y;
MAD R0.z, R0.x, c[3].x, R0.y;
POW_SAT R4.w, R0.z, c[5].z;
MUL R0.xy, fragment.texcoord[1], c[2].x;
TEX R5.yw, R0, texture[5], 2D;
MAD R2.xyz, R4.w, R3, R2;
MAD R3.xy, R5.wyzw, c[5].w, -c[5].y;
TEX R0, R0, texture[4], 2D;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R3.w, R3.z, R3;
ADD R3.z, -fragment.texcoord[2], c[5].y;
ADD R3.w, -R3, c[5].y;
MAD R3.z, R0, R3, fragment.texcoord[2];
MUL R2.w, R0.z, fragment.texcoord[2].z;
MAD R2.w, R2, c[3].x, R3.z;
RSQ R3.w, R3.w;
RCP R3.z, R3.w;
POW_SAT R3.w, R2.w, c[5].z;
ADD R3.xyz, R3, -R2;
MAD R3.xyz, R3.w, R3, R2;
TEX R2, fragment.texcoord[3], texture[7], 2D;
MUL R2.xyz, R2.w, R2;
MUL R4.xyz, R2, c[6].w;
TEX R2, fragment.texcoord[3], texture[6], 2D;
DP3_SAT R5.z, R3, c[6];
DP3_SAT R5.y, R3, c[7];
DP3_SAT R5.x, R3, c[8];
DP3 R5.x, R5, R4;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, R5.x;
MUL R5.xyz, R2, c[6].w;
TEX R2, R6, texture[0], 2D;
ADD R1, R1, -R2;
MAD R1, R4.w, R1, R2;
ADD R0, R0, -R1;
MAD R0, R3.w, R0, R1;
MUL R7.xyz, R4.y, c[7];
MAD R2.xyz, R4.x, c[8], R7;
MAD R2.xyz, R4.z, c[6], R2;
DP3 R1.x, R2, R2;
ADD R1.w, R1, -R2;
MAD R1.w, R4, R1, R2;
ADD R0.w, R0, -R1;
MAD R1.w, R3, R0, R1;
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, R2;
DP3 R4.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.x, R4.x;
MAD R1.xyz, R2.x, fragment.texcoord[4], R1;
DP3 R2.x, R1, R1;
RSQ R2.x, R2.x;
MUL R1.xyz, R2.x, R1;
DP3 R1.x, R3, R1;
MOV R0.w, c[7];
MUL R1.y, R0.w, c[1].x;
MAX R0.w, R1.x, c[5].x;
POW R0.w, R0.w, R1.y;
MUL R6.xyz, R5, c[0];
MUL R1.xyz, R6, R1.w;
MUL R1.xyz, R1, R0.w;
MUL R0.xyz, R0, c[4];
MAD result.color.xyz, R0, R5, R1;
MOV result.color.w, c[5].x;
END
# 83 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
"ps_3_0
; 83 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c5, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c7, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c8, 0.81649655, 0.00000000, 0.57735026, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4.xyz
mul r2.xy, v0.zwzw, c2.x
texld r0, r2, s2
texld r3.yw, r2, s3
add_pp r1.x, -v2.y, c5
mad_pp r3.xy, r3.wyzw, c5.z, c5.w
mad_pp r1.x, r0.y, r1, v2.y
mul_pp r1.y, v2, r0
mad_pp r2.z, r1.y, c3.x, r1.x
pow_pp_sat r1, r2.z, c5.y
mul r4.xy, v0, c2.x
texld r1.yw, r4, s1
mad_pp r2.xy, r1.wyzw, c5.z, c5.w
mul_pp r2.zw, r2.xyxy, r2.xyxy
add_pp_sat r1.y, r2.z, r2.w
mul_pp r1.zw, r3.xyxy, r3.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.y, -r1, c5.x
rsq_pp r1.y, r1.y
add_pp r1.z, -r1, c5.x
rsq_pp r1.z, r1.z
mov_pp r2.w, r1.x
rcp_pp r2.z, r1.y
rcp_pp r3.z, r1.z
add_pp r5.xyz, r3, -r2
mul r3.xy, v1, c2.x
texld r1, r3, s4
add_pp r3.z, -v2, c5.x
mad_pp r2.xyz, r2.w, r5, r2
texld r3.yw, r3, s5
mad_pp r5.xy, r3.wyzw, c5.z, c5.w
mul_pp r3.xy, r5, r5
mul_pp r4.z, r1, v2
mad_pp r3.z, r1, r3, v2
mad_pp r4.w, r4.z, c3.x, r3.z
add_pp_sat r3.x, r3, r3.y
add_pp r4.z, -r3.x, c5.x
pow_pp_sat r3, r4.w, c5.y
rsq_pp r3.y, r4.z
rcp_pp r5.z, r3.y
add_pp r5.xyz, r5, -r2
mov_pp r3.w, r3.x
mad_pp r2.xyz, r3.w, r5, r2
texld r5, v3, s7
mul_pp r5.xyz, r5.w, r5
mul_pp r6.xyz, r5, c6.w
texld r5, v3, s6
dp3_pp_sat r3.z, r2, c6
dp3_pp_sat r3.y, r2, c7
dp3_pp_sat r3.x, r2, c8
dp3_pp r4.z, r3, r6
mul r3.xyz, r6.y, c7
mad r3.xyz, r6.x, c8, r3
mul_pp r5.xyz, r5.w, r5
mul_pp r5.xyz, r5, r4.z
mad r6.xyz, r6.z, c6, r3
mul_pp r3.xyz, r5, c6.w
dp3 r4.z, r6, r6
rsq r4.w, r4.z
dp3_pp r4.z, v4, v4
mul r6.xyz, r4.w, r6
rsq_pp r4.z, r4.z
mad_pp r6.xyz, r4.z, v4, r6
texld r4, r4, s0
add_pp r0, r0, -r4
mad_pp r0, r2.w, r0, r4
add_pp r1, r1, -r0
mad_pp r1, r3.w, r1, r0
dp3_pp r5.w, r6, r6
rsq_pp r5.w, r5.w
mul_pp r4.xyz, r5.w, r6
dp3_pp r2.x, r2, r4
add_pp r0.y, r0.w, -r4.w
mad_pp r2.z, r2.w, r0.y, r4.w
max_pp r2.y, r2.x, c7.w
mov_pp r0.x, c1
mul_pp r2.x, c8.w, r0
pow r0, r2.y, r2.x
add_pp r0.y, r1.w, -r2.z
mad_pp r0.y, r3.w, r0, r2.z
mul_pp r5.xyz, r3, c0
mul_pp r2.xyz, r5, r0.y
mul r0.xyz, r2, r0.x
mul_pp r1.xyz, r1, c4
mad_pp oC0.xyz, r1, r3, r0
mov_pp oC0.w, c7
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_ShadowMapTexture] 2D 6
"3.0-!!ARBfp1.0
# 77 ALU, 7 TEX
PARAM c[8] = { program.local[0..5],
		{ 1, 20, 2, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R5.xy, fragment.texcoord[1], c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R2, R3.zwzw, texture[0], 2D;
TEX R4, R5, texture[4], 2D;
TEX R0, R3, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[6];
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[4], R1.y;
ADD R0, R0, -R2;
POW_SAT R5.z, R1.x, c[6].y;
MAD R0, R5.z, R0, R2;
ADD R1, R4, -R0;
TEX R4.yw, R5, texture[5], 2D;
TEX R5.yw, R3.zwzw, texture[1], 2D;
MAD R2.xy, R5.wyzw, c[6].z, -c[6].x;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].z, -c[6].x;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R3, R3.w;
MUL R5.xy, R2, R2;
ADD_SAT R4.x, R5, R5.y;
ADD R3.z, -R4.x, c[6].x;
RSQ R3.w, R3.z;
ADD R2.z, -R2, c[6].x;
RSQ R3.z, R2.z;
RCP R2.z, R3.w;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R2.xyz, R5.z, R3, R2;
MAD R4.xy, R4.wyzw, c[6].z, -c[6].x;
MUL R3.xy, R4, R4;
ADD_SAT R3.y, R3.x, R3;
ADD R3.x, -fragment.texcoord[2].z, c[6];
ADD R3.y, -R3, c[6].x;
MUL R3.z, R4, fragment.texcoord[2];
MAD R3.x, R4.z, R3, fragment.texcoord[2].z;
RSQ R3.y, R3.y;
MAD R3.w, R3.z, c[4].x, R3.x;
POW_SAT R3.w, R3.w, c[6].y;
MAD R1, R3.w, R1, R0;
MUL R0.xyz, R1, c[5];
RCP R4.z, R3.y;
ADD R3.xyz, R4, -R2;
ADD R4.x, R0.w, -R2.w;
MAD R2.xyz, R3.w, R3, R2;
DP3 R3.x, R2, fragment.texcoord[3];
MAD R2.w, R5.z, R4.x, R2;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
ADD R4.x, R1.w, -R2.w;
MAX R3.x, R3, c[6].w;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R1, R3.x;
RSQ R0.w, R0.w;
MOV R3.xyz, fragment.texcoord[3];
MAD R3.xyz, R0.w, fragment.texcoord[5], R3;
DP3 R0.w, R3, R3;
RSQ R1.w, R0.w;
MUL R3.xyz, R1.w, R3;
DP3 R2.x, R2, R3;
MOV R1.w, c[7].x;
MUL R2.y, R1.w, c[2].x;
MAX R1.w, R2.x, c[6];
POW R1.w, R1.w, R2.y;
MAD R0.w, R3, R4.x, R2;
MOV R2, c[1];
MUL R0.w, R1, R0;
MUL R2.xyz, R2, c[0];
MAD R1.xyz, R2, R0.w, R1;
TXP R3.x, fragment.texcoord[6], texture[6], 2D;
MUL R1.w, R3.x, c[6].z;
MUL R2.x, R2.w, c[0].w;
MUL R1.xyz, R1, R1.w;
MUL R0.w, R0, R2.x;
MAD result.color.xyz, R0, fragment.texcoord[4], R1;
MUL result.color.w, R3.x, R0;
END
# 77 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_ShadowMapTexture] 2D 6
"ps_3_0
; 80 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r6.xy, v0, c3.x
texld r2, r6, s0
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mov_pp r4.w, r4.x
mad_pp r3, r4.w, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r5.yw, r5, s3
mad_pp r4.xy, r5.wyzw, c6.z, c6.w
texld r7.yw, r7, s5
add_pp r1, r1, -r3
mov_pp r5.z, r0.x
mad_pp r0, r5.z, r1, r3
mul_pp r5.xy, r4, r4
mul_pp r0.xyz, r0, c5
texld r6.yw, r6, s1
mad_pp r3.xy, r6.wyzw, c6.z, c6.w
mul_pp r6.xy, r3, r3
add_pp_sat r1.w, r5.x, r5.y
mad_pp r2.xy, r7.wyzw, c6.z, c6.w
add_pp_sat r2.z, r6.x, r6.y
add_pp r2.z, -r2, c6.x
rsq_pp r2.z, r2.z
rcp_pp r3.z, r2.z
add_pp r1.w, -r1, c6.x
rsq_pp r1.w, r1.w
rcp_pp r4.z, r1.w
add_pp r4.xyz, r4, -r3
mad_pp r3.xyz, r4.w, r4, r3
mul_pp r5.xy, r2, r2
add_pp_sat r1.w, r5.x, r5.y
add_pp r1.w, -r1, c6.x
dp3_pp r2.z, v5, v5
mul_pp r1.xyz, r0, c0
rsq_pp r1.w, r1.w
rsq_pp r2.z, r2.z
mov_pp r4.xyz, v3
mad_pp r4.xyz, r2.z, v5, r4
rcp_pp r2.z, r1.w
add_pp r2.xyz, r2, -r3
mad_pp r2.xyz, r5.z, r2, r3
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r4
dp3_pp r1.w, r2, r3
dp3_pp r5.x, r2, v3
max_pp r4.x, r5, c7
mul_pp r2.xyz, r1, r4.x
add_pp r1.y, r3.w, -r2.w
mad_pp r2.w, r4, r1.y, r2
mov_pp r1.x, c2
add_pp r0.w, r0, -r2
max_pp r3.x, r1.w, c7
mul_pp r3.y, c7, r1.x
pow r1, r3.x, r3.y
mad_pp r1.w, r5.z, r0, r2
mov r0.w, r1.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mul r0.w, r0, r1
mad r2.xyz, r1, r0.w, r2
texldp r1.x, v6, s6
mov_pp r1.z, c0.w
mul_pp r1.y, r1.x, c6.z
mul_pp r1.z, c1.w, r1
mul r2.xyz, r2, r1.y
mul r0.w, r0, r1.z
mad_pp oC0.xyz, r0, v4, r2
mul oC0.w, r1.x, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Tile]
Float 1 [_blendPower]
Vector 2 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_ShadowMapTexture] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
"3.0-!!ARBfp1.0
# 32 ALU, 5 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 1, 20, 8 },
		{ 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[0], c[0].x;
TEX R1.xyz, R0, texture[0], 2D;
MUL R0.xy, fragment.texcoord[0].zwzw, c[0].x;
TEX R0.xyz, R0, texture[2], 2D;
ADD R0.w, -fragment.texcoord[2].y, c[3].y;
MAD R1.w, R0.y, R0, fragment.texcoord[2].y;
MUL R0.w, fragment.texcoord[2].y, R0.y;
MAD R0.w, R0, c[1].x, R1;
ADD R0.xyz, R0, -R1;
POW_SAT R0.w, R0.w, c[3].z;
MAD R1.xyz, R0.w, R0, R1;
MUL R0.xy, fragment.texcoord[1], c[0].x;
TEX R0.xyz, R0, texture[4], 2D;
ADD R0.w, -fragment.texcoord[2].z, c[3].y;
MAD R1.w, R0.z, R0, fragment.texcoord[2].z;
MUL R0.w, R0.z, fragment.texcoord[2].z;
MAD R0.w, R0, c[1].x, R1;
ADD R0.xyz, R0, -R1;
POW_SAT R0.w, R0.w, c[3].z;
MAD R0.xyz, R0.w, R0, R1;
TEX R2, fragment.texcoord[3], texture[7], 2D;
MUL R1.xyz, R2.w, R2;
TXP R3.x, fragment.texcoord[4], texture[6], 2D;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[3].w;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[4].x;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL R0.xyz, R0, c[2];
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[3].x;
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Tile]
Float 1 [_blendPower]
Vector 2 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_ShadowMapTexture] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
"ps_3_0
; 32 ALU, 5 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s4
dcl_2d s6
dcl_2d s7
def c3, 1.00000000, 20.00000000, 8.00000000, 2.00000000
def c4, 0.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
mul r0.xy, v0, c0.x
texld r2.xyz, r0, s0
mul r0.xy, v0.zwzw, c0.x
texld r0.xyz, r0, s2
add_pp r3.xyz, r0, -r2
add_pp r0.w, -v2.y, c3.x
mad_pp r1.x, r0.y, r0.w, v2.y
mul_pp r0.w, v2.y, r0.y
mad_pp r0.w, r0, c1.x, r1.x
mul r0.xy, v1, c0.x
texld r1.xyz, r0, s4
pow_pp_sat r4, r0.w, c3.y
add_pp r0.z, -v2, c3.x
mad_pp r0.y, r1.z, r0.z, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r1.w, r0.x, c1.x, r0.y
pow_pp_sat r0, r1.w, c3.y
mov_pp r0.y, r4.x
mad_pp r2.xyz, r0.y, r3, r2
add_pp r1.xyz, r1, -r2
mad_pp r0.xyz, r0.x, r1, r2
texld r2, v3, s7
mul_pp r1.xyz, r2.w, r2
texldp r3.x, v4, s6
mul_pp r2.xyz, r2, r3.x
mul_pp r1.xyz, r1, c3.z
mul_pp r3.xyz, r1, r3.x
mul_pp r2.xyz, r2, c3.w
min_pp r1.xyz, r1, r2
max_pp r1.xyz, r1, r3
mul_pp r0.xyz, r0, c2
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, c4.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_ShadowMapTexture] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
# 89 ALU, 9 TEX
PARAM c[9] = { program.local[0..4],
		{ 0, 1, 20, 2 },
		{ -0.40824828, -0.70710677, 0.57735026, 8 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
MUL R2.zw, fragment.texcoord[0], c[2].x;
TEX R0.yw, R2.zwzw, texture[3], 2D;
MUL R2.xy, fragment.texcoord[0], c[2].x;
TEX R1.yw, R2, texture[1], 2D;
MAD R1.xy, R1.wyzw, c[5].w, -c[5].y;
MAD R0.xy, R0.wyzw, c[5].w, -c[5].y;
MUL R0.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.z, R0, R0.w;
MUL R1.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.w, R1.z, R1;
ADD R0.z, -R0, c[5].y;
RSQ R0.z, R0.z;
ADD R0.w, -R0, c[5].y;
RCP R1.z, R0.z;
RSQ R0.w, R0.w;
RCP R0.z, R0.w;
ADD R3.xyz, R0, -R1;
TEX R0, R2.zwzw, texture[2], 2D;
ADD R1.w, -fragment.texcoord[2].y, c[5].y;
MUL R2.z, fragment.texcoord[2].y, R0.y;
MAD R1.w, R0.y, R1, fragment.texcoord[2].y;
MAD R1.w, R2.z, c[3].x, R1;
POW_SAT R1.w, R1.w, c[5].z;
MUL R2.zw, fragment.texcoord[1].xyxy, c[2].x;
MAD R1.xyz, R1.w, R3, R1;
TEX R3, R2.zwzw, texture[4], 2D;
TEX R4.yw, R2.zwzw, texture[5], 2D;
MAD R4.xy, R4.wyzw, c[5].w, -c[5].y;
MUL R2.zw, R4.xyxy, R4.xyxy;
ADD_SAT R2.z, R2, R2.w;
ADD R2.w, -fragment.texcoord[2].z, c[5].y;
ADD R2.z, -R2, c[5].y;
MUL R4.z, R3, fragment.texcoord[2];
MAD R2.w, R3.z, R2, fragment.texcoord[2].z;
MAD R2.w, R4.z, c[3].x, R2;
RSQ R2.z, R2.z;
RCP R4.z, R2.z;
ADD R4.xyz, R4, -R1;
POW_SAT R2.z, R2.w, c[5].z;
MAD R1.xyz, R2.z, R4, R1;
TEX R4, fragment.texcoord[3], texture[8], 2D;
MUL R4.xyz, R4.w, R4;
MUL R4.xyz, R4, c[6].w;
DP3_SAT R5.z, R1, c[6];
DP3_SAT R5.y, R1, c[7];
DP3_SAT R5.x, R1, c[8];
DP3 R2.w, R5, R4;
TEX R6, fragment.texcoord[3], texture[7], 2D;
MUL R5.xyz, R6.w, R6;
MUL R5.xyz, R5, R2.w;
TXP R7.x, fragment.texcoord[5], texture[6], 2D;
MUL R6.xyz, R6, R7.x;
MUL R5.xyz, R5, c[6].w;
MUL R6.xyz, R6, c[5].w;
MUL R7.xyz, R5, R7.x;
MIN R6.xyz, R5, R6;
MAX R6.xyz, R6, R7;
TEX R7, R2, texture[0], 2D;
ADD R0, R0, -R7;
MAD R0, R1.w, R0, R7;
ADD R3, R3, -R0;
MAD R3, R2.z, R3, R0;
MUL R2.xyw, R4.y, c[7].xyzz;
MAD R7.xyz, R4.x, c[8], R2.xyww;
MAD R4.xyz, R4.z, c[6], R7;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R0.w, R0, -R7;
RSQ R2.x, R2.x;
MUL R0.xyz, R0.x, R4;
MAD R0.xyz, R2.x, fragment.texcoord[4], R0;
MAD R2.x, R1.w, R0.w, R7.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP3 R0.y, R1, R0;
ADD R1.w, R3, -R2.x;
MOV R0.w, c[7];
MAX R0.y, R0, c[5].x;
MUL R0.x, R0.w, c[1];
MUL R5.xyz, R5, c[0];
MAD R1.w, R2.z, R1, R2.x;
MUL R1.xyz, R5, R1.w;
POW R0.x, R0.y, R0.x;
MUL R0.xyz, R1, R0.x;
MUL R1.xyz, R3, c[4];
MAD result.color.xyz, R1, R6, R0;
MOV result.color.w, c[5].x;
END
# 89 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_ShadowMapTexture] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
; 89 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c5, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c7, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c8, 0.81649655, 0.00000000, 0.57735026, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5
mul r1.xy, v0.zwzw, c2.x
texld r2, r1, s2
texld r1.yw, r1, s3
add_pp r0.x, -v2.y, c5
mad_pp r0.y, r2, r0.x, v2
mul_pp r0.x, v2.y, r2.y
mad_pp r1.z, r0.x, c3.x, r0.y
pow_pp_sat r0, r1.z, c5.y
mul r3.xy, v0, c2.x
texld r0.yw, r3, s1
mad_pp r4.xy, r0.wyzw, c5.z, c5.w
mad_pp r1.xy, r1.wyzw, c5.z, c5.w
mul_pp r0.zw, r1.xyxy, r1.xyxy
mul_pp r1.zw, r4.xyxy, r4.xyxy
add_pp_sat r0.y, r0.z, r0.w
add_pp_sat r1.z, r1, r1.w
add_pp r0.z, -r1, c5.x
rsq_pp r0.z, r0.z
add_pp r0.y, -r0, c5.x
rsq_pp r0.y, r0.y
mov_pp r3.z, r0.x
rcp_pp r1.z, r0.y
rcp_pp r4.z, r0.z
add_pp r1.xyz, r1, -r4
mad_pp r4.xyz, r3.z, r1, r4
mul r0.xy, v1, c2.x
texld r1, r0, s4
texld r0.yw, r0, s5
mad_pp r5.xy, r0.wyzw, c5.z, c5.w
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.w, -v2.z, c5.x
mul_pp r0.z, r1, v2
mad_pp r0.w, r1.z, r0, v2.z
mad_pp r3.w, r0.z, c3.x, r0
add_pp r4.w, -r0.x, c5.x
pow_pp_sat r0, r3.w, c5.y
rsq_pp r0.y, r4.w
rcp_pp r5.z, r0.y
mov_pp r3.w, r0.x
add_pp r5.xyz, r5, -r4
mad_pp r5.xyz, r3.w, r5, r4
texld r0, v3, s8
mul_pp r0.xyz, r0.w, r0
mul_pp r6.xyz, r0, c6.w
texld r0, v3, s7
mul_pp r7.xyz, r0.w, r0
dp3_pp_sat r4.z, r5, c6
dp3_pp_sat r4.x, r5, c8
dp3_pp_sat r4.y, r5, c7
dp3_pp r4.y, r4, r6
texldp r4.x, v5, s6
mul_pp r7.xyz, r7, r4.y
mul_pp r0.xyz, r0, r4.x
mul_pp r4.yzw, r0.xxyz, c5.z
mul_pp r7.xyz, r7, c6.w
mul r0.xyz, r6.y, c7
mad r0.xyz, r6.x, c8, r0
mad r0.xyz, r6.z, c6, r0
min_pp r4.yzw, r7.xxyz, r4
mul_pp r6.xyw, r7.xyzz, r4.x
max_pp r6.xyz, r4.yzww, r6.xyww
dp3 r0.w, r0, r0
rsq r4.w, r0.w
dp3_pp r0.w, v4, v4
mul_pp r4.xyz, r7, c0
mul r0.xyz, r4.w, r0
rsq_pp r0.w, r0.w
mad_pp r7.xyz, r0.w, v4, r0
texld r0, r3, s0
add_pp r2, r2, -r0
mad_pp r2, r3.z, r2, r0
add_pp r1, r1, -r2
dp3_pp r3.x, r7, r7
rsq_pp r3.x, r3.x
mul_pp r0.xyz, r3.x, r7
dp3_pp r0.x, r5, r0
mad_pp r1, r3.w, r1, r2
max_pp r2.y, r0.x, c7.w
mov_pp r0.y, c1.x
add_pp r0.x, r2.w, -r0.w
mad_pp r2.x, r3.z, r0, r0.w
mul_pp r2.z, c8.w, r0.y
pow r0, r2.y, r2.z
add_pp r0.y, r1.w, -r2.x
mad_pp r0.y, r3.w, r0, r2.x
mov r0.w, r0.x
mul_pp r0.xyz, r4, r0.y
mul r2.xyz, r0, r0.w
mul_pp r0.xyz, r1, c4
mad_pp oC0.xyz, r0, r6, r2
mov_pp oC0.w, c7
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
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
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex1_ST]
Vector 21 [_MainTex2_ST]
Vector 22 [_MainTex3_ST]
"3.0-!!ARBvp1.0
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
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
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex1_ST]
Vector 20 [_MainTex2_ST]
Vector 21 [_MainTex3_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
dp3 o4.y, r0, r2
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r3
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mov o3, v4
dp4 o6.z, r0, c14
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
Vector 12 [_MainTex1_ST]
Vector 13 [_MainTex2_ST]
Vector 14 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 28 ALU
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
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 28 instructions, 4 R-regs
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
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_MainTex1_ST]
Vector 12 [_MainTex2_ST]
Vector 13 [_MainTex3_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c14, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
dp3 o4.y, r4, r2
dp3 o5.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mov o3, v4
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
mad o2.xy, v3, c13, c13.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
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
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex1_ST]
Vector 21 [_MainTex2_ST]
Vector 22 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 37 ALU
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
DP4 result.texcoord[5].w, R0, c[16];
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 4 R-regs
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
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex1_ST]
Vector 20 [_MainTex2_ST]
Vector 21 [_MainTex3_ST]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
dp3 o4.y, r0, r2
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r3
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mov o3, v4
dp4 o6.w, r0, c15
dp4 o6.z, r0, c14
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
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
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex1_ST]
Vector 21 [_MainTex2_ST]
Vector 22 [_MainTex3_ST]
"3.0-!!ARBvp1.0
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
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
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex1_ST]
Vector 20 [_MainTex2_ST]
Vector 21 [_MainTex3_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
dp3 o4.y, r0, r2
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r3
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mov o3, v4
dp4 o6.z, r0, c14
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
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
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex1_ST]
Vector 21 [_MainTex2_ST]
Vector 22 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 34 ALU
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
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MOV result.texcoord[2], vertex.color;
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
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
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex1_ST]
Vector 20 [_MainTex2_ST]
Vector 21 [_MainTex3_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
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
dp3 o4.y, r4, r2
dp3 o5.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mov o3, v4
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTexture0] 2D 6
"3.0-!!ARBfp1.0
# 77 ALU, 7 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 1, 20, 2 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R1, R3, texture[2], 2D;
MUL R4.zw, fragment.texcoord[1].xyxy, c[3].x;
ADD R2.x, -fragment.texcoord[2].y, c[6].y;
TEX R0, R3.zwzw, texture[0], 2D;
TEX R5, R4.zwzw, texture[4], 2D;
MUL R2.y, fragment.texcoord[2], R1;
MAD R2.x, R1.y, R2, fragment.texcoord[2].y;
MAD R2.x, R2.y, c[4], R2;
ADD R1, R1, -R0;
POW_SAT R4.x, R2.x, c[6].z;
MAD R1, R4.x, R1, R0;
ADD R2, R5, -R1;
ADD R0.x, -fragment.texcoord[2].z, c[6].y;
TEX R5.yw, R4.zwzw, texture[5], 2D;
MUL R0.y, R5.z, fragment.texcoord[2].z;
MAD R0.x, R5.z, R0, fragment.texcoord[2].z;
MAD R0.x, R0.y, c[4], R0;
POW_SAT R4.y, R0.x, c[6].z;
MAD R2, R4.y, R2, R1;
MAD R0.xy, R5.wyzw, c[6].w, -c[6].y;
MUL R4.zw, R0.xyxy, R0.xyxy;
MUL R1.xyz, R2, c[5];
TEX R5.yw, R3.zwzw, texture[1], 2D;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].w, -c[6].y;
ADD R1.w, R1, -R0;
MAD R1.w, R4.x, R1, R0;
ADD R0.w, R2, -R1;
MAD R0.w, R4.y, R0, R1;
ADD_SAT R0.z, R4, R4.w;
MAD R2.xy, R5.wyzw, c[6].w, -c[6].y;
MUL R4.zw, R2.xyxy, R2.xyxy;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R4, R4.w;
ADD_SAT R3.z, R3, R3.w;
ADD R2.z, -R2, c[6].y;
ADD R3.z, -R3, c[6].y;
RSQ R2.z, R2.z;
RSQ R3.z, R3.z;
ADD R0.z, -R0, c[6].y;
RSQ R0.z, R0.z;
RCP R2.z, R2.z;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R3.xyz, R4.x, R3, R2;
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.z, R0.z;
ADD R0.xyz, R0, -R3;
MAD R0.xyz, R4.y, R0, R3;
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[3];
DP3 R3.x, R0, R2;
MAX R3.x, R3, c[6];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R3.x;
DP3 R3.y, fragment.texcoord[4], fragment.texcoord[4];
RSQ R3.x, R3.y;
MAD R2.xyz, R3.x, fragment.texcoord[4], R2;
DP3 R3.x, R2, R2;
RSQ R2.w, R3.x;
MUL R2.xyz, R2.w, R2;
DP3 R0.y, R0, R2;
MOV R1.w, c[7].x;
MOV R2.xyz, c[1];
MAX R0.y, R0, c[6].x;
MUL R0.x, R1.w, c[2];
POW R0.x, R0.y, R0.x;
MUL R0.y, R0.x, R0.w;
DP3 R0.x, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, R0.x, texture[6], 2D;
MUL R2.xyz, R2, c[0];
MUL R0.x, R0.w, c[6].w;
MAD R1.xyz, R2, R0.y, R1;
MUL result.color.xyz, R1, R0.x;
MOV result.color.w, c[6].x;
END
# 77 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTexture0] 2D 6
"ps_3_0
; 79 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r6.xy, v0, c3.x
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
texld r2, r6, s0
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mov_pp r4.w, r4.x
mad_pp r3, r4.w, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r5.yw, r5, s3
mad_pp r2.xy, r5.wyzw, c6.z, c6.w
add_pp r1, r1, -r3
mov_pp r5.z, r0.x
mad_pp r0, r5.z, r1, r3
texld r1.yw, r6, s1
mad_pp r1.xy, r1.wyzw, c6.z, c6.w
mul_pp r3.xy, r1, r1
add_pp_sat r2.z, r3.x, r3.y
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.w, -r2.z, c6.x
mul_pp r0.xyz, r0, c5
dp3_pp r3.x, v3, v3
rsq_pp r3.x, r3.x
mul_pp r0.xyz, r0, c0
rsq_pp r2.z, r1.w
add_pp r1.z, -r1, c6.x
rsq_pp r1.w, r1.z
rcp_pp r1.z, r2.z
rcp_pp r2.z, r1.w
add_pp r2.xyz, r2, -r1
mad_pp r2.xyz, r4.w, r2, r1
texld r5.yw, r7, s5
mad_pp r1.xy, r5.wyzw, c6.z, c6.w
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.z, -r1, c6.x
dp3_pp r1.w, v4, v4
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
add_pp r1.xyz, r1, -r2
mad_pp r1.xyz, r5.z, r1, r2
mul_pp r3.xyz, r3.x, v3
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r1.w, v4, r3
dp3_pp r3.x, r1, r3
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r2.xyz, r1.w, r4
dp3_pp r1.w, r1, r2
max_pp r3.x, r3, c7
mul_pp r1.xyz, r0, r3.x
add_pp r0.z, r3.w, -r2.w
mov_pp r0.y, c2.x
mad_pp r0.z, r4.w, r0, r2.w
max_pp r0.x, r1.w, c7
mul_pp r0.y, c7, r0
pow r2, r0.x, r0.y
add_pp r0.x, r0.w, -r0.z
mad_pp r0.y, r5.z, r0.x, r0.z
mov r0.x, r2
mul r0.y, r0.x, r0
dp3 r0.x, v5, v5
texld r0.x, r0.x, s6
mov_pp r2.xyz, c0
mul_pp r0.w, r0.x, c6.z
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.y, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c7.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
"3.0-!!ARBfp1.0
# 72 ALU, 6 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 1, 20, 2 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R5.xy, fragment.texcoord[1], c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R2, R3.zwzw, texture[0], 2D;
TEX R4, R5, texture[4], 2D;
TEX R0, R3, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[6].y;
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[4], R1.y;
ADD R0, R0, -R2;
POW_SAT R5.z, R1.x, c[6].z;
MAD R0, R5.z, R0, R2;
ADD R1, R4, -R0;
TEX R4.yw, R5, texture[5], 2D;
TEX R5.yw, R3.zwzw, texture[1], 2D;
MAD R2.xy, R5.wyzw, c[6].w, -c[6].y;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].w, -c[6].y;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R3, R3.w;
MUL R5.xy, R2, R2;
ADD_SAT R4.x, R5, R5.y;
ADD R3.z, -R4.x, c[6].y;
RSQ R3.w, R3.z;
ADD R2.z, -R2, c[6].y;
RSQ R3.z, R2.z;
RCP R2.z, R3.w;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R2.xyz, R5.z, R3, R2;
MAD R4.xy, R4.wyzw, c[6].w, -c[6].y;
MUL R3.xy, R4, R4;
ADD_SAT R3.y, R3.x, R3;
ADD R3.x, -fragment.texcoord[2].z, c[6].y;
ADD R3.y, -R3, c[6];
MUL R3.z, R4, fragment.texcoord[2];
MAD R3.x, R4.z, R3, fragment.texcoord[2].z;
RSQ R3.y, R3.y;
MAD R3.w, R3.z, c[4].x, R3.x;
POW_SAT R3.w, R3.w, c[6].z;
MAD R1, R3.w, R1, R0;
MUL R0.xyz, R1, c[5];
RCP R4.z, R3.y;
ADD R3.xyz, R4, -R2;
MAD R2.xyz, R3.w, R3, R2;
DP3 R3.x, R2, fragment.texcoord[3];
MAX R1.x, R3, c[6];
ADD R3.x, R0.w, -R2.w;
MAD R2.w, R5.z, R3.x, R2;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
ADD R1.w, R1, -R2;
RSQ R0.w, R0.w;
MOV R1.xyz, fragment.texcoord[3];
MAD R1.xyz, R0.w, fragment.texcoord[4], R1;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R1.x, R2, R1;
MOV R0.w, c[7].x;
MUL R1.y, R0.w, c[2].x;
MAX R0.w, R1.x, c[6].x;
POW R0.w, R0.w, R1.y;
MAD R1.w, R3, R1, R2;
MOV R1.xyz, c[1];
MUL R0.w, R0, R1;
MUL R1.xyz, R1, c[0];
MAD R0.xyz, R1, R0.w, R0;
MUL result.color.xyz, R0, c[6].w;
MOV result.color.w, c[6].x;
END
# 72 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
"ps_3_0
; 74 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mul r6.xy, v0, c3.x
texld r2, r6, s0
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mad_pp r3, r4.x, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r6.yw, r6, s1
mad_pp r2.xy, r6.wyzw, c6.z, c6.w
mul_pp r4.zw, r2.xyxy, r2.xyxy
add_pp r1, r1, -r3
mov_pp r4.y, r0.x
mad_pp r0, r4.y, r1, r3
texld r1.yw, r7, s5
mul_pp r0.xyz, r0, c5
texld r5.yw, r5, s3
mad_pp r1.xy, r1.wyzw, c6.z, c6.w
mad_pp r3.xy, r5.wyzw, c6.z, c6.w
mul_pp r1.zw, r3.xyxy, r3.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp_sat r2.z, r4, r4.w
add_pp r1.w, -r2.z, c6.x
rsq_pp r1.w, r1.w
add_pp r1.z, -r1, c6.x
rsq_pp r1.z, r1.z
rcp_pp r2.z, r1.w
rcp_pp r3.z, r1.z
add_pp r3.xyz, r3, -r2
mad_pp r2.xyz, r4.x, r3, r2
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.z, -r1, c6.x
dp3_pp r1.w, v4, v4
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
add_pp r1.xyz, r1, -r2
mad_pp r1.xyz, r4.y, r1, r2
dp3_pp r4.z, r1, v3
rsq_pp r1.w, r1.w
mov_pp r3.xyz, v3
mad_pp r3.xyz, r1.w, v4, r3
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r2.xyz, r1.w, r3
dp3_pp r1.x, r1, r2
max_pp r2.x, r1, c7
mov_pp r1.x, c2
add_pp r1.y, r3.w, -r2.w
mad_pp r2.z, r4.x, r1.y, r2.w
max_pp r1.w, r4.z, c7.x
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r1.w
mul_pp r2.y, c7, r1.x
pow r1, r2.x, r2.y
add_pp r0.w, r0, -r2.z
mad_pp r1.w, r4.y, r0, r2.z
mov r0.w, r1.x
mov_pp r1.xyz, c0
mul r0.w, r0, r1
mul_pp r1.xyz, c1, r1
mad r0.xyz, r1, r0.w, r0
mul oC0.xyz, r0, c6.z
mov_pp oC0.w, c7.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTexture0] 2D 6
SetTexture 7 [_LightTextureB0] 2D 7
"3.0-!!ARBfp1.0
# 83 ALU, 8 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 1, 20, 2 },
		{ 128, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R1, R3, texture[2], 2D;
MUL R4.zw, fragment.texcoord[1].xyxy, c[3].x;
ADD R2.x, -fragment.texcoord[2].y, c[6].y;
TEX R0, R3.zwzw, texture[0], 2D;
TEX R5, R4.zwzw, texture[4], 2D;
MUL R2.y, fragment.texcoord[2], R1;
MAD R2.x, R1.y, R2, fragment.texcoord[2].y;
MAD R2.x, R2.y, c[4], R2;
ADD R1, R1, -R0;
POW_SAT R4.x, R2.x, c[6].z;
MAD R1, R4.x, R1, R0;
ADD R2, R5, -R1;
ADD R0.x, -fragment.texcoord[2].z, c[6].y;
TEX R5.yw, R4.zwzw, texture[5], 2D;
MUL R0.y, R5.z, fragment.texcoord[2].z;
MAD R0.x, R5.z, R0, fragment.texcoord[2].z;
MAD R0.x, R0.y, c[4], R0;
POW_SAT R4.y, R0.x, c[6].z;
MAD R2, R4.y, R2, R1;
MAD R0.xy, R5.wyzw, c[6].w, -c[6].y;
MUL R4.zw, R0.xyxy, R0.xyxy;
MUL R1.xyz, R2, c[5];
TEX R5.yw, R3.zwzw, texture[1], 2D;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].w, -c[6].y;
ADD R1.w, R1, -R0;
MAD R1.w, R4.x, R1, R0;
ADD R0.w, R2, -R1;
MAD R0.w, R4.y, R0, R1;
ADD_SAT R0.z, R4, R4.w;
MAD R2.xy, R5.wyzw, c[6].w, -c[6].y;
MUL R4.zw, R2.xyxy, R2.xyxy;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R4, R4.w;
ADD_SAT R3.z, R3, R3.w;
ADD R2.z, -R2, c[6].y;
ADD R3.z, -R3, c[6].y;
RSQ R2.z, R2.z;
RSQ R3.z, R3.z;
ADD R0.z, -R0, c[6].y;
RSQ R0.z, R0.z;
RCP R2.z, R2.z;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R3.xyz, R4.x, R3, R2;
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.z, R0.z;
ADD R0.xyz, R0, -R3;
MAD R0.xyz, R4.y, R0, R3;
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[3];
DP3 R3.x, R0, R2;
MAX R3.x, R3, c[6];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R3.x;
DP3 R3.y, fragment.texcoord[4], fragment.texcoord[4];
RSQ R3.x, R3.y;
MAD R2.xyz, R3.x, fragment.texcoord[4], R2;
DP3 R3.x, R2, R2;
RSQ R2.w, R3.x;
MUL R2.xyz, R2.w, R2;
DP3 R0.y, R0, R2;
MOV R1.w, c[7].x;
MUL R0.x, R1.w, c[2];
MAX R0.y, R0, c[6].x;
POW R0.x, R0.y, R0.x;
MUL R2.z, R0.x, R0.w;
RCP R0.w, fragment.texcoord[5].w;
MAD R2.xy, fragment.texcoord[5], R0.w, c[7].y;
MOV R0.xyz, c[1];
TEX R1.w, R2, texture[6], 2D;
MUL R3.xyz, R0, c[0];
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
SLT R2.x, c[6], fragment.texcoord[5].z;
TEX R0.w, R0.w, texture[7], 2D;
MUL R1.w, R2.x, R1;
MUL R0.w, R1, R0;
MUL R0.x, R0.w, c[6].w;
MAD R1.xyz, R3, R2.z, R1;
MUL result.color.xyz, R1, R0.x;
MOV result.color.w, c[6].x;
END
# 83 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTexture0] 2D 6
SetTexture 7 [_LightTextureB0] 2D 7
"ps_3_0
; 84 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 1.00000000, 0.50000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5
mul r6.xy, v0, c3.x
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
texld r2, r6, s0
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mov_pp r4.w, r4.x
mad_pp r3, r4.w, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r5.yw, r5, s3
mad_pp r2.xy, r5.wyzw, c6.z, c6.w
add_pp r1, r1, -r3
mov_pp r5.z, r0.x
mad_pp r0, r5.z, r1, r3
texld r1.yw, r6, s1
mad_pp r1.xy, r1.wyzw, c6.z, c6.w
mul_pp r3.xy, r1, r1
add_pp_sat r2.z, r3.x, r3.y
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.w, -r2.z, c6.x
mul_pp r0.xyz, r0, c5
dp3_pp r3.x, v3, v3
rsq_pp r3.x, r3.x
mul_pp r0.xyz, r0, c0
mul_pp r3.xyz, r3.x, v3
rsq_pp r2.z, r1.w
add_pp r1.z, -r1, c6.x
rsq_pp r1.w, r1.z
rcp_pp r1.z, r2.z
rcp_pp r2.z, r1.w
add_pp r2.xyz, r2, -r1
mad_pp r2.xyz, r4.w, r2, r1
texld r5.yw, r7, s5
mad_pp r1.xy, r5.wyzw, c6.z, c6.w
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.z, -r1, c6.x
dp3_pp r1.w, v4, v4
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r1.w, v4, r3
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
add_pp r1.xyz, r1, -r2
mad_pp r1.xyz, r5.z, r1, r2
dp3_pp r3.x, r1, r3
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r2.xyz, r1.w, r4
dp3_pp r1.w, r1, r2
max_pp r3.x, r3, c7
mul_pp r1.xyz, r0, r3.x
add_pp r0.z, r3.w, -r2.w
mov_pp r0.y, c2.x
mad_pp r0.z, r4.w, r0, r2.w
max_pp r0.x, r1.w, c7
mul_pp r0.y, c7, r0
pow r2, r0.x, r0.y
add_pp r0.x, r0.w, -r0.z
mad_pp r0.y, r5.z, r0.x, r0.z
mov r0.x, r2
mul r1.w, r0.x, r0.y
rcp r0.x, v5.w
mad r3.xy, v5, r0.x, c7.w
dp3 r0.x, v5, v5
texld r0.w, r3, s6
cmp r0.y, -v5.z, c7.x, c7.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s7
mul_pp r0.w, r0.y, r0.x
mov_pp r2.xyz, c0
mul_pp r0.xyz, c1, r2
mul_pp r0.w, r0, c6.z
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c7.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
SetTexture 7 [_LightTexture0] CUBE 7
"3.0-!!ARBfp1.0
# 79 ALU, 8 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 1, 20, 2 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R1, R3, texture[2], 2D;
MUL R4.zw, fragment.texcoord[1].xyxy, c[3].x;
ADD R2.x, -fragment.texcoord[2].y, c[6].y;
TEX R0, R3.zwzw, texture[0], 2D;
TEX R5, R4.zwzw, texture[4], 2D;
MUL R2.y, fragment.texcoord[2], R1;
MAD R2.x, R1.y, R2, fragment.texcoord[2].y;
MAD R2.x, R2.y, c[4], R2;
ADD R1, R1, -R0;
POW_SAT R4.x, R2.x, c[6].z;
MAD R1, R4.x, R1, R0;
ADD R2, R5, -R1;
ADD R0.x, -fragment.texcoord[2].z, c[6].y;
TEX R5.yw, R4.zwzw, texture[5], 2D;
MUL R0.y, R5.z, fragment.texcoord[2].z;
MAD R0.x, R5.z, R0, fragment.texcoord[2].z;
MAD R0.x, R0.y, c[4], R0;
POW_SAT R4.y, R0.x, c[6].z;
MAD R2, R4.y, R2, R1;
MAD R0.xy, R5.wyzw, c[6].w, -c[6].y;
MUL R4.zw, R0.xyxy, R0.xyxy;
MUL R1.xyz, R2, c[5];
TEX R5.yw, R3.zwzw, texture[1], 2D;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].w, -c[6].y;
ADD R1.w, R1, -R0;
MAD R1.w, R4.x, R1, R0;
ADD R0.w, R2, -R1;
MAD R0.w, R4.y, R0, R1;
ADD_SAT R0.z, R4, R4.w;
MAD R2.xy, R5.wyzw, c[6].w, -c[6].y;
MUL R4.zw, R2.xyxy, R2.xyxy;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R4, R4.w;
ADD_SAT R3.z, R3, R3.w;
ADD R2.z, -R2, c[6].y;
ADD R3.z, -R3, c[6].y;
RSQ R2.z, R2.z;
RSQ R3.z, R3.z;
ADD R0.z, -R0, c[6].y;
RSQ R0.z, R0.z;
RCP R2.z, R2.z;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R3.xyz, R4.x, R3, R2;
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.z, R0.z;
ADD R0.xyz, R0, -R3;
MAD R0.xyz, R4.y, R0, R3;
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[3];
DP3 R3.x, R0, R2;
MAX R3.x, R3, c[6];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R3.x;
DP3 R3.y, fragment.texcoord[4], fragment.texcoord[4];
RSQ R3.x, R3.y;
MAD R2.xyz, R3.x, fragment.texcoord[4], R2;
DP3 R3.x, R2, R2;
RSQ R2.w, R3.x;
MUL R2.xyz, R2.w, R2;
DP3 R0.y, R0, R2;
MOV R1.w, c[7].x;
MUL R0.x, R1.w, c[2];
MAX R0.y, R0, c[6].x;
POW R0.x, R0.y, R0.x;
MUL R2.x, R0, R0.w;
MOV R0.xyz, c[1];
MUL R3.xyz, R0, c[0];
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, fragment.texcoord[5], texture[7], CUBE;
TEX R1.w, R1.w, texture[6], 2D;
MUL R0.w, R1, R0;
MUL R0.x, R0.w, c[6].w;
MAD R1.xyz, R3, R2.x, R1;
MUL result.color.xyz, R1, R0.x;
MOV result.color.w, c[6].x;
END
# 79 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
SetTexture 7 [_LightTexture0] CUBE 7
"ps_3_0
; 80 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_cube s7
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r6.xy, v0, c3.x
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
texld r2, r6, s0
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mov_pp r4.w, r4.x
mad_pp r3, r4.w, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r5.yw, r5, s3
mad_pp r2.xy, r5.wyzw, c6.z, c6.w
add_pp r1, r1, -r3
mov_pp r5.z, r0.x
mad_pp r0, r5.z, r1, r3
texld r1.yw, r6, s1
mad_pp r1.xy, r1.wyzw, c6.z, c6.w
mul_pp r3.xy, r1, r1
add_pp_sat r2.z, r3.x, r3.y
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.w, -r2.z, c6.x
mul_pp r0.xyz, r0, c5
dp3_pp r3.x, v3, v3
rsq_pp r3.x, r3.x
mul_pp r0.xyz, r0, c0
rsq_pp r2.z, r1.w
add_pp r1.z, -r1, c6.x
rsq_pp r1.w, r1.z
rcp_pp r1.z, r2.z
rcp_pp r2.z, r1.w
add_pp r2.xyz, r2, -r1
mad_pp r2.xyz, r4.w, r2, r1
texld r5.yw, r7, s5
mad_pp r1.xy, r5.wyzw, c6.z, c6.w
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.z, -r1, c6.x
dp3_pp r1.w, v4, v4
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
add_pp r1.xyz, r1, -r2
mad_pp r1.xyz, r5.z, r1, r2
mul_pp r3.xyz, r3.x, v3
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r1.w, v4, r3
dp3_pp r3.x, r1, r3
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r2.xyz, r1.w, r4
dp3_pp r1.w, r1, r2
max_pp r3.x, r3, c7
mul_pp r1.xyz, r0, r3.x
add_pp r0.z, r3.w, -r2.w
mov_pp r0.y, c2.x
mad_pp r0.z, r4.w, r0, r2.w
max_pp r0.x, r1.w, c7
mul_pp r0.y, c7, r0
pow r2, r0.x, r0.y
add_pp r0.x, r0.w, -r0.z
mad_pp r0.y, r5.z, r0.x, r0.z
mov r0.x, r2
mul r1.w, r0.x, r0.y
dp3 r0.x, v5, v5
texld r0.x, r0.x, s6
texld r0.w, v5, s7
mul r0.w, r0.x, r0
mov_pp r2.xyz, c0
mul_pp r0.xyz, c1, r2
mul_pp r0.w, r0, c6.z
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c7.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTexture0] 2D 6
"3.0-!!ARBfp1.0
# 74 ALU, 7 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 1, 20, 2 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.zw, fragment.texcoord[0].xyxy, c[3].x;
MUL R5.xy, fragment.texcoord[1], c[3].x;
MUL R3.xy, fragment.texcoord[0].zwzw, c[3].x;
TEX R2, R3.zwzw, texture[0], 2D;
TEX R4, R5, texture[4], 2D;
TEX R0, R3, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[6].y;
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[4], R1.y;
ADD R0, R0, -R2;
POW_SAT R5.z, R1.x, c[6].z;
MAD R0, R5.z, R0, R2;
ADD R1, R4, -R0;
TEX R4.yw, R5, texture[5], 2D;
TEX R5.yw, R3.zwzw, texture[1], 2D;
MAD R2.xy, R5.wyzw, c[6].w, -c[6].y;
TEX R3.yw, R3, texture[3], 2D;
MAD R3.xy, R3.wyzw, c[6].w, -c[6].y;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R2.z, R3, R3.w;
MUL R5.xy, R2, R2;
ADD_SAT R4.x, R5, R5.y;
ADD R3.z, -R4.x, c[6].y;
RSQ R3.w, R3.z;
ADD R2.z, -R2, c[6].y;
RSQ R3.z, R2.z;
RCP R2.z, R3.w;
RCP R3.z, R3.z;
ADD R3.xyz, R3, -R2;
MAD R2.xyz, R5.z, R3, R2;
MAD R4.xy, R4.wyzw, c[6].w, -c[6].y;
MUL R3.xy, R4, R4;
ADD_SAT R3.y, R3.x, R3;
ADD R3.x, -fragment.texcoord[2].z, c[6].y;
ADD R3.y, -R3, c[6];
MUL R3.z, R4, fragment.texcoord[2];
MAD R3.x, R4.z, R3, fragment.texcoord[2].z;
RSQ R3.y, R3.y;
MAD R3.w, R3.z, c[4].x, R3.x;
POW_SAT R3.w, R3.w, c[6].z;
MAD R1, R3.w, R1, R0;
MUL R0.xyz, R1, c[5];
RCP R4.z, R3.y;
ADD R3.xyz, R4, -R2;
MAD R2.xyz, R3.w, R3, R2;
DP3 R3.x, R2, fragment.texcoord[3];
MAX R1.x, R3, c[6];
ADD R3.x, R0.w, -R2.w;
MAD R2.w, R5.z, R3.x, R2;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
ADD R1.w, R1, -R2;
RSQ R0.w, R0.w;
MOV R1.xyz, fragment.texcoord[3];
MAD R1.xyz, R0.w, fragment.texcoord[4], R1;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R1.x, R2, R1;
MOV R0.w, c[7].x;
MUL R1.y, R0.w, c[2].x;
MAX R0.w, R1.x, c[6].x;
POW R0.w, R0.w, R1.y;
MAD R1.w, R3, R1, R2;
MUL R1.w, R0, R1;
MOV R1.xyz, c[1];
TEX R0.w, fragment.texcoord[5], texture[6], 2D;
MUL R1.xyz, R1, c[0];
MUL R0.w, R0, c[6];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[6].x;
END
# 74 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_Shininess]
Float 3 [_Tile]
Float 4 [_blendPower]
Vector 5 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightTexture0] 2D 6
"ps_3_0
; 75 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c6, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c7, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xy
mul r6.xy, v0, c3.x
texld r2, r6, s0
mul r5.xy, v0.zwzw, c3.x
texld r0, r5, s2
add_pp r3, r0, -r2
add_pp r1.x, -v2.y, c6
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c4, r1.y
pow_pp_sat r4, r1.x, c6.y
mul r7.xy, v1, c3.x
texld r1, r7, s4
add_pp r0.x, -v2.z, c6
mad_pp r0.y, r1.z, r0.x, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r4.y, r0.x, c4.x, r0
mad_pp r3, r4.x, r3, r2
pow_pp_sat r0, r4.y, c6.y
texld r6.yw, r6, s1
mad_pp r2.xy, r6.wyzw, c6.z, c6.w
mul_pp r4.zw, r2.xyxy, r2.xyxy
add_pp r1, r1, -r3
mov_pp r4.y, r0.x
mad_pp r0, r4.y, r1, r3
texld r1.yw, r7, s5
mul_pp r0.xyz, r0, c5
texld r5.yw, r5, s3
mad_pp r1.xy, r1.wyzw, c6.z, c6.w
mad_pp r3.xy, r5.wyzw, c6.z, c6.w
mul_pp r1.zw, r3.xyxy, r3.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp_sat r2.z, r4, r4.w
add_pp r1.w, -r2.z, c6.x
rsq_pp r1.w, r1.w
add_pp r1.z, -r1, c6.x
rsq_pp r1.z, r1.z
rcp_pp r2.z, r1.w
rcp_pp r3.z, r1.z
add_pp r3.xyz, r3, -r2
mad_pp r2.xyz, r4.x, r3, r2
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r1.z, -r1, c6.x
dp3_pp r1.w, v4, v4
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
add_pp r1.xyz, r1, -r2
mad_pp r1.xyz, r4.y, r1, r2
dp3_pp r4.z, r1, v3
rsq_pp r1.w, r1.w
mov_pp r3.xyz, v3
mad_pp r3.xyz, r1.w, v4, r3
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r2.xyz, r1.w, r3
dp3_pp r1.x, r1, r2
max_pp r2.x, r1, c7
mov_pp r1.x, c2
add_pp r1.y, r3.w, -r2.w
mad_pp r2.z, r4.x, r1.y, r2.w
max_pp r1.w, r4.z, c7.x
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r1.w
mul_pp r2.y, c7, r1.x
pow r1, r2.x, r2.y
add_pp r0.w, r0, -r2.z
mad_pp r1.y, r4, r0.w, r2.z
mov r0.w, r1.x
mul r1.w, r0, r1.y
mov_pp r1.xyz, c0
texld r0.w, v5, s6
mul_pp r1.xyz, c1, r1
mul_pp r0.w, r0, c6.z
mad r0.xyz, r1, r1.w, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c7.x
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_MainTex1_ST]
Vector 11 [_MainTex2_ST]
Vector 12 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 24 ALU
PARAM c[13] = { program.local[0],
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[3].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[4].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[5].xyz, R0, c[9].w;
MOV result.texcoord[2], vertex.color;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_MainTex1_ST]
Vector 10 [_MainTex2_ST]
Vector 11 [_MainTex3_ST]
"vs_3_0
; 25 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o4.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o5.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o6.xyz, r0, c8.w
mov o3, v4
mad o1.zw, v3.xyxy, c10.xyxy, c10
mad o1.xy, v3, c9, c9.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Shininess]
Float 1 [_Tile]
Float 2 [_blendPower]
SetTexture 0 [_BumpMap1] 2D 0
SetTexture 1 [_MainTex2] 2D 1
SetTexture 2 [_BumpMap2] 2D 2
SetTexture 3 [_MainTex3] 2D 3
SetTexture 4 [_BumpMap3] 2D 4
"3.0-!!ARBfp1.0
# 45 ALU, 5 TEX
PARAM c[4] = { program.local[0..2],
		{ 1, 20, 2, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[0].zwzw, c[1].x;
TEX R2.yw, R0, texture[2], 2D;
TEX R0.y, R0, texture[1], 2D;
MUL R0.zw, fragment.texcoord[1].xyxy, c[1].x;
TEX R1.yw, R0.zwzw, texture[4], 2D;
MAD R3.xy, R1.wyzw, c[3].z, -c[3].x;
MUL R1.xy, fragment.texcoord[0], c[1].x;
TEX R1.yw, R1, texture[0], 2D;
MAD R1.xy, R1.wyzw, c[3].z, -c[3].x;
MAD R2.xy, R2.wyzw, c[3].z, -c[3].x;
MUL R1.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.z, R1, R1.w;
MUL R2.zw, R1.xyxy, R1.xyxy;
ADD_SAT R2.z, R2, R2.w;
ADD R1.w, -R2.z, c[3].x;
RSQ R2.z, R1.w;
ADD R1.z, -R1, c[3].x;
RSQ R1.w, R1.z;
RCP R1.z, R2.z;
RCP R2.z, R1.w;
ADD R1.w, -fragment.texcoord[2].y, c[3].x;
ADD R2.xyz, R2, -R1;
MAD R1.w, R0.y, R1, fragment.texcoord[2].y;
MUL R0.x, fragment.texcoord[2].y, R0.y;
MAD R0.y, R0.x, c[2].x, R1.w;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R0.x, R3.z, R3.w;
POW_SAT R0.y, R0.y, c[3].y;
ADD R0.x, -R0, c[3];
RSQ R1.w, R0.x;
MAD R1.xyz, R0.y, R2, R1;
RCP R3.z, R1.w;
TEX R0.z, R0.zwzw, texture[3], 2D;
ADD R0.x, -fragment.texcoord[2].z, c[3];
MAD R0.y, R0.z, R0.x, fragment.texcoord[2].z;
MUL R0.x, R0.z, fragment.texcoord[2].z;
MAD R0.x, R0, c[2], R0.y;
POW_SAT R0.x, R0.x, c[3].y;
ADD R2.xyz, R3, -R1;
MAD R1.xyz, R0.x, R2, R1;
DP3 R0.z, fragment.texcoord[5], R1;
DP3 R0.x, R1, fragment.texcoord[3];
DP3 R0.y, R1, fragment.texcoord[4];
MAD result.color.xyz, R0, c[3].w, c[3].w;
MOV result.color.w, c[0].x;
END
# 45 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Shininess]
Float 1 [_Tile]
Float 2 [_blendPower]
SetTexture 0 [_BumpMap1] 2D 0
SetTexture 1 [_MainTex2] 2D 1
SetTexture 2 [_BumpMap2] 2D 2
SetTexture 3 [_MainTex3] 2D 3
SetTexture 4 [_BumpMap3] 2D 4
"ps_3_0
; 45 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c4, 0.50000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v0.zwzw, c1.x
texld r2.yw, r0, s2
mad_pp r2.xy, r2.wyzw, c3.z, c3.w
texld r0.y, r0, s1
mul_pp r0.zw, r2.xyxy, r2.xyxy
add_pp_sat r0.z, r0, r0.w
mul r1.xy, v0, c1.x
texld r1.yw, r1, s0
mad_pp r1.xy, r1.wyzw, c3.z, c3.w
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp r0.w, -r1.z, c3.x
rsq_pp r0.w, r0.w
add_pp r0.z, -r0, c3.x
rsq_pp r0.z, r0.z
rcp_pp r2.z, r0.z
rcp_pp r1.z, r0.w
add_pp r0.z, -v2.y, c3.x
add_pp r2.xyz, r2, -r1
mad_pp r0.z, r0.y, r0, v2.y
mul_pp r0.x, v2.y, r0.y
mad_pp r1.w, r0.x, c2.x, r0.z
pow_pp_sat r0, r1.w, c3.y
mul r3.xy, v1, c1.x
texld r0.yw, r3, s4
mad_pp r0.yw, r0.xwzy, c3.z, c3.w
mad_pp r1.xyz, r0.x, r2, r1
mul_pp r3.zw, r0.xyyw, r0.xyyw
texld r0.z, r3, s3
add_pp r0.x, -v2.z, c3
mad_pp r1.w, r0.z, r0.x, v2.z
mul_pp r0.x, r0.z, v2.z
add_pp_sat r2.x, r3.z, r3.w
add_pp r0.z, -r2.x, c3.x
mad_pp r0.x, r0, c2, r1.w
pow_pp_sat r2, r0.x, c3.y
rsq_pp r0.x, r0.z
rcp_pp r0.x, r0.x
add_pp r0.xyz, r0.ywxw, -r1
mov_pp r0.w, r2.x
mad_pp r1.xyz, r0.w, r0, r1
dp3 r0.z, v5, r1
dp3 r0.x, r1, v3
dp3 r0.y, r1, v4
mad_pp oC0.xyz, r0, c4.x, c4.x
mov_pp oC0.w, c0.x
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
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
Vector 18 [_MainTex1_ST]
Vector 19 [_MainTex2_ST]
Vector 20 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 31 ALU
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
ADD result.texcoord[4].xyz, R3, R2;
ADD result.texcoord[3].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[3].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
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
Vector 18 [_MainTex1_ST]
Vector 19 [_MainTex2_ST]
Vector 20 [_MainTex3_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c21, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
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
add o5.xyz, r3, r2
mad o4.xy, r0.z, c9.zwzw, r0
mov o0, r1
mov o3, v3
mov o4.zw, r1
mad o1.zw, v2.xyxy, c19.xyxy, c19
mad o1.xy, v2, c18, c18.zwzw
mad o2.xy, v2, c20, c20.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex1_ST]
Vector 17 [_MainTex2_ST]
Vector 18 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 23 ALU
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
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[3].zw, R0;
MUL result.texcoord[5].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[5].w, -R0.x, R0.y;
END
# 23 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex1_ST]
Vector 17 [_MainTex2_ST]
Vector 18 [_MainTex3_ST]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c19.x
mul r1.y, r1, c12.x
mad o4.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c19, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o3, v3
mov o4.zw, r0
mul o6.xyz, r1, c14.w
mad o1.zw, v1.xyxy, c17.xyxy, c17
mad o1.xy, v1, c16, c16.zwzw
mad o2.xy, v1, c18, c18.zwzw
mad o5.xy, v2, c15, c15.zwzw
mul o6.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex1_ST]
Vector 14 [_MainTex2_ST]
Vector 15 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 27 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R1.xyz, R2, c[11].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
DP3 result.texcoord[5].y, R1, R3;
ADD result.texcoord[3].xy, R2, R2.z;
DP3 result.texcoord[5].z, vertex.normal, R1;
DP3 result.texcoord[5].x, R1, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex1_ST]
Vector 14 [_MainTex2_ST]
Vector 15 [_MainTex3_ST]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c16, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c16.y
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c16.x
mul r2.y, r2, c9.x
dp3 o6.y, r1, r3
mad o4.xy, r2.z, c10.zwzw, r2
dp3 o6.z, v2, r1
dp3 o6.x, r1, v1
mov o0, r0
mov o3, v5
mov o4.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o2.xy, v3, c15, c15.zwzw
mad o5.xy, v4, c12, c12.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
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
Vector 18 [_MainTex1_ST]
Vector 19 [_MainTex2_ST]
Vector 20 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 31 ALU
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
ADD result.texcoord[4].xyz, R3, R2;
ADD result.texcoord[3].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[3].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
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
Vector 18 [_MainTex1_ST]
Vector 19 [_MainTex2_ST]
Vector 20 [_MainTex3_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c21, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
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
add o5.xyz, r3, r2
mad o4.xy, r0.z, c9.zwzw, r0
mov o0, r1
mov o3, v3
mov o4.zw, r1
mad o1.zw, v2.xyxy, c19.xyxy, c19
mad o1.xy, v2, c18, c18.zwzw
mad o2.xy, v2, c20, c20.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex1_ST]
Vector 17 [_MainTex2_ST]
Vector 18 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 23 ALU
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
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[3].zw, R0;
MUL result.texcoord[5].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[5].w, -R0.x, R0.y;
END
# 23 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex1_ST]
Vector 17 [_MainTex2_ST]
Vector 18 [_MainTex3_ST]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c19.x
mul r1.y, r1, c12.x
mad o4.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c19, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o3, v3
mov o4.zw, r0
mul o6.xyz, r1, c14.w
mad o1.zw, v1.xyxy, c17.xyxy, c17
mad o1.xy, v1, c16, c16.zwzw
mad o2.xy, v1, c18, c18.zwzw
mad o5.xy, v2, c15, c15.zwzw
mul o6.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex1_ST]
Vector 14 [_MainTex2_ST]
Vector 15 [_MainTex3_ST]
"3.0-!!ARBvp1.0
# 27 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R1.xyz, R2, c[11].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
DP3 result.texcoord[5].y, R1, R3;
ADD result.texcoord[3].xy, R2, R2.z;
DP3 result.texcoord[5].z, vertex.normal, R1;
DP3 result.texcoord[5].x, R1, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[2], vertex.color;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex1_ST]
Vector 14 [_MainTex2_ST]
Vector 15 [_MainTex3_ST]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c16, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c16.y
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c16.x
mul r2.y, r2, c9.x
dp3 o6.y, r1, r3
mad o4.xy, r2.z, c10.zwzw, r2
dp3 o6.z, v2, r1
dp3 o6.x, r1, v1
mov o0, r0
mov o3, v5
mov o4.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o2.xy, v3, c15, c15.zwzw
mad o5.xy, v4, c12, c12.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
"3.0-!!ARBfp1.0
# 36 ALU, 4 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 20 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[0], c[1].x;
TEX R2, R0, texture[0], 2D;
MUL R0.xy, fragment.texcoord[0].zwzw, c[1].x;
TEX R0, R0, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[4];
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[2], R1.y;
ADD R0, R0, -R2;
POW_SAT R3.x, R1.x, c[4].y;
MAD R1, R3.x, R0, R2;
ADD R2.y, R1.w, -R2.w;
MUL R0.xy, fragment.texcoord[1], c[1].x;
TEX R0, R0, texture[4], 2D;
ADD R2.x, -fragment.texcoord[2].z, c[4];
MAD R2.z, R0, R2.x, fragment.texcoord[2];
MUL R2.x, R0.z, fragment.texcoord[2].z;
MAD R2.x, R2, c[2], R2.z;
ADD R0, R0, -R1;
POW_SAT R2.x, R2.x, c[4].y;
MAD R1, R2.x, R0, R1;
TXP R0, fragment.texcoord[3], texture[6], 2D;
MAD R2.y, R3.x, R2, R2.w;
ADD R1.w, R1, -R2.y;
MAD R1.w, R2.x, R1, R2.y;
LG2 R0.w, R0.w;
MUL R0.w, -R0, R1;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[4];
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R0.w, R2;
MUL R1.xyz, R1, c[3];
MAD result.color.xyz, R1, R0, R2;
MUL result.color.w, R0, c[0];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
"ps_3_0
; 38 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s4
dcl_2d s6
def c4, 1.00000000, 20.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
mul r0.xy, v0.zwzw, c1.x
texld r1, r0, s2
add_pp r0.x, -v2.y, c4
mad_pp r0.w, r1.y, r0.x, v2.y
mul_pp r0.z, v2.y, r1.y
mul r0.xy, v0, c1.x
texld r2, r0, s0
mad_pp r3.x, r0.z, c2, r0.w
pow_pp_sat r0, r3.x, c4.y
add_pp r3, r1, -r2
mov_pp r4.x, r0
mad_pp r3, r4.x, r3, r2
add_pp r2.y, r3.w, -r2.w
mul r1.xy, v1, c1.x
mad_pp r2.y, r4.x, r2, r2.w
texld r1, r1, s4
add_pp r0.y, -v2.z, c4.x
mad_pp r0.z, r1, r0.y, v2
mul_pp r0.y, r1.z, v2.z
mad_pp r4.y, r0, c2.x, r0.z
pow_pp_sat r0, r4.y, c4.y
mov_pp r2.x, r0
add_pp r1, r1, -r3
mad_pp r0, r2.x, r1, r3
texldp r1, v3, s6
add_pp r0.w, r0, -r2.y
mad_pp r2.w, r2.x, r0, r2.y
log_pp r0.w, r1.w
mul_pp r0.w, -r0, r2
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
add_pp r1.xyz, -r1, v4
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r0.w, r2
mul_pp r0.xyz, r0, c3
mad_pp oC0.xyz, r0, r1, r2
mul_pp oC0.w, r0, c0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
Vector 4 [unity_LightmapFade]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
# 47 ALU, 6 TEX
PARAM c[6] = { program.local[0..4],
		{ 1, 20, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xy, fragment.texcoord[0], c[1].x;
MUL R1.xy, fragment.texcoord[0].zwzw, c[1].x;
TEX R0, R0, texture[0], 2D;
TEX R1, R1, texture[2], 2D;
ADD R2.x, -fragment.texcoord[2].y, c[5];
MAD R2.y, R1, R2.x, fragment.texcoord[2];
MUL R2.x, fragment.texcoord[2].y, R1.y;
MAD R2.x, R2, c[2], R2.y;
ADD R1, R1, -R0;
POW_SAT R2.x, R2.x, c[5].y;
MAD R1, R2.x, R1, R0;
ADD R0.x, R1.w, -R0.w;
MAD R4.x, R2, R0, R0.w;
MUL R0.xy, fragment.texcoord[1], c[1].x;
TEX R0, R0, texture[4], 2D;
ADD R2.x, -fragment.texcoord[2].z, c[5];
MAD R2.y, R0.z, R2.x, fragment.texcoord[2].z;
MUL R2.x, R0.z, fragment.texcoord[2].z;
MAD R2.x, R2, c[2], R2.y;
ADD R0, R0, -R1;
POW_SAT R3.w, R2.x, c[5].y;
MAD R2, R3.w, R0, R1;
TEX R0, fragment.texcoord[4], texture[7], 2D;
MUL R0.xyz, R0.w, R0;
TEX R1, fragment.texcoord[4], texture[8], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[5].z;
DP4 R0.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R0.w, R0.w;
RCP R1.w, R0.w;
MAD R3.xyz, R0, c[5].z, -R1;
TXP R0, fragment.texcoord[3], texture[6], 2D;
MAD_SAT R1.w, R1, c[4].z, c[4];
MAD R1.xyz, R1.w, R3, R1;
ADD R2.w, R2, -R4.x;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R1;
MAD R1.w, R3, R2, R4.x;
LG2 R0.w, R0.w;
MUL R0.w, -R0, R1;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R0.w, R1;
MUL R2.xyz, R2, c[3];
MAD result.color.xyz, R2, R0, R1;
MUL result.color.w, R0, c[0];
END
# 47 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
Vector 4 [unity_LightmapFade]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
; 47 ALU, 6 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s4
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c5, 1.00000000, 20.00000000, 8.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
mul r2.xy, v0, c1.x
mul r0.xy, v0.zwzw, c1.x
texld r3, r2, s0
texld r0, r0, s2
add_pp r1.x, -v2.y, c5
mad_pp r1.y, r0, r1.x, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r2.z, r1.x, c2.x, r1.y
pow_pp_sat r1, r2.z, c5.y
add_pp r0, r0, -r3
mov_pp r4.x, r1
mad_pp r2, r4.x, r0, r3
mul r0.xy, v1, c1.x
texld r1, r0, s4
add_pp r0.z, -v2, c5.x
mad_pp r0.y, r1.z, r0.z, v2.z
mul_pp r0.x, r1.z, v2.z
mad_pp r3.x, r0, c2, r0.y
pow_pp_sat r0, r3.x, c5.y
add_pp r3.y, r2.w, -r3.w
mad_pp r3.x, r4, r3.y, r3.w
mov_pp r3.y, r0.x
add_pp r1, r1, -r2
mad_pp r2, r3.y, r1, r2
texld r0, v4, s7
mul_pp r0.xyz, r0.w, r0
texld r1, v4, s8
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c5.z
dp4 r0.w, v5, v5
rsq r0.w, r0.w
rcp r1.w, r0.w
mad_pp r4.xyz, r0, c5.z, -r1
texldp r0, v3, s6
mad_sat r1.w, r1, c4.z, c4
mad_pp r1.xyz, r1.w, r4, r1
add_pp r2.w, r2, -r3.x
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r0.xyz, -r0, r1
mad_pp r1.w, r3.y, r2, r3.x
log_pp r0.w, r0.w
mul_pp r0.w, -r0, r1
mul_pp r1.xyz, r0, c0
mul_pp r1.xyz, r0.w, r1
mul_pp r2.xyz, r2, c3
mad_pp oC0.xyz, r2, r0, r1
mul_pp oC0.w, r0, c0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
# 89 ALU, 9 TEX
PARAM c[9] = { program.local[0..4],
		{ 1, 20, 2, 8 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R0.zw, fragment.texcoord[0].xyxy, c[2].x;
MUL R0.xy, fragment.texcoord[0].zwzw, c[2].x;
TEX R1, R0, texture[2], 2D;
ADD R3.x, -fragment.texcoord[2].y, c[5];
TEX R2, R0.zwzw, texture[0], 2D;
MUL R3.y, fragment.texcoord[2], R1;
MAD R3.x, R1.y, R3, fragment.texcoord[2].y;
MAD R3.x, R3.y, c[3], R3;
ADD R1, R1, -R2;
POW_SAT R4.x, R3.x, c[5].y;
MAD R1, R4.x, R1, R2;
ADD R2.z, R1.w, -R2.w;
MUL R2.xy, fragment.texcoord[1], c[2].x;
TEX R3, R2, texture[4], 2D;
ADD R5, R3, -R1;
TEX R3.yw, R2, texture[5], 2D;
MAD R2.xy, R3.wyzw, c[5].z, -c[5].x;
ADD R4.y, -fragment.texcoord[2].z, c[5].x;
MAD R2.w, R4.x, R2.z, R2;
TEX R3.yw, R0.zwzw, texture[1], 2D;
MUL R4.z, R3, fragment.texcoord[2];
MAD R4.y, R3.z, R4, fragment.texcoord[2].z;
MAD R4.y, R4.z, c[3].x, R4;
POW_SAT R3.x, R4.y, c[5].y;
MAD R1, R3.x, R5, R1;
TEX R4.yw, R0, texture[3], 2D;
MAD R0.xy, R3.wyzw, c[5].z, -c[5].x;
MAD R5.xy, R4.wyzw, c[5].z, -c[5].x;
MUL R3.zw, R0.xyxy, R0.xyxy;
MUL R0.zw, R5.xyxy, R5.xyxy;
ADD_SAT R2.z, R3, R3.w;
ADD_SAT R0.w, R0.z, R0;
ADD R0.z, -R2, c[5].x;
MUL R3.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.z, R3, R3.w;
ADD R1.w, R1, -R2;
ADD R0.w, -R0, c[5].x;
RSQ R0.w, R0.w;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
RCP R5.z, R0.w;
ADD R5.xyz, R5, -R0;
MAD R4.xyz, R4.x, R5, R0;
TEX R0, fragment.texcoord[4], texture[8], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[5].w;
ADD R2.z, -R2, c[5].x;
RSQ R0.w, R2.z;
RCP R2.z, R0.w;
ADD R2.xyz, R2, -R4;
MAD R2.xyz, R3.x, R2, R4;
MUL R5.xyz, R0.y, c[7];
MAD R4.xyz, R0.x, c[8], R5;
MAD R4.xyz, R0.z, c[6], R4;
DP3 R0.w, R4, R4;
RSQ R4.w, R0.w;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
DP3_SAT R3.y, R2, c[8];
DP3_SAT R3.w, R2, c[6];
DP3_SAT R3.z, R2, c[7];
DP3 R3.z, R3.yzww, R0;
MUL R4.xyz, R4.w, R4;
RSQ R0.w, R0.w;
MAD R4.xyz, R0.w, fragment.texcoord[5], R4;
DP3 R3.y, R4, R4;
TEX R0, fragment.texcoord[4], texture[7], 2D;
MUL R0.xyz, R0.w, R0;
RSQ R3.y, R3.y;
MUL R4.xyz, R3.y, R4;
DP3 R0.w, R2, R4;
TXP R4, fragment.texcoord[3], texture[6], 2D;
MUL R0.xyz, R0, R3.z;
MAX R2.x, R0.w, c[6].w;
MOV R2.y, c[7].w;
MUL R0.w, R2.y, c[1].x;
POW R0.w, R2.x, R0.w;
MUL R0.xyz, R0, c[5].w;
LG2 R4.x, R4.x;
LG2 R4.y, R4.y;
LG2 R4.z, R4.z;
LG2 R4.w, R4.w;
ADD R0, -R4, R0;
MAD R1.w, R3.x, R1, R2;
MUL R0.w, R0, R1;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R0.w, R2;
MUL R1.xyz, R1, c[4];
MAD result.color.xyz, R0, R1, R2;
MUL result.color.w, R0, c[0];
END
# 89 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
; 88 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c5, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c7, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c8, 0.81649655, 0.00000000, 0.57735026, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
dcl_texcoord5 v5.xyz
mul r5.xy, v0.zwzw, c2.x
texld r0, r5, s2
mul r6.xy, v0, c2.x
add_pp r1.y, -v2, c5.x
texld r3, r6, s0
mad_pp r1.y, r0, r1, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c3, r1.y
pow_pp_sat r2, r1.x, c5.y
mul r4.xy, v1, c2.x
add_pp r0, r0, -r3
texld r1, r4, s4
add_pp r2.y, -v2.z, c5.x
mad_pp r2.z, r1, r2.y, v2
mul_pp r2.y, r1.z, v2.z
mov_pp r4.w, r2.x
mad_pp r4.z, r2.y, c3.x, r2
mad_pp r2, r4.w, r0, r3
pow_pp_sat r0, r4.z, c5.y
add_pp r1, r1, -r2
mov_pp r4.z, r0.x
mad_pp r0, r4.z, r1, r2
add_pp r3.x, r2.w, -r3.w
mad_pp r2.w, r4, r3.x, r3
texld r1.yw, r4, s5
mad_pp r2.xy, r1.wyzw, c5.z, c5.w
texld r3.yw, r5, s3
texld r1.yw, r6, s1
add_pp r0.w, r0, -r2
mad_pp r1.xy, r1.wyzw, c5.z, c5.w
mad_pp r3.xy, r3.wyzw, c5.z, c5.w
mul_pp r3.zw, r1.xyxy, r1.xyxy
mul_pp r1.zw, r3.xyxy, r3.xyxy
add_pp_sat r1.z, r1, r1.w
add_pp_sat r2.z, r3, r3.w
add_pp r1.w, -r2.z, c5.x
rsq_pp r2.z, r1.w
add_pp r1.z, -r1, c5.x
rsq_pp r1.w, r1.z
rcp_pp r1.z, r2.z
mul_pp r4.xy, r2, r2
rcp_pp r3.z, r1.w
add_pp r3.xyz, r3, -r1
mad_pp r3.xyz, r4.w, r3, r1
add_pp_sat r2.z, r4.x, r4.y
texld r1, v4, s8
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c6.w
add_pp r2.z, -r2, c5.x
rsq_pp r1.w, r2.z
rcp_pp r2.z, r1.w
add_pp r2.xyz, r2, -r3
mad_pp r2.xyz, r4.z, r2, r3
mul r5.xyz, r1.y, c7
mad r3.xyz, r1.x, c8, r5
mad r3.xyz, r1.z, c6, r3
dp3 r1.w, r3, r3
rsq r3.w, r1.w
dp3_pp r1.w, v5, v5
dp3_pp_sat r5.z, r2, c6
dp3_pp_sat r5.y, r2, c7
dp3_pp_sat r5.x, r2, c8
mul r3.xyz, r3.w, r3
rsq_pp r1.w, r1.w
mad_pp r3.xyz, r1.w, v5, r3
dp3_pp r3.w, r5, r1
dp3_pp r4.x, r3, r3
texld r1, v4, s7
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, r3.w
rsq_pp r4.x, r4.x
mul_pp r3.xyz, r4.x, r3
dp3_pp r1.w, r2, r3
mov_pp r3.w, c1.x
mul_pp r2.x, c8.w, r3.w
max_pp r1.w, r1, c7
pow r3, r1.w, r2.x
mul_pp r3.xyz, r1, c6.w
texldp r1, v3, s6
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
log_pp r1.w, r1.w
add_pp r1, -r1, r3
mad_pp r0.w, r4.z, r0, r2
mul_pp r0.w, r1, r0
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r0.w, r2
mul_pp r0.xyz, r0, c4
mad_pp oC0.xyz, r1, r0, r2
mul_pp oC0.w, r0, c0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
"3.0-!!ARBfp1.0
# 32 ALU, 4 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 20 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[0], c[1].x;
TEX R2, R0, texture[0], 2D;
MUL R0.xy, fragment.texcoord[0].zwzw, c[1].x;
TEX R0, R0, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[4];
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[2], R1.y;
ADD R0, R0, -R2;
POW_SAT R3.x, R1.x, c[4].y;
MAD R1, R3.x, R0, R2;
ADD R2.y, R1.w, -R2.w;
MUL R0.xy, fragment.texcoord[1], c[1].x;
TEX R0, R0, texture[4], 2D;
ADD R2.x, -fragment.texcoord[2].z, c[4];
MAD R2.z, R0, R2.x, fragment.texcoord[2];
MUL R2.x, R0.z, fragment.texcoord[2].z;
MAD R2.x, R2, c[2], R2.z;
ADD R0, R0, -R1;
POW_SAT R2.x, R2.x, c[4].y;
MAD R1, R2.x, R0, R1;
MAD R2.y, R3.x, R2, R2.w;
ADD R1.w, R1, -R2.y;
TXP R0, fragment.texcoord[3], texture[6], 2D;
MAD R1.w, R2.x, R1, R2.y;
ADD R0.xyz, R0, fragment.texcoord[4];
MUL R0.w, R0, R1;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R0.w, R2;
MUL R1.xyz, R1, c[3];
MAD result.color.xyz, R1, R0, R2;
MUL result.color.w, R0, c[0];
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
"ps_3_0
; 34 ALU, 4 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s4
dcl_2d s6
def c4, 1.00000000, 20.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
mul r0.xy, v0.zwzw, c1.x
texld r1, r0, s2
add_pp r0.x, -v2.y, c4
mad_pp r0.w, r1.y, r0.x, v2.y
mul_pp r0.z, v2.y, r1.y
mul r0.xy, v0, c1.x
texld r2, r0, s0
mad_pp r3.x, r0.z, c2, r0.w
pow_pp_sat r0, r3.x, c4.y
add_pp r3, r1, -r2
mov_pp r4.x, r0
mad_pp r3, r4.x, r3, r2
mul r1.xy, v1, c1.x
add_pp r2.y, r3.w, -r2.w
texld r1, r1, s4
add_pp r0.y, -v2.z, c4.x
mad_pp r0.z, r1, r0.y, v2
mul_pp r0.y, r1.z, v2.z
mad_pp r4.y, r0, c2.x, r0.z
pow_pp_sat r0, r4.y, c4.y
mov_pp r2.x, r0
add_pp r1, r1, -r3
mad_pp r0, r2.x, r1, r3
mad_pp r2.y, r4.x, r2, r2.w
add_pp r0.w, r0, -r2.y
texldp r1, v3, s6
mad_pp r0.w, r2.x, r0, r2.y
add_pp r1.xyz, r1, v4
mul_pp r0.w, r1, r0
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r0.w, r2
mul_pp r0.xyz, r0, c3
mad_pp oC0.xyz, r0, r1, r2
mul_pp oC0.w, r0, c0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
Vector 4 [unity_LightmapFade]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
# 43 ALU, 6 TEX
PARAM c[6] = { program.local[0..4],
		{ 1, 20, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[0], c[1].x;
TEX R3, R0, texture[0], 2D;
MUL R0.xy, fragment.texcoord[0].zwzw, c[1].x;
TEX R0, R0, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[5];
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[2], R1.y;
ADD R0, R0, -R3;
POW_SAT R2.x, R1.x, c[5].y;
MAD R1, R2.x, R0, R3;
ADD R2.y, R1.w, -R3.w;
MUL R0.xy, fragment.texcoord[1], c[1].x;
TEX R0, R0, texture[4], 2D;
ADD R2.z, -fragment.texcoord[2], c[5].x;
MAD R2.w, R0.z, R2.z, fragment.texcoord[2].z;
MUL R2.z, R0, fragment.texcoord[2];
MAD R2.z, R2, c[2].x, R2.w;
ADD R0, R0, -R1;
POW_SAT R2.w, R2.z, c[5].y;
MAD R1, R2.w, R0, R1;
MAD R3.x, R2, R2.y, R3.w;
TEX R0, fragment.texcoord[4], texture[7], 2D;
MUL R2.xyz, R0.w, R0;
TEX R0, fragment.texcoord[4], texture[8], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[5].z;
ADD R1.w, R1, -R3.x;
DP4 R3.y, fragment.texcoord[5], fragment.texcoord[5];
RSQ R0.w, R3.y;
RCP R0.w, R0.w;
MAD R2.xyz, R2, c[5].z, -R0;
MAD_SAT R0.w, R0, c[4].z, c[4];
MAD R2.xyz, R0.w, R2, R0;
TXP R0, fragment.texcoord[3], texture[6], 2D;
ADD R0.xyz, R0, R2;
MAD R1.w, R2, R1, R3.x;
MUL R0.w, R0, R1;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R0.w, R2;
MUL R1.xyz, R1, c[3];
MAD result.color.xyz, R1, R0, R2;
MUL result.color.w, R0, c[0];
END
# 43 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Float 1 [_Tile]
Float 2 [_blendPower]
Vector 3 [_Color]
Vector 4 [unity_LightmapFade]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 2 [_MainTex2] 2D 2
SetTexture 4 [_MainTex3] 2D 4
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
; 43 ALU, 6 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s4
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c5, 1.00000000, 20.00000000, 8.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
mul r0.xy, v0.zwzw, c1.x
texld r1, r0, s2
add_pp r0.x, -v2.y, c5
mad_pp r0.w, r1.y, r0.x, v2.y
mul_pp r0.z, v2.y, r1.y
mul r0.xy, v0, c1.x
texld r2, r0, s0
mad_pp r3.x, r0.z, c2, r0.w
pow_pp_sat r0, r3.x, c5.y
add_pp r3, r1, -r2
mov_pp r4.x, r0
mad_pp r3, r4.x, r3, r2
mul r1.xy, v1, c1.x
add_pp r2.y, r3.w, -r2.w
texld r1, r1, s4
add_pp r0.y, -v2.z, c5.x
mad_pp r0.z, r1, r0.y, v2
mul_pp r0.y, r1.z, v2.z
mad_pp r4.y, r0, c2.x, r0.z
pow_pp_sat r0, r4.y, c5.y
add_pp r1, r1, -r3
mov_pp r2.x, r0
mad_pp r0, r2.x, r1, r3
mad_pp r2.y, r4.x, r2, r2.w
add_pp r0.w, r0, -r2.y
texld r1, v4, s7
mul_pp r3.xyz, r1.w, r1
texld r1, v4, s8
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c5.z
dp4 r2.z, v5, v5
rsq r1.w, r2.z
rcp r1.w, r1.w
mad_pp r0.w, r2.x, r0, r2.y
mad_pp r3.xyz, r3, c5.z, -r1
mad_sat r1.w, r1, c4.z, c4
mad_pp r3.xyz, r1.w, r3, r1
texldp r1, v3, s6
add_pp r1.xyz, r1, r3
mul_pp r0.w, r1, r0
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r0.w, r2
mul_pp r0.xyz, r0, c3
mad_pp oC0.xyz, r0, r1, r2
mul_pp oC0.w, r0, c0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
# 85 ALU, 9 TEX
PARAM c[9] = { program.local[0..4],
		{ 1, 20, 2, 8 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R4.zw, fragment.texcoord[0].xyxy, c[2].x;
MUL R4.xy, fragment.texcoord[0].zwzw, c[2].x;
TEX R3, R4.zwzw, texture[0], 2D;
TEX R0, R4, texture[2], 2D;
ADD R1.x, -fragment.texcoord[2].y, c[5];
MAD R1.y, R0, R1.x, fragment.texcoord[2];
MUL R1.x, fragment.texcoord[2].y, R0.y;
MAD R1.x, R1, c[3], R1.y;
ADD R0, R0, -R3;
POW_SAT R5.z, R1.x, c[5].y;
MAD R1, R5.z, R0, R3;
MUL R3.xy, fragment.texcoord[1], c[2].x;
TEX R0, R3, texture[4], 2D;
ADD R2.x, -fragment.texcoord[2].z, c[5];
MAD R2.y, R0.z, R2.x, fragment.texcoord[2].z;
MUL R2.x, R0.z, fragment.texcoord[2].z;
MAD R2.x, R2, c[3], R2.y;
ADD R0, R0, -R1;
POW_SAT R5.x, R2.x, c[5].y;
MAD R2, R5.x, R0, R1;
ADD R0.x, R1.w, -R3.w;
MAD R5.y, R5.z, R0.x, R3.w;
TEX R0.yw, R3, texture[5], 2D;
MAD R3.xy, R0.wyzw, c[5].z, -c[5].x;
TEX R1.yw, R4.zwzw, texture[1], 2D;
TEX R0.yw, R4, texture[3], 2D;
MAD R1.xy, R1.wyzw, c[5].z, -c[5].x;
MAD R0.xy, R0.wyzw, c[5].z, -c[5].x;
MUL R0.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.w, R0.z, R0;
MUL R1.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R1, R1.w;
ADD R0.w, -R0, c[5].x;
RSQ R0.w, R0.w;
ADD R0.z, -R0, c[5].x;
RSQ R0.z, R0.z;
MUL R3.zw, R3.xyxy, R3.xyxy;
RCP R1.z, R0.w;
ADD_SAT R0.w, R3.z, R3;
ADD R1.w, -R0, c[5].x;
RSQ R1.w, R1.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, -R1;
MAD R1.xyz, R5.z, R0, R1;
TEX R0, fragment.texcoord[4], texture[8], 2D;
MUL R0.xyz, R0.w, R0;
RCP R3.z, R1.w;
ADD R3.xyz, R3, -R1;
MAD R4.xyz, R5.x, R3, R1;
MUL R0.xyz, R0, c[5].w;
MUL R3.xyz, R0.y, c[7];
MAD R3.xyz, R0.x, c[8], R3;
MAD R3.xyz, R0.z, c[6], R3;
DP3 R0.w, R3, R3;
DP3_SAT R1.z, R4, c[6];
DP3_SAT R1.y, R4, c[7];
DP3_SAT R1.x, R4, c[8];
DP3 R1.x, R1, R0;
RSQ R0.x, R0.w;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R0.xyz, R0.x, R3;
RSQ R0.w, R0.w;
MAD R3.xyz, R0.w, fragment.texcoord[5], R0;
TEX R0, fragment.texcoord[4], texture[7], 2D;
MUL R0.xyz, R0.w, R0;
DP3 R1.y, R3, R3;
MUL R0.xyz, R0, R1.x;
RSQ R0.w, R1.y;
MUL R1.xyz, R0, c[5].w;
MUL R0.xyz, R0.w, R3;
DP3 R0.x, R4, R0;
MOV R0.w, c[7];
MUL R0.y, R0.w, c[1].x;
MAX R0.x, R0, c[6].w;
POW R1.w, R0.x, R0.y;
TXP R0, fragment.texcoord[3], texture[6], 2D;
ADD R0, R0, R1;
ADD R2.w, R2, -R5.y;
MAD R1.w, R5.x, R2, R5.y;
MUL R0.w, R0, R1;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R0.w, R1;
MUL R2.xyz, R2, c[4];
MAD result.color.xyz, R0, R2, R1;
MUL result.color.w, R0, c[0];
END
# 85 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Float 1 [_Shininess]
Float 2 [_Tile]
Float 3 [_blendPower]
Vector 4 [_Color]
SetTexture 0 [_MainTex1] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_MainTex2] 2D 2
SetTexture 3 [_BumpMap2] 2D 3
SetTexture 4 [_MainTex3] 2D 4
SetTexture 5 [_BumpMap3] 2D 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
; 85 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c5, 1.00000000, 20.00000000, 2.00000000, -1.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c7, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c8, 0.81649655, 0.00000000, 0.57735026, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
dcl_texcoord5 v5.xyz
mul r5.xy, v0.zwzw, c2.x
texld r0, r5, s2
mul r6.xy, v0, c2.x
add_pp r1.y, -v2, c5.x
texld r3, r6, s0
mad_pp r1.y, r0, r1, v2
mul_pp r1.x, v2.y, r0.y
mad_pp r1.x, r1, c3, r1.y
pow_pp_sat r2, r1.x, c5.y
mul r4.xy, v1, c2.x
add_pp r0, r0, -r3
mov_pp r4.z, r2.x
texld r1, r4, s4
add_pp r2.y, -v2.z, c5.x
mad_pp r2.z, r1, r2.y, v2
mul_pp r2.y, r1.z, v2.z
mad_pp r4.w, r2.y, c3.x, r2.z
mad_pp r2, r4.z, r0, r3
pow_pp_sat r0, r4.w, c5.y
add_pp r1, r1, -r2
mov_pp r4.w, r0.x
mad_pp r0, r4.w, r1, r2
add_pp r3.x, r2.w, -r3.w
mad_pp r1.w, r4.z, r3.x, r3
texld r3.yw, r6, s1
mad_pp r1.xy, r3.wyzw, c5.z, c5.w
texld r2.yw, r5, s3
mad_pp r2.xy, r2.wyzw, c5.z, c5.w
mul_pp r2.zw, r2.xyxy, r2.xyxy
mul_pp r3.xy, r1, r1
add_pp_sat r1.z, r2, r2.w
add_pp_sat r3.x, r3, r3.y
add_pp r2.z, -r3.x, c5.x
texld r3, v4, s8
mul_pp r3.xyz, r3.w, r3
add_pp r0.w, r0, -r1
mul_pp r3.xyz, r3, c6.w
rsq_pp r2.w, r2.z
add_pp r1.z, -r1, c5.x
rsq_pp r2.z, r1.z
rcp_pp r1.z, r2.w
rcp_pp r2.z, r2.z
add_pp r2.xyz, r2, -r1
mad_pp r1.xyz, r4.z, r2, r1
texld r2.yw, r4, s5
mad_pp r2.xy, r2.wyzw, c5.z, c5.w
mul_pp r2.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.z, r2, r2.w
mul r4.xyz, r3.y, c7
mad r4.xyz, r3.x, c8, r4
mad r4.xyz, r3.z, c6, r4
add_pp r2.z, -r2, c5.x
rsq_pp r2.z, r2.z
rcp_pp r2.z, r2.z
add_pp r2.xyz, r2, -r1
mad_pp r1.xyz, r4.w, r2, r1
dp3 r2.w, r4, r4
rsq r2.x, r2.w
dp3_pp r2.w, v5, v5
mul r2.xyz, r2.x, r4
rsq_pp r2.w, r2.w
mad_pp r4.xyz, r2.w, v5, r2
dp3_pp r2.x, r4, r4
rsq_pp r2.w, r2.x
dp3_pp_sat r2.z, r1, c6
dp3_pp_sat r2.y, r1, c7
dp3_pp_sat r2.x, r1, c8
dp3_pp r5.x, r2, r3
mul_pp r4.xyz, r2.w, r4
dp3_pp r1.x, r1, r4
mov_pp r1.y, c1.x
texld r3, v4, s7
max_pp r1.x, r1, c7.w
mul_pp r1.y, c8.w, r1
pow r2, r1.x, r1.y
mul_pp r1.xyz, r3.w, r3
mul_pp r1.xyz, r1, r5.x
mov r3.w, r2
mul_pp r3.xyz, r1, c6.w
texldp r2, v3, s6
add_pp r2, r2, r3
mad_pp r0.w, r4, r0, r1
mul_pp r0.w, r2, r0
mul_pp r1.xyz, r2, c0
mul_pp r1.xyz, r0.w, r1
mul_pp r0.xyz, r0, c4
mad_pp oC0.xyz, r2, r0, r1
mul_pp oC0.w, r0, c0
"
}
}
 }
}
Fallback "Diffuse"
}