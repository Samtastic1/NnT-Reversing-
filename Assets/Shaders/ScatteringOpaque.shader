Shader "JAW/Sky Plane/Scattering Opaque" {
SubShader { 
 Pass {
  Cull Front
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [eyePosition]
Vector 11 [sunColor]
Float 12 [sunIntensity]
Vector 13 [sunDirection]
Float 14 [cloudEyeHeight]
Vector 15 [windDirection]
Float 16 [windSpeed]
Vector 17 [zenithColor]
Vector 18 [horizonColor]
Vector 19 [cloudColor]
Float 20 [overrideColor]
Float 21 [directionalityFactor]
Float 22 [atmosphereMie]
Float 23 [cloudMie]
Vector 24 [vBetaRayleigh]
Vector 25 [BetaRayTheta]
Vector 26 [vBetaMie]
Vector 27 [BetaMieTheta]
"3.0-!!ARBvp1.0
# 196 ALU
PARAM c[33] = { { 1, 0.5, 3, 2 },
		state.matrix.mvp,
		program.local[5..27],
		{ 1.5, 2.718282, 0.30000001, 1.05 },
		{ 2000, 100, 0, 4 },
		{ 2, 4, 0.16666667, 6 },
		{ 0.2, 1.01, 0.80999994, 0.00060999999 },
		{ 0.00029 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R4.w, c[0].x;
MOV R3.w, c[22].x;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD R0.xyz, R0, -c[10];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
MAX R0.x, R1.y, c[29].z;
MUL R0.x, -R0, c[29].w;
POW R0.x, c[28].y, R0.x;
MUL R2.xyz, R0.x, c[18];
ADD R0.x, -R0, c[0];
MAD R0.xyz, R0.x, c[17], R2;
MIN R1.w, R0.y, R0.z;
MAX R0.w, R0.y, R0.z;
MAX R0.w, R0.x, R0;
ADD R2.xyz, R0.w, -R0;
MIN R1.w, R0.x, R1;
ADD R2.w, R0, -R1;
RCP R1.w, R2.w;
MUL R2.xyz, R2, R1.w;
ADD R2.xyz, R2, -R2.zxyw;
ABS R1.w, R2;
ADD R0.z, -R4.w, c[20].x;
SGE R0.x, R0, R0.w;
ADD R2.xy, R2, c[30];
SLT R3.x, c[29].z, R1.w;
ABS R0.z, R0;
SGE R1.w, c[29].z, R0.z;
MUL R3.x, R1.w, R3;
MUL R0.z, R3.x, R0.x;
MUL R0.z, R2, R0;
ABS R2.z, R0.x;
ADD R0.x, R2, -R0.z;
SGE R2.x, c[29].z, R2.z;
SGE R2.z, R0.y, R0.w;
MUL R0.y, R3.x, R2.x;
MUL R2.x, R0.y, R2.z;
ABS R3.y, R2.z;
RCP R0.w, R0.w;
MUL R0.w, R2, R0;
MAD R0.x, R0, R2, R0.z;
SGE R2.z, c[29], R3.y;
MUL R0.z, R0.y, R2;
ADD R0.y, R2, -R0.x;
MAD R0.x, R0.y, R0.z, R0;
MUL R0.y, R0.x, c[30].z;
FRC R0.y, R0;
ADD R0.y, R0, -R0.x;
MAD R0.x, R0.y, R3, R0;
MUL R0.y, R0.x, c[30].w;
ADD R0.x, R0.y, -c[0].z;
ABS R0.x, R0;
DP3 R2.w, R1, c[13];
ADD R0.z, R0.y, -c[0].w;
ADD R2.x, R0.y, -c[29].w;
ABS R0.y, R0.z;
ABS R0.z, R2.x;
MUL R0.w, R3.x, R0;
MUL R2.xyz, R3.w, c[26];
MUL R3.xyz, R2, c[29].y;
ADD R2.xyz, R2, c[24];
RCP R2.x, R2.x;
RCP R2.z, R2.z;
RCP R2.y, R2.y;
ADD R0.x, R0, -c[0];
ADD R0.y, -R0, c[0].w;
ADD R0.z, -R0, c[0].w;
MIN R0.xyz, R0, c[0].x;
MAX R0.xyz, R0, c[29].z;
ADD R0.xyz, R0, -c[0].x;
MAD R4.xyz, R0, R0.w, c[0].x;
ABS R0.w, R1.y;
POW R0.x, R0.w, c[28].z;
ADD R0.x, -R0, c[28].w;
MUL R0.xyz, R0.x, c[24];
MAD R0.xyz, R0, c[29].x, R3;
MUL R3.x, -R2.w, c[21];
MUL R3.x, R3, c[0].w;
MAD R5.x, c[21], c[21], -R3;
POW R0.x, c[28].y, -R0.x;
POW R0.y, c[28].y, -R0.y;
POW R0.z, c[28].y, -R0.z;
ADD R3.xyz, -R0, c[0].x;
ADD R0.x, R5, c[0];
POW R0.y, R0.x, c[28].x;
ADD R0.x, R4.w, -c[21];
MUL R5.x, -R2.w, -R2.w;
RCP R4.w, R0.y;
MUL R5.y, R0.x, R0.x;
MUL R0.xyz, R3.w, c[27];
MUL R0.xyz, R0, R5.y;
MUL R0.xyz, R0, R4.w;
MAD R3.w, R5.x, c[0].y, c[0].z;
MAD R0.xyz, R3.w, c[25], R0;
MUL R0.xyz, R0, R3;
MUL R0.xyz, R0, R2;
MAX R2.x, c[19].y, c[19].z;
MAX R3.x, R2, c[19];
MIN R2.y, c[19], c[19].z;
MIN R2.y, R2, c[19].x;
ADD R3.y, R3.x, -R2;
MUL R0.xyz, R0, c[11];
SGE R3.w, c[19].x, R3.x;
MUL R0.xyz, R0, c[12].x;
RCP R3.z, R3.y;
ADD R2.xyz, R3.x, -c[19];
MUL R2.xyz, R2, R3.z;
ADD R2.xyz, R2, -R2.zxyw;
ABS R3.z, R3.y;
SLT R3.z, c[29], R3;
MUL R3.z, R1.w, R3;
MUL R4.w, R3.z, R3;
MUL R2.z, R2, R4.w;
ADD R2.xy, R2, c[30];
SGE R4.w, c[19].y, R3.x;
ABS R5.x, R4.w;
ABS R3.w, R3;
SGE R3.w, c[29].z, R3;
MUL R3.w, R3.z, R3;
ABS R1.w, R1;
ADD R2.x, R2, -R2.z;
MUL R4.w, R3, R4;
MAD R2.x, R2, R4.w, R2.z;
SGE R5.x, c[29].z, R5;
ADD R2.y, R2, -R2.x;
MUL R2.z, R3.w, R5.x;
MAD R3.w, R2.y, R2.z, R2.x;
MUL R2.y, R3.w, c[30].z;
MAX R2.x, R0.y, R0.z;
FRC R2.y, R2;
ADD R4.w, R2.y, -R3;
MAX R2.x, R0, R2;
MUL R2.xyz, R4, R2.x;
MAD R3.w, R4, R3.z, R3;
MUL R3.w, R3, c[30];
ADD R4.x, R3.w, -c[0].z;
ADD R0.xyz, R0, -R2;
SGE R1.w, c[29].z, R1;
MAD result.color.xyz, R0, R1.w, R2;
MOV R2.x, c[23];
MUL R2.z, R2.x, c[26];
MAD R2.y, R2.w, c[31].x, c[31];
ABS R4.x, R4;
ADD R0.z, R3.w, -c[29].w;
ADD R0.y, R3.w, -c[0].w;
ABS R0.z, R0;
ABS R0.y, R0;
POW R2.y, R2.y, c[28].x;
MUL R2.z, R2, c[29].y;
RCP R2.y, R2.y;
MUL R2.x, R2, c[27].z;
MUL R2.x, R2, R2.y;
POW R2.z, c[28].y, -R2.z;
ADD R2.y, -R2.z, c[0].x;
MUL R2.x, R2, R2.y;
RCP R2.z, c[26].z;
MUL R2.x, R2, R2.z;
MUL R2.w, R2.x, c[23].x;
ADD R0.x, R4, -c[0];
ADD R0.z, -R0, c[0].w;
ADD R0.y, -R0, c[0].w;
MIN R0.xyz, R0, c[0].x;
MAX R0.xyz, R0, c[29].z;
ADD R2.xyz, R0, -c[0].x;
MUL R0.xyz, R2.w, c[11];
RCP R2.w, R3.x;
MUL R0.xyz, R0, c[12].x;
MUL R0.xyz, R0, c[31].z;
MUL R2.w, R3.y, R2;
MUL R2.w, R3.z, R2;
MAX R3.x, R0.y, R0.z;
MAD R2.xyz, R2, R2.w, c[0].x;
MAX R2.w, R0.x, R3.x;
MUL R2.xyz, R2, R2.w;
ADD R0.xyz, R0, -R2;
MOV R3.x, c[16];
MUL R2.w, R3.x, c[9].x;
MAD result.color.secondary.xyz, R1.w, R0, R2;
MUL R2.w, R0, R2;
MUL R0.xy, R2.w, c[15];
MUL R2.xy, R0, c[28].x;
MUL R0.xy, R1.zxzw, c[14].x;
MUL R2.zw, R2.w, c[15];
MAD result.texcoord[0].xy, R0, c[31].w, R2;
MAD result.texcoord[1].xy, R0, c[32].x, R2.zwzw;
MOV result.texcoord[2].y, R0.w;
MOV result.texcoord[2].x, R1.y;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MOV result.color.w, c[0].x;
MOV result.color.secondary.w, c[0].x;
END
# 196 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [eyePosition]
Vector 10 [sunColor]
Float 11 [sunIntensity]
Vector 12 [sunDirection]
Float 13 [cloudEyeHeight]
Vector 14 [windDirection]
Float 15 [windSpeed]
Vector 16 [zenithColor]
Vector 17 [horizonColor]
Vector 18 [cloudColor]
Float 19 [overrideColor]
Float 20 [directionalityFactor]
Float 21 [atmosphereMie]
Float 22 [cloudMie]
Vector 23 [vBetaRayleigh]
Vector 24 [BetaRayTheta]
Vector 25 [vBetaMie]
Vector 26 [BetaMieTheta]
"vs_3_0
; 190 ALU, 14 FLOW
dcl_position o0
dcl_color0 o1
dcl_color1 o2
dcl_texcoord0 o3
dcl_texcoord1 o4
dcl_texcoord2 o5
def c27, 0.00061000, 1.50000000, 0.00029000, 2.71828198
def c28, 0.00000000, 4.00000000, 1.00000000, 2.00000000
def c29, 0.50000000, 3.00000000, 0.30000001, 1.04999995
def c30, 2000.00000000, 100.00000000, 0.16666667, -1.00000000
def c31, 6.00000000, -3.00000000, -2.00000000, -4.00000000
def c32, 0.20000000, 1.00999999, 0.80999994, 0
dcl_position0 v0
mov r2.xyz, c25
mul r2.xyz, c21.x, r2
mul r3.xyz, r2, c30.y
add r2.xyz, r2, c23
rcp r2.x, r2.x
rcp r2.z, r2.z
rcp r2.y, r2.y
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r0.xyz, r0, -c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
abs r1.w, r1.y
pow r0, r1.w, c29.z
add r0.x, -r0, c29.w
mul r0.xyz, r0.x, c23
mad r3.xyz, r0, c30.x, r3
pow r0, c27.w, -r3.x
mov r3.x, r0
pow r0, c27.w, -r3.y
dp3 r2.w, r1, c12
mul r0.x, -r2.w, c20
mul r3.w, r0.x, c28
mov r3.y, r0
pow r0, c27.w, -r3.z
mad r0.x, c20, c20, -r3.w
mov r3.z, r0
add r3.w, r0.x, c28.z
pow r0, r3.w, c27.y
mov r0.y, r0.x
mul r0.w, -r2, -r2
mov r0.x, c20
add r4.x, c28.z, -r0
rcp r3.w, r0.y
mov r0.xyz, c26
add r3.xyz, -r3, c28.z
mul r4.x, r4, r4
mul r0.xyz, c21.x, r0
mul r0.xyz, r0, r4.x
mul r0.xyz, r0, r3.w
mad r0.w, r0, c29.x, c29.y
mad r0.xyz, r0.w, c24, r0
mul r0.xyz, r0, r3
mul r0.xyz, r0, r2
mul r2.xyz, r0, c10
max r0.y, r1, c28.x
mov r0.x, c8
mul r0.x, c15, r0
mul r3.z, r1.w, r0.x
mul r3.w, -r0.y, c28.y
pow r0, c27.w, r3.w
mul r0.zw, r1.xyzx, c13.x
mul r3.xy, r3.z, c14
mul r3.xy, r3, c27.y
mad r4.zw, r0, c27.x, r3.xyxy
mul r3.xy, r3.z, c14.zwzw
mov r4.y, r1.w
mov r4.x, r1.y
mov r1.x, r0
mad r5.xy, r0.zwzw, c27.z, r3
add r0.w, -r1.x, c28.z
mul r0.xyz, r1.x, c17
mad r0.xyz, r0.w, c16, r0
mov r0.w, -r2
mov r2.w, c28.z
mul r2.xyz, r2, c11.x
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r1.y, v0, c1
dp4 r1.x, v0, c0
if_eq c19.x, r2.w
max r2.w, r0.y, r0.z
max r3.x, r0, r2.w
max r2.y, r2, r2.z
min r3.y, r0, r0.z
min r2.w, r0.x, r3.y
add r3.w, r3.x, -r2
max r2.w, r2.x, r2.y
mov r2.z, r3.x
mov r2.xy, c28.x
if_ne r3.w, c28.x
add r3.xyz, r2.z, -r0
rcp r2.x, r3.w
mul r3.xyz, r3, r2.x
add r3.xyz, r3, -r3.zxyw
rcp r2.x, r2.z
mov r0.z, r2
add r3.xy, r3, c28.wyzw
mul r2.y, r3.w, r2.x
if_ge r0.x, r0.z
mov r2.x, r3.z
else
if_ge r0.y, r2.z
mov r2.x, r3
else
mov r2.x, r3.y
endif
endif
mul r0.x, r2, c30.z
frc r2.x, r0
endif
mad r0.x, r2, c31, c31.y
mad r0.z, r2.x, c31.x, c31.w
mad r0.y, r2.x, c31.x, c31.z
abs r0.x, r0
abs r0.z, r0
abs r0.y, r0
add_sat r0.x, r0, c30.w
add_sat r0.z, -r0, c28.w
add_sat r0.y, -r0, c28.w
add r0.xyz, r0, c30.w
mad r0.xyz, r0, r2.y, c28.z
mul r2.xyz, r0, r2.w
else
endif
mov r0.x, c25.z
mul r0.x, c22, r0
mul r3.x, r0, c30.y
mad r2.w, -r0, c32.x, c32.y
pow r0, c27.w, -r3.x
mov r0.z, r0.x
pow r3, r2.w, c27.y
mov r0.y, r3.x
mov r0.x, c26.z
rcp r0.y, r0.y
mul r0.x, c22, r0
mul r0.x, r0, r0.y
add r0.y, -r0.z, c28.z
mul r0.x, r0, r0.y
rcp r0.z, c25.z
mul r0.x, r0, r0.z
mul r0.x, r0, c22
mul r0.xyz, r0.x, c10
mul r0.xyz, r0, c11.x
mul r3.xyz, r0, c32.z
mov r0.xyz, r2
mov r2.x, c28.z
mov r0.w, c28.z
if_eq c19.x, r2.x
max r2.x, r3.y, r3.z
max r2.w, r3.x, r2.x
min r3.x, c18.y, c18.z
max r2.z, c18.y, c18
min r3.x, r3, c18
max r2.z, r2, c18.x
add r3.w, r2.z, -r3.x
mov r2.xy, c28.x
if_ne r3.w, c28.x
rcp r2.y, r2.z
rcp r2.x, r3.w
add r3.xyz, r2.z, -c18
mul r3.xyz, r3, r2.x
add r3.xyz, r3, -r3.zxyw
mov r2.x, r2.z
add r3.xy, r3, c28.wyzw
mul r2.y, r3.w, r2
if_ge c18.x, r2.x
mov r2.x, r3.z
else
if_ge c18.y, r2.z
mov r2.x, r3
else
mov r2.x, r3.y
endif
endif
mul r2.x, r2, c30.z
frc r2.x, r2
endif
mad r2.z, r2.x, c31.x, c31.y
abs r2.z, r2
add_sat r3.x, r2.z, c30.w
mad r2.z, r2.x, c31.x, c31.w
abs r2.z, r2
mad r2.x, r2, c31, c31.z
abs r2.x, r2
add_sat r3.z, -r2, c28.w
add_sat r3.y, -r2.x, c28.w
add r3.xyz, r3, c30.w
mad r2.xyz, r3, r2.y, c28.z
mul r2.xyz, r2, r2.w
else
mov r2.xyz, r3
endif
mov o0, r1
mov o1, r0
mov o2.xyz, r2
mov o3.xy, r4.zwzw
mov o4.xy, r5
mov o5.xy, r4
mov o2.w, c28.z
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "$Globals" 224
Vector 16 [eyePosition] 3
Vector 32 [sunColor] 3
Float 44 [sunIntensity]
Vector 48 [sunDirection] 3
Float 60 [cloudEyeHeight]
Vector 80 [windDirection]
Float 96 [windSpeed]
Vector 100 [zenithColor] 3
Vector 112 [horizonColor] 3
Vector 128 [cloudColor] 3
Float 140 [overrideColor]
Float 144 [directionalityFactor]
Float 148 [atmosphereMie]
Float 152 [cloudMie]
Vector 160 [vBetaRayleigh] 3
Vector 176 [BetaRayTheta] 3
Vector 192 [vBetaMie] 3
Vector 208 [BetaMieTheta] 3
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhfelkfkicfikagpmjnkmamilkiobnapiabaaaaaapabbaaaaadaaaaaa
cmaaaaaakaaaaaaafmabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamadaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefc
imbaaaaaeaaaabaacdaeaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadgaaaaagicaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaacpaaaaaf
ccaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaajkjjjjdobjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdp
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaapkeediaaaaai
pcaabaaaacaaaaaacgacbaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaadiaaaaaj
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaaakiacaaaabaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaak
mcaabaaaabaaaaaaagaebaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaagioibpdk
gioibpdkdiaaaaaipcaabaaaadaaaaaaagaabaaaaaaaaaaaegiocaaaaaaaaaaa
afaaaaaadcaaaaamdccabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaamadp
aaaamadpaaaaaaaaaaaaaaaaogakbaaaabaaaaaadcaaaaammccabaaaadaaaaaa
kgaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaacealjidjcealjidjkgaobaaa
adaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaeaeadiaaaaaj
pcaabaaaacaaaaaafgijcaaaaaaaaaaaajaaaaaaegikcaaaaaaaaaaaanaaaaaa
aaaaaaajecaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaajaaaaaa
abeaaaaaaaaaiadpapaaaaajecaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaa
agiacaaaaaaaaaaaajaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaebaaaaaaabaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaamadpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaakgakbaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
alaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaajpcaabaaaadaaaaaa
fgijcaaaaaaaaaaaajaaaaaaegikcaaaaaaaaaaaamaaaaaadiaaaaakpcaabaaa
adaaaaaaegaobaaaadaaaaaaaceaaaaaaaaamiecaaaamiecaaaamiecpoeebamd
dcaaaaakocaabaaaabaaaaaaagijcaaaaaaaaaaaakaaaaaafgafbaaaabaaaaaa
agajbaaaadaaaaaadiaaaaakocaabaaaabaaaaaafgaobaaaabaaaaaaaceaaaaa
aaaaaaaadlkklilpdlkklilpdlkklilpbjaaaaafocaabaaaabaaaaaafgaobaaa
abaaaaaaaaaaaaalocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaiadpaaaaiadpdiaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaa
amaaaaaafgifcaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaoaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaafgaobaaaabaaaaaapgipcaaaaaaaaaaaacaaaaaabiaaaaaibcaabaaa
aaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpbpaaaeadakaabaaa
aaaaaaaadeaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklimabjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaacaaaaaaagaabaaa
acaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaajgihcaaa
aaaaaaaaagaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadeaaaaahecaabaaa
aaaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaadeaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaadeaaaaahbcaabaaaadaaaaaackaabaaa
acaaaaaabkaabaaaacaaaaaadeaaaaahbcaabaaaadaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaddaaaaahccaabaaaadaaaaaackaabaaaacaaaaaabkaabaaa
acaaaaaaddaaaaahccaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaa
aaaaaaaiccaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaaakaabaaaadaaaaaa
djaaaaahecaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaaoaaaaah
ccaabaaaaeaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaihcaabaaa
afaaaaaaegacbaiaebaaaaaaacaaaaaaagaabaaaadaaaaaaaoaaaaahhcaabaaa
afaaaaaaegacbaaaafaaaaaafgafbaaaadaaaaaaaaaaaaaihcaabaaaafaaaaaa
cgajbaiaebaaaaaaafaaaaaaegacbaaaafaaaaaaaaaaaaakmcaabaaaaeaaaaaa
agaebaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiaeabnaaaaah
dcaabaaaacaaaaaaegaabaaaacaaaaaaagaabaaaadaaaaaadhaaaaajccaabaaa
acaaaaaabkaabaaaacaaaaaackaabaaaaeaaaaaadkaabaaaaeaaaaaadhaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaaafaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkckdobkaaaaaf
bcaabaaaaeaaaaaaakaabaaaacaaaaaaabaaaaahdcaabaaaacaaaaaakgakbaaa
adaaaaaaegaabaaaaeaaaaaadcaaaaaphcaabaaaadaaaaaaagaabaaaacaaaaaa
aceaaaaaaaaamaeaaaaamaeaaaaamaeaaaaaaaaaaceaaaaaaaaaeamaaaaaaama
aaaaiamaaaaaaaaadccaaabahcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaa
aceaaaaaaaaaiadpaaaaialpaaaaialpaaaaaaaaaceaaaaaaaaaialpaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
adaaaaaafgafbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahocaabaaaabaaaaaakgakbaaaaaaaaaaaagajbaaaacaaaaaabfaaaaab
diaaaaahecaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaacifmepdpdcaaaaak
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaamnmmemloabeaaaaa
koehibdpcpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaamadpbjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaadkaabaaaadaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaapgipcaaaaaaaaaaaacaaaaaabpaaaeadakaabaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaabkaabaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadeaaaaajecaabaaa
aaaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaaaiaaaaaadeaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaddaaaaaj
bcaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaaaiaaaaaa
ddaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
aaaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
djaaaaahicaabaaaacaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaaoaaaaah
ccaabaaaadaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaajhcaabaaa
aeaaaaaakgakbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaiaaaaaaaoaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaagaabaaaabaaaaaaaaaaaaaihcaabaaa
aeaaaaaacgajbaiaebaaaaaaaeaaaaaaegacbaaaaeaaaaaaaaaaaaakmcaabaaa
adaaaaaaagaebaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiaea
bnaaaaaidcaabaaaaeaaaaaaegiacaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaa
dhaaaaajecaabaaaaaaaaaaabkaabaaaaeaaaaaackaabaaaadaaaaaadkaabaaa
adaaaaaadhaaaaajecaabaaaaaaaaaaaakaabaaaaeaaaaaackaabaaaaeaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
klkkckdobkaaaaafbcaabaaaadaaaaaackaabaaaaaaaaaaaabaaaaahdcaabaaa
adaaaaaapgapbaaaacaaaaaaegaabaaaadaaaaaadcaaaaapncaabaaaadaaaaaa
agaabaaaadaaaaaaaceaaaaaaaaamaeaaaaaaaaaaaaamaeaaaaamaeaaceaaaaa
aaaaeamaaaaaaaaaaaaaaamaaaaaiamadccaaabancaabaaaadaaaaaaagaobaia
ibaaaaaaadaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaialpaaaaialpaceaaaaa
aaaaialpaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaakncaabaaaadaaaaaaagaobaaa
adaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaialpdcaaaaamhcaabaaa
adaaaaaaigadbaaaadaaaaaafgafbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaa
adaaaaaabfaaaaabdgaaaaafhccabaaaabaaaaaajgahbaaaabaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaafhccabaaaacaaaaaaegacbaaa
acaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaafdccabaaa
aeaaaaaangafbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [sunDirection]
Float 1 [cloudCover]
Float 2 [cloudNebulosity]
Float 3 [cloudFadeHeight]
SetTexture 0 [noiseTexture] 2D 0
"3.0-!!ARBfp1.0
# 33 ALU, 2 TEX
PARAM c[6] = { program.local[0..3],
		{ 0.5, 0, 1, 2.718282 },
		{ -20, 0.80000001, 20 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[2].y;
MUL R0.zw, R0.x, fragment.texcoord[1].xyxy;
TEX R1, R0.zwzw, texture[0], 2D;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R0.y, R0, -c[4].z;
ABS R0.y, R0;
MAD R0.x, R0.y, c[4], R0;
ADD R0.x, R0, -c[1];
MUL R0.x, -R0, c[2];
POW R0.x, c[4].w, R0.x;
ADD R0.y, -R0.x, c[4].z;
ADD R1.x, fragment.texcoord[2], -c[3];
MAX R1.x, R1, c[4].y;
MUL R1.x, R1, c[5];
ADD R0.zw, R0, -c[4].z;
MUL R0.zw, R0, c[0].xyxz;
ADD R0.z, R0, R0.w;
MAD R0.z, R0, c[4].x, c[4].x;
POW R1.x, c[4].w, R1.x;
ADD R1.x, -R1, c[4].z;
MAX R0.y, R0, c[4];
MUL R0.y, R0, R1.x;
ADD R0.w, -R0.y, c[4].z;
MUL R0.x, R0, R0.z;
MUL R1.xyz, fragment.color.primary, R0.w;
MAD R0.w, R0.x, c[5].z, c[5].y;
MUL R0.xyz, fragment.color.secondary, R0.y;
MUL R0.xyz, R0, R0.w;
ADD result.color.xyz, R0, R1;
MOV result.depth.z, c[4];
MOV result.color.w, c[4].z;
END
# 33 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [sunDirection]
Float 1 [cloudCover]
Float 2 [cloudNebulosity]
Float 3 [cloudFadeHeight]
SetTexture 0 [noiseTexture] 2D 0
"ps_3_0
; 36 ALU, 2 TEX
dcl_2d s0
def c4, -1.00000000, 0.50000000, 2.71828198, 0.00000000
def c5, -20.00000000, 1.00000000, 20.00000000, 0.80000001
dcl_color0 v0.xyz
dcl_color1 v1.xyz
dcl_texcoord0 v2.xy
dcl_texcoord1 v3.xy
dcl_texcoord2 v4.xy
rcp r0.x, v4.y
mul r1.xy, r0.x, v3
mul r0.xy, v2, r0.x
texld r0, r0, s0
texld r1, r1, s0
add r1, r0, r1
add r0.x, r1.y, c4
abs r0.x, r0
mad r0.x, r0, c4.y, r1
add r0.x, r0, -c1
mul r1.x, -r0, c2
pow r0, c4.z, r1.x
add r0.y, v4.x, -c3.x
mov r1.y, r0.x
max r0.y, r0, c4.w
mul r2.x, r0.y, c5
pow r0, c4.z, r2.x
add r1.x, -r1.y, c5.y
max r0.y, r1.x, c4.w
add r0.zw, r1, c4.x
mul r0.zw, r0, c0.xyxz
add r0.x, -r0, c5.y
add r0.z, r0, r0.w
mul r0.x, r0.y, r0
mad r0.y, r0.z, c4, c4
mul r0.y, r1, r0
add r0.z, -r0.x, c5.y
mul r1.xyz, v0, r0.z
mad r0.w, r0.y, c5.z, c5
mul r0.xyz, v1, r0.x
mul r0.xyz, r0, r0.w
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, c5.y
mov oDepth, c5.y
"
}
SubProgram "d3d11 " {
SetTexture 0 [noiseTexture] 2D 0
ConstBuffer "$Globals" 224
Vector 48 [sunDirection] 3
Float 64 [cloudCover]
Float 68 [cloudNebulosity]
Float 72 [cloudFadeHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedddcfdmahbijlmmcmelifdohggoencpiiabaaaaaadaafaaaaadaaaaaa
cmaaaaaaoiaaaaaadmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakkaaaaaaacaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaaecaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ppppppppabaoaaaafdfgfpfegbhcghgfheaafdfgfpeegfhahegiaaklfdeieefc
omadaaaaeaaaaaaaplaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
gfaaaaacabmaaaaagiaaaaacacaaaaaaaoaaaaahpcaabaaaaaaaaaaaegbobaaa
adaaaaaafgbfbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakocaabaaaaaaaaaaafgaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialpdcaaaaakbcaabaaa
aaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaaadpakaabaaaaaaaaaaa
apaaaaaiccaabaaaaaaaaaaaogakbaaaaaaaaaaaigiacaaaaaaaaaaaadaaaaaa
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaaadpaaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaaeaaaaaadiaaaaajbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
bkiacaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaakaebaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmemdpaaaaaaajecaabaaa
aaaaaaaaakbabaaaaeaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadeaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaamkneogmbbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egbcbaaaabaaaaaadiaaaaahncaabaaaaaaaaaaapgapbaaaaaaaaaaaagbjbaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaigadbaaaaaaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaae
abmaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}