Shader "JAW/FX/Distortion/Shockwaves" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "black" {}
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
Float 5 [aspect]
Vector 6 [position1]
Vector 7 [position2]
Vector 8 [position3]
Vector 9 [position4]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[6].xyxy;
ADD R0.xy, vertex.texcoord[0], -c[7];
MUL result.texcoord[2].x, R0.z, c[5];
MOV result.texcoord[2].y, R0.w;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[8].xyxy;
MUL result.texcoord[3].x, R0, c[5];
MOV result.texcoord[3].y, R0;
ADD R0.xy, vertex.texcoord[0], -c[9];
MOV result.texcoord[1].xy, vertex.texcoord[0];
MUL result.texcoord[4].x, R0.z, c[5];
MOV result.texcoord[4].y, R0.w;
MUL result.texcoord[5].x, R0, c[5];
MOV result.texcoord[5].y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [aspect]
Vector 5 [position1]
Vector 6 [position2]
Vector 7 [position3]
Vector 8 [position4]
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_position0 v0
dcl_texcoord0 v1
add r0.zw, v1.xyxy, -c5.xyxy
add r0.xy, v1, -c6
mul o2.x, r0.z, c4
mov o2.y, r0.w
add r0.zw, v1.xyxy, -c7.xyxy
mul o3.x, r0, c4
mov o3.y, r0
add r0.xy, v1, -c8
mov o1.xy, v1
mul o4.x, r0.z, c4
mov o4.y, r0.w
mul o5.x, r0, c4
mov o5.y, r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Float 48 [aspect]
Vector 64 [position1] 2
Vector 96 [position2] 2
Vector 128 [position3] 2
Vector 160 [position4] 2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpglnjnagecddgjhkdoainlppehppikefabaaaaaaoeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeacaaaa
eaaaabaakjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaa
aeaaaaaadiaaaaaieccabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaai
bccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaf
cccabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaadiaaaaaieccabaaaacaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
bkaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 1 TEX
PARAM c[7] = { program.local[0..5],
		{ 0, 2.718282 } };
TEMP R0;
MUL R0.xy, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.x, R0, R0.y;
RSQ R0.x, R0.x;
RCP R0.y, R0.x;
MUL R0.y, -R0, c[4].x;
ADD R0.y, R0, c[1].x;
MAX R0.y, R0, c[6].x;
MUL R0.z, R0.y, c[3].x;
MUL R0.w, -R0.y, c[5].x;
SIN R0.y, R0.z;
MUL R0.y, R0, c[2].x;
POW R0.z, c[6].y, R0.w;
MUL R0.z, R0.y, R0;
MUL R0.xy, R0.x, fragment.texcoord[2];
MUL R0.xy, R0, R0.z;
MUL R0.x, R0, c[0];
ADD R0.xy, fragment.texcoord[1], R0;
TEX result.color, R0, texture[0], 2D;
END
# 18 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 31 ALU, 1 TEX
dcl_2d s0
def c6, 0.00000000, 0.15915491, 0.50000000, 2.71828198
def c7, 6.28318501, -3.14159298, 0, 0
dcl_texcoord1 v0.xy
dcl_texcoord2 v1.xy
mul r0.xy, v1, v1
add r0.x, r0, r0.y
rsq r2.x, r0.x
rcp r0.x, r2.x
mul r0.x, -r0, c4
add r0.x, r0, c1
max r0.x, r0, c6
mul r0.y, r0.x, c3.x
mad r0.y, r0, c6, c6.z
frc r0.y, r0
mul r1.x, -r0, c5
mad r2.y, r0, c7.x, c7
pow r0, c6.w, r1.x
sincos r1.xy, r2.y
mov r0.y, r0.x
mul r0.x, r1.y, c2
mul r0.zw, r2.x, v1.xyxy
mul r0.x, r0, r0.y
mul r0.xy, r0.zwzw, r0.x
mul r0.x, r0, c0
add r0.xy, v0, r0
texld r0, r0, s0
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Float 52 [inverseAspect]
Float 56 [time1]
Float 72 [amplitude1]
Float 76 [frequency1]
Float 80 [inverseSpeed1]
Float 84 [decay1]
BindCB  "$Globals" 0
"ps_4_0
eefiecedajefeapgnomljifpmelnbjkmohidbndpabaaaaaaheadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeacaaaa
eaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
apaaaaahbcaabaaaaaaaaaaaogbkbaaaabaaaaaaogbkbaaaabaaaaaaelaaaaaf
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahfcaabaaaaaaaaaaaagaabaaaaaaaaaaakgblbaaaabaaaaaa
dcaaaaamccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaackiacaaaaaaaaaaaadaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaeaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
enaaaaagicaabaaaaaaaaaaaaanaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahgcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaaigaabaaa
aaaaaaaaegbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Float 5 [aspect]
Vector 6 [position1]
Vector 7 [position2]
Vector 8 [position3]
Vector 9 [position4]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[6].xyxy;
ADD R0.xy, vertex.texcoord[0], -c[7];
MUL result.texcoord[2].x, R0.z, c[5];
MOV result.texcoord[2].y, R0.w;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[8].xyxy;
MUL result.texcoord[3].x, R0, c[5];
MOV result.texcoord[3].y, R0;
ADD R0.xy, vertex.texcoord[0], -c[9];
MOV result.texcoord[1].xy, vertex.texcoord[0];
MUL result.texcoord[4].x, R0.z, c[5];
MOV result.texcoord[4].y, R0.w;
MUL result.texcoord[5].x, R0, c[5];
MOV result.texcoord[5].y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [aspect]
Vector 5 [position1]
Vector 6 [position2]
Vector 7 [position3]
Vector 8 [position4]
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_position0 v0
dcl_texcoord0 v1
add r0.zw, v1.xyxy, -c5.xyxy
add r0.xy, v1, -c6
mul o2.x, r0.z, c4
mov o2.y, r0.w
add r0.zw, v1.xyxy, -c7.xyxy
mul o3.x, r0, c4
mov o3.y, r0
add r0.xy, v1, -c8
mov o1.xy, v1
mul o4.x, r0.z, c4
mov o4.y, r0.w
mul o5.x, r0, c4
mov o5.y, r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Float 48 [aspect]
Vector 64 [position1] 2
Vector 96 [position2] 2
Vector 128 [position3] 2
Vector 160 [position4] 2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpglnjnagecddgjhkdoainlppehppikefabaaaaaaoeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeacaaaa
eaaaabaakjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaa
aeaaaaaadiaaaaaieccabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaai
bccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaf
cccabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaadiaaaaaieccabaaaacaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
bkaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
Float 6 [time2]
Float 7 [amplitude2]
Float 8 [frequency2]
Float 9 [inverseSpeed2]
Float 10 [decay2]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 1 TEX
PARAM c[12] = { program.local[0..10],
		{ 0, 2.718282 } };
