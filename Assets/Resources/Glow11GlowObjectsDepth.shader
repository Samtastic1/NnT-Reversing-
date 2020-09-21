Shader "Hidden/Glow 11/GlowObjectsDepth" {
Properties {
 _TintColor ("Tint Color", Color) = (1,1,1,1)
 _GlowStrength ("Glow Strength", Float) = 1
 _GlowColor ("Glow Color", Color) = (1,1,1,1)
 _TintColor1 ("Effect Colour Tint 1", Color) = (1,1,1,1)
 _TintColor2 ("Effect Colour Tint 2", Color) = (1,1,1,1)
 _Pulse_Speed ("_Pulse_Speed", Range(0,5)) = 1.34
 _GlowTex2 ("Glow", 2D) = "" {}
 _GlowStrength2 ("Glow Strength 2", Float) = 1
}
SubShader { 
 Tags { "RenderType"="Glow11" "RenderEffect"="Glow11" }
 Pass {
  Name "OPAQUEGLOW"
  Tags { "RenderType"="Glow11" "RenderEffect"="Glow11" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 12 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[3];
MOV result.position, R0;
MOV result.texcoord[3].z, -R1.x;
MOV result.texcoord[3].w, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord3 o1
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
mad o1.xy, r1.z, c9.zwzw, r1
dp4 r0.z, v0, c6
dp4 r1.x, v0, c2
mov o0, r0
mov o1.z, -r1.x
mov o1.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedplhdagnjmnajdkikbgjkkhbfojinboigabaaaaaacmadaaaaadaaaaaa
cmaaaaaaiaaaaaaapeaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcdaacaaaaeaaaabaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 12 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[3];
MOV result.position, R0;
MOV result.texcoord[3].z, -R1.x;
MOV result.texcoord[3].w, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord3 o1
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
mad o1.xy, r1.z, c9.zwzw, r1
dp4 r0.z, v0, c6
dp4 r1.x, v0, c2
mov o0, r0
mov o1.z, -r1.x
mov o1.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedplhdagnjmnajdkikbgjkkhbfojinboigabaaaaaacmadaaaaadaaaaaa
cmaaaaaaiaaaaaaapeaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcdaacaaaaeaaaabaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord2 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbboaoeigigfdmbnmmmpbpldnhcjpbdagabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 12 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[3];
MOV result.position, R0;
MOV result.texcoord[3].z, -R1.x;
MOV result.texcoord[3].w, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord3 o1
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
mad o1.xy, r1.z, c9.zwzw, r1
dp4 r0.z, v0, c6
dp4 r1.x, v0, c2
mov o0, r0
mov o1.z, -r1.x
mov o1.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlepjmbgmbognknaeaknpihphjoehdmihabaaaaaaeeadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadapaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcdaacaaaaeaaaabaaimaaaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmdlibhihidchljekdoapnmgcgcmngmfjabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmdlibhihidchljekdoapnmgcgcmngmfjabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjeeakefgdnfijdbbkojjnoiaclobhcgdabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjeeakefgdnfijdbbkojjnoiaclobhcgdabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_GlowTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedpnamhgahkblafmiepkkohoncchdkkiohabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecednaibmbfbpcafaedjmkncafdmodgmepegabaaaaaalaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadapaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord2 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbboaoeigigfdmbnmmmpbpldnhcjpbdagabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord2 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbboaoeigigfdmbnmmmpbpldnhcjpbdagabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddfbohmplofdhhbhkipmpinjhnhiagdjlabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddfbohmplofdhhbhkipmpinjhnhiagdjlabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord2 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbboaoeigigfdmbnmmmpbpldnhcjpbdagabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord2 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedddlmhiagolnfeigcpkdlplpoecaaimopabaaaaaalaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadapaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 12 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[3];
MOV result.position, R0;
MOV result.texcoord[3].z, -R1.x;
MOV result.texcoord[3].w, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord3 o1
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
mad o1.xy, r1.z, c9.zwzw, r1
dp4 r0.z, v0, c6
dp4 r1.x, v0, c2
mov o0, r0
mov o1.z, -r1.x
mov o1.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedplhdagnjmnajdkikbgjkkhbfojinboigabaaaaaacmadaaaaadaaaaaa
cmaaaaaaiaaaaaaapeaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcdaacaaaaeaaaabaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 12 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[3];
MOV result.position, R0;
MOV result.texcoord[3].z, -R1.x;
MOV result.texcoord[3].w, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord3 o1
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
mad o1.xy, r1.z, c9.zwzw, r1
dp4 r0.z, v0, c6
dp4 r1.x, v0, c2
mov o0, r0
mov o1.z, -r1.x
mov o1.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedplhdagnjmnajdkikbgjkkhbfojinboigabaaaaaacmadaaaaadaaaaaa
cmaaaaaaiaaaaaaapeaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcdaacaaaaeaaaabaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord2 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbboaoeigigfdmbnmmmpbpldnhcjpbdagabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 12 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
MOV R0.w, R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[3];
MOV result.position, R0;
MOV result.texcoord[3].z, -R1.x;
MOV result.texcoord[3].w, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord3 o1
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
mad o1.xy, r1.z, c9.zwzw, r1
dp4 r0.z, v0, c6
dp4 r1.x, v0, c2
mov o0, r0
mov o1.z, -r1.x
mov o1.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlepjmbgmbognknaeaknpihphjoehdmihabaaaaaaeeadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadapaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcdaacaaaaeaaaabaaimaaaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhefjaghodlaceflnbndohahlmlbcmggdabaaaaaaheadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddfbohmplofdhhbhkipmpinjhnhiagdjlabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord3 o2
def c10, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mov o1, v1
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedfnfddbbigjepdogppioebnckfpcedcgiabaaaaaaimadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadapaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcfmacaaaaeaaaabaajhaaaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R0, R0, c[1].x;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 7 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul oC0, r0, c1.x
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfcbpockglnfkefefkgmfdpgpikbhbmdkabaaaaaamiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[3].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[3].yyyz, R1;
MUL R0, R0, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0, v0, s1
mul r0, r0, c1.x
mul oC0, r0, c2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfacadnmknkafoogobekgjjepdmfdplaaabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, fragment.color.primary;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0, r0, v0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedobaiaejjfjcabmgenkkaobefhgbjdckeabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, fragment.color.primary.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0, r0, v0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddklcmgmldiajbjkhpmphplhonahehekbabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgbpbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
TEX R1, fragment.texcoord[0], texture[1], 2D;
MUL R1, R1, c[1].x;
TEX R2.w, fragment.texcoord[2], texture[2], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r1, v0, s1
texld r0.w, v1, s2
mul r1, r1, c1.x
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlcighgdjibondpeonhinlhoemgkodmgaabaaaaaaeiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, R0.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul r0, r0, c1.x
mul oC0, r0, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedddnclipgmnpfmlfmmhnleddniacgckdfabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaahpccabaaaaaaaaaaapgapbaaaaaaaaaaaegaobaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
MUL R0, R0.x, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 9 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord3 v0
texldp r1.x, v0, s0
mad r1.x, r1, c0.z, c0.w
add r1.y, v0.z, c3.x
rcp r1.x, r1.x
add r2.x, r1, -r1.y
cmp r0, r2.x, r0, c3.zzzy
mov r1, c2
mul r1, c1.x, r1
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcibeblibnjibmimhbllbgnecapdcpoliabaaaaaagiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimabaaaaeaaaaaaa
gdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpccabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
Vector 3 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[4].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[4].yyyz, R0;
MOV R1.z, c[1].x;
MUL R1, R1.z, c[3];
MUL R1, R1, c[2];
CMP R2.x, R2, c[4].y, c[4].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
Vector 3 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 10 ALU, 1 TEX
dcl_2d s0
def c4, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord3 v0
texldp r2.x, v0, s0
mov r1, c3
mad r2.x, r2, c0.z, c0.w
mul r1, c1.x, r1
add r2.y, v0.z, c4.x
rcp r2.x, r2.x
add r2.x, r2, -r2.y
cmp r0, r2.x, r0, c4.zzzy
mul r1, r1, c2
cmp_pp r2.x, r2, c4.y, c4.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 64
Float 16 [_GlowStrength]
Vector 32 [_GlowColor]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedeabkiaibkolfhfnhdnfpcegengmhnpnkabaaaaaaiiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmabaaaaeaaaaaaa
glaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaa
adaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[3].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[3].yyyz, R0;
MOV R1.z, c[1].x;
MUL R1, R1.z, c[2];
MUL R1, R1, fragment.color.primary;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 10 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord3 v1
texldp r2.x, v1, s0
mov r1, c2
mad r2.x, r2, c0.z, c0.w
mul r1, c1.x, r1
add r2.y, v1.z, c3.x
rcp r2.x, r2.x
add r2.x, r2, -r2.y
cmp r0, r2.x, r0, c3.zzzy
mul r1, r1, v0
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjiaklelaolcjkbjpaebhpnpjcomgpeccabaaaaaajaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaa
gnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[3].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[3].yyyz, R0;
MOV R1.z, c[1].x;
MUL R1, R1.z, c[2];
MUL R1, R1, fragment.color.primary.w;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 10 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord3 v1
texldp r2.x, v1, s0
mov r1, c2
mad r2.x, r2, c0.z, c0.w
mul r1, c1.x, r1
add r2.y, v1.z, c3.x
rcp r2.x, r2.x
add r2.x, r2, -r2.y
cmp r0, r2.x, r0, c3.zzzy
mul r1, r1, v0.w
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddnamfldkapdingpdbdjonaddklbndfjoabaaaaaajaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaa
gnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgbpbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
MOV R1.x, c[1];
MUL R1, R1.x, c[2];
TEX R2.w, fragment.texcoord[2], texture[1], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[3].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord2 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r1, c2
texld r0.w, v0, s1
mul r1, c1.x, r1
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcoooppjhohnbfnoflbemfnefigmeniheabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiocaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
MOV R1.x, c[1];
MUL R1, R1.x, c[2];
TEX R2.w, fragment.texcoord[0], texture[1], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[3].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r1, c2
texld r0.w, v0, s1
mul r1, c1.x, r1
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcpdidfpjfhfckdcfnkmngnompnlpgiioabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiocaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0, fragment.texcoord[1], texture[1], 2D;
MUL R0, R0, c[1].x;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"ps_3_0
; 7 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul oC0, r0, c1.x
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_GlowTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbjmneepcbaigkbkdiembholccgigcfacabaaaaaamiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[3].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[3].yyyz, R1;
MUL R0, R0, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0, v0, s1
mul r0, r0, c1.x
mul oC0, r0, c2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_GlowTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbkckgkecckppjachhhaopmoomcdojoiiabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, fragment.color.primary;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0, r0, v0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_GlowTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecednjohnoedfppjlfdepahokhmjgocmldmpabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, fragment.color.primary.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0, r0, v0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_GlowTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbnmmmefmmledfedkoapjgpnbhebhciljabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgbpbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1, R1, c[1].x;
TEX R2.w, fragment.texcoord[2], texture[2], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r1, v0, s1
texld r0.w, v1, s2
mul r1, r1, c1.x
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmojibpohhjkeaohpdaakpmkgdhlfnijkabaaaaaaeiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1, R1, c[1].x;
TEX R2.w, fragment.texcoord[0], texture[2], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r1, v1, s1
texld r0.w, v0, s2
mul r1, r1, c1.x
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedopogacikigklacacccpggohadnakckgcabaaaaaaeiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R0, R0, c[1].x;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 7 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord2 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul oC0, r0, c1.x
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedofkhpgbopdpappjhoghhalndjlpibhknabaaaaaamiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[3].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[3].yyyz, R1;
MUL R0, R0, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord2 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0, v0, s1
mul r0, r0, c1.x
mul oC0, r0, c2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfobcilkmllgoliaaaaiadcjimmfpbdbpabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, fragment.color.primary;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0, r0, v0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpehdbgphbldepjbdbfgkfjnfhjeahidoabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, fragment.color.primary.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0, r0, v0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecediaemlddjpnndemhhobcjhfpcbnpmobiiabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgbpbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MAD R2.x, R2, c[0].z, c[0].w;
MUL R0, R0, c[1].x;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, R0, R0.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord2 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul r0, r0, c1.x
mul oC0, r0, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcdbhihpnhgnjmpfihfkfdekeoalkoadfabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaahpccabaaaaaaaaaaapgapbaaaaaaaaaaaegaobaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
TEX R1, fragment.texcoord[2], texture[1], 2D;
MUL R1, R1, c[1].x;
TEX R2.w, fragment.texcoord[0], texture[2], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r1, v1, s1
texld r0.w, v0, s2
mul r1, r1, c1.x
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmdpfccaelihfalgbmdgmedhhigcngkgdabaaaaaaeiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
MUL R0, R0.x, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 9 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord3 v0
texldp r1.x, v0, s0
mad r1.x, r1, c0.z, c0.w
add r1.y, v0.z, c3.x
rcp r1.x, r1.x
add r2.x, r1, -r1.y
cmp r0, r2.x, r0, c3.zzzy
mov r1, c2
mul r1, c1.x, r1
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcibeblibnjibmimhbllbgnecapdcpoliabaaaaaagiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimabaaaaeaaaaaaa
gdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpccabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[3].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[3].yyyz, R0;
MOV R1.z, c[1].x;
MUL R1, R1.z, c[2];
MUL R1, R1, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 10 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord3 v0
texldp r2.x, v0, s0
mov r1, c2
mad r2.x, r2, c0.z, c0.w
mul r1, c1.x, r1
add r2.y, v0.z, c3.x
rcp r2.x, r2.x
add r2.x, r2, -r2.y
cmp r0, r2.x, r0, c3.zzzy
mul r1, r1, c2
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedocnamkonoglddekkafdfjdolnnmnnmneabaaaaaaiiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmabaaaaeaaaaaaa
glaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaaegiocaaaaaaaaaaa
acaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[3].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[3].yyyz, R0;
MOV R1.z, c[1].x;
MUL R1, R1.z, c[2];
MUL R1, R1, fragment.color.primary;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 10 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord3 v1
texldp r2.x, v1, s0
mov r1, c2
mad r2.x, r2, c0.z, c0.w
mul r1, c1.x, r1
add r2.y, v1.z, c3.x
rcp r2.x, r2.x
add r2.x, r2, -r2.y
cmp r0, r2.x, r0, c3.zzzy
mul r1, r1, v0
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjiaklelaolcjkbjpaebhpnpjcomgpeccabaaaaaajaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaa
gnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[3].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[3].yyyz, R0;
MOV R1.z, c[1].x;
MUL R1, R1.z, c[2];
MUL R1, R1, fragment.color.primary.w;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 10 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord3 v1
texldp r2.x, v1, s0
mov r1, c2
mad r2.x, r2, c0.z, c0.w
mul r1, c1.x, r1
add r2.y, v1.z, c3.x
rcp r2.x, r2.x
add r2.x, r2, -r2.y
cmp r0, r2.x, r0, c3.zzzy
mul r1, r1, v0.w
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddnamfldkapdingpdbdjonaddklbndfjoabaaaaaajaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaa
gnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgbpbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
MOV R1.x, c[1];
MUL R1, R1.x, c[2];
TEX R2.w, fragment.texcoord[2], texture[1], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[3].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord2 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r1, c2
texld r0.w, v0, s1
mul r1, c1.x, r1
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcoooppjhohnbfnoflbemfnefigmeniheabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiocaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
MOV R1.x, c[1];
MUL R1, R1.x, c[2];
TEX R2.w, fragment.texcoord[0], texture[1], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[3].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r1, c2
texld r0.w, v0, s1
mul r1, c1.x, r1
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcpdidfpjfhfckdcfnkmngnompnlpgiioabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
diaaaaajpcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiocaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaapgapbaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 9 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0, fragment.color.primary, c[1].x;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 9 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 8 ALU, 1 TEX
dcl_2d s0
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r2.x, r0, -r0.y
cmp r1, r2.x, r1, c2.zzzy
mul r0, v0, c1.x
cmp_pp r2.x, r2, c2.y, c2.z
cmp oC0, -r2.x, r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 32
Float 16 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlobnoaoaednkklncgdfkgcolcphngfflabaaaaaahaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeabaaaaeaaaaaaa
gfaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaaipccabaaaaaaaaaaaegbobaaaabaaaaaa
agiacaaaaaaaaaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[3].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[3].yyyz, R0;
MUL R1, fragment.color.primary, c[1].x;
MUL R1, R1, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R1, R0;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 9 ALU, 1 TEX
dcl_2d s0
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord3 v1
texldp r1.x, v1, s0
mad r1.x, r1, c0.z, c0.w
add r1.y, v1.z, c3.x
rcp r1.x, r1.x
add r2.x, r1, -r1.y
cmp r0, r2.x, r0, c3.zzzy
mul r1, v0, c1.x
mul r1, r1, c2
cmp_pp r2.x, r2, c3.y, c3.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_GlowStrength]
Vector 32 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedaogjpmbalimellhipiedkkiifjogelbhabaaaaaajaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaa
gnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaaipcaabaaaaaaaaaaaegbobaaaabaaaaaa
agiacaaaaaaaaaaaabaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[2].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, fragment.color.primary, c[1].x;
MUL R1, R1, fragment.color.primary;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 9 ALU, 1 TEX
dcl_2d s0
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord3 v1
texldp r1.x, v1, s0
mad r1.x, r1, c0.z, c0.w
add r1.y, v1.z, c2.x
rcp r1.x, r1.x
add r2.x, r1, -r1.y
cmp r0, r2.x, r0, c2.zzzy
mul r1, v0, c1.x
mul r1, r1, v0
cmp_pp r2.x, r2, c2.y, c2.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 32
Float 16 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlekahicmanphiemkplpaicoogmagnhmfabaaaaaaimacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaabaaaaeaaaaaaa
gmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaahpcaabaaaaaaaaaaaegbobaaaabaaaaaa
egbobaaaabaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[3], texture[0], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
ADD R1.y, fragment.texcoord[3].z, -c[2].x;
RCP R1.x, R1.x;
ADD R2.x, R1, -R1.y;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, fragment.color.primary, c[1].x;
MUL R1, R1, fragment.color.primary.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
; 9 ALU, 1 TEX
dcl_2d s0
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord3 v1
texldp r1.x, v1, s0
mad r1.x, r1, c0.z, c0.w
add r1.y, v1.z, c2.x
rcp r1.x, r1.x
add r2.x, r1, -r1.y
cmp r0, r2.x, r0, c2.zzzy
mul r1, v0, c1.x
mul r1, r1, v0.w
cmp_pp r2.x, r2, c2.y, c2.z
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 32
Float 16 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlmeiegfjdpdoolhafgcpmbecbfkkbiajabaaaaaaleacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcniabaaaaeaaaaaaa
hgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdgaaaaagbcaabaaaaaaaaaaaakiacaaaaaaaaaaa
abaaaaaadgaaaaaficaabaaaaaaaaaaadkbabaaaabaaaaaadiaaaaahpcaabaaa
abaaaaaaagambaaaaaaaaaaaegbobaaaabaaaaaadiaaaaahpccabaaaaaaaaaaa
pgadbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
MUL R1, fragment.color.primary, c[1].x;
TEX R2.w, fragment.texcoord[2], texture[1], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.w, v1, s1
mul r1, v0, c1.x
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_Illum] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgihhhinhkekgbocidceggfkppjjanbkjabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaaipcaabaaaaaaaaaaaegbobaaaabaaaaaa
agiacaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgapbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R2.y, R2.x, c[0].z, c[0].w;
MUL R1, fragment.color.primary, c[1].x;
TEX R2.w, fragment.texcoord[0], texture[1], 2D;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R2.y, R2.y;
ADD R2.x, R2.y, -R2;
CMP R0, R2.x, c[2].yyyz, R0;
MUL R1, R1, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R1, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.w, v1, s1
mul r1, v0, c1.x
mul oC0, r1, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkkoifbodalojbelooideamnhfnoagoklabaaaaaapaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabdiaaaaaipcaabaaaaaaaaaaaegbobaaaabaaaaaa
agiacaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgapbaaaabaaaaaadoaaaaab"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Glow11Transparent" "RenderEffect"="Glow11Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Glow11Transparent" "RenderEffect"="Glow11Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepndphiegkbaabdghnkgjmeolepcbdpeabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepndphiegkbaabdghnkgjmeolepcbdpeabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedapjhcgokoonjibbicobanpcinmhglnpgabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedapjhcgokoonjibbicobanpcinmhglnpgabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
Vector 12 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[13] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..12] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
Vector 12 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c13, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mad o3.xy, v1, c12, c12.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
Vector 48 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhjbaonegpiijieoplnkdecpfhbelimnhabaaaaaadiaeaaaaadaaaaaa
cmaaaaaaiaaaaaaadmabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefc
peacaaaaeaaaabaalnaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaa
ogikcaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaeaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepndphiegkbaabdghnkgjmeolepcbdpeabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedebjppbgflfacfcgeikigoipmemmdjbllabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedebjppbgflfacfcgeikigoipmemmdjbllabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedebjppbgflfacfcgeikigoipmemmdjbllabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mov oC0.w, r0
mul oC0.xyz, r0, c1.x
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddbbpodkajljaepcpfceehemkpcflnknjabaaaaaanmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoiabaaaaeaaaaaaahkaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[3].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0, v0, s1
mul r0.xyz, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r0, c2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbpgbngomhpikkmopiggomldmammjbpleabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, fragment.color.primary;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0.xyz, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r0, v0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfkapbjiliojmfpglmjpmdcgijinibkcaabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, fragment.color.primary.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0.xyz, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r0, v0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpchenkieggacapcphdchnpkgebpicnhgabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R2.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mov oC0.w, r0
texld r0.w, v1, s2
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgmmefnmjicdfneoggnnaekhelfbnbjaeabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R3.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R2, R0, c[1].x;
MUL R0.xyz, R2, R2.w;
CMP R1, R3.x, c[2].yyyz, R1;
CMP R2.x, R3, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul r1, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r1, r1.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjloiampmboghjcdpllaepjjibgmpihdeabaaaaaapiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaeacaaaaeaaaaaaaibaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.x, c[1];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0.x, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul oC0.xyz, c1.x, r0
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcgfpagklklchklchkkogidhaklnnekdjabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhccabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
Vector 3 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[5] = { program.local[0..3],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[4].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[3];
CMP R1, R0.w, c[4].yyyz, R1;
CMP R2.x, R0.w, c[4].y, c[4].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
Vector 3 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c4, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c4.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c4, c4.z
cmp oC0, r0.x, r1, c4.zzzy
if_gt r0.y, c4.z
mov r0.xyz, c3
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, c2
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
Vector 64 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjncdakpagekcaiacdicgkmadhocmlgababaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaaeaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepkpmlnogepiocmoeliabkmloiflpiliabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedejeagoicojhpcaibchflmiiodcjiapdhabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[3].y, c[3].z;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v1, s2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepbcmodlmfdkpockfhgoelpchobfnookabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 10 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v0, s1
mul r0.xyz, c1.x, r0
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpgjcdfkolghadmfbjpmdfompihhgkoihabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, c[1].x;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 7 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
mul oC0.xyz, r0, c1.x
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmgnfgblhjgomjpnomneledbkdfeahneeabaaaaaaeaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdeacaaaaeaaaaaaainaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0.xyz, v1, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, c2
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedajglnbpggddmcpfgppmabgimefcngledabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord1 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedeaamfhblojdpeenmgcdmjmabndkeokagabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord1 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddbboibkidoambochodcfhkaimcfpfnjaabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_Illum] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R0.w, fragment.texcoord[2], texture[3], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[2].y, c[2].z;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_Illum] 2D 3
"ps_3_0
; 8 ALU, 4 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
texld r0.w, v2, s3
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 3
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
SetTexture 3 [_Illum] 2D 2
ConstBuffer "$Globals" 80
Float 64 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedejeladilknkkhljgmhbfjahfhkljkeoeabaaaaaamaadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaaeaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
texld r0.w, v0, s2
mul r0.xyz, r0, c1.x
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpfffjlfdohblpmfmkobmbiepmcbnnmbiabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, c[1].x;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 7 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
mul oC0.xyz, r0, c1.x
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmkpeidcpoaikmnmkafelcjfnhjokfdkhabaaaaaaeaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdeacaaaaeaaaaaaainaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0.xyz, v1, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, c2
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgnidbbicbnmcjpeiackchjldhegmjfhnabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedogpndegkcegelpahfeihpdednlmegoiiabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhkkemldljkjdafdkomaomoifdlldegmfabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R0, R0, c[1].x;
MUL R0.xyz, R0, R0.w;
MAD R2.x, R2, c[0].z, c[0].w;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
CMP R2.x, R2, c[2].y, c[2].z;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmgokmaakjojagaglppcaagijcjdbeaipabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
texld r0.w, v0, s2
mul r0.xyz, r0, c1.x
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhcjacloapohopdccmhnididbpicialflabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.x, c[1];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0.x, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul oC0.xyz, c1.x, r0
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcgfpagklklchklchkkogidhaklnnekdjabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhccabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, c2
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedffehlljocjmhkamidpcdmbniangloodhabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepkpmlnogepiocmoeliabkmloiflpiliabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedejeagoicojhpcaibchflmiiodcjiapdhabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[3].y, c[3].z;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v1, s2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepbcmodlmfdkpockfhgoelpchobfnookabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 10 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v0, s1
mul r0.xyz, c1.x, r0
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpgjcdfkolghadmfbjpmdfompihhgkoihabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, fragment.color.primary, c[1].x;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 7 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
mul oC0.xyz, v0, c1.x
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedenglhkddpfmbnnockbgabhnddaogmmhkabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MUL R0.xyz, fragment.color.primary, c[1].x;
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, c2
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcphocaonheeobkegpcagoldmnnedfdhmabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MUL R0.xyz, fragment.color.primary, c[1].x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, v0
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlbhffhlnncfamkmieagpjdolbmdcihliabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MUL R0.xyz, fragment.color.primary, c[1].x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedeheoonamhdbijdnllhglakbmfonomfffabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, fragment.color.primary, c[1].x;
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[2].y, c[2].z;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.w, v2, s2
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, r0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkdnaofigppinalekdollinffiaponbahabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, fragment.color.primary, c[1].x;
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.w, v1, s1
mul r0.xyz, v0, c1.x
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedemnhpghfblgpjkmgalficbjfhcmjihihabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="AlphaTest" "RenderType"="Glow11TransparentCutout" "RenderEffect"="Glow11TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "RenderType"="Glow11TransparentCutout" "RenderEffect"="Glow11TransparentCutout" }
  Fog { Mode Off }
  AlphaTest Greater [_Cutoff]
