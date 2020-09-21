Shader "JAW/Fog Plane" {
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Matrix 5 [_Object2World]
Vector 9 [_ScreenParams]
"3.0-!!ARBvp1.0
# 19 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
MOV R0.w, R1;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
ADD R0.xy, R1, R1.z;
RCP R1.y, c[9].x;
RCP R1.x, c[9].y;
MUL R1.y, R1.w, R1;
MUL R1.x, R1.w, R1;
MAD result.texcoord[0].y, R1.x, c[0].x, R0;
MAD result.texcoord[0].x, R1.y, c[0], R0;
MOV result.texcoord[0].zw, R0;
DP4 result.texcoord[2].w, vertex.position, c[8];
DP4 result.texcoord[2].z, vertex.position, c[7];
DP4 result.texcoord[2].y, vertex.position, c[6];
DP4 result.texcoord[2].x, vertex.position, c[5];
END
# 19 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ScreenParams]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
def c9, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.z, v0, c3
rcp r1.w, c8.y
mov r0.w, r0.z
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c9.x
mov r1.y, -r1
add r1.xy, r1, r1.z
mul r1.w, r0.z, r1
rcp r1.z, c8.x
mad o1.y, r1.w, c9.x, r1
mul r1.y, r0.z, r1.z
dp4 r0.z, v0, c2
mad o1.x, r1.y, c9, r1
mov o0, r0
mov o1.zw, r0
dp4 o2.w, v0, c7
dp4 o2.z, v0, c6
dp4 o2.y, v0, c5
dp4 o2.x, v0, c4
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlfjjagaeiajomebfdkjgnlcaemhcpfedabaaaaaagmadaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcfeacaaaaeaaaabaajfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaa
fpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaamgabbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaalpaaaaaaaaaaaaaaahdcaabaaaaaaaaaaafgafbaaa
abaaaaaaigaabaaaabaaaaaaaoaaaaaldcaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaajdccabaaa
abaaaaaaegaabaaaabaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadgaaaaaf
mccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaacaaaaaaegiocaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [fogColor]
Float 3 [fogDensity]
Float 4 [startDistance]
Float 5 [height]
Float 6 [inverseFadeOff]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 20 ALU, 1 TEX
PARAM c[8] = { program.local[0..6],
		{ 1, 2.718282, 0 } };
TEMP R0;
TXP R0.x, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0, c[1], c[1].y;
RCP R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
ADD R0.y, R0, c[0];
RCP R0.x, R0.x;
ADD R0.y, R0, -c[5].x;
ADD R0.x, R0, -c[4];
MUL R0.y, R0, c[6].x;
MAX R0.x, R0, c[7].z;
MAX R0.y, R0, c[7].z;
MUL R0.x, R0, -c[3];
MUL R0.y, R0, R0;
POW R0.x, c[7].y, R0.x;
POW R0.y, c[7].y, -R0.y;
ADD R0.x, -R0, c[7];
MUL result.color.w, R0.x, R0.y;
MOV result.color.xyz, c[2];
END
# 20 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [fogColor]
Float 3 [fogDensity]
Float 4 [startDistance]
Float 5 [height]
Float 6 [inverseFadeOff]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 25 ALU, 1 TEX
dcl_2d s0
def c7, 0.00000000, 2.71828198, 1.00000000, 0
dcl_texcoord0 v0
dcl_texcoord2 v1.xyz
texldp r0.x, v0, s0
mad r0.x, r0, c1, c1.y
rcp r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.x, r0, r0
rsq r0.x, r0.x
add r0.y, r0, c0
rcp r0.x, r0.x
add r0.y, r0, -c5.x
add r0.x, r0, -c4
mul r0.y, r0, c6.x
max r0.y, r0, c7.x
max r0.x, r0, c7
mul r0.x, r0, -c3
pow r1, c7.y, r0.x
mul r2.x, r0.y, r0.y
pow r0, c7.y, -r2.x
mov r0.z, r0.x
mov r0.y, r1.x
add r0.x, -r0.y, c7.z
mul oC0.w, r0.x, r0.z
mov oC0.xyz, c2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [fogColor]
Float 32 [fogDensity]
Float 36 [startDistance]
Float 40 [height]
Float 44 [inverseFadeOff]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhkfpkenanbennmnemmogpcafijdippokabaaaaaaoiadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaadaaaaeaaaaaaameaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaah
ocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaaaeaaaaaa
aaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaacaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}