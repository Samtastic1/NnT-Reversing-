Shader "JAW/Clouds" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _UVPanX ("UV X Pan Speed", Float) = 0
 _UVPanY ("UV Y Pan Speed", Float) = 0
 _MainTex2 ("Base (RGB)", 2D) = "white" {}
 _UVPanX2 ("UV X Pan Speed", Float) = 0
 _UVPanY2 ("UV Y Pan Speed", Float) = 0
 _AlphaIntensity ("Alpha Intensity", Range(0,1)) = 1
 _ColorTint ("Colour Tint", Color) = (0.5,0.5,0.5,1)
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="True" "RenderType"="FogBufferClouds" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="True" "RenderType"="FogBufferClouds" }
  ZWrite Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_MainTex_ST]
Vector 6 [_MainTex2_ST]
"!!ARBvp1.0
# 7 ALU
PARAM c[7] = { program.local[0],
		state.matrix.mvp,
		program.local[5..6] };
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[6], c[6].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [_MainTex2_ST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov oD0, v3
mad oT0.xy, v1, c4, c4.zwzw
mad oT1.xy, v2, c5, c5.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 96
Vector 16 [_MainTex_ST]
Vector 48 [_MainTex2_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddmdjnaifahjaccnggbdgbjdahfckobehabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcjmabaaaaeaaaabaaghaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaacaaaaaaagiecaaaaaaaaaaaadaaaaaa
kgiocaaaaaaaaaaaadaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaadaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 96
Vector 16 [_MainTex_ST]
Vector 48 [_MainTex2_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedjfnmhiobonkdhmdnnamonneoopekeplgabaaaaaabeaeaaaaaeaaaaaa
daaaaaaafmabaaaaaaadaaaaiiadaaaaebgpgodjceabaaaaceabaaaaaaacpopp
niaaaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaaaaaadaaabaaacaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
abaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaacaabejaacaabekaacaaleka
afaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
agaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaadaaoejappppaaaafdeieefc
jmabaaaaeaaaabaaghaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaacaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaadaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
hbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaa
hnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaedepemepfcaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Time]
Float 1 [_UVPanX]
Float 2 [_UVPanY]
Float 3 [_UVPanX2]
Float 4 [_UVPanY2]
Float 5 [_AlphaIntensity]
Vector 6 [_ColorTint]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 13 ALU, 2 TEX
PARAM c[7] = { program.local[0..6] };
TEMP R0;
TEMP R1;
MOV R0.y, c[4].x;
MOV R0.x, c[3];
MAD R0.zw, R0.xyxy, c[0].x, fragment.texcoord[1].xyxy;
MOV R0.y, c[2].x;
MOV R0.x, c[1];
MAD R0.xy, R0, c[0].x, fragment.texcoord[0];
TEX R1, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
ADD R1.xyz, R0, R1;
ADD R0.w, R0, R1;
MUL R0.x, R0.w, c[5];
MUL result.color.xyz, R1, c[6];
MUL result.color.w, R0.x, fragment.color.primary;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Time]
Float 1 [_UVPanX]
Float 2 [_UVPanY]
Float 3 [_UVPanX2]
Float 4 [_UVPanY2]
Float 5 [_AlphaIntensity]
Vector 6 [_ColorTint]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 12 ALU, 2 TEX
dcl_2d s0
dcl t0.xy
dcl t1.xy
dcl v0.xyzw
mov_pp r0.y, c4.x
mov_pp r0.x, c3
mad r1.xy, r0, c0.x, t1
mov_pp r0.y, c2.x
mov_pp r0.x, c1
mad r0.xy, r0, c0.x, t0
texld r2, r0, s0
texld r1, r1, s0
add_pp r0.x, r2.w, r1.w
add_pp r1.xyz, r2, r1
mul r0.x, r0, c5
mul_pp r1.xyz, r1, c6
mul r1.w, r0.x, v0
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 32 [_UVPanX]
Float 36 [_UVPanY]
Float 64 [_UVPanX2]
Float 68 [_UVPanY2]
Float 72 [_AlphaIntensity]
Vector 80 [_ColorTint]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedanacgbghjlmjcmkkccoenololhbecbafabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadicbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaaldcaabaaaaaaaaaaaagiacaaa
abaaaaaaaaaaaaaaegiacaaaaaaaaaaaacaaaaaaegbabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaaogbkbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaeaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 32 [_UVPanX]
Float 36 [_UVPanY]
Float 64 [_UVPanX2]
Float 68 [_UVPanY2]
Float 72 [_AlphaIntensity]
Vector 80 [_ColorTint]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedneaaikchcfodlebiogcmdfjoegafibipabaaaaaalaadaaaaaeaaaaaa
daaaaaaafaabaaaapaacaaaahmadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
mmaaaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaaaaeaaacaaabaaaaaaaaaaabaaaaaaabaaadaa
aaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaapla
bpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaaiiaadaaaakaaeaaaaaeaaaaadia
aaaappiaaaaaoekaaaaaoelaaeaaaaaeabaaadiaaaaappiaabaaoekaaaaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeiaaaaioeka
acaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadabaachiaaaaaoeiaacaaoeka
afaaaaadaaaaabiaaaaappiaabaakkkaafaaaaadabaaciiaaaaaaaiaabaappla
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadicbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaaldcaabaaaaaaaaaaa
agiacaaaabaaaaaaaaaaaaaaegiacaaaaaaaaaaaacaaaaaaegbabaaaabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaaogbkbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaeaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaacaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}