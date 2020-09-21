Shader "JAW/FX/VaporParticle" {
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  ZTest Always
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
# 5 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
; 5 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
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
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddolmmcahcgjmjpiinclfhjokihhgamkaabaaaaaaaeacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [lightDirection]
SetTexture 0 [gradientTexture] 2D 0
SetTexture 1 [densityTexture] 2D 1
"3.0-!!ARBfp1.0
# 8 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD R0.xy, R0.ywzw, -R0.xzzw;
MUL R0.xy, R0, c[0];
ADD R0.x, R0, R0.y;
MIN R0.y, -R0.x, c[1].x;
MOV result.color.z, -R0.y;
MAX result.color.w, -R0.x, c[1].x;
TEX result.color.xy, fragment.texcoord[0], texture[1], 2D;
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [lightDirection]
SetTexture 0 [gradientTexture] 2D 0
SetTexture 1 [densityTexture] 2D 1
"ps_3_0
; 6 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
texld r0, v0, s0
add r0.xy, r0.ywzw, -r0.xzzw
mul r0.xy, r0, c0
add r0.x, r0, r0.y
min r0.y, -r0.x, c1.x
mov oC0.z, -r0.y
max oC0.w, -r0.x, c1.x
texld oC0.xy, v0, s1
"
}
SubProgram "d3d11 " {
SetTexture 0 [gradientTexture] 2D 1
SetTexture 1 [densityTexture] 2D 0
ConstBuffer "$Globals" 32
Vector 16 [lightDirection]
BindCB  "$Globals" 0
"ps_4_0
eefiecedchnhbmbmfiknlcchmnohoempnlaloeababaaaaaaciacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaa
eaaaaaaafkaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaaaaaaaaa
igaabaiaebaaaaaaaaaaaaaangafbaaaaaaaaaaaapaaaaaibcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaaddaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaaiiccabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaageccabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadgaaaaafdccabaaaaaaaaaaaegaabaaa
aaaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}