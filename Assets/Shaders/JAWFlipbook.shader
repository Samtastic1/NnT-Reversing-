Shader "Custom/JAWFlipbook" {
Properties {
 _MainTex ("Background Texture", 2D) = "white" {}
 _FlipTex ("Animation Texture", 2D) = "white" {}
 _XOffset ("Number of Columns", Float) = 1
 _YOffset ("Number of Rows", Float) = 1
 _Speed ("FPS", Float) = 1
}
SubShader { 
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_Time]
Float 6 [_XOffset]
Float 7 [_YOffset]
Float 8 [_Speed]
"!!ARBvp1.0
# 14 ALU
PARAM c[9] = { program.local[0],
		state.matrix.mvp,
		program.local[5..8] };
TEMP R0;
MOV R0.y, c[8].x;
MUL R0.z, R0.y, c[5].y;
RCP R0.xw, c[7].x;
MOV R0.y, R0.x;
FLR R0.z, R0;
RCP R0.x, c[6].x;
MUL R0.w, R0.z, R0;
MUL R0.z, R0, R0.x;
MAD result.texcoord[1].xy, vertex.texcoord[0], R0, R0.zwzw;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Time]
Float 5 [_XOffset]
Float 6 [_YOffset]
Float 7 [_Speed]
"vs_2_0
; 16 ALU
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c4.y
mul r0.z, c7.x, r0.x
frc r0.w, r0.z
add r0.z, r0, -r0.w
rcp r0.xy, c6.x
mul r0.w, r0.z, r0.x
rcp r0.x, c5.x
mul r0.z, r0, r0.x
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
ConstBuffer "$Globals" 32
Float 16 [_XOffset]
Float 20 [_YOffset]
Float 24 [_Speed]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedepgjccecmcoboblnjbcpealapokgpcdfabaaaaaanmacaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcmeabaaaaeaaaabaahbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaackiacaaa
aaaaaaaaabaaaaaabkiacaaaabaaaaaaaaaaaaaaebaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaaoaaaaaidcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiacaaa
aaaaaaaaabaaaaaaaoaaaaaimcaabaaaaaaaaaaaagbebaaaacaaaaaaagiecaaa
aaaaaaaaabaaaaaaaaaaaaahmccabaaaabaaaaaaagaebaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Float 16 [_XOffset]
Float 20 [_YOffset]
Float 24 [_Speed]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedjhddbimbbbghchedlgjaphaamimlkolcabaaaaaaeaaeaaaaaeaaaaaa
daaaaaaajaabaaaafmadaaaanaadaaaaebgpgodjfiabaaaafiabaaaaaaacpopp
amabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
abaaaaacaaaaaeiaabaakkkaafaaaaadaaaaabiaaaaakkiaacaaffkabdaaaaac
aaaaaciaaaaaaaiaacaaaaadaaaaabiaaaaaffibaaaaaaiaagaaaaacaaaaaiia
abaaaakaagaaaaacaaaaaeiaabaaffkaafaaaaadaaaaadiaaaaaooiaaaaaaaia
aeaaaaaeaaaaamoaacaabejaaaaaoeiaaaaaeeiaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadoaacaaoejappppaaaafdeieefcmeabaaaaeaaaabaahbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaackiacaaa
aaaaaaaaabaaaaaabkiacaaaabaaaaaaaaaaaaaaebaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaaoaaaaaidcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiacaaa
aaaaaaaaabaaaaaaaoaaaaaimcaabaaaaaaaaaaaagbebaaaacaaaaaaagiecaaa
aaaaaaaaabaaaaaaaaaaaaahmccabaaaabaaaaaaagaebaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaaaaaagaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapadaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaklklklepfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
"!!ARBfp1.0
# 3 ALU, 2 TEX
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
ADD result.color, R0, R1;
END
# 3 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
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
add r0, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
"ps_4_0
eefiecedbajopjkjnkjfmkiajdgfmeknkcigdlnmabaaaaaakmabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneaaaaaaeaaaaaaadfaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_FlipTex] 2D 1
"ps_4_0_level_9_1
eefiecedfhoncidjcpehhfnfljonpdemlhchmnfnabaaaaaafiacaaaaaeaaaaaa
daaaaaaaniaaaaaaleabaaaaceacaaaaebgpgodjkaaaaaaakaaaaaaaaaacpppp
heaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadaaaaapia
aaaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaacaaaaadaaaacpia
aaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcneaaaaaa
eaaaaaaadfaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}