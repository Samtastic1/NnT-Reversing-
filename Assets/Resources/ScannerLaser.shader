Shader "JAW/FX/ScannerLaser" {
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha One
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.color, vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
; 6 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedocgiedofpfhklggmjdlgacmajlmcddlkabaaaaaakaacaaaaadaaaaaa
cmaaaaaapeaaaaaagiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefcdaabaaaaeaaaabaaemaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaa
egbabaaaadaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaafaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Time]
Vector 1 [laserColor]
Float 2 [laserIntensity]
Float 3 [beamIntensity]
Float 4 [fadeOff]
SetTexture 0 [spreadTexture] 2D 0
SetTexture 1 [beamTexture] 2D 1
"3.0-!!ARBfp1.0
# 22 ALU, 2 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 0.1, 183 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.z, c[5].w;
ADD R2.x, fragment.texcoord[0], fragment.texcoord[0].y;
RCP R0.x, R2.x;
MUL R2.y, R1.z, c[0];
FRC R2.y, R2;
MUL R1.x, fragment.texcoord[0], R0;
MOV R1.y, c[5].x;
TEX R0, R1, texture[0], 2D;
MAD R1.x, R1.z, c[0].y, R1;
MOV R1.y, c[5].x;
TEX R1, R1, texture[1], 2D;
MUL R1, R1, c[3].x;
MAD R2.y, -R2, c[5].z, c[5];
MAD R1, R0, R2.y, R1;
MUL R0, fragment.color.primary, c[1];
MUL R0, R0, R1;
MUL R0, R0, c[2].x;
MUL R1.x, -R2, c[4];
ADD R1.x, R1, c[5].y;
MUL R0.w, R0, fragment.color.primary;
MUL result.color.w, R0, R1.x;
MOV result.color.xyz, R0;
END
# 22 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Time]
Vector 1 [laserColor]
Float 2 [laserIntensity]
Float 3 [beamIntensity]
Float 4 [fadeOff]
SetTexture 0 [spreadTexture] 2D 0
SetTexture 1 [beamTexture] 2D 1
"ps_3_0
; 21 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 183.00000000, 0.10000000, 1.00000000
dcl_texcoord0 v0.xy
dcl_color0 v1
add r2.x, v0, v0.y
rcp r0.x, r2.x
mul r1.x, v0, r0
mov r1.y, c5.x
texld r0, r1, s0
mov r1.z, c0.y
mad r1.x, c5.y, r1.z, r1
mov r1.z, c0.y
mul r2.y, c5, r1.z
mov r1.y, c5.x
texld r1, r1, s1
frc r2.y, r2
mul r1, r1, c3.x
mad r2.y, -r2, c5.z, c5.w
mad r1, r0, r2.y, r1
mul r0, v1, c1
mul r0, r0, r1
mul r0, r0, c2.x
mul r1.x, -r2, c4
add r1.x, r1, c5.w
mul r0.w, r0, v1
mul oC0.w, r0, r1.x
mov oC0.xyz, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [spreadTexture] 2D 0
SetTexture 1 [beamTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [laserColor]
Float 32 [laserIntensity]
Float 36 [beamIntensity]
Float 40 [fadeOff]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedclgfjegcjdejkgcmnjfefnmdcikfdlkgabaaaaaakiadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmacaaaaeaaaaaaa
ldaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadiaaaaaibcaabaaaaaaaaaaabkiacaaaabaaaaaaaaaaaaaa
abeaaaaaaaaadhedbkaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaamnmmmmdnabeaaaaa
aaaaiadpaaaaaaahccaabaaaaaaaaaaabkbabaaaabaaaaaaakbabaaaabaaaaaa
aoaaaaahbcaabaaaabaaaaaaakbabaaaabaaaaaabkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaacaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakecaabaaaabaaaaaabkiacaaaabaaaaaaaaaaaaaa
abeaaaaaaaaadhedakaabaaaabaaaaaadgaaaaaikcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaai
pcaabaaaacaaaaaaegbobaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaadkbabaaaacaaaaaadgaaaaafhccabaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}