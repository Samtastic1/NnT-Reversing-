Shader "Custom/StatusBoardAdSlide" {
Properties {
 _MainTex ("Current Ad", 2D) = "white" {}
 _NextTex ("Next Ad", 2D) = "white" {}
 _OffsetAd ("Ad fade offset", Float) = 1
 _Color ("Main Color", Color) = (1,1,1,1)
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
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
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedlfkcgifjpgpncnfigmnbfdfbngenmafkabaaaaaanmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaaieacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaacaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfcee
aaklklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_OffsetAd]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_NextTex] 2D 1
"!!ARBfp1.0
# 14 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[2];
ADD R0.x, R0, -c[0];
ADD R2.x, fragment.texcoord[0], R0;
MOV R2.y, fragment.texcoord[0];
ADD R0.x, R2, -c[2];
MOV R0.y, fragment.texcoord[0];
TEX R1, R2, texture[0], 2D;
TEX R0, R0, texture[1], 2D;
SGE R2.x, c[2], R2;
ABS R2.x, R2;
MUL R0, R0, c[1];
MUL R1, R1, c[1];
CMP R2.x, -R2, c[2].y, c[2];
CMP result.color, -R2.x, R0, R1;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_OffsetAd]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_NextTex] 2D 1
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 1.00000000, 0.00000000, -1.00000000, 0
dcl t0.xy
mov r0.x, c0
add r0.x, c2, -r0
add r0.x, t0, r0
mov_pp r0.y, t0
add r1.x, r0, c2.z
mov_pp r1.y, t0
texld r2, r0, s0
texld r1, r1, s1
add_pp r0.x, -r0, c2
cmp_pp r0.x, r0, c2, c2.y
mul r1, r1, c1
mul r2, r2, c1
abs_pp r0.x, r0
cmp_pp r0, -r0.x, r1, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_NextTex] 2D 1
ConstBuffer "$Globals" 48
Float 16 [_OffsetAd]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedahbdbigpaojhbdmfncjolcpacpidcplpabaaaaaaeiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiabaaaa
eaaaaaaagcaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajecaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaiaebaaaaaaaaaaaaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpbnaaaaahbcaabaaaabaaaaaaabeaaaaa
aaaaiadpakaabaaaaaaaaaaadgaaaaafkcaabaaaaaaaaaaafgbfbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaabpaaaeadakaabaaaabaaaaaadiaaaaaipccabaaaaaaaaaaa
egaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadoaaaaabbcaaaaabdiaaaaai
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaadoaaaaab
bfaaaaabdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_NextTex] 2D 1
ConstBuffer "$Globals" 48
Float 16 [_OffsetAd]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjghifgmdcmbgmdmpnmlbgebeacopecibabaaaaaahiadaaaaaeaaaaaa
daaaaaaafmabaaaaomacaaaaeeadaaaaebgpgodjceabaaaaceabaaaaaaacpppp
omaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaacciaaaaafflaacaaaaad
aaaaabiaaaaaaalaaaaaaakbacaaaaadabaacbiaaaaaaaiaacaaaakaabaaaaac
abaacciaaaaafflaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadacaaapia
abaaoeiaaaaioekaafaaaaadaaaacpiaaaaaoeiaabaaoekaacaaaaadabaaabia
abaaaaibacaaaakaafaaaaadacaacpiaacaaoeiaabaaoekafiaaaaaeaaaacpia
abaaaaiaacaaoeiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
iiabaaaaeaaaaaaagcaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajecaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaabaaaaaaaaaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpbnaaaaahbcaabaaaabaaaaaa
abeaaaaaaaaaiadpakaabaaaaaaaaaaadgaaaaafkcaabaaaaaaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaabpaaaeadakaabaaaabaaaaaadiaaaaaipccabaaa
aaaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadoaaaaabbcaaaaab
diaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
doaaaaabbfaaaaabdoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}