TEMP R0;
TEMP R1;
MUL R0.xy, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.x, R0, R0.y;
MUL R0.zw, fragment.texcoord[3].xyxy, fragment.texcoord[3].xyxy;
ADD R0.y, R0.z, R0.w;
RSQ R1.z, R0.x;
RSQ R1.w, R0.y;
MOV R0.z, c[4].x;
MOV R0.w, c[9].x;
MOV R1.y, c[6].x;
MOV R1.x, c[1];
RCP R0.x, R1.z;
RCP R0.y, R1.w;
MAD R0.xy, -R0, R0.zwzw, R1;
MAX R1.xy, R0, c[11].x;
MOV R0.w, c[10].x;
MOV R0.z, c[5].x;
MOV R0.y, c[8].x;
MOV R0.x, c[3];
MUL R0.xy, R1, R0;
MUL R1.xy, -R1, R0.zwzw;
SIN R0.z, R0.x;
SIN R0.w, R0.y;
MOV R0.y, c[7].x;
MOV R0.x, c[2];
MUL R0.xy, R0.zwzw, R0;
POW R0.z, c[11].y, R1.x;
POW R0.w, c[11].y, R1.y;
MUL R0.xy, R0, R0.zwzw;
MUL R1.xy, R1.w, fragment.texcoord[3];
MUL R0.zw, R0.y, R1.xyxy;
MUL R1.xy, R1.z, fragment.texcoord[2];
MAD R0.xy, R1, R0.x, R0.zwzw;
MUL R0.x, R0, c[0];
ADD R0.xy, fragment.texcoord[1], R0;
TEX result.color, R0, texture[0], 2D;
END
# 35 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
Float 6 [time2]
Float 7 [amplitude2]
Float 8 [frequency2]
Float 9 [inverseSpeed2]
Float 10 [decay2]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 61 ALU, 1 TEX
dcl_2d s0
def c11, 0.00000000, 0.15915491, 0.50000000, 2.71828198
def c12, 6.28318501, -3.14159298, 0, 0
dcl_texcoord1 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2.xy
mul r0.xy, v1, v1
add r0.x, r0, r0.y
rsq r3.x, r0.x
mul r0.zw, v2.xyxy, v2.xyxy
add r0.y, r0.z, r0.w
rsq r3.y, r0.y
rcp r1.x, r3.x
rcp r1.y, r3.y
mov r0.z, c4.x
mov r0.w, c9.x
mov r0.y, c6.x
mov r0.x, c1
mad r0.xy, -r1, r0.zwzw, r0
max r0.xy, r0, c11.x
mov r1.y, c10.x
mov r1.x, c5
mul r2.zw, -r0.xyxy, r1.xyxy
mov r0.w, c8.x
mov r0.z, c3.x
mul r0.zw, r0.xyxy, r0
mad r0.z, r0, c11.y, c11
frc r0.x, r0.z
mad r0.y, r0.w, c11, c11.z
mad r0.x, r0, c12, c12.y
sincos r1.xy, r0.x
frc r0.y, r0
mad r1.x, r0.y, c12, c12.y
sincos r0.xy, r1.x
mov r0.x, r1.y
pow r1, c11.w, r2.z
mov r0.w, c7.x
mov r0.z, c2.x
mul r2.xy, r0, r0.zwzw
pow r0, c11.w, r2.w
mov r0.x, r1
mul r1.xy, r2, r0
mul r0.zw, r3.y, v2.xyxy
mul r0.zw, r1.y, r0
mul r0.xy, r3.x, v1
mad r0.xy, r0, r1.x, r0.zwzw
mul r0.x, r0, c0
add r0.xy, v0, r0
texld r0, r0, s0
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Float 52 [inverseAspect]
Float 56 [time1]
Float 72 [amplitude1]
Float 76 [frequency1]
Float 80 [inverseSpeed1]
Float 84 [decay1]
Float 88 [time2]
Float 104 [amplitude2]
Float 108 [frequency2]
Float 112 [inverseSpeed2]
Float 116 [decay2]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoflolcaghajdibdcemadigkdlpieiglpabaaaaaalaaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaa
eaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaapaaaaahbcaabaaaaaaaaaaaogbkbaaaabaaaaaa
ogbkbaaaabaaaaaaelaaaaafccaabaaaaaaaaaaaakaabaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahfcaabaaaaaaaaaaaagaabaaa
aaaaaaaakgblbaaaabaaaaaadcaaaaambcaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaadaaaaaaapaaaaah
ccaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaaacaaaaaaelaaaaaficaabaaa
aaaaaaaabkaabaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahmcaabaaaabaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaam
ccaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
ckiacaaaaaaaaaaaafaaaaaadeaaaaakkcaabaaaaaaaaaaaagaebaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaajbcaabaaaabaaaaaa
bkaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaajccaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaadlkklidpdlkklidpaaaaaaaa
aaaaaaaabjaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaa
acaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaenaaaaagkcaabaaa
aaaaaaaaaanaaaaaagaebaaaacaaaaaadiaaaaaibcaabaaaacaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaaacaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaagaaaaaadiaaaaahkcaabaaaaaaaaaaaagaebaaa
abaaaaaaagaebaaaacaaaaaadiaaaaahdcaabaaaabaaaaaapgapbaaaaaaaaaaa
ogakbaaaabaaaaaadcaaaaajgcaabaaaaaaaaaaaagacbaaaaaaaaaaafgafbaaa
aaaaaaaaagabbaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaaigaabaaaaaaaaaaa
egbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Float 5 [aspect]
Vector 6 [position1]
Vector 7 [position2]
Vector 8 [position3]
Vector 9 [position4]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[6].xyxy;
ADD R0.xy, vertex.texcoord[0], -c[7];
MUL result.texcoord[2].x, R0.z, c[5];
MOV result.texcoord[2].y, R0.w;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[8].xyxy;
MUL result.texcoord[3].x, R0, c[5];
MOV result.texcoord[3].y, R0;
ADD R0.xy, vertex.texcoord[0], -c[9];
MOV result.texcoord[1].xy, vertex.texcoord[0];
MUL result.texcoord[4].x, R0.z, c[5];
MOV result.texcoord[4].y, R0.w;
MUL result.texcoord[5].x, R0, c[5];
MOV result.texcoord[5].y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [aspect]
Vector 5 [position1]
Vector 6 [position2]
Vector 7 [position3]
Vector 8 [position4]
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_position0 v0
dcl_texcoord0 v1
add r0.zw, v1.xyxy, -c5.xyxy
add r0.xy, v1, -c6
mul o2.x, r0.z, c4
mov o2.y, r0.w
add r0.zw, v1.xyxy, -c7.xyxy
mul o3.x, r0, c4
mov o3.y, r0
add r0.xy, v1, -c8
mov o1.xy, v1
mul o4.x, r0.z, c4
mov o4.y, r0.w
mul o5.x, r0, c4
mov o5.y, r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Float 48 [aspect]
Vector 64 [position1] 2
Vector 96 [position2] 2
Vector 128 [position3] 2
Vector 160 [position4] 2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpglnjnagecddgjhkdoainlppehppikefabaaaaaaoeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeacaaaa
eaaaabaakjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaa
aeaaaaaadiaaaaaieccabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaai
bccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaf
cccabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaadiaaaaaieccabaaaacaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
bkaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
Float 6 [time2]
Float 7 [amplitude2]
Float 8 [frequency2]
Float 9 [inverseSpeed2]
Float 10 [decay2]
Float 11 [time3]
Float 12 [amplitude3]
Float 13 [frequency3]
Float 14 [inverseSpeed3]
Float 15 [decay3]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 50 ALU, 1 TEX
PARAM c[17] = { program.local[0..15],
		{ 0, 2.718282 } };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R0.zw, fragment.texcoord[2].xyxy, fragment.texcoord[2].xyxy;
