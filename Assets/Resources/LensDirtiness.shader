Shader "Hidden/LensDirtiness" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Pass {
  Name "THRESHOLD"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { { 1 },
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
ADD result.texcoord[0].y, -vertex.texcoord[0], c[0].x;
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.z, -v1.y, c5.y
add r0.y, -r0.x, c5
mul r0.y, r0, r0.z
mad oT0.y, r0.x, v1, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocahmafgaaljdcpnlpenmomcfpkelfkbabaaaaaahiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedkffhagioodagakflffggaohlamlaneijabaaaaaamiadaaaaaeaaaaaa
daaaaaaahmabaaaabmadaaaahaadaaaaebgpgodjeeabaaaaeeabaaaaaaacpopp
aeabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiadpaaaaaaaaaaaaaamaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
abaaffkaaaaaffiaacaaaaadaaaaaciaabaaffjbagaaaakaaeaaaaaeaaaaaeia
aaaaffiaagaakkkaagaaaakaaeaaaaaeaaaaacoaaaaaaaiaaaaakkiaaaaaffia
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaaboaabaaaajappppaaaafdeieefc
jiabaaaaeaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdej
feejepeoaafeeffiedepepfceeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
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
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmjhbmnjmolpgjhmibgphbfibamhbnkeiabaaaaaajiadaaaaaeaaaaaa
daaaaaaagmabaaaaomacaaaaeaadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajappppaaaafdeieefchiabaaaaeaaaabaafoaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaa
akbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Float 0 [gain]
Float 1 [threshold]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0].x;
ADD R1.x, R0, -c[1];
MUL R0, R1.x, R0;
MAX result.color, R0, c[2].x;
END
# 5 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Float 0 [gain]
Float 1 [threshold]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 5 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 0, 0, 0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, c0.x
add r1.x, r0, -c1
mul r0, r1.x, r0
max r0, r0, c2.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 16 [gain]
Float 20 [threshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfipholhlgehmjklaofkcknjocemidbogabaaaaaanaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaabaaaa
eaaaaaaaeeaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadcaaaaambcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaabkiacaiaebaaaaaa
aaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaa
aaaaaaaadeaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 16 [gain]
Float 20 [threshold]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcmjhhfphldlihbanmlhglapnnfiladbkabaaaaaakiacaaaaaeaaaaaa
daaaaaaaaeabaaaabmacaaaaheacaaaaebgpgodjmmaaaaaammaaaaaaaaacpppp
jiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaaaaaoelaaaaioekaafaaaaadabaaapiaaaaaoeiaaaaaaaka
aeaaaaaeaaaaabiaaaaaaaiaaaaaaakaaaaaffkbafaaaaadaaaacpiaabaaoeia
aaaaaaiaalaaaaadabaacpiaaaaaoeiaabaaaakaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcbaabaaaaeaaaaaaaeeaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadcaaaaambcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaadeaaaaakpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
Float 0 [gain]
Float 1 [threshold]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0].x;
ADD R1.x, R0, -c[1];
MUL R0, R1.x, R0;
MAX result.color, R0, c[2].x;
END
# 5 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_OFF" }
Float 0 [gain]
Float 1 [threshold]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 5 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 0, 0, 0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, c0.x
add r1.x, r0, -c1
mul r0, r1.x, r0
max r0, r0, c2.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 16 [gain]
Float 20 [threshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfipholhlgehmjklaofkcknjocemidbogabaaaaaanaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaabaaaa
eaaaaaaaeeaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadcaaaaambcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaabkiacaiaebaaaaaa
aaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaa
aaaaaaaadeaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 16 [gain]
Float 20 [threshold]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcmjhhfphldlihbanmlhglapnnfiladbkabaaaaaakiacaaaaaeaaaaaa
daaaaaaaaeabaaaabmacaaaaheacaaaaebgpgodjmmaaaaaammaaaaaaaaacpppp
jiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaaaaaoelaaaaioekaafaaaaadabaaapiaaaaaoeiaaaaaaaka
aeaaaaaeaaaaabiaaaaaaaiaaaaaaakaaaaaffkbafaaaaadaaaacpiaabaaoeia
aaaaaaiaalaaaaadabaacpiaaaaaoeiaabaaaakaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcbaabaaaaeaaaaaaaeeaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadcaaaaambcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaadeaaaaakpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "DOWNSAMPLE"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { { 1 },
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
ADD result.texcoord[0].y, -vertex.texcoord[0], c[0].x;
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.z, -v1.y, c5.y
add r0.y, -r0.x, c5
mul r0.y, r0, r0.z
mad oT0.y, r0.x, v1, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocahmafgaaljdcpnlpenmomcfpkelfkbabaaaaaahiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedkffhagioodagakflffggaohlamlaneijabaaaaaamiadaaaaaeaaaaaa
daaaaaaahmabaaaabmadaaaahaadaaaaebgpgodjeeabaaaaeeabaaaaaaacpopp
aeabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiadpaaaaaaaaaaaaaamaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
abaaffkaaaaaffiaacaaaaadaaaaaciaabaaffjbagaaaakaaeaaaaaeaaaaaeia
aaaaffiaagaakkkaagaaaakaaeaaaaaeaaaaacoaaaaaaaiaaaaakkiaaaaaffia
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaaboaabaaaajappppaaaafdeieefc
jiabaaaaeaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdej
feejepeoaafeeffiedepepfceeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
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
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmjhbmnjmolpgjhmibgphbfibamhbnkeiabaaaaaajiadaaaaaeaaaaaa
daaaaaaagmabaaaaomacaaaaeaadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajappppaaaafdeieefchiabaaaaeaaaabaafoaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaa
akbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 12 ALU, 4 TEX
PARAM c[1] = { { -0.001, 0.001, 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R1.zw, fragment.texcoord[0].xyxy, c[0].y;
ADD R1.xy, fragment.texcoord[0], c[0];
ADD R0.zw, fragment.texcoord[0].xyxy, c[0].xyyx;
ADD R0.xy, fragment.texcoord[0], c[0].x;
TEX R3, R1.zwzw, texture[0], 2D;
TEX R2, R1, texture[0], 2D;
TEX R1, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[0].z;
END
# 12 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 11 ALU, 4 TEX
dcl_2d s0
def c0, -0.00100000, 0.00100000, 0.25000000, 0
dcl t0.xy
add r3.xy, t0, c0.x
add r1.xy, t0, c0
mov r0.y, c0.x
mov r0.x, c0.y
add r2.xy, t0, r0
add r0.xy, t0, c0.y
texld r0, r0, s0
texld r1, r1, s0
texld r2, r2, s0
texld r3, r3, s0
add r2, r3, r2
add r1, r2, r1
add r0, r1, r0
mul r0, r0, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhpjfjcaaakijmocnpijgpbkieokhbkocabaaaaaageacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckeabaaaa
eaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaaaaaaakpcaabaaaaaaaaaaaegbebaaaabaaaaaaaceaaaaagpbcidlk
gpbcidlkgpbciddkgpbcidlkefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakpcaabaaaabaaaaaaegbebaaa
abaaaaaaaceaaaaagpbcidlkgpbciddkgpbciddkgpbciddkefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiado
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedekbjfhooghehebopldoiedlmikkbfjeaabaaaaaajmadaaaaaeaaaaaa
daaaaaaageabaaaabaadaaaagiadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aeabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkagpbcidlkgpbciddkgpbcidlkaaaaiadobpaaaaac
aaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadiaaaaaoela
aaaaaakaacaaaaadabaaadiaaaaaoelaaaaamjkaacaaaaadacaaadiaaaaaoela
aaaaoekaacaaaaadadaaadiaaaaaoelaaaaaffkaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
aaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaacaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaapiaacaaoeiaaaaaoeiaacaaaaadaaaaapiaadaaoeia
aaaaoeiaafaaaaadaaaacpiaaaaaoeiaaaaappkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaakpcaabaaaaaaaaaaaegbebaaa
abaaaaaaaceaaaaagpbcidlkgpbcidlkgpbciddkgpbcidlkefaaaaajpcaabaaa
abaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
pcaabaaaabaaaaaaegbebaaaabaaaaaaaceaaaaagpbcidlkgpbciddkgpbciddk
gpbciddkefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaa
aaaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadodoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 12 ALU, 4 TEX
PARAM c[1] = { { -0.001, 0.001, 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R1.zw, fragment.texcoord[0].xyxy, c[0].y;
ADD R1.xy, fragment.texcoord[0], c[0];
ADD R0.zw, fragment.texcoord[0].xyxy, c[0].xyyx;
ADD R0.xy, fragment.texcoord[0], c[0].x;
TEX R3, R1.zwzw, texture[0], 2D;
TEX R2, R1, texture[0], 2D;
TEX R1, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[0].z;
END
# 12 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 11 ALU, 4 TEX
dcl_2d s0
def c0, -0.00100000, 0.00100000, 0.25000000, 0
dcl t0.xy
add r3.xy, t0, c0.x
add r1.xy, t0, c0
mov r0.y, c0.x
mov r0.x, c0.y
add r2.xy, t0, r0
add r0.xy, t0, c0.y
texld r0, r0, s0
texld r1, r1, s0
texld r2, r2, s0
texld r3, r3, s0
add r2, r3, r2
add r1, r2, r1
add r0, r1, r0
mul r0, r0, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhpjfjcaaakijmocnpijgpbkieokhbkocabaaaaaageacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckeabaaaa
eaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaaaaaaakpcaabaaaaaaaaaaaegbebaaaabaaaaaaaceaaaaagpbcidlk
gpbcidlkgpbciddkgpbcidlkefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakpcaabaaaabaaaaaaegbebaaa
abaaaaaaaceaaaaagpbcidlkgpbciddkgpbciddkgpbciddkefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiado
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedekbjfhooghehebopldoiedlmikkbfjeaabaaaaaajmadaaaaaeaaaaaa
daaaaaaageabaaaabaadaaaagiadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aeabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkagpbcidlkgpbciddkgpbcidlkaaaaiadobpaaaaac
aaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadiaaaaaoela
aaaaaakaacaaaaadabaaadiaaaaaoelaaaaamjkaacaaaaadacaaadiaaaaaoela
aaaaoekaacaaaaadadaaadiaaaaaoelaaaaaffkaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
aaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaacaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaapiaacaaoeiaaaaaoeiaacaaaaadaaaaapiaadaaoeia
aaaaoeiaafaaaaadaaaacpiaaaaaoeiaaaaappkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaakpcaabaaaaaaaaaaaegbebaaa
abaaaaaaaceaaaaagpbcidlkgpbcidlkgpbciddkgpbcidlkefaaaaajpcaabaaa
abaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
pcaabaaaabaaaaaaegbebaaaabaaaaaaaceaaaaagpbcidlkgpbciddkgpbciddk
gpbciddkefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaa
aaaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadodoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "KAWASE"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { { 1 },
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
ADD result.texcoord[0].y, -vertex.texcoord[0], c[0].x;
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.z, -v1.y, c5.y
add r0.y, -r0.x, c5
mul r0.y, r0, r0.z
mad oT0.y, r0.x, v1, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocahmafgaaljdcpnlpenmomcfpkelfkbabaaaaaahiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedkffhagioodagakflffggaohlamlaneijabaaaaaamiadaaaaaeaaaaaa
daaaaaaahmabaaaabmadaaaahaadaaaaebgpgodjeeabaaaaeeabaaaaaaacpopp
aeabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiadpaaaaaaaaaaaaaamaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
abaaffkaaaaaffiaacaaaaadaaaaaciaabaaffjbagaaaakaaeaaaaaeaaaaaeia
aaaaffiaagaakkkaagaaaakaaeaaaaaeaaaaacoaaaaaaaiaaaaakkiaaaaaffia
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaaboaabaaaajappppaaaafdeieefc
jiabaaaaeaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdej
feejepeoaafeeffiedepepfceeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
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
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmjhbmnjmolpgjhmibgphbfibamhbnkeiabaaaaaajiadaaaaaeaaaaaa
daaaaaaagmabaaaaomacaaaaeaadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajappppaaaafdeieefchiabaaaaeaaaabaafoaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaa
akbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Vector 0 [_ScreenParams]
Float 1 [iteration]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 18 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.y, c[0].y;
RCP R0.x, c[0].x;
MUL R0.zw, R0.xyxy, c[2].x;
MAD R0.xy, R0, c[1].x, R0.zwzw;
ADD R1.xy, fragment.texcoord[0], R0;
ADD R3.xy, fragment.texcoord[0], -R0;
MOV R0.z, R1.x;
MOV R0.w, R3.y;
MOV R0.y, R1;
MOV R0.x, R3;
TEX R2, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
TEX R1, R1, texture[0], 2D;
TEX R3, R3, texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[2].y;
END
# 18 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Vector 0 [_ScreenParams]
Float 1 [iteration]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 15 ALU, 4 TEX
dcl_2d s0
def c2, 0.50000000, 0.25000000, 0, 0
dcl t0.xy
rcp r0.y, c0.y
rcp r0.x, c0.x
mul r1.xy, r0, c2.x
mad r0.xy, r0, c1.x, r1
add r2.xy, t0, r0
add r0.xy, t0, -r0
mov r3.y, r2
mov r3.x, r0
mov r1.x, r2
mov r1.y, r0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r0, r0, s0
add r2, r3, r2
add r1, r2, r1
add r0, r1, r0
mul r0, r0, c2.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 24 [iteration]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmnpmppaegkdcgdbimcbdfenmiimcbggaabaaaaaaomacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccmacaaaa
eaaaaaaailaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaaoaaaaaldcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbgifcaaaabaaaaaaagaaaaaadiaaaaakmcaabaaaaaaaaaaaagaebaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdcaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaakgikcaaaaaaaaaaaabaaaaaaogakbaaaaaaaaaaa
aaaaaaahmcaabaaaabaaaaaaagaebaaaaaaaaaaafgbbbaaaabaaaaaaaaaaaaai
dcaabaaaabaaaaaabgafbaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaalgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaahgapbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaadaaaaaaegaobaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadodoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 24 [iteration]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedoaajkdnojmojchdlehfnflldngmbcchdabaaaaaaleaeaaaaaeaaaaaa
daaaaaaapeabaaaaciaeaaaaiaaeaaaaebgpgodjlmabaaaalmabaaaaaaacpppp
hmabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaabaaagaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaadpaaaaiadoaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaajaaaaiapkaagaaaaacaaaaabiaabaaaakaagaaaaacaaaaacia
abaaffkaafaaaaadaaaaamiaaaaabliaacaaaakaaeaaaaaeaaaaadiaaaaaoeia
aaaakkkaaaaabliaacaaaaadabaaaciaaaaaaaibaaaaaalaacaaaaadabaaabia
aaaaaaiaaaaaaalaacaaaaadabaaaeiaaaaaffiaaaaafflaabaaaaacacaaadia
abaamjiaabaaaaacadaaabiaabaaffiaacaaaaadaaaaaciaaaaaffibaaaaffla
abaaaaacabaaaciaabaakkiaabaaaaacaaaaabiaabaaaaiaabaaaaacadaaacia
aaaaffiaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaadabaaapiaabaaoeia
aaaioekaacaaaaadabaaapiaabaaoeiaacaaoeiaacaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaapiaadaaoeiaaaaaoeiaafaaaaadaaaacpiaaaaaoeia
acaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefccmacaaaaeaaaaaaa
ilaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
ahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aoaaaaaldcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bgifcaaaabaaaaaaagaaaaaadiaaaaakmcaabaaaaaaaaaaaagaebaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdcaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgikcaaaaaaaaaaaabaaaaaaogakbaaaaaaaaaaaaaaaaaah
mcaabaaaabaaaaaaagaebaaaaaaaaaaafgbbbaaaabaaaaaaaaaaaaaidcaabaaa
abaaaaaabgafbaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaalgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaahgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadodoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
Vector 0 [_ScreenParams]
Float 1 [iteration]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 18 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.y, c[0].y;
RCP R0.x, c[0].x;
MUL R0.zw, R0.xyxy, c[2].x;
MAD R0.xy, R0, c[1].x, R0.zwzw;
ADD R1.xy, fragment.texcoord[0], R0;
ADD R3.xy, fragment.texcoord[0], -R0;
MOV R0.z, R1.x;
MOV R0.w, R3.y;
MOV R0.y, R1;
MOV R0.x, R3;
TEX R2, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
TEX R1, R1, texture[0], 2D;
TEX R3, R3, texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[2].y;
END
# 18 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_OFF" }
Vector 0 [_ScreenParams]
Float 1 [iteration]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 15 ALU, 4 TEX
dcl_2d s0
def c2, 0.50000000, 0.25000000, 0, 0
dcl t0.xy
rcp r0.y, c0.y
rcp r0.x, c0.x
mul r1.xy, r0, c2.x
mad r0.xy, r0, c1.x, r1
add r2.xy, t0, r0
add r0.xy, t0, -r0
mov r3.y, r2
mov r3.x, r0
mov r1.x, r2
mov r1.y, r0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r0, r0, s0
add r2, r3, r2
add r1, r2, r1
add r0, r1, r0
mul r0, r0, c2.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 24 [iteration]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmnpmppaegkdcgdbimcbdfenmiimcbggaabaaaaaaomacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccmacaaaa
eaaaaaaailaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaaoaaaaaldcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbgifcaaaabaaaaaaagaaaaaadiaaaaakmcaabaaaaaaaaaaaagaebaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdcaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaakgikcaaaaaaaaaaaabaaaaaaogakbaaaaaaaaaaa
aaaaaaahmcaabaaaabaaaaaaagaebaaaaaaaaaaafgbbbaaaabaaaaaaaaaaaaai
dcaabaaaabaaaaaabgafbaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaalgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaahgapbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaadaaaaaaegaobaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadodoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 24 [iteration]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedoaajkdnojmojchdlehfnflldngmbcchdabaaaaaaleaeaaaaaeaaaaaa
daaaaaaapeabaaaaciaeaaaaiaaeaaaaebgpgodjlmabaaaalmabaaaaaaacpppp
hmabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaabaaagaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaadpaaaaiadoaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaajaaaaiapkaagaaaaacaaaaabiaabaaaakaagaaaaacaaaaacia
abaaffkaafaaaaadaaaaamiaaaaabliaacaaaakaaeaaaaaeaaaaadiaaaaaoeia
aaaakkkaaaaabliaacaaaaadabaaaciaaaaaaaibaaaaaalaacaaaaadabaaabia
aaaaaaiaaaaaaalaacaaaaadabaaaeiaaaaaffiaaaaafflaabaaaaacacaaadia
abaamjiaabaaaaacadaaabiaabaaffiaacaaaaadaaaaaciaaaaaffibaaaaffla
abaaaaacabaaaciaabaakkiaabaaaaacaaaaabiaabaaaaiaabaaaaacadaaacia
aaaaffiaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaadabaaapiaabaaoeia
aaaioekaacaaaaadabaaapiaabaaoeiaacaaoeiaacaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaapiaadaaoeiaaaaaoeiaafaaaaadaaaacpiaaaaaoeia
acaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefccmacaaaaeaaaaaaa
ilaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
ahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aoaaaaaldcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bgifcaaaabaaaaaaagaaaaaadiaaaaakmcaabaaaaaaaaaaaagaebaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdcaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgikcaaaaaaaaaaaabaaaaaaogakbaaaaaaaaaaaaaaaaaah
mcaabaaaabaaaaaaagaebaaaaaaaaaaafgbbbaaaabaaaaaaaaaaaaaidcaabaaa
abaaaaaabgafbaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaalgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaahgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadodoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "COMPOSE"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { { 1 },
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
ADD result.texcoord[0].y, -vertex.texcoord[0], c[0].x;
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.z, -v1.y, c5.y
add r0.y, -r0.x, c5
mul r0.y, r0, r0.z
mad oT0.y, r0.x, v1, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocahmafgaaljdcpnlpenmomcfpkelfkbabaaaaaahiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedkffhagioodagakflffggaohlamlaneijabaaaaaamiadaaaaaeaaaaaa
daaaaaaahmabaaaabmadaaaahaadaaaaebgpgodjeeabaaaaeeabaaaaaaacpopp
aeabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiadpaaaaaaaaaaaaaamaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
abaaffkaaaaaffiaacaaaaadaaaaaciaabaaffjbagaaaakaaeaaaaaeaaaaaeia
aaaaffiaagaakkkaagaaaakaaeaaaaaeaaaaacoaaaaaaaiaaaaakkiaaaaaffia
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaaboaabaaaajappppaaaafdeieefc
jiabaaaaeaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdej
feejepeoaafeeffiedepepfceeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
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
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmjhbmnjmolpgjhmibgphbfibamhbnkeiabaaaaaajiadaaaaaeaaaaaa
daaaaaaagmabaaaaomacaaaaeaadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajappppaaaafdeieefchiabaaaaeaaaabaafoaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaa
akbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "FLIP_V_ON" }
Float 0 [Dirtiness]
Vector 1 [BloomColor]
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 1
SetTexture 2 [DirtinessTexture] 2D 2
"!!ARBfp1.0
# 6 ALU, 3 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R2, R1, R2;
MAD R0, R2, c[0].x, R0;
MAD result.color, R1, c[1], R0;
END
# 6 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_ON" }
Float 0 [Dirtiness]
Vector 1 [BloomColor]
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 1
SetTexture 2 [DirtinessTexture] 2D 2
"ps_2_0
; 4 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl t0.xy
texld r2, t0, s0
texld r1, t0, s1
texld r0, t0, s2
mul r0, r2, r0
mad r0, r0, c0.x, r1
mad r0, r2, c1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 2
SetTexture 2 [DirtinessTexture] 2D 1
ConstBuffer "$Globals" 64
Float 28 [Dirtiness]
Vector 32 [BloomColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecednlfeehdjkgaiomkofbiadapnnblolejaabaaaaaaciacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaa
eaaaaaaafkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_ON" }
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 2
SetTexture 2 [DirtinessTexture] 2D 1
ConstBuffer "$Globals" 64
Float 28 [Dirtiness]
Vector 32 [BloomColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcpbjlekbceeggnakclbimmnjdaiijpmhabaaaaaabmadaaaaaeaaaaaa
daaaaaaacaabaaaajaacaaaaoiacaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpppp
kmaaaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
acababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaecaaaaadaaaaapiaaaaaoelaacaioekaecaaaaadabaaapia
aaaaoelaabaioekaecaaaaadacaaapiaaaaaoelaaaaioekaafaaaaadabaaapia
abaaoeiaacaaoeiaaeaaaaaeaaaaapiaabaaoeiaaaaappkaaaaaoeiaaeaaaaae
aaaacpiaacaaoeiaabaaoekaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaa
acaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "FLIP_V_OFF" }
Float 0 [Dirtiness]
Vector 1 [BloomColor]
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 1
SetTexture 2 [DirtinessTexture] 2D 2
"!!ARBfp1.0
# 6 ALU, 3 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R2, R1, R2;
MAD R0, R2, c[0].x, R0;
MAD result.color, R1, c[1], R0;
END
# 6 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "FLIP_V_OFF" }
Float 0 [Dirtiness]
Vector 1 [BloomColor]
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 1
SetTexture 2 [DirtinessTexture] 2D 2
"ps_2_0
; 4 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl t0.xy
texld r2, t0, s0
texld r1, t0, s1
texld r0, t0, s2
mul r0, r2, r0
mad r0, r0, c0.x, r1
mad r0, r2, c1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 2
SetTexture 2 [DirtinessTexture] 2D 1
ConstBuffer "$Globals" 64
Float 28 [Dirtiness]
Vector 32 [BloomColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecednlfeehdjkgaiomkofbiadapnnblolejaabaaaaaaciacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaa
eaaaaaaafkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FLIP_V_OFF" }
SetTexture 0 [Bloom] 2D 0
SetTexture 1 [OriginalImage] 2D 2
SetTexture 2 [DirtinessTexture] 2D 1
ConstBuffer "$Globals" 64
Float 28 [Dirtiness]
Vector 32 [BloomColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcpbjlekbceeggnakclbimmnjdaiijpmhabaaaaaabmadaaaaaeaaaaaa
daaaaaaacaabaaaajaacaaaaoiacaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpppp
kmaaaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
acababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaecaaaaadaaaaapiaaaaaoelaacaioekaecaaaaadabaaapia
aaaaoelaabaioekaecaaaaadacaaapiaaaaaoelaaaaioekaafaaaaadabaaapia
abaaoeiaacaaoeiaaeaaaaaeaaaaapiaabaaoeiaaaaappkaaaaaoeiaaeaaaaae
aaaacpiaacaaoeiaabaaoekaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaa
acaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}