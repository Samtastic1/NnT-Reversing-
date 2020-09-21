Shader "JAW/FX/Vapor" {
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
"3.0-!!ARBvp1.0
# 8 ALU
PARAM c[5] = { { 0.5 },
		state.matrix.mvp };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
ADD result.texcoord[0].xy, R1, R1.z;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
; 9 ALU
dcl_position o0
dcl_texcoord0 o1
def c4, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c4.x
mov r1.y, -r1
add o1.xy, r1, r1.z
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedddnebhkblmggfaigphlajgdcifhfgolkabaaaaaafaacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfaabaaaa
eaaaabaafeaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaa
mgabbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaalpaaaaaaaadgaaaaaf
mccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaafgafbaaa
abaaaaaaigaabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ZBufferParams]
Vector 1 [vaporColor]
Float 2 [vaporDensity]
Float 3 [lightIntensity]
Vector 4 [lightColor]
Float 5 [inverseFadeDistance]
SetTexture 0 [vaporTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"3.0-!!ARBfp1.0
# 17 ALU, 2 TEX
PARAM c[8] = { program.local[0..5],
		{ 1, 2.718282, 0.5, 0 },
		{ 0, -0.5, 0.5 } };
TEMP R0;
TEMP R1;
TXP R0, fragment.texcoord[0], texture[0], 2D;
DP4 R1.x, R0, c[7].xxyz;
ADD R1.x, R1, c[6].z;
MUL R1.yzw, R1.x, c[4].xxyz;
DP4 R0.x, R0, c[6].zzww;
TXP R1.x, fragment.texcoord[0], texture[1], 2D;
MAD R1.x, R1, c[0].z, c[0].w;
RCP R0.y, R1.x;
MUL R0.x, R0, c[2];
ADD R0.y, -fragment.texcoord[0].z, R0;
POW R0.x, c[6].y, -R0.x;
MUL R1.yzw, R1, c[3].x;
MUL_SAT R0.y, R0, c[5].x;
ADD R0.x, -R0, c[6];
MUL R0.x, R0, R0.y;
MAD result.color.xyz, R0.x, R1.yzww, c[1];
MOV result.color.w, R0.x;
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ZBufferParams]
Vector 1 [vaporColor]
Float 2 [vaporDensity]
Float 3 [lightIntensity]
Vector 4 [lightColor]
Float 5 [inverseFadeDistance]
SetTexture 0 [vaporTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
; 18 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c6, 0.50000000, 0.00000000, 2.71828198, 1.00000000
def c7, 0.00000000, -0.50000000, 0.50000000, 0
dcl_texcoord0 v0
texldp r0, v0, s0
dp4 r1.x, r0, c7.xxyz
dp4 r0.y, r0, c6.xxyy
texldp r0.x, v0, s1
add r1.x, r1, c6
mul r1.xyz, r1.x, c4
mad r2.x, r0, c0.z, c0.w
mul r1.w, r0.y, c2.x
pow r0, c6.z, -r1.w
rcp r0.y, r2.x
add r0.y, -v0.z, r0
mov r0.z, r0.x
mul_sat r0.x, r0.y, c5
add r0.y, -r0.z, c6.w
mul r0.x, r0.y, r0
mul r1.xyz, r1, c3.x
mad oC0.xyz, r0.x, r1, c1
mov oC0.w, r0.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [vaporTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 96
Vector 32 [vaporColor]
Float 48 [vaporDensity]
Float 52 [lightIntensity]
Vector 64 [lightColor]
Float 80 [inverseFadeDistance]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhlnnpnnnjnnjnfefkedifclgilfdjebdabaaaaaajaadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaacaaaa
eaaaaaaaleaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaabaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaaapaaaaakbcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
apaaaaakccaabaaaaaaaaaaaogakbaaaaaaaaaaaaceaaaaaaaaaaalpaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaaaaaaaaa
aeaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegifcaaaaaaaaaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklilp
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}