ADD R0.z, R0, R0.w;
RSQ R1.w, R0.z;
MUL R0.xy, fragment.texcoord[3], fragment.texcoord[3];
ADD R0.x, R0, R0.y;
RSQ R1.z, R0.x;
RCP R1.x, R1.w;
RCP R1.y, R1.z;
MOV R0.z, c[4].x;
MOV R0.w, c[9].x;
MOV R0.y, c[6].x;
MOV R0.x, c[1];
MAD R0.xy, -R1, R0.zwzw, R0;
MUL R1.xy, fragment.texcoord[4], fragment.texcoord[4];
ADD R1.x, R1, R1.y;
RSQ R2.x, R1.x;
MAX R0.xy, R0, c[16].x;
MOV R0.w, c[8].x;
MOV R0.z, c[3].x;
MUL R0.zw, R0.xyxy, R0;
SIN R0.z, R0.z;
SIN R0.w, R0.w;
MOV R1.y, c[7].x;
MOV R1.x, c[2];
MUL R1.xy, R0.zwzw, R1;
MOV R0.w, c[10].x;
MOV R0.z, c[5].x;
MUL R0.xy, -R0, R0.zwzw;
RCP R2.y, R2.x;
MUL R0.z, -R2.y, c[14].x;
ADD R0.z, R0, c[11].x;
MAX R0.z, R0, c[16].x;
MUL R0.w, R0.z, c[13].x;
POW R0.x, c[16].y, R0.x;
POW R0.y, c[16].y, R0.y;
MUL R0.xy, R1, R0;
MUL R1.x, -R0.z, c[15];
SIN R0.z, R0.w;
POW R0.w, c[16].y, R1.x;
MUL R0.z, R0, c[12].x;
MUL R1.x, R0.z, R0.w;
MUL R0.zw, R2.x, fragment.texcoord[4].xyxy;
MUL R0.zw, R0, R1.x;
MUL R1.xy, R1.w, fragment.texcoord[2];
MAD R1.xy, R0.x, R1, R0.zwzw;
MUL R0.zw, R1.z, fragment.texcoord[3].xyxy;
MAD R0.xy, R0.zwzw, R0.y, R1;
MUL R0.x, R0, c[0];
ADD R0.xy, fragment.texcoord[1], R0;
TEX result.color, R0, texture[0], 2D;
END
# 50 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
Float 6 [time2]
Float 7 [amplitude2]
Float 8 [frequency2]
Float 9 [inverseSpeed2]
Float 10 [decay2]
Float 11 [time3]
Float 12 [amplitude3]
Float 13 [frequency3]
Float 14 [inverseSpeed3]
Float 15 [decay3]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 90 ALU, 1 TEX
dcl_2d s0
def c16, 0.00000000, 0.15915491, 0.50000000, 2.71828198
def c17, 6.28318501, -3.14159298, 0, 0
dcl_texcoord1 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2.xy
dcl_texcoord4 v3.xy
mul r0.zw, v1.xyxy, v1.xyxy
add r0.z, r0, r0.w
rsq r2.w, r0.z
mul r0.xy, v2, v2
add r0.x, r0, r0.y
rsq r2.z, r0.x
rcp r1.x, r2.w
rcp r1.y, r2.z
mov r0.z, c4.x
mov r0.w, c9.x
mov r0.y, c6.x
mov r0.x, c1
mad r0.xy, -r1, r0.zwzw, r0
max r2.xy, r0, c16.x
mov r0.y, c8.x
mov r0.x, c3
mul r0.xy, r2, r0
mad r0.x, r0, c16.y, c16.z
frc r0.x, r0
mad r0.x, r0, c17, c17.y
mad r0.y, r0, c16, c16.z
sincos r1.xy, r0.x
frc r0.y, r0
mad r1.x, r0.y, c17, c17.y
sincos r0.xy, r1.x
mov r0.x, r1.y
mul r0.zw, v3.xyxy, v3.xyxy
add r0.z, r0, r0.w
mov r1.y, c7.x
mov r1.x, c2
mul r1.xy, r0, r1
mov r0.y, c10.x
mov r0.x, c5
mul r1.zw, -r2.xyxy, r0.xyxy
rsq r2.x, r0.z
pow r0, c16.w, r1.z
rcp r0.y, r2.x
mul r0.y, -r0, c14.x
mov r1.z, r0.x
add r2.y, r0, c11.x
pow r0, c16.w, r1.w
max r0.x, r2.y, c16
mov r1.w, r0.y
mul r3.xy, r1, r1.zwzw
mul r0.z, r0.x, c13.x
mad r0.y, r0.z, c16, c16.z
frc r0.y, r0
mul r1.x, -r0, c15
mad r2.y, r0, c17.x, c17
pow r0, c16.w, r1.x
sincos r1.xy, r2.y
mov r0.y, r0.x
mul r0.x, r1.y, c12
mul r0.z, r0.x, r0.y
mul r0.xy, r2.x, v3
mul r0.zw, r0.xyxy, r0.z
mul r0.xy, r2.w, v1
mad r0.zw, r3.x, r0.xyxy, r0
mul r0.xy, r2.z, v2
mad r0.xy, r0, r3.y, r0.zwzw
mul r0.x, r0, c0
add r0.xy, v0, r0
texld r0, r0, s0
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Float 52 [inverseAspect]
Float 56 [time1]
Float 72 [amplitude1]
Float 76 [frequency1]
Float 80 [inverseSpeed1]
Float 84 [decay1]
Float 88 [time2]
Float 104 [amplitude2]
Float 108 [frequency2]
Float 112 [inverseSpeed2]
Float 116 [decay2]
Float 120 [time3]
Float 136 [amplitude3]
Float 140 [frequency3]
Float 144 [inverseSpeed3]
Float 148 [decay3]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpmpadlfhpelepndgbejdipecfhcofmnfabaaaaaafeagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeafaaaa
eaaaaaaaenabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaapaaaaahbcaabaaa
aaaaaaaaogbkbaaaacaaaaaaogbkbaaaacaaaaaaelaaaaafccaabaaaaaaaaaaa
akaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
fcaabaaaaaaaaaaaagaabaaaaaaaaaaakgblbaaaacaaaaaadcaaaaamccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaahaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaa
aiaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaenaaaaagicaabaaa
aaaaaaaaaanaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaafgafbaaaaaaaaaaa
igaabaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaaogbkbaaaabaaaaaaogbkbaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaackaabaaaaaaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahdcaabaaaabaaaaaakgakbaaaaaaaaaaa
ogbkbaaaabaaaaaadcaaaaambcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaadaaaaaaapaaaaahecaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaa
ckaabaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
mcaabaaaabaaaaaakgakbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaamccaabaaa
acaaaaaadkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaackiacaaa
aaaaaaaaafaaaaaadeaaaaakmcaabaaaaaaaaaaaagaebaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaajbcaabaaaacaaaaaackaabaia
ebaaaaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaajccaabaaaacaaaaaa
dkaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaakdcaabaaa
acaaaaaaegaabaaaacaaaaaaaceaaaaadlkklidpdlkklidpaaaaaaaaaaaaaaaa
bjaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaaibcaabaaaadaaaaaa
ckaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaaadaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaenaaaaagmcaabaaaaaaaaaaa
aanaaaaaagaebaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaaadaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaagaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaacaaaaaa
agaebaaaadaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaabaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaajgcaabaaaaaaaaaaakgalbaaaabaaaaaa
pgapbaaaaaaaaaaaagabbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaaigaabaaa
aaaaaaaaegbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Float 5 [aspect]
Vector 6 [position1]
Vector 7 [position2]
Vector 8 [position3]
Vector 9 [position4]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[6].xyxy;
ADD R0.xy, vertex.texcoord[0], -c[7];
MUL result.texcoord[2].x, R0.z, c[5];
MOV result.texcoord[2].y, R0.w;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[8].xyxy;
MUL result.texcoord[3].x, R0, c[5];
MOV result.texcoord[3].y, R0;
ADD R0.xy, vertex.texcoord[0], -c[9];
MOV result.texcoord[1].xy, vertex.texcoord[0];
MUL result.texcoord[4].x, R0.z, c[5];
MOV result.texcoord[4].y, R0.w;
MUL result.texcoord[5].x, R0, c[5];
MOV result.texcoord[5].y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [aspect]
Vector 5 [position1]
Vector 6 [position2]
Vector 7 [position3]
Vector 8 [position4]
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_position0 v0
dcl_texcoord0 v1
add r0.zw, v1.xyxy, -c5.xyxy
add r0.xy, v1, -c6
mul o2.x, r0.z, c4
mov o2.y, r0.w
add r0.zw, v1.xyxy, -c7.xyxy
mul o3.x, r0, c4
mov o3.y, r0
add r0.xy, v1, -c8
mov o1.xy, v1
mul o4.x, r0.z, c4
mov o4.y, r0.w
mul o5.x, r0, c4
mov o5.y, r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Float 48 [aspect]
Vector 64 [position1] 2
Vector 96 [position2] 2
Vector 128 [position3] 2
Vector 160 [position4] 2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpglnjnagecddgjhkdoainlppehppikefabaaaaaaoeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeacaaaa
eaaaabaakjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaa
aeaaaaaadiaaaaaieccabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaai
bccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaf
cccabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaadiaaaaaieccabaaaacaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
bkaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
Float 6 [time2]
Float 7 [amplitude2]
Float 8 [frequency2]
Float 9 [inverseSpeed2]
Float 10 [decay2]
Float 11 [time3]
Float 12 [amplitude3]
Float 13 [frequency3]
Float 14 [inverseSpeed3]
Float 15 [decay3]
Float 16 [time4]
Float 17 [amplitude4]
Float 18 [frequency4]
Float 19 [inverseSpeed4]
Float 20 [decay4]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 69 ALU, 1 TEX
PARAM c[22] = { program.local[0..20],
		{ 0, 2.718282 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.x, R0, R0.y;
MUL R0.zw, fragment.texcoord[3].xyxy, fragment.texcoord[3].xyxy;
ADD R0.y, R0.z, R0.w;
RSQ R0.w, R0.x;
RSQ R0.z, R0.y;
RCP R1.x, R0.w;
RCP R1.y, R0.z;
MOV R1.w, c[6].x;
MOV R1.z, c[1].x;
MOV R0.x, c[4];
MOV R0.y, c[9].x;
MAD R0.xy, -R1, R0, R1.zwzw;
MAX R1.xy, R0, c[21].x;
MOV R1.w, c[10].x;
MOV R1.z, c[5].x;
MOV R0.y, c[8].x;
MOV R0.x, c[3];
MUL R0.xy, R1, R0;
MUL R1.xy, -R1, R1.zwzw;
SIN R1.z, R0.x;
SIN R1.w, R0.y;
MOV R0.y, c[7].x;
MOV R0.x, c[2];
MUL R1.zw, R1, R0.xyxy;
POW R0.y, c[21].y, R1.y;
POW R0.x, c[21].y, R1.x;
MUL R2.zw, R1, R0.xyxy;
MUL R0.xy, R0.w, fragment.texcoord[2];
MUL R2.xy, R0, R2.z;
MUL R1.zw, R0.z, fragment.texcoord[3].xyxy;
MUL R0.zw, fragment.texcoord[4].xyxy, fragment.texcoord[4].xyxy;
ADD R0.z, R0, R0.w;
RSQ R3.x, R0.z;
MUL R0.xy, fragment.texcoord[5], fragment.texcoord[5];
ADD R0.x, R0, R0.y;
RSQ R3.y, R0.x;
RCP R1.x, R3.x;
RCP R1.y, R3.y;
MOV R0.z, c[14].x;
MOV R0.w, c[19].x;
MOV R0.y, c[16].x;
MOV R0.x, c[11];
MAD R0.xy, -R1, R0.zwzw, R0;
MAX R1.xy, R0, c[21].x;
MOV R0.w, c[20].x;
MOV R0.z, c[15].x;
MUL R2.zw, R2.w, R1;
MOV R0.y, c[18].x;
MOV R0.x, c[13];
MUL R0.xy, R1, R0;
MUL R1.xy, -R1, R0.zwzw;
SIN R0.z, R0.x;
SIN R0.w, R0.y;
MOV R0.y, c[17].x;
MOV R0.x, c[12];
MUL R0.xy, R0.zwzw, R0;
POW R0.w, c[21].y, R1.y;
POW R0.z, c[21].y, R1.x;
MUL R0.xy, R0, R0.zwzw;
MUL R0.zw, R3.y, fragment.texcoord[5].xyxy;
MUL R0.zw, R0.y, R0;
MUL R1.xy, R3.x, fragment.texcoord[4];
MUL R0.xy, R1, R0.x;
ADD R0, R2, R0;
ADD R0.xy, R0, R0.zwzw;
MUL R0.x, R0, c[0];
ADD R0.xy, fragment.texcoord[1], R0;
TEX result.color, R0, texture[0], 2D;
END
# 69 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
Float 6 [time2]
Float 7 [amplitude2]
Float 8 [frequency2]
Float 9 [inverseSpeed2]
Float 10 [decay2]
Float 11 [time3]
Float 12 [amplitude3]
Float 13 [frequency3]
Float 14 [inverseSpeed3]
Float 15 [decay3]
Float 16 [time4]
Float 17 [amplitude4]
Float 18 [frequency4]
Float 19 [inverseSpeed4]
Float 20 [decay4]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 121 ALU, 1 TEX
dcl_2d s0
def c21, 0.00000000, 0.15915491, 0.50000000, 2.71828198
def c22, 6.28318501, -3.14159298, 0, 0
dcl_texcoord1 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2.xy
dcl_texcoord4 v3.xy
dcl_texcoord5 v4.xy
mul r0.xy, v1, v1
add r0.x, r0, r0.y
rsq r3.y, r0.x
mul r0.zw, v2.xyxy, v2.xyxy
add r0.y, r0.z, r0.w
rsq r3.x, r0.y
rcp r1.x, r3.y
rcp r1.y, r3.x
mov r0.z, c4.x
mov r0.w, c9.x
mov r0.y, c6.x
mov r0.x, c1
mad r0.xy, -r1, r0.zwzw, r0
max r0.xy, r0, c21.x
mov r0.w, c8.x
mov r0.z, c3.x
mul r1.xy, r0, r0.zwzw
mad r1.x, r1, c21.y, c21.z
mov r0.w, c10.x
mov r0.z, c5.x
mul r2.zw, -r0.xyxy, r0
frc r0.x, r1
mad r0.y, r1, c21, c21.z
mad r0.x, r0, c22, c22.y
sincos r1.xy, r0.x
frc r0.y, r0
mad r1.x, r0.y, c22, c22.y
sincos r0.xy, r1.x
mov r0.x, r1.y
pow r1, c21.w, r2.z
mov r0.w, c7.x
mov r0.z, c2.x
mul r2.xy, r0, r0.zwzw
pow r0, c21.w, r2.w
mov r0.x, r1
mul r0.zw, r2.xyxy, r0.xyxy
mul r0.xy, v3, v3
add r0.x, r0, r0.y
rsq r4.x, r0.x
mul r1.xy, v4, v4
add r0.y, r1.x, r1
rsq r4.y, r0.y
rcp r1.z, r4.x
rcp r1.w, r4.y
mov r1.x, c14
mov r1.y, c19.x
mov r0.y, c16.x
mov r0.x, c11
mad r0.xy, -r1.zwzw, r1, r0
mul r1.xy, r3.y, v1
mul r1.xy, r1, r0.z
mul r1.zw, r3.x, v2.xyxy
mul r1.zw, r0.w, r1
max r0.xy, r0, c21.x
mov r0.w, c20.x
mov r0.z, c15.x
mul r3.xy, -r0, r0.zwzw
mov r2.y, c18.x
mov r2.x, c13
mul r2.xy, r0, r2
mad r2.x, r2, c21.y, c21.z
frc r0.x, r2
mad r0.y, r2, c21, c21.z
mad r0.x, r0, c22, c22.y
sincos r2.xy, r0.x
frc r0.y, r0
mad r2.x, r0.y, c22, c22.y
sincos r0.xy, r2.x
mov r0.x, r2.y
pow r2, c21.w, r3.x
mov r0.w, c17.x
mov r0.z, c12.x
mul r3.zw, r0.xyxy, r0
pow r0, c21.w, r3.y
mov r0.x, r2
mul r0.xy, r3.zwzw, r0
mul r0.zw, r4.y, v4.xyxy
mul r0.zw, r0.y, r0
mul r2.xy, r4.x, v3
mul r0.xy, r2, r0.x
add r0, r1, r0
add r0.xy, r0, r0.zwzw
mul r0.x, r0, c0
add r0.xy, v0, r0
texld r0, r0, s0
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Float 52 [inverseAspect]
Float 56 [time1]
Float 72 [amplitude1]
Float 76 [frequency1]
Float 80 [inverseSpeed1]
Float 84 [decay1]
Float 88 [time2]
Float 104 [amplitude2]
Float 108 [frequency2]
Float 112 [inverseSpeed2]
Float 116 [decay2]
Float 120 [time3]
Float 136 [amplitude3]
Float 140 [frequency3]
Float 144 [inverseSpeed3]
Float 148 [decay3]
Float 152 [time4]
Float 168 [amplitude4]
Float 172 [frequency4]
Float 176 [inverseSpeed4]
Float 180 [decay4]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhgfgckpighbnaghlhmkmllbpojnaaodfabaaaaaalaahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaagaaaa
eaaaaaaakeabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaapaaaaahbcaabaaaaaaaaaaaogbkbaaaabaaaaaaogbkbaaaabaaaaaa
elaaaaafccaabaaaaaaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahfcaabaaaaaaaaaaaagaabaaaaaaaaaaakgblbaaa
abaaaaaadcaaaaambcaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaackiacaaaaaaaaaaaadaaaaaaapaaaaahccaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaabkaabaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
abaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaamccaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaa
afaaaaaadeaaaaakkcaabaaaaaaaaaaaagaebaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaajbcaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaajccaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaadlkklidpdlkklidpaaaaaaaaaaaaaaaabjaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadiaaaaaibcaabaaaacaaaaaabkaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaaacaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaagaaaaaaenaaaaagkcaabaaaaaaaaaaaaanaaaaa
agaebaaaacaaaaaadiaaaaaibcaabaaaacaaaaaabkaabaaaaaaaaaaackiacaaa
aaaaaaaaaeaaaaaadiaaaaaiccaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaadiaaaaahkcaabaaaaaaaaaaaagaebaaaabaaaaaaagaebaaa
acaaaaaadiaaaaahdcaabaaaacaaaaaafgafbaaaaaaaaaaaigaabaaaaaaaaaaa
diaaaaahmcaabaaaacaaaaaapgapbaaaaaaaaaaakgaobaaaabaaaaaaapaaaaah
bcaabaaaaaaaaaaaogbkbaaaacaaaaaaogbkbaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahfcaabaaaaaaaaaaaagaabaaaaaaaaaaakgblbaaaacaaaaaadcaaaaam
bcaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaahaaaaaaapaaaaahccaabaaaaaaaaaaaegbabaaaadaaaaaa
egbabaaaadaaaaaaelaaaaaficaabaaaaaaaaaaabkaabaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaabaaaaaafgafbaaa
aaaaaaaaagbebaaaadaaaaaadcaaaaamccaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaackiacaaaaaaaaaaaajaaaaaadeaaaaak
kcaabaaaaaaaaaaaagaebaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaajbcaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaadiaaaaajccaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
bkiacaaaaaaaaaaaalaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaadlkklidpdlkklidpaaaaaaaaaaaaaaaabjaaaaafdcaabaaaabaaaaaa
egaabaaaabaaaaaadiaaaaaibcaabaaaadaaaaaabkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaiaaaaaadiaaaaaiccaabaaaadaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaakaaaaaaenaaaaagkcaabaaaaaaaaaaaaanaaaaaagaebaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaa
diaaaaaiccaabaaaadaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaa
diaaaaahkcaabaaaaaaaaaaaagaebaaaabaaaaaaagaebaaaadaaaaaadiaaaaah
dcaabaaaadaaaaaafgafbaaaaaaaaaaaigaabaaaaaaaaaaadiaaaaahmcaabaaa
adaaaaaapgapbaaaaaaaaaaakgaobaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaahgcaabaaaaaaaaaaakgalbaaa
aaaaaaaaagabbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaaigaabaaaaaaaaaaa
egbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
}
 }
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
Float 5 [aspect]
Vector 6 [position1]
Vector 7 [position2]
Vector 8 [position3]
Vector 9 [position4]
"!!ARBvp1.0
# 17 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[6].xyxy;
ADD R0.xy, vertex.texcoord[0], -c[7];
MUL result.texcoord[2].x, R0.z, c[5];
MOV result.texcoord[2].y, R0.w;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[8].xyxy;
MUL result.texcoord[3].x, R0, c[5];
MOV result.texcoord[3].y, R0;
ADD R0.xy, vertex.texcoord[0], -c[9];
MOV result.texcoord[1].xy, vertex.texcoord[0];
MUL result.texcoord[4].x, R0.z, c[5];
MOV result.texcoord[4].y, R0.w;
MUL result.texcoord[5].x, R0, c[5];
MOV result.texcoord[5].y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [aspect]
Vector 5 [position1]
Vector 6 [position2]
Vector 7 [position3]
Vector 8 [position4]
"vs_2_0
; 17 ALU
dcl_position0 v0
dcl_texcoord0 v1
add r0.zw, v1.xyxy, -c5.xyxy
add r0.xy, v1, -c6
mul oT2.x, r0.z, c4
mov oT2.y, r0.w
add r0.zw, v1.xyxy, -c7.xyxy
mul oT3.x, r0, c4
mov oT3.y, r0
add r0.xy, v1, -c8
mov oT1.xy, v1
mul oT4.x, r0.z, c4
mov oT4.y, r0.w
mul oT5.x, r0, c4
mov oT5.y, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Float 48 [aspect]
Vector 64 [position1] 2
Vector 96 [position2] 2
Vector 128 [position3] 2
Vector 160 [position4] 2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpglnjnagecddgjhkdoainlppehppikefabaaaaaaoeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeacaaaa
eaaaabaakjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaa
aeaaaaaadiaaaaaieccabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaai
bccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaf
cccabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaadiaaaaaieccabaaaacaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
bkaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Float 48 [aspect]
Vector 64 [position1] 2
Vector 96 [position2] 2
Vector 128 [position3] 2
Vector 160 [position4] 2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecednhnlmhiikkkonjklcgemlenigpmhddfnabaaaaaajmafaaaaaeaaaaaa
daaaaaaaoeabaaaajaaeaaaaoeaeaaaaebgpgodjkmabaaaakmabaaaaaaacpopp
eiabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
acaaabaaaaaaaaaaaaaaagaaabaaadaaaaaaaaaaaaaaaiaaabaaaeaaaaaaaaaa
aaaaakaaabaaafaaaaaaaaaaabaaaaaaaeaaagaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaacaaaaadaaaaadia
abaaoejaacaaoekbafaaaaadaaaaaioaaaaaaaiaabaaaakaabaaaaacaaaaaeoa
aaaaffiaacaaaaadaaaaadiaabaaoejaadaaoekbafaaaaadabaaaboaaaaaaaia
abaaaakaabaaaaacabaaacoaaaaaffiaacaaaaadaaaaadiaabaaoejaaeaaoekb
afaaaaadabaaaioaaaaaaaiaabaaaakaabaaaaacabaaaeoaaaaaffiaafaaaaad
aaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoejaacaaaaadaaaaagiaabaanaja
afaanakbafaaaaadaaaaabiaaaaaffiaabaaaakaabaaaaacacaaadoaaaaaoiia
ppppaaaafdeieefckeacaaaaeaaaabaakjaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadmccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaa
egiacaiaebaaaaaaaaaaaaaaaeaaaaaadiaaaaaieccabaaaabaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaabaaaaaabkaabaaa
aaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaa
aaaaaaaaagaaaaaadiaaaaaibccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaadaaaaaadgaaaaafcccabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaa
diaaaaaieccabaaaacaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaa
dgaaaaaficcabaaaacaaaaaabkaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaa
agbbbaaaabaaaaaaagibcaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaafdccabaaa
adaaaaaaigaabaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 1 TEX
PARAM c[7] = { program.local[0..5],
		{ 0, 2.718282 } };
