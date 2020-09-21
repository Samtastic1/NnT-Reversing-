Shader "FMVTexture" {
Properties {
 _MainTex ("Luminance Texture", 2D) = "white" {}
 _CromaTex ("croma texture", 2D) = "white" {}
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
# 5 ALU
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
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
Vector 4 [_MainTex_ST]
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord0 v1
mad oT0.xy, v1, c4, c4.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpppjaaopfmpaljpbndifafimdoppldababaaaaaacmacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefccmabaaaa
eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
aaaaaaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedjnjhdhfchndnolmllohcidaalhegajopabaaaaaabiadaaaaaeaaaaaa
daaaaaaabiabaaaaemacaaaamaacaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpopp
kaaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefccmabaaaa
eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
aaaaaaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CromaTex] 2D 1
"!!ARBfp1.0
# 18 ALU, 2 TEX
PARAM c[4] = { { 1, 0, 1.1644, 1.7927001 },
		{ 0.0625, 0.5 },
		{ 1.1644, -0.2133, -0.53289998 },
		{ 1.1644, 2.1124001, 0 } };
TEMP R0;
TEMP R1;
TEX R0.xy, fragment.texcoord[0], texture[1], 2D;
TEX R1.x, fragment.texcoord[0], texture[0], 2D;
ADD R0.yz, R0.xxyw, -c[1].y;
ADD R0.x, R1, -c[1];
DP3 R1.x, R0, c[0].zyww;
DP3 R1.y, R0, c[2];
SLT R0.w, fragment.texcoord[0].x, c[0].y;
SLT R1.z, fragment.texcoord[0].y, c[0].y;
ADD_SAT R1.z, R0.w, R1;
SLT R1.w, c[0].x, fragment.texcoord[0].x;
ADD_SAT R1.z, R1, R1.w;
SLT R0.w, c[0].x, fragment.texcoord[0].y;
ADD_SAT R0.w, R1.z, R0;
DP3 R1.z, R0, c[3];
ABS R0.x, R0.w;
MOV R1.w, c[0].x;
CMP R0.x, -R0, c[0].y, c[0];
CMP result.color, -R0.x, R1, c[0].xyyx;
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CromaTex] 2D 1
"ps_2_0
; 23 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c0, 0.00000000, 1.00000000, -0.06250000, -0.50000000
def c1, 1.16439998, 0.00000000, 1.79270005, 2.11240005
def c2, 1.16439998, -0.21330000, -0.53289998, 0
dcl t0.xy
texld r1, t0, s0
texld r0, t0, s1
add r4.yz, r0.zxyw, c0.w
add r4.x, r1, c0.z
add r2.x, -t0.y, c0.y
mov r0.x, c1
mov r0.y, c1.w
mov r0.z, c1.y
dp3 r3.z, r4, r0
cmp r1.x, t0.y, c0, c0.y
cmp r0.x, t0, c0, c0.y
add_pp_sat r0.x, r0, r1
add r1.x, -t0, c0.y
cmp r1.x, r1, c0, c0.y
add_pp_sat r0.x, r0, r1
cmp r2.x, r2, c0, c0.y
add_pp_sat r0.x, r0, r2
dp3 r3.x, r4, c1
dp3 r3.y, r4, c2
abs_pp r0.x, r0
mov r1.yz, c0.x
mov r1.xw, c0.y
mov r3.w, c0.y
cmp r0, -r0.x, r3, r1
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CromaTex] 2D 1
"ps_4_0
eefiecedibaioekaaoiadkjeghnjgkcbgocledfbabaaaaaabaadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaacaaaa
eaaaaaaajeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
dbaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadmaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadbaaaaakgcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadp
aaaaaaaaagbbbaaaabaaaaaadmaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadmaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaialnefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaak
gcaabaaaacaaaaaaagabbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaalpaaaaaalp
aaaaaaaaapaaaaakbcaabaaaabaaaaaaaceaaaaaapaljfdpdchhofdpaaaaaaaa
aaaaaaaaigaabaaaacaaaaaabaaaaaakccaabaaaabaaaaaaaceaaaaaapaljfdp
fbglfkloccgmailpaaaaaaaaegacbaaaacaaaaaaapaaaaakecaabaaaabaaaaaa
aceaaaaaapaljfdpjadbaheaaaaaaaaaaaaaaaaaegaabaaaacaaaaaadhaaaaam
pccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaiadpegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CromaTex] 2D 1
"ps_4_0_level_9_1
eefiecedancnahoopbhlnahphffgcamnbkdfohieabaaaaaaeaafaaaaaeaaaaaa
daaaaaaafmacaaaaleaeaaaaamafaaaaebgpgodjceacaaaaceacaaaaaaacpppp
piabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaaaaaaaaiadpaaaaialnaaaaaalp
fbaaaaafabaaapkaapaljfdpaaaaaaaadchhofdpaaaaaaaafbaaaaafacaaapka
apaljfdpfbglfkloccgmailpaaaaaaaafbaaaaafadaaapkaapaljfdpjadbahea
aaaaaaaaaaaaaaaafbaaaaafaeaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadp
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaecaaaaadabaaapiaaaaaoela
abaioekafiaaaaaeaaaaagiaaaaanclaaaaaaakaaaaaffkaacaaaaadaaaaacia
aaaakkiaaaaaffiafiaaaaaeaaaaaciaaaaaffibaaaaaakaaaaaffkaacaaaaad
aaaaaeiaaaaaaalbaaaaffkafiaaaaaeaaaaaeiaaaaakkiaaaaaaakaaaaaffka
acaaaaadaaaaaciaaaaakkiaaaaaffiafiaaaaaeaaaaaciaaaaaffibaaaaaaka
aaaaffkaacaaaaadaaaaaeiaaaaafflbaaaaffkafiaaaaaeaaaaaeiaaaaakkia
aaaaaakaaaaaffkaacaaaaadaaaaaciaaaaakkiaaaaaffiaabaaaaacacaaaiia
aaaaffkaacaaaaadadaaabiaaaaaaaiaaaaakkkaacaaaaadadaaagiaabaancia
aaaappkaaiaaaaadacaaabiaabaaoekaadaaoeiaaiaaaaadacaaaciaacaaoeka
adaaoeiafkaaaaaeacaaaeiaadaaoekaadaaoeiaadaakkkafiaaaaaeaaaaapia
aaaaffibacaaoeiaaeaaoekaabaaaaacaaaiapiaaaaaoeiappppaaaafdeieefc
faacaaaaeaaaaaaajeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadbaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadmaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadbaaaaakgcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaiadpaaaaaaaaagbbbaaaabaaaaaadmaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadmaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaialnefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaakgcaabaaaacaaaaaaagabbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaalp
aaaaaalpaaaaaaaaapaaaaakbcaabaaaabaaaaaaaceaaaaaapaljfdpdchhofdp
aaaaaaaaaaaaaaaaigaabaaaacaaaaaabaaaaaakccaabaaaabaaaaaaaceaaaaa
apaljfdpfbglfkloccgmailpaaaaaaaaegacbaaaacaaaaaaapaaaaakecaabaaa
abaaaaaaaceaaaaaapaljfdpjadbaheaaaaaaaaaaaaaaaaaegaabaaaacaaaaaa
dhaaaaampccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaiadpegaobaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
}