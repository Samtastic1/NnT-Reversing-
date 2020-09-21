Shader "JAW/FX/Bubble-CompiledAndFixed" {
Properties {
 bubbleRadius ("Bubble Radius", Float) = 1
 bubbleRadiusSquared ("Bubble Radius Squared", Float) = 1
 innerRadiusSquared ("Inner Radius Squared", Float) = 1
 skinColor ("Skin Color", Color) = (1,0,0,1)
 skinDensity ("Skin Density", Float) = 1
 skinEmission ("Skin Emission", Float) = 1
}
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
# 9 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
TEMP R0;
DP4 R0.x, vertex.position, c[4];
DP4 R0.y, vertex.position, c[3];
MOV result.texcoord[0].xy, vertex.position;
MOV result.position.w, R0.x;
MOV result.position.z, R0.y;
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
RCP result.texcoord[0].w, R0.x;
MOV result.texcoord[0].z, R0.y;
END
# 9 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
; 9 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dp4 r0.x, v0, c3
dp4 r0.y, v0, c2
mov o1.xy, v0
mov o0.w, r0.x
mov o0.z, r0.y
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
rcp o1.w, r0.x
mov o1.z, r0.y
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedopgjjjkjhjjlijnikokbcinlcmgemdnaabaaaaaaeiacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefceiabaaaa
eaaaabaafcaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaakiccabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaadgaaaaaf
eccabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_3
eefiecedogfhcdmefghnnehbefhcadkbimhiecieabaaaaaacmadaaaaaeaaaaaa
daaaaaaabaabaaaagaacaaaaneacaaaaebgpgodjniaaaaaaniaaaaaaaaacpopp
keaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaabacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaad
aaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaappjaaaaaoeiaagaaaaacaaaaaioaaaaappiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaaeoaaaaakkia
abaaaaacaaaaadoaaaaaoejappppaaaafdeieefceiabaaaaeaaaabaafcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaoaaaaakiccabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaadgaaaaafeccabaaaabaaaaaa
ckaabaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaaaaaa
gaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafaepfdejfeejepeo
aaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [bubbleRadius]
Float 1 [bubbleRadiusSquared]
Float 2 [innerRadiusSquared]
Vector 3 [skinColor]
Float 4 [skinDensity]
Float 5 [skinEmission]
"3.0-!!ARBfp1.0
# 23 ALU, 0 TEX
PARAM c[7] = { program.local[0..5],
		{ 1, 2.718282 } };
TEMP R0;
MUL R0.xy, fragment.texcoord[0], fragment.texcoord[0];
ADD R0.x, R0, R0.y;
MUL R0.y, -R0.x, c[1].x;
ADD R0.y, R0, c[2].x;
MAD R0.w, -R0.x, c[1].x, c[1].x;
RSQ R0.z, R0.y;
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
RCP R0.z, R0.z;
ADD R0.z, R0.w, -R0;
CMP R0.z, -R0.y, R0, R0.w;
RCP R0.y, c[0].x;
MUL R0.z, -R0, c[4].x;
MUL R0.y, R0.z, R0;
POW R0.y, c[6].y, R0.y;
ADD result.color.w, -R0.y, c[6].x;
SGE R0.y, R0.x, c[6].x;
MOV R0.x, c[6];
KIL -R0.y;
ADD R0.y, R0.x, c[5].x;
ADD R0.x, fragment.texcoord[0].z, -R0.w;
MUL result.color.xyz, R0.y, c[3];
MUL result.depth, R0.x, fragment.texcoord[0].w;
END
# 23 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [bubbleRadius]
Float 1 [bubbleRadiusSquared]
Float 2 [innerRadiusSquared]
Vector 3 [skinColor]
Float 4 [skinDensity]
Float 5 [skinEmission]
"ps_3_0
; 27 ALU, 1 TEX
def c6, -1.00000000, 1.00000000, 0.00000000, 2.71828198
dcl_texcoord0 v0
mul r0.xy, v0, v0
add r0.x, r0, r0.y
mul r0.y, -r0.x, c1.x
mad r0.z, -r0.x, c1.x, c1.x
add r0.y, r0, c2.x
rsq r0.w, r0.y
rsq r0.z, r0.z
add r0.x, r0, c6
cmp r1.y, r0.x, c6, c6.z
mov_pp r2, -r1.y
rcp r1.x, r0.z
rcp r0.w, r0.w
add r0.z, r1.x, -r0.w
cmp r0.y, -r0, r1.x, r0.z
mul r0.y, -r0, c4.x
rcp r0.z, c0.x
mul r1.z, r0.y, r0
pow r0, c6.w, r1.z
mov r0.y, r0.x
mov r0.x, c5
add oC0.w, -r0.y, c6.y
add r0.x, c6.y, r0
add r0.y, v0.z, -r1.x
texkill r2.xyzw
mul oC0.xyz, r0.x, c3
mul oDepth, v0.w, r0.y
"
}
SubProgram "d3d11 " {
ConstBuffer "$Globals" 64
Float 16 [bubbleRadius]
Float 20 [bubbleRadiusSquared]
Float 24 [innerRadiusSquared]
Vector 32 [skinColor] 3
Float 44 [skinDensity]
Float 48 [skinEmission]
BindCB  "$Globals" 0
"ps_4_0
eefiecedahgcocaepbgpjnjpilkfgajglpmkejecabaaaaaadmadaaaaadaaaaaa
cmaaaaaaieaaaaaaniaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaaecaaaaaaaaaaaaaaaaaaaaaaadaaaaaapppppppp
abaoaaaafdfgfpfegbhcghgfheaafdfgfpeegfhahegiaaklfdeieefcfmacaaaa
eaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaagcbaaaadpcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaacabmaaaaagiaaaaacabaaaaaa
apaaaaahbcaabaaaaaaaaaaaegbabaaaabaaaaaaegbabaaaabaaaaaabnaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpanaaaeadbkaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
abaaaaaadcaaaaamfcaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaafgifcaaa
aaaaaaaaabaaaaaakgijcaaaaaaaaaaaabaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackiacaaaaaaaaaaaabaaaaaaelaaaaaffcaabaaaaaaaaaaa
agacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaaaoaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaaiiccabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaiadp
diaaaaaihccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaa
aaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackbabaaaabaaaaaa
diaaaaagabmaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
ConstBuffer "$Globals" 64
Float 16 [bubbleRadius]
Float 20 [bubbleRadiusSquared]
Float 24 [innerRadiusSquared]
Vector 32 [skinColor] 3
Float 44 [skinDensity]
Float 48 [skinEmission]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedbccdegoalnegkjjhcmpjpcfbpokmjgdbabaaaaaacaafaaaaaeaaaaaa
daaaaaaabaacaaaaheaeaaaammaeaaaaebgpgodjniabaaaaniabaaaaaaacpppp
kiabaaaadaaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaaaaadaaaaaaaabaa
adaaaaaaaaaaaaaaabacppppfbaaaaafadaaapkaaaaaaaaaaaaaialpaaaaaaia
dlkklidpbpaaaaacaaaaaaiaaaaaaplafkaaaaaeaaaaaiiaaaaaoelaaaaaoela
adaaaakafkaaaaaeaaaaabiaaaaaoelaaaaaoelaadaaffkafiaaaaaeabaaapia
aaaaaaiaadaaffkaadaakkkaebaaaaababaaapiaaeaaaaaeaaaaabiaaaaappia
aaaaffkaaaaakkkbaeaaaaaeaaaaagiaaaaappiaaaaaffkbaaaaoekaahaaaaac
aaaaaciaaaaaffiaagaaaaacaaaaaciaaaaaffiaahaaaaacaaaaaeiaaaaakkia
agaaaaacaaaaaeiaaaaakkiaacaaaaadaaaaaeiaaaaakkibaaaaffiafiaaaaae
aaaaabiaaaaaaaiaaaaaffiaaaaakkiaafaaaaadaaaaabiaaaaaaaibabaappka
agaaaaacaaaaaeiaaaaaaakaafaaaaadaaaaabiaaaaakkiaaaaaaaiaafaaaaad
aaaaabiaaaaaaaiaadaappkaaoaaaaacaaaaabiaaaaaaaiaacaaaaadabaaaiia
aaaaaaibadaaffkbacaaaaadaaaaabiaaaaaffibaaaakklaafaaaaadaaaaabia
aaaaaaiaaaaapplaabaaaaacaaaaaciaadaaffkaacaaaaadaaaaaciaaaaaffib
acaaaakaafaaaaadabaaahiaaaaaffiaabaaoekaabaaaaacaaaiapiaabaaoeia
abaaaaacaaaiapjaaaaaaaiappppaaaafdeieefcfmacaaaaeaaaaaaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaagcbaaaadpcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagfaaaaacabmaaaaagiaaaaacabaaaaaaapaaaaahbcaabaaa
aaaaaaaaegbabaaaabaaaaaaegbabaaaabaaaaaabnaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpanaaaeadbkaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaadcaaaaam
fcaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaafgifcaaaaaaaaaaaabaaaaaa
kgijcaaaaaaaaaaaabaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaabaaaaaaelaaaaaffcaabaaaaaaaaaaaagacbaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dhaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadkiacaaa
aaaaaaaaacaaaaaaaoaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiiccabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
aaaaaaaaakiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaaihccabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaaaaaaaaibcaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackbabaaaabaaaaaadiaaaaagabmaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaaecaaaaaaaaaaaaaaaaaaaaaa
adaaaaaappppppppabaoaaaafdfgfpfegbhcghgfheaafdfgfpeegfhahegiaakl
"
}
}
 }
}
Fallback "Diffuse"
}