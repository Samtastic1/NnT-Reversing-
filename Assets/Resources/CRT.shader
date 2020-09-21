Shader "Custom/CRT" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Distortion ("Distortion", Float) = 0.1
 _InputGamma ("Input Gamma", Float) = 2.4
 _OutputGamma ("Output Gamma", Float) = 2.2
 _TextureSize ("Texture Size", Vector) = (512,512,0,0)
 _InputSize ("Input Size", Vector) = (512,512,0,0)
 _OutputSize ("Output Size", Vector) = (512,512,0,0)
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
# 8 ALU
PARAM c[9] = { { 0 },
		state.matrix.mvp,
		state.matrix.texture[0] };
TEMP R0;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[0].y, R0, c[6];
DP4 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
"vs_3_0
; 8 ALU
dcl_position o0
dcl_texcoord0 o1
def c8, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c8.x
mov r0.xy, v1
dp4 o1.y, r0, c5
dp4 o1.x, r0, c4
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0
eefiecedeedelkdobbmimfefjdhgabnhlefmpcmlabaaaaaaciacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceiabaaaa
eaaaabaafcaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaccaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaafgbfbaaaabaaaaaaegiacaaaabaaaaaacbaaaaaadcaaaaak
dccabaaaabaaaaaaegiacaaaabaaaaaacaaaaaaaagbabaaaabaaaaaaegaabaaa
aaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_InputSize]
Vector 1 [_OutputSize]
Vector 2 [_TextureSize]
Vector 3 [_ScrollOffset]
Float 4 [_OutputGamma]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
# 84 ALU, 2 TEX
PARAM c[9] = { program.local[0..4],
		{ 3.3333333, 2.718282, 0.5, 4 },
		{ 2, 0.2, 0.60000002, 1 },
		{ 0, -0.30000001, 0.30000001, 1.4 },
		{ 1, 0.69999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R0.xw, fragment.texcoord[0].yyzx, c[2].yyzx;
ADD R1.w, R0.x, -c[5].z;
MOV R0.xy, c[2];
MUL R1.xy, R0, c[3];
FLR R2.xy, R1;
FLR R0.z, R1.w;
ADD R2.zw, R2.xyxy, c[5].z;
RCP R3.xy, c[2].y;
ADD R0.x, R0.z, c[5].z;
MUL R0.y, R3.x, R0.x;
MOV R2.y, R3;
RCP R2.x, c[2].x;
MOV R1.y, R3;
MOV R0.x, fragment.texcoord[0];
MOV R1.x, c[7];
ADD R1.xy, R0, R1;
MAD R0.xy, R2.zwzw, R2, R0;
MAD R1.xy, R2.zwzw, R2, R1;
TEX R0.xyz, R0, texture[0], 2D;
FRC R1.w, R1;
MUL R2.w, R1, c[5].x;
ADD R1.w, -R1, c[6];
TEX R1.xyz, R1, texture[0], 2D;
POW R2.x, R0.x, c[5].w;
POW R2.z, R0.z, c[5].w;
POW R2.y, R0.y, c[5].w;
MAD R3.xyz, R2, c[6].x, c[6].x;
MUL R4.xyz, R3, c[5].z;
POW R2.x, R1.x, c[5].w;
POW R2.z, R1.z, c[5].w;
POW R2.y, R1.y, c[5].w;
MAD R5.xyz, R2, c[6].x, c[6].x;
MUL R2.xyz, R5, c[5].z;
MUL R1.w, R1, c[5].x;
RSQ R4.x, R4.x;
RSQ R4.y, R4.y;
RSQ R4.z, R4.z;
MUL R4.xyz, R2.w, R4;
POW R2.w, R4.y, R3.y;
POW R4.y, c[5].y, -R2.w;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
MUL R2.xyz, R1.w, R2;
POW R1.w, R4.x, R3.x;
POW R4.x, c[5].y, -R1.w;
POW R1.w, R4.z, R3.z;
MAD R3.xyz, R3, c[6].y, c[6].z;
POW R4.z, c[5].y, -R1.w;
POW R1.w, R2.x, R5.x;
POW R2.x, c[5].y, -R1.w;
POW R2.y, R2.y, R5.y;
RCP R1.w, c[0].x;
MUL R0.w, R0, c[1].x;
MUL R0.w, R0, R1;
POW R1.w, R2.z, R5.z;
MUL R2.w, R0, c[5].z;
POW R2.z, c[5].y, -R1.w;
ABS R1.w, R2;
FRC R1.w, R1;
MUL R1.w, R1, c[6].x;
CMP R0.w, R0, -R1, R1;
FLR R0.w, R0;
RCP R3.x, R3.x;
RCP R3.z, R3.z;
RCP R3.y, R3.y;
MUL R3.xyz, R4, R3;
MAD R4.xyz, R5, c[6].y, c[6].z;
RCP R4.x, R4.x;
RCP R4.y, R4.y;
POW R2.y, c[5].y, -R2.y;
RCP R4.z, R4.z;
MUL R2.xyz, R2, R4;
MUL R4.xy, R0.w, c[7].yzzw;
MUL R1.xyz, R2, R1;
RCP R0.w, c[4].x;
ADD R2.xy, R4, c[8];
MAD R0.xyz, R3, R0, R1;
MUL R0.xyz, R0, R2.xyxw;
MUL R0.xyz, R0, c[7].w;
POW result.color.x, R0.x, R0.w;
POW result.color.y, R0.y, R0.w;
POW result.color.z, R0.z, R0.w;
MOV result.color.w, c[6];
END
# 84 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_InputSize]
Vector 1 [_OutputSize]
Vector 2 [_TextureSize]
Vector 3 [_ScrollOffset]
Float 4 [_OutputGamma]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 145 ALU, 2 TEX
dcl_2d s0
def c5, 2.71828198, -0.50000000, 3.33333325, 0.50000000
def c6, 4.00000000, 2.00000000, 0.20000000, 0.60000002
def c7, 1.00000000, 0.00000000, 1.39999998, 0
def c8, -0.30000001, 0.30000001, 1.00000000, 0.69999999
dcl_texcoord0 v0.xy
mov r0.xy, c3
mul r1.xw, v0.yyzx, c2.yyzx
mul r0.zw, c2.xyxy, r0.xyxy
add r0.x, r1, c5.y
frc r2.w, r0.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r2.xy, r0.zwzw, c5.w
rcp r1.xy, c2.y
add r0.x, -r2.w, r0
add r0.x, r0, c5.w
mul r3.y, r1.x, r0.x
mov r0.w, r1.y
rcp r0.z, c2.x
mov r3.x, v0
mad r0.xy, r2, r0.zwzw, r3
mov r1.x, c7.y
add r3.xy, r3, r1
texld r1.xyz, r0, s0
mad r0.xy, r2, r0.zwzw, r3
texld r2.xyz, r0, s0
pow r3, r1.x, c6.x
pow r0, r2.x, c6.x
pow r4, r1.y, c6.x
mov r5.x, r3
pow r3, r1.z, c6.x
mov r6.x, r0
pow r0, r2.z, c6.x
mov r5.z, r3
mov r5.y, r4
mad r4.xyz, r5, c6.y, c6.y
mul r3.xyz, r4, c5.w
pow r5, r2.y, c6.x
mov r6.z, r0
mov r6.y, r5
mad r5.xyz, r6, c6.y, c6.y
rsq r0.x, r3.x
rsq r0.y, r3.y
rsq r0.z, r3.z
mul r0.w, r2, c5.z
mul r7.xyz, r0.w, r0
mul r0.xyz, r5, c5.w
pow r3, r7.x, r4.x
add r0.w, -r2, c7.x
rsq r0.x, r0.x
rsq r0.y, r0.y
rsq r0.z, r0.z
mul r0.w, r0, c5.z
mul r6.xyz, r0.w, r0
pow r0, r6.x, r5.x
mov r0.y, r3.x
pow r3, c5.x, -r0.y
mov r2.w, r0.x
pow r0, r7.y, r4.y
mov r7.x, r3
pow r3, r7.z, r4.z
mov r3.y, r0.x
pow r0, c5.x, -r3.y
mov r0.x, r3
pow r3, c5.x, -r0.x
mov r7.y, r0
mad r0.xyz, r4, c6.z, c6.w
mov r7.z, r3
pow r3, c5.x, -r2.w
rcp r0.x, r0.x
rcp r0.z, r0.z
rcp r0.y, r0.y
mul r4.xyz, r7, r0
pow r0, r6.y, r5.y
mov r2.w, r0.x
pow r0, r6.z, r5.z
mov r6.x, r3
pow r3, c5.x, -r2.w
mov r2.w, r0.x
pow r0, c5.x, -r2.w
mul r0.x, r1.w, c1
rcp r0.y, c0.x
mul r0.w, r0.x, r0.y
mul r0.x, r0.w, c5.w
abs r1.w, r0.x
mov r6.z, r0
mad r0.xyz, r5, c6.z, c6.w
frc r1.w, r1
mul r1.w, r1, c6.y
cmp r0.w, r0, r1, -r1
frc r1.w, r0
add r0.w, r0, -r1
rcp r1.w, c4.x
mov r6.y, r3
rcp r0.x, r0.x
rcp r0.y, r0.y
rcp r0.z, r0.z
mul r0.xyz, r6, r0
mul r0.xyz, r0, r2
mad r2.xy, r0.w, c8, c8.zwzw
mad r0.xyz, r4, r1, r0
mul r0.xyz, r0, r2.xyxw
mul r1.xyz, r0, c7.z
pow r0, r1.x, r1.w
mov oC0.x, r0
pow r0, r1.y, r1.w
pow r2, r1.z, r1.w
mov oC0.y, r0
mov oC0.z, r2
mov oC0.w, c7.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 16 [_InputSize] 2
Vector 24 [_OutputSize] 2
Vector 32 [_TextureSize] 2
Vector 56 [_ScrollOffset] 2
Float 76 [_OutputGamma]
BindCB  "$Globals" 0
"ps_4_0
eefiecednoibpodjlkdgogoajclgpkofahbcihdmabaaaaaacmajaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmaiaaaa
eaaaaaaablacaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaajdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaadaaaaaaebaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaaoaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaacaaaaaaaoaaaaalccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkiacaaaaaaaaaaaacaaaaaa
dgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaa
bkbabaaaabaaaaaabkiacaaaaaaaaaaaacaaaaaaabeaaaaaaaaaaalpebaaaaaf
icaabaaaaaaaaaaackaabaaaaaaaaaaabkaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
aoaaaaaiccaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaa
dgaaaaafbcaabaaaacaaaaaaakbabaaaabaaaaaaaaaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaaegaabaaaacaaaaaaaaaaaaahmcaabaaaabaaaaaaagaebaaa
aaaaaaaaagaebaaaacaaaaaaaaaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahlcaabaaaaaaaaaaaegaibaaa
acaaaaaaegaibaaaacaaaaaadiaaaaahlcaabaaaaaaaaaaaegambaaaaaaaaaaa
egambaaaaaaaaaaadcaaaaaplcaabaaaaaaaaaaaegambaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaeaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaeadiaaaaakhcaabaaaadaaaaaaegadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaeeaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaa
aaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaffffffeadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaffffffeadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaacpaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegadbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaaplcaabaaaaaaaaaaaegambaaaaaaaaaaaaceaaaaamnmmemdo
mnmmemdoaaaaaaaamnmmemdoaceaaaaajkjjbjdpjkjjbjdpaaaaaaaajkjjbjdp
bjaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaakhcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaadlkklilpdlkklilpdlkklilpaaaaaaaabjaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaa
adaaaaaaaceaaaaaddddlddpddddlddpddddlddpaaaaaaaaaoaaaaahlcaabaaa
aaaaaaaaegaibaaaadaaaaaaegambaaaaaaaaaaadiaaaaahlcaabaaaaaaaaaaa
egambaaaaaaaaaaaegaibaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaaphcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaeeaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaacpaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaaphcaabaaaacaaaaaaegacbaaaacaaaaaa
aceaaaaamnmmemdomnmmemdomnmmemdoaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
jkjjbjdpaaaaaaaabjaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaak
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaadlkklilpdlkklilpdlkklilp
aaaaaaaabjaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaakhcaabaaa
adaaaaaaegacbaaaadaaaaaaaceaaaaaddddlddpddddlddpddddlddpaaaaaaaa
aoaaaaahhcaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegadbaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaabaaaaaa
aoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpbnaaaaai
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaaaaag
icaabaaaaaaaaaaadkaabaiaibaaaaaaaaaaaaaadhaaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaebaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaaphcaabaaaabaaaaaapgapbaaaaaaaaaaa
aceaaaaajkjjjjlojkjjjjdojkjjjjloaaaaaaaaaceaaaaaaaaaiadpdddddddp
aaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaoaaaaalicaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkiacaaaaaaaaaaa
aeaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
bjaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
}