TEMP R0;
MUL R0.xy, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.x, R0, R0.y;
RSQ R0.x, R0.x;
RCP R0.y, R0.x;
MUL R0.y, -R0, c[4].x;
ADD R0.y, R0, c[1].x;
MAX R0.y, R0, c[6].x;
MUL R0.z, R0.y, c[3].x;
MUL R0.w, -R0.y, c[5].x;
SIN R0.y, R0.z;
MUL R0.y, R0, c[2].x;
POW R0.z, c[6].y, R0.w;
MUL R0.z, R0.y, R0;
MUL R0.xy, R0.x, fragment.texcoord[2];
MUL R0.xy, R0, R0.z;
MUL R0.x, R0, c[0];
ADD R0.xy, fragment.texcoord[1], R0;
TEX result.color, R0, texture[0], 2D;
END
# 18 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [inverseAspect]
Float 1 [time1]
Float 2 [amplitude1]
Float 3 [frequency1]
Float 4 [inverseSpeed1]
Float 5 [decay1]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 31 ALU, 1 TEX
dcl_2d s0
def c6, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c7, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c8, 0.00000000, 0.15915491, 0.50000000, 2.71828198
def c9, 6.28318501, -3.14159298, 0, 0
dcl t1.xy
dcl t2.xy
mul r0.xy, t2, t2
add r0.x, r0, r0.y
rsq r0.x, r0.x
rcp r1.x, r0.x
mul r1.x, -r1, c4
add r1.x, r1, c1
max r1.x, r1, c8
mul r2.x, r1, c3
mad r2.x, r2, c8.y, c8.z
frc r3.x, r2
mul r2.x, -r1, c5
mad r1.x, r3, c9, c9.y
pow r3.x, c8.w, r2.x
sincos r2.xy, r1.x, c7.xyzw, c6.xyzw
mov r1.x, r3.x
mul r2.x, r2.y, c2
mul r1.x, r2, r1
mul r0.xy, r0.x, t2
mul r0.xy, r0, r1.x
mul r0.x, r0, c0
add r0.xy, t1, r0
texld r0, r0, s0
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Float 52 [inverseAspect]
Float 56 [time1]
Float 72 [amplitude1]
Float 76 [frequency1]
Float 80 [inverseSpeed1]
Float 84 [decay1]
BindCB  "$Globals" 0
"ps_4_0
eefiecedajefeapgnomljifpmelnbjkmohidbndpabaaaaaaheadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeacaaaa
eaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
apaaaaahbcaabaaaaaaaaaaaogbkbaaaabaaaaaaogbkbaaaabaaaaaaelaaaaaf
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahfcaabaaaaaaaaaaaagaabaaaaaaaaaaakgblbaaaabaaaaaa
dcaaaaamccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaackiacaaaaaaaaaaaadaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaeaaaaaadiaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
enaaaaagicaabaaaaaaaaaaaaanaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahgcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaaigaabaaa
aaaaaaaaegbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Float 52 [inverseAspect]
Float 56 [time1]
Float 72 [amplitude1]
Float 76 [frequency1]
Float 80 [inverseSpeed1]
Float 84 [decay1]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedclepmhpaihnpolokdabnmkahlidehgpfabaaaaaakiafaaaaaeaaaaaa
daaaaaaagaacaaaalmaeaaaaheafaaaaebgpgodjciacaaaaciacaaaaaaacpppp
peabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaadaaaaaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaaaidpjccdo
aaaaaadpdlkklidpfbaaaaafaeaaapkanlapmjeanlapejmaaaaaaaaaaaaaaaaa
fbaaaaafafaaapkaabannalfgballglhklkkckdlijiiiidjfbaaaaafagaaapka
klkkkklmaaaaaaloaaaaiadpaaaaaadpbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaajaaaaiapkafkaaaaaeaaaaaiiaaaaabllaaaaabllaadaaaakaahaaaaac
aaaaabiaaaaappiaagaaaaacaaaaaciaaaaaaaiaafaaaaadabaaaciaaaaaaaia
aaaapplaafaaaaadabaaaeiaaaaaaaiaaaaakklaabaaaaacaaaaabiaacaaaaka
aeaaaaaeaaaaabiaaaaaffiaaaaaaaibaaaakkkaalaaaaadabaaabiaaaaaaaia
adaaaakaafaaaaadabaaaiiaabaaaaiaabaappkaafaaaaadaaaaabiaabaaaaib
acaaffkaafaaaaadaaaaabiaaaaaaaiaadaappkaaoaaaaacaaaaabiaaaaaaaia
aeaaaaaeaaaaaciaabaappiaadaaffkaadaakkkabdaaaaacaaaaaciaaaaaffia
aeaaaaaeaaaaaciaaaaaffiaaeaaaakaaeaaffkacfaaaaaeacaaaciaaaaaffia
afaaoekaagaaoekaafaaaaadaaaaaciaacaaffiaabaakkkaafaaaaadaaaaabia
aaaaaaiaaaaaffiaafaaaaadaaaaaciaaaaaaaiaabaaffiaaeaaaaaeabaaabia
aaaaffiaaaaaffkaaaaaaalaaeaaaaaeabaaaciaabaakkiaaaaaaaiaaaaaffla
ecaaaaadaaaaapiaabaaoeiaaaaioekaabaaaaacaaaiapiaaaaaoeiappppaaaa
fdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaapaaaaahbcaabaaaaaaaaaaaogbkbaaaabaaaaaaogbkbaaa
abaaaaaaelaaaaafccaabaaaaaaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahfcaabaaaaaaaaaaaagaabaaaaaaaaaaa
kgblbaaaabaaaaaadcaaaaamccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaadaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaadiaaaaajccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaenaaaaagicaabaaaaaaaaaaaaanaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
gcaabaaaaaaaaaaafgafbaaaaaaaaaaaagacbaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaa
aaaaaaaaigaabaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaadaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}