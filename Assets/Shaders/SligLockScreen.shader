Shader "Custom/SligLockScreenAnimating" {
Properties {
 _MainTex ("Background Texture", 2D) = "white" {}
 _FlipTex ("Animation Texture", 2D) = "white" {}
 _Emission ("Emission Strength", Float) = 1
 _XOffset ("Number of Rows", Float) = 1
 _YOffset ("Number of Columns", Float) = 1
 _XAnimationOffset ("Horizontal Animation Offset (Codey)", Float) = 1
 _YAnimationOffset ("Vertical Animation Offset (Codey)", Float) = 1
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Float 5 [_XOffset]
Float 6 [_YOffset]
Float 7 [_XAnimationOffset]
Float 8 [_YAnimationOffset]
"!!ARBvp1.0
# 11 ALU
PARAM c[9] = { program.local[0],
		state.matrix.mvp,
		program.local[5..8] };
TEMP R0;
RCP R0.zw, c[6].x;
MOV R0.y, R0.w;
RCP R0.x, c[5].x;
MUL R0.w, R0.z, c[8].x;
MUL R0.z, R0.x, c[7].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], R0, R0.zwzw;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [_XOffset]
Float 5 [_YOffset]
Float 6 [_XAnimationOffset]
Float 7 [_YAnimationOffset]
"vs_2_0
; 11 ALU
dcl_position0 v0
dcl_texcoord0 v1
rcp r0.zw, c5.x
mov r0.y, r0.w
rcp r0.x, c4.x
mul r0.w, r0.z, c7.x
mul r0.z, r0.x, c6.x
mad oT1.xy, v1, r0, r0.zwzw
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
ConstBuffer "$Globals" 48
Float 20 [_XOffset]
Float 24 [_YOffset]
Float 28 [_XAnimationOffset]
Float 32 [_YAnimationOffset]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjnbamfgfkaifndnnahobpceleejhmhphabaaaaaaoaacaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcmiabaaaaeaaaabaahcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaaidcaabaaaaaaaaaaaegbabaaaacaaaaaajgifcaaaaaaaaaaaabaaaaaa
aoaaaaalmcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
fgijcaaaaaaaaaaaabaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaacaaaaaaaaaaaaahmccabaaaabaaaaaaagaebaaaaaaaaaaa
kgaobaaaabaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Float 20 [_XOffset]
Float 24 [_YOffset]
Float 28 [_XAnimationOffset]
Float 32 [_YAnimationOffset]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecednnoajcanhdmlagbjhpofjpgfakghgpdlabaaaaaabaaeaaaaaeaaaaaa
daaaaaaafmabaaaacmadaaaakaadaaaaebgpgodjceabaaaaceabaaaaaaacpopp
oeaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaagaaaaacaaaaaiiaabaaffka
afaaaaadabaaaiiaaaaappiaabaappkaagaaaaacaaaaaeiaabaakkkaafaaaaad
abaaaeiaaaaakkiaacaaaakaaeaaaaaeaaaaamoaacaabejaaaaaoeiaabaaoeia
afaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
agaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaacaaoejappppaaaafdeieefc
miabaaaaeaaaabaahcaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadmccabaaaabaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaaaoaaaaaidcaabaaaaaaaaaaaegbabaaaacaaaaaa
jgifcaaaaaaaaaaaabaaaaaaaoaaaaalmcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpfgijcaaaaaaaaaaaabaaaaaadiaaaaaiecaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadiaaaaaiicaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaacaaaaaaaaaaaaahmccabaaa
abaaaaaaagaebaaaaaaaaaaakgaobaaaabaaaaaadgaaaaafdccabaaaabaaaaaa
egbabaaaacaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Emission]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
"!!ARBfp1.0
# 3 ALU, 2 TEX
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
MAD result.color, R0, c[0].x, R1;
END
# 3 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Emission]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
"ps_2_0
; 2 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
dcl t0.xy
dcl t1.xy
texld r1, t0, s0
texld r0, t1, s1
mad r0, r0, c0.x, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
ConstBuffer "$Globals" 48
Float 16 [_Emission]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaofaheaghdamppbleepaommdmmoclkidabaaaaaamiabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaaaaaaaeaaaaaaadmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaabaaaaaaegaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
ConstBuffer "$Globals" 48
Float 16 [_Emission]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedefikeaffgdknkadngipecgkjdcicmjalabaaaaaaieacaaaaaeaaaaaa
daaaaaaaoiaaaaaaoaabaaaafaacaaaaebgpgodjlaaaaaaalaaaaaaaaaacpppp
hiaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadia
aaaabllaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoela
aaaioekaaeaaaaaeaaaacpiaaaaaoeiaaaaaaakaabaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcpaaaaaaaeaaaaaaadmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaaagiacaaaaaaaaaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
}
Fallback "Diffuse"
}