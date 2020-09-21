Shader "Custom/LED" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _InputGamma ("Input Gamma", Float) = 2.4
 _OutputGamma ("Output Gamma", Float) = 2.2
 _Cutoff ("Base Alpha cutoff", Range(0,0.9)) = 0.5
 _Ratio ("Aspect Ratio", Range(0,1)) = 0.5
}
SubShader { 
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  AlphaTest Greater [_Cutoff]
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
Vector 0 [_ScrollOffset]
Float 1 [_InputGamma]
Float 2 [_OutputGamma]
Vector 3 [_TextureSize]
Float 4 [_Ratio]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
# 21 ALU, 1 TEX
PARAM c[7] = { program.local[0..5],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
MOV R0.xy, c[3];
MUL R0.xy, R0, c[0];
FLR R0.xy, R0;
ADD R0.zw, R0.xyxy, c[6].y;
RCP R1.x, c[2].x;
RCP R0.y, c[3].y;
RCP R0.x, c[3].x;
MUL R0.zw, R0, R0.xyxy;
MOV R0.x, c[4];
MOV R0.y, c[6].x;
MAD R0.xy, fragment.texcoord[0], R0, R0.zwzw;
TEX R0, R0, texture[0], 2D;
POW R0.x, R0.x, c[1].x;
POW result.color.x, R0.x, R1.x;
POW R0.x, R0.y, c[1].x;
POW R0.y, R0.z, c[1].x;
POW result.color.y, R0.x, R1.x;
SLT R0.x, R0.w, c[5];
POW result.color.z, R0.y, R1.x;
MOV result.color.w, R0;
KIL -R0.x;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ScrollOffset]
Float 1 [_InputGamma]
Float 2 [_OutputGamma]
Vector 3 [_TextureSize]
Float 4 [_Ratio]
Float 5 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 39 ALU, 2 TEX
dcl_2d s0
def c6, 0.50000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
mov r0.xy, c0
mul r0.xy, c3, r0
frc r0.zw, r0.xyxy
add r0.xy, r0, -r0.zwzw
add r0.zw, r0.xyxy, c6.x
rcp r0.y, c3.y
rcp r0.x, c3.x
mul r0.zw, r0, r0.xyxy
mov r0.x, c4
mov r0.y, c6
mad r0.xy, v0, r0, r0.zwzw
texld r1, r0, s0
pow r0, r1.x, c1.x
add r2.x, r1.w, -c5
rcp r1.x, c2.x
mov r2.y, r0.x
pow r0, r2.y, r1.x
cmp r2.x, r2, c6.z, c6.y
mov_pp r2, -r2.x
texkill r2.xyzw
pow r2, r1.z, c1.x
mov oC0.x, r0
pow r0, r1.y, c1.x
mov r1.y, r2.x
pow r2, r0.x, r1.x
pow r0, r1.y, r1.x
mov oC0.y, r2
mov oC0.z, r0
mov oC0.w, r1
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 24 [_ScrollOffset] 2
Float 32 [_InputGamma]
Float 36 [_OutputGamma]
Vector 40 [_TextureSize] 2
Float 48 [_Ratio]
Float 52 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkmclcoibffknkacmblkhhcikgnhlbgknabaaaaaapmacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdmacaaaa
eaaaaaaaipaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadiaaaaajdcaabaaaaaaaaaaa
ogikcaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaacaaaaaaebaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaaoaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaogikcaaaaaaaaaaaacaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaadgaaaaafccaabaaaabaaaaaa
bkbabaaaabaaaaaaaaaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaaoaaaaal
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkiacaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaabjaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
}
 }
}
}