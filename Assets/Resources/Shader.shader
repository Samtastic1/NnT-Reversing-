Shader "DirectoryFadeEffectShader" {
Properties {
 _MainTex ("Base", 2D) = "white" {}
 _VignetteTex ("Vignette", 2D) = "white" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.texcoord[1].xy, vertex.texcoord[0];
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
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 14 ALU
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
mad oT1.y, r0.x, r0, r0.z
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT1.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcgpkjomlliambniijdcnofnhhghfopciabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedidfcckgkmojengoiglcaeejdojciidncabaaaaaalmadaaaaaeaaaaaa
daaaaaaagmabaaaapiacaaaaemadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaaeoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaloaabaacejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
iccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Intensity]
Float 1 [_Blur]
Vector 2 [_AbePos]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 2, 1, 0.099975586 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
ADD R2.xy, fragment.texcoord[0], -c[2];
MUL R2.xy, R2, c[3].x;
MUL R2.xy, R2, R2;
ADD R2.x, R2, R2.y;
MUL R2.y, R2.x, c[0].x;
ADD R1, R1, -R0;
MUL_SAT R2.x, R2, c[1];
MAD R2.y, -R2, c[3].z, c[3];
MAD R0, R2.x, R1, R0;
MUL result.color, R0, R2.y;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Intensity]
Float 1 [_Blur]
Vector 2 [_AbePos]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
"ps_2_0
; 11 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c3, 2.00000000, 0.09997559, 1.00000000, 0
dcl t0.xy
dcl t1.xy
texld r2, t0, s0
texld r3, t1, s1
add_pp r0.xy, t0, -c2
mul_pp r0.xy, r0, c3.x
mul_pp r0.xy, r0, r0
add_pp r0.x, r0, r0.y
mul_pp r1.x, r0, c0
add_pp r3, r3, -r2
mul_pp_sat r0.x, r0, c1
mad_pp r1.x, -r1, c3.y, c3.z
mad_pp r0, r0.x, r3, r2
mul r0, r0, r1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
ConstBuffer "$Globals" 48
Float 16 [_Intensity]
Float 20 [_Blur]
Vector 24 [_AbePos] 2
BindCB  "$Globals" 0
"ps_4_0
eefiecedhcfllfnmdpdkbkfmegcpnooepjekahohabaaaaaaliacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaabaaaaeaaaaaaahiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egbabaaaabaaaaaaogikcaiaebaaaaaaaaaaaaaaabaaaaaaaaaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaagaabaaa
aaaaaaaabgifcaaaaaaaaaaaabaaaaaadgcaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
mnmmmmdnabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpccabaaa
aaaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
ConstBuffer "$Globals" 48
Float 16 [_Intensity]
Float 20 [_Blur]
Vector 24 [_AbePos] 2
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedionllchpehagebbnjmnkeobjjodakkipabaaaaaabeaeaaaaaeaaaaaa
daaaaaaaiiabaaaahaadaaaaoaadaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
biabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaa
mnmmmmdnaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaad
aaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaacaaaaad
acaacbiaaaaaaalaaaaakkkbacaaaaadacaacciaaaaafflaaaaappkbacaaaaad
acaacdiaacaaoeiaacaaoeiafkaaaaaeacaacbiaacaaoeiaacaaoeiaabaaaaka
afaaaaadacaadciaacaaaaiaaaaaffkaafaaaaadacaacbiaacaaaaiaaaaaaaka
aeaaaaaeacaaabiaacaaaaiaabaaffkbabaakkkabcaaaaaeadaacpiaacaaffia
aaaaoeiaabaaoeiaafaaaaadaaaacpiaacaaaaiaadaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcoaabaaaaeaaaaaaahiaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaa
ogikcaiaebaaaaaaaaaaaaaaabaaaaaaaaaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaagaabaaaaaaaaaaabgifcaaa
aaaaaaaaabaaaaaadgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaamnmmmmdnabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpccabaaaaaaaaaaafgafbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}