Program "vp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepndphiegkbaabdghnkgjmeolepcbdpeabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepndphiegkbaabdghnkgjmeolepcbdpeabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedapjhcgokoonjibbicobanpcinmhglnpgabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedapjhcgokoonjibbicobanpcinmhglnpgabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
Vector 12 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[13] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..12] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
Vector 12 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c13, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mad o3.xy, v1, c12, c12.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
Vector 48 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhjbaonegpiijieoplnkdecpfhbelimnhabaaaaaadiaeaaaaadaaaaaa
cmaaaaaaiaaaaaaadmabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefc
peacaaaaeaaaabaalnaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaa
ogikcaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaeaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_GlowTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepndphiegkbaabdghnkgjmeolepcbdpeabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedebjppbgflfacfcgeikigoipmemmdjbllabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedebjppbgflfacfcgeikigoipmemmdjbllabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mad o2.xy, v1, c11, c11.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaijpjjdlmfmhfnkdcolmibpifnpdibomabaaaaaaoiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaceabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefclmacaaaaeaaaabaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcgacgdeclodllfpccgnaahcpnllokckabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"3.0-!!ARBvp1.0
# 15 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..11] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
Vector 11 [_Illum_ST]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o4.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mad o3.xy, v1, c11, c11.zwzw
mov o4.z, -r0.x
mov o4.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_Illum_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedebjppbgflfacfcgeikigoipmemmdjbllabaaaaaadaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_3_0
; 14 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord3 o3
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o3.xy, r1.z, c9.zwzw, r1
mov o1, v2
mad o2.xy, v1, c10, c10.zwzw
mov o3.z, -r0.x
mov o3.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedoaiaggfimgnjhakjagphgcmkdgmfgndfabaaaaaaoaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
fpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaacaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mov oC0.w, r0
mul oC0.xyz, r0, c1.x
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddbbpodkajljaepcpfceehemkpcflnknjabaaaaaanmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoiabaaaaeaaaaaaahkaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[3].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, c[2];
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0, v0, s1
mul r0.xyz, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r0, c2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbpgbngomhpikkmopiggomldmammjbpleabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, fragment.color.primary;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0.xyz, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r0, v0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfkapbjiliojmfpglmjpmdcgijinibkcaabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, fragment.color.primary.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0.xyz, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r0, v0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpchenkieggacapcphdchnpkgebpicnhgabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R2.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, R2.w;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mov oC0.w, r0
texld r0.w, v1, s2
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, r0.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgmmefnmjicdfneoggnnaekhelfbnbjaeabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R3.x, R0, -R0.y;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R2, R0, c[1].x;
MUL R0.xyz, R2, R2.w;
CMP R1, R3.x, c[2].yyyz, R1;
CMP R2.x, R3, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v0, s1
mul r1, r0, c1.x
mov oC0.w, r0
mul oC0.xyz, r1, r1.w
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjloiampmboghjcdpllaepjjibgmpihdeabaaaaaapiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaeacaaaaeaaaaaaaibaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.x, c[1];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0.x, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul oC0.xyz, c1.x, r0
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcgfpagklklchklchkkogidhaklnnekdjabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhccabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
Vector 3 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[5] = { program.local[0..3],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[4].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[3];
CMP R1, R0.w, c[4].yyyz, R1;
CMP R2.x, R0.w, c[4].y, c[4].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
Vector 3 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c4, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c4.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c4, c4.z
cmp oC0, r0.x, r1, c4.zzzy
if_gt r0.y, c4.z
mov r0.xyz, c3
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, c2
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
Vector 64 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjncdakpagekcaiacdicgkmadhocmlgababaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaaeaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepkpmlnogepiocmoeliabkmloiflpiliabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedejeagoicojhpcaibchflmiiodcjiapdhabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[3].y, c[3].z;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v1, s2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepbcmodlmfdkpockfhgoelpchobfnookabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_Color]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 10 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v0, s1
mul r0.xyz, c1.x, r0
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_MAINCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpgjcdfkolghadmfbjpmdfompihhgkoihabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, c[1].x;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 7 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
mul oC0.xyz, r0, c1.x
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmgnfgblhjgomjpnomneledbkdfeahneeabaaaaaaeaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdeacaaaaeaaaaaaainaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0.xyz, v1, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, c2
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedajglnbpggddmcpfgppmabgimefcngledabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord1 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedeaamfhblojdpeenmgcdmjmabndkeokagabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord1 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddbboibkidoambochodcfhkaimcfpfnjaabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_Illum] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R0.w, fragment.texcoord[2], texture[3], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[2].y, c[2].z;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_Illum] 2D 3
"ps_3_0
; 8 ALU, 4 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
texld r0.w, v2, s3
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 3
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
SetTexture 3 [_Illum] 2D 2
ConstBuffer "$Globals" 80
Float 64 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedejeladilknkkhljgmhbfjahfhkljkeoeabaaaaaamaadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaaeaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
texld r0.w, v0, s2
mul r0.xyz, r0, c1.x
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpfffjlfdohblpmfmkobmbiepmcbnnmbiabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, c[1].x;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 7 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
mul oC0.xyz, r0, c1.x
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmkpeidcpoaikmnmkafelcjfnhjokfdkhabaaaaaaeaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcdeacaaaaeaaaaaaainaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[3];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0.xyz, v1, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, c2
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgnidbbicbnmcjpeiackchjldhegmjfhnabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedogpndegkcegelpahfeihpdednlmegoiiabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.w, R2.x, c[0].z, c[0];
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0, c[1].x;
ADD R2.x, fragment.texcoord[3].z, -c[2];
RCP R0.w, R0.w;
ADD R0.w, R0, -R2.x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v2, s1
mul r0.xyz, r0, c1.x
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhkkemldljkjdafdkomaomoifdlldegmfabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R0, R0, c[1].x;
MUL R0.xyz, R0, R0.w;
MAD R2.x, R2, c[0].z, c[0].w;
ADD R2.y, fragment.texcoord[3].z, -c[2].x;
RCP R2.x, R2.x;
ADD R2.x, R2, -R2.y;
CMP R1, R2.x, c[2].yyyz, R1;
CMP R2.x, R2, c[2].y, c[2].z;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0, v1, s1
mul r0, r0, c1.x
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s2
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmgokmaakjojagaglppcaagijcjdbeaipabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.xyz, fragment.texcoord[2], texture[1], 2D;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.xyz, R0, c[1].x;
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.xyz, v1, s1
texld r0.w, v0, s2
mul r0.xyz, r0, c1.x
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_ILLUMTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Illum] 2D 1
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhcjacloapohopdccmhnididbpicialflabaaaaaafmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.x, c[1];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0.x, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul oC0.xyz, c1.x, r0
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcgfpagklklchklchkkogidhaklnnekdjabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhccabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, c2
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedffehlljocjmhkamidpcdmbniangloodhabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepkpmlnogepiocmoeliabkmloiflpiliabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MOV R0.z, c[1].x;
MUL R0.xyz, R0.z, c[2];
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyzw
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedejeagoicojhpcaibchflmiiodcjiapdhabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[3].y, c[3].z;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 9 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v1, s2
mul r0.xyz, c1.x, r0
mul oC0.xyz, r0, r0.w
texld oC0.w, v0, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 80
Float 48 [_GlowStrength]
Vector 64 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedepbcmodlmfdkpockfhgoelpchobfnookabaaaaaagaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[3].yyyz, R1;
MOV R0.x, c[1];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, R0.x, c[2];
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 10 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mov r0.xyz, c2
texld r0.w, v0, s1
mul r0.xyz, c1.x, r0
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpgjcdfkolghadmfbjpmdfompihhgkoihabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, fragment.color.primary, c[1].x;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 7 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
mul oC0.xyz, v0, c1.x
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedenglhkddpfmbnnockbgabhnddaogmmhkabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[3].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MUL R0.xyz, fragment.color.primary, c[1].x;
CMP R1, R0.w, c[3].yyyz, R1;
CMP R2.x, R0.w, c[3].y, c[3].z;
MUL R0.xyz, R0, c[2];
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Vector 2 [_GlowColor]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, c2
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_GlowStrength]
Vector 48 [_GlowColor]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcphocaonheeobkegpcagoldmnnedfdhmabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MUL R0.xyz, fragment.color.primary, c[1].x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, v0
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlbhffhlnncfamkmieagpjdolbmdcihliabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegbcbaaa
abaaaaaaegbcbaaaabaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R0.w, R0.x, -R0.y;
MUL R0.xyz, fragment.color.primary, c[1].x;
CMP R1, R0.w, c[2].yyyz, R1;
CMP R2.x, R0.w, c[2].y, c[2].z;
MUL R0.xyz, R0, fragment.color.primary.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 8 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, v0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedeheoonamhdbijdnllhglakbmfonomfffabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.w, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, fragment.color.primary, c[1].x;
MUL R0.xyz, R0, R0.w;
CMP R2.x, R2, c[2].y, c[2].z;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
CMP result.color, -R2.x, R0, R1;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Illum] 2D 2
"ps_3_0
; 8 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texldp r0.x, v3, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v3.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.w, v2, s2
mul r0.xyz, v0, c1.x
mul oC0.xyz, r0, r0.w
texld oC0.w, v1, s1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_Illum] 2D 1
ConstBuffer "$Globals" 64
Float 48 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkdnaofigppinalekdollinffiaponbahabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.x, fragment.texcoord[3], texture[0], 2D;
MAD R0.x, R0, c[0].z, c[0].w;
ADD R0.y, fragment.texcoord[3].z, -c[2].x;
RCP R0.x, R0.x;
ADD R2.x, R0, -R0.y;
CMP R1, R2.x, c[2].yyyz, R1;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, fragment.color.primary, c[1].x;
MUL R0.xyz, R0.w, R0;
CMP R2.x, R2, c[2].y, c[2].z;
CMP result.color, -R2.x, R0, R1;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 9 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c2, -0.00100000, 1.00000000, 0.00000000, 0
dcl_color0 v0.xyz
dcl_texcoord0 v1.xy
dcl_texcoord3 v2
texldp r0.x, v2, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v2.z, c2.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c2, c2.z
cmp oC0, r0.x, r1, c2.zzzy
if_gt r0.y, c2.z
texld r0.w, v1, s1
mul r0.xyz, v0, c1.x
mul r0.xyz, r0.w, r0
mov oC0, r0
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_GlowStrength]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedemnhpghfblgpjkmgalficbjfhcmjihihabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaackbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabbfaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="GlowPulse" "RenderEffect"="Glow11" }
 Pass {
  Name "OPAQUEGLOW"
  Tags { "RenderType"="GlowPulse" "RenderEffect"="Glow11" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_PULSE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_PULSE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_PULSE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 16 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmdlibhihidchljekdoapnmgcgcmngmfjabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaa
ogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_PULSE" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Float 2 [_GlowStrength]
Vector 3 [_TintColor1]
Vector 4 [_TintColor2]
Float 5 [_Pulse_Speed]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 20 ALU, 2 TEX
PARAM c[7] = { program.local[0..5],
		{ 0.5, 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[5];
MUL R2.x, R0, c[0].w;
MOV R0, c[3];
COS R2.x, R2.x;
TXP R3.x, fragment.texcoord[3], texture[0], 2D;
MAD R3.x, R3, c[1].z, c[1].w;
ADD R2.x, R2, c[6].w;
ADD R0, -R0, c[4];
MUL R0, R2.x, R0;
MUL R0, R0, c[6].x;
ADD R2, R0, c[3];
TEX R0, fragment.texcoord[1], texture[1], 2D;
MUL R0, R0, c[2].x;
MUL R0, R0, R2;
ADD R3.y, fragment.texcoord[3].z, -c[6];
RCP R3.x, R3.x;
ADD R3.x, R3, -R3.y;
CMP R1, R3.x, c[6].zzzw, R1;
CMP R2.x, R3, c[6].z, c[6].w;
CMP result.color, -R2.x, R0, R1;
END
# 20 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_PULSE" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Float 2 [_GlowStrength]
Vector 3 [_TintColor1]
Vector 4 [_TintColor2]
Float 5 [_Pulse_Speed]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
"ps_3_0
; 27 ALU, 2 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
def c6, -0.00100000, 1.00000000, 0.00000000, 0.50000000
def c7, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord1 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c1.z, c1.w
add r0.y, v1.z, c6.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c6, c6.z
cmp oC0, r0.x, r1, c6.zzzy
if_gt r0.y, c6.z
mov r0.x, c0.w
mul r0.x, c5, r0
mad r0.x, r0, c7, c7.y
frc r0.x, r0
mad r1.x, r0, c7.z, c7.w
sincos r0.xy, r1.x
mov r1, c4
add r1, -c3, r1
add r0.x, r0, c6.y
mul r0, r0.x, r1
mul r1, r0, c6.w
texld r0, v0, s1
add r1, r1, c3
mul r0, r0, c2.x
mul oC0, r0, r1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWTEX" "GLOW11_MULTIPLY_PULSE" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_GlowTex] 2D 0
ConstBuffer "$Globals" 112
Float 32 [_GlowStrength]
Vector 48 [_TintColor1]
Vector 64 [_TintColor2]
Float 80 [_Pulse_Speed]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedephhogdoklfhienjljagaljigbnaohddabaaaaaakiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcleacaaaaeaaaaaaaknaaaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckbabaaaadaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaab
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadiaaaaajbcaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaadkiacaaa
abaaaaaaaaaaaaaaenaaaaagaanaaaaabcaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpaaaaaaakpcaabaaa
acaaaaaaegiocaiaebaaaaaaaaaaaaaaadaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="GlowCombine" "RenderEffect"="Glow11" }
 Pass {
  Name "OPAQUEGLOW"
  Tags { "RenderType"="GlowCombine" "RenderEffect"="Glow11" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOMBINE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [_GlowTex_ST]
"3.0-!!ARBvp1.0
# 13 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R1, R1.z;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MOV result.texcoord[3].z, -R0.x;
MOV result.texcoord[3].w, R1;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOMBINE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_GlowTex_ST]
"vs_3_0
; 13 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov o0, r0
dp4 r0.x, v0, c2
mad o2.xy, r1.z, c9.zwzw, r1
mad o1.xy, v1, c10, c10.zwzw
mov o2.z, -r0.x
mov o2.w, r1
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOMBINE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_GlowTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedddikpejlpfjhoifmjibkokojcoihmllfabaaaaaajiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaamabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklfdeieefcieacaaaaeaaaabaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaa
ogikcaaaaaaaaaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GLOW11_GLOW_GLOWCOMBINE" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Float 2 [_GlowStrength2]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_GlowTex2] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.001, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[1], texture[1], 2D;
TEX R1, fragment.texcoord[1], texture[2], 2D;
MUL R1, R1, R1.w;
TXP R3.x, fragment.texcoord[3], texture[0], 2D;
MAD R3.x, R3, c[0].z, c[0].w;
MUL R1, R1, c[2].x;
MUL R0, R0, R0.w;
MAD R0, R0, c[1].x, R1;
ADD R3.y, fragment.texcoord[3].z, -c[3].x;
RCP R3.x, R3.x;
ADD R3.x, R3, -R3.y;
CMP R1, R3.x, c[3].yyyz, R2;
CMP R2.x, R3, c[3].y, c[3].z;
CMP result.color, -R2.x, R0, R1;
END
# 14 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "GLOW11_GLOW_GLOWCOMBINE" }
Vector 0 [_ZBufferParams]
Float 1 [_GlowStrength]
Float 2 [_GlowStrength2]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_GlowTex2] 2D 2
"ps_3_0
; 10 ALU, 3 TEX, 1 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, -0.00100000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_texcoord3 v1
texldp r0.x, v1, s0
mad r0.x, r0, c0.z, c0.w
add r0.y, v1.z, c3.x
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp_pp r0.y, r0.x, c3, c3.z
cmp oC0, r0.x, r1, c3.zzzy
if_gt r0.y, c3.z
texld r0, v0, s2
mul r1, r0, r0.w
texld r0, v0, s1
mul r1, r1, c2.x
mul r0, r0, r0.w
mad oC0, r0, c1.x, r1
endif
"
}
SubProgram "d3d11 " {
Keywords { "GLOW11_GLOW_GLOWCOMBINE" }
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_GlowTex] 2D 1
SetTexture 2 [_GlowTex2] 2D 2
ConstBuffer "$Globals" 64
Float 16 [_GlowStrength]
Float 48 [_GlowStrength2]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjeppaildeknpjdnefgfbcjbhjmcebkcpabaaaaaagiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcheacaaaaeaaaaaaajnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaackbabaaa
adaaaaaaabeaaaaagpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaabpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdoaaaaabbfaaaaabefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahpcaabaaaaaaaaaaapgapbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaapgapbaaaabaaaaaaegaobaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}