Shader "JAW/FX/Distortion/Ripple" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _RippleTex ("Ripple Texture", 2D) = "" {}
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
eefiecedaffpdldohodkdgpagjklpapmmnbhcfmlabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedmomopcjkglcmfiigcnlfbdoahcohgpeoabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Params]
Vector 1 [_Center]
SetTexture 0 [_RippleTex] 2D 0
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 2, -1, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
ADD R0.xy, fragment.texcoord[0], c[1];
MAD R0.xy, R0, c[2].x, c[2].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD R0.z, R0, R0.w;
RSQ R0.z, R0.z;
RCP R2.x, R0.z;
MAD R0.w, R2.x, c[0].x, -c[0].y;
MIN R1.x, R2, c[0].w;
COS R0.w, R0.w;
MAX R1.x, R1, c[2].z;
ADD R2.x, R2, c[1].z;
ADD_SAT R2.x, R2, -c[2];
RCP R1.y, c[0].w;
ADD R1.x, -R1, c[0].w;
MUL R1.x, R1, R1.y;
MUL R0.w, R0, c[0].z;
MUL R0.w, R0, R1.x;
MUL R0.xy, R0.z, R0;
MAD R1.xy, R0, R0.w, fragment.texcoord[0];
ADD R2.y, -R2.x, c[2].w;
TEX R0, R1, texture[0], 2D;
TEX R1, R1, texture[1], 2D;
MUL R1, R1, R2.y;
MAD result.color, R0, R2.x, R1;
END
# 24 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Params]
Vector 1 [_Center]
SetTexture 0 [_RippleTex] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
; 33 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c3, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c4, 2.00000000, -1.00000000, 0.15915491, 0.50000000
def c5, 6.28318501, -3.14159298, 0.00000000, -2.00000000
dcl t0.xy
add r0.xy, t0, c1
mad r5.xy, r0, c4.x, c4.y
mul r0.xy, r5, r5
add r0.x, r0, r0.y
rsq r1.x, r0.x
rcp r0.x, r1.x
mad r2.x, r0, c0, -c0.y
mad r2.x, r2, c4.z, c4.w
frc r2.x, r2
mad r2.x, r2, c5, c5.y
sincos r4.xy, r2.x, c3.xyzw, c2.xyzw
min r2.x, r0, c0.w
max r3.x, r2, c5.z
add r0.x, r0, c1.z
add r3.x, -r3, c0.w
rcp r2.x, c0.w
mul r2.x, r3, r2
mul r3.x, r4, c0.z
mul r2.x, r3, r2
mul r1.xy, r1.x, r5
mad r1.xy, r1, r2.x, t0
add_sat r0.x, r0, c5.w
texld r3, r1, s0
texld r2, r1, s1
add r1.x, -r0, c2.z
mul r1, r2, r1.x
mad r0, r3, r0.x, r1
mov oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_RippleTex] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_Params]
Vector 32 [_Center]
BindCB  "$Globals" 0
"ps_4_0
eefiecedijfkbofjipkadfnfnkjijohcbipbiafjabaaaaaammadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamadaaaa
eaaaaaaamdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaaidcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaadcaaaaapdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaddaaaaai
icaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaaj
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaa
aoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaa
dcaaaaambcaabaaaabaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaabaaaaaaenaaaaagaanaaaaabcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaa
aaaaaaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
aacaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaaegbabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahpcaabaaaabaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpccabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_RippleTex] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_Params]
Vector 32 [_Center]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddiflgdpobmcjaplhabndhceicgnihkldabaaaaaaciagaaaaaeaaaaaa
daaaaaaaiiacaaaajmafaaaapeafaaaaebgpgodjfaacaaaafaacaaaaaaacpppp
biacaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaabaaaaaa
aaababaaaaaaabaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaaamafbaaaaafadaaapkaidpjccdoaaaaaadpnlapmjea
nlapejmafbaaaaafaeaaapkaabannalfgballglhklkkckdlijiiiidjfbaaaaaf
afaaapkaklkkkklmaaaaaaloaaaaiadpaaaaaadpbpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaacaaaaadaaaaadia
aaaaoelaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaacaaaakaacaaffkafkaaaaae
aaaaaeiaaaaaoeiaaaaaoeiaacaakkkaahaaaaacaaaaaeiaaaaakkiaagaaaaac
aaaaaiiaaaaakkiaafaaaaadaaaaadiaaaaakkiaaaaaoeiaaeaaaaaeaaaaaeia
aaaappiaaaaaaakaaaaaffkbaeaaaaaeaaaaaeiaaaaakkiaadaaaakaadaaffka
bdaaaaacaaaaaeiaaaaakkiaaeaaaaaeaaaaaeiaaaaakkiaadaakkkaadaappka
cfaaaaaeabaaabiaaaaakkiaaeaaoekaafaaoekaafaaaaadaaaaaeiaabaaaaia
aaaakkkaakaaaaadabaaabiaaaaappkaaaaappiaacaaaaadaaaaaiiaaaaappia
abaakkkaacaaaaadaaaabiiaaaaappiaacaappkaacaaaaadabaaabiaabaaaaib
aaaappkaagaaaaacabaaaciaaaaappkaafaaaaadabaaabiaabaaffiaabaaaaia
afaaaaadaaaaaeiaaaaakkiaabaaaaiaaeaaaaaeaaaaadiaaaaaoeiaaaaakkia
aaaaoelaecaaaaadabaaapiaaaaaoeiaabaioekaecaaaaadacaaapiaaaaaoeia
aaaioekabcaaaaaeadaaapiaaaaappiaabaaoeiaacaaoeiaabaaaaacaaaiapia
adaaoeiappppaaaafdeieefcamadaaaaeaaaaaaamdaaaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aaaaaaaidcaabaaaaaaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaa
dcaaaaapdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
ecaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaaaaaaaaajicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaadcaaaaambcaabaaaabaaaaaackaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaa
enaaaaagaanaaaaabcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgakbaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaackiacaaaaaaaaaaaacaaaaaaaacaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaamadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaibcaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaa
abaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaajpccabaaaaaaaaaaa
egaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}