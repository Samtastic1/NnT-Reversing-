Shader "JAW/FX/VaporParticles" {
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZTest Always
  ZWrite Off
  Blend One One
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 9 [_Time]
Float 10 [maxParticleSize]
Vector 11 [wind]
"3.0-!!ARBvp1.0
# 27 ALU
PARAM c[13] = { { 0.5, 1000, 0.60000002, 1 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..11],
		{ 2, 0.079999998 } };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R0.x, vertex.position.z, c[0].y;
FRC R2.y, R0.x;
ADD R0.x, -R2.y, c[12];
RCP R0.y, R0.x;
MAD R0.y, R0, c[9], R2;
FRC R2.x, R0.y;
MUL R0.x, R0, R2;
MAD R1, R0.x, c[11], vertex.position;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R0.zw, R0, c[10].x;
DP4 R0.y, R1, c[2];
DP4 R0.x, R1, c[1];
MAD R2.y, -R2, c[0].z, c[0].w;
MAD R0.xy, R0.zwzw, R2.y, R0;
DP4 R0.z, R1, c[3];
DP4 R0.w, R1, c[4];
MUL R1.x, R2, c[12];
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
ADD R1.x, R1, -c[0].w;
DP4 result.position.x, R0, c[5];
ABS R0.x, R1;
ADD R0.x, -R0, c[0].w;
MOV result.color, vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
MUL result.texcoord[2].x, R0, c[12].y;
END
# 27 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 8 [_Time]
Float 9 [maxParticleSize]
Vector 10 [wind]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord2 o3
def c11, -0.50000000, 1000.00000000, 0.60000002, 1.00000000
def c12, 2.00000000, -1.00000000, 0.08000000, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mul r0.x, v0.z, c11.y
frc r2.y, r0.x
add r0.x, -r2.y, c12
rcp r0.y, r0.x
mad r0.y, r0, c8, r2
frc r2.x, r0.y
mul r0.x, r0, r2
mad r1, r0.x, c10, v0
add r0.zw, v1.xyxy, c11.x
mul r0.zw, r0, c9.x
dp4 r0.y, r1, c1
dp4 r0.x, r1, c0
mad r2.y, -r2, c11.z, c11.w
mad r0.xy, r0.zwzw, r2.y, r0
dp4 r0.z, r1, c2
dp4 r0.w, r1, c3
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
mad r1.x, r2, c12, c12.y
dp4 o0.x, r0, c4
abs r0.x, r1
add r0.x, -r0, c11.w
mov o1, v2
mov o2.xy, v1
mul o3.x, r0, c12.z
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Float 16 [maxParticleSize]
Vector 32 [wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 64 [glstate_matrix_modelview0]
ConstBuffer "UnityPerFrame" 208
Matrix 0 [glstate_matrix_projection]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityPerFrame" 3
"vs_4_0
eefiecedboacbkfiggghaofonhcjifiihjbjklokabaaaaaageafaaaaadaaaaaa
cmaaaaaapeaaaaaaiaabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnmadaaaaeaaaabaaphaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
eccabaaaacaaaaaagiaaaaacadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaahecaabaaa
aaaaaaaackbabaaaaaaaaaaaabeaaaaaaaaahkeebkaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaaeaaoaaaaaibcaabaaaabaaaaaabkiacaaaabaaaaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaa
jkjjbjdpabeaaaaaaaaaiadpbkaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialp
aaaaaaaibcaabaaaabaaaaaaakaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaaheccabaaaacaaaaaaakaabaaaabaaaaaaabeaaaaaaknhkddndcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaapgapbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
afaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaaagaabaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaa
agaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaahaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaaaaaaaaaaegaabaaaabaaaaaa
diaaaaaipcaabaaaacaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaafaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaadaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [litParticleTexture] 2D 0
"3.0-!!ARBfp1.0
# 3 ALU, 1 TEX
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, fragment.color.primary, R0;
MUL result.color, R0, fragment.texcoord[2].x;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [litParticleTexture] 2D 0
"ps_3_0
; 2 ALU, 1 TEX
dcl_2d s0
dcl_color0 v0
dcl_texcoord0 v1.xy
dcl_texcoord2 v2.x
texld r0, v1, s0
mul r0, v0, r0
mul oC0, r0, v2.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [litParticleTexture] 2D 0
"ps_4_0
eefiecedokfimnfagbaeegpdfkkdjmbmnmidpepmabaaaaaalaabaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefclmaaaaaaeaaaaaaacpaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaakgbkbaaaacaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}