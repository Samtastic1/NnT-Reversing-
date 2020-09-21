Shader "JAW/CloudsFogBuffer" {
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
 Tags { "QUEUE"="Transparent" "RenderType"="FogBufferClouds" "RenderEffect"="FogBufferClouds" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="FogBufferClouds" "RenderEffect"="FogBufferClouds" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [_MainTex_ST]
Vector 7 [_MainTex2_ST]
"!!ARBvp1.0
# 12 ALU
PARAM c[8] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[6], c[6].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[7], c[7].zwzw;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_MainTex_ST]
Vector 7 [_MainTex2_ST]
"vs_2_0
; 12 ALU
def c8, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c8.x
mul r1.y, r1, c4.x
mad oT2.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mov oD0, v3
mad oT0.xy, v1, c6, c6.zwzw
mad oT1.xy, v2, c7, c7.zwzw
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
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhinpdeicmffldijicihjdikcgnaolkldabaaaaaakeadaaaaadaaaaaa
cmaaaaaaleaaaaaafiabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefceeacaaaa
eaaaabaajbaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
pcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
aaaaaaaaabaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaacaaaaaaagiecaaa
aaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaa
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
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedibokokffkgjboecgcdgjmnameecmbaajabaaaaaaeeafaaaaaeaaaaaa
daaaaaaammabaaaabiaeaaaakaaeaaaaebgpgodjjeabaaaajeabaaaaaaacpopp
dmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaabaa
abaaabaaaaaaaaaaaaaaadaaabaaacaaaaaaaaaaabaaafaaabaaadaaaaaaaaaa
acaaaaaaaeaaaeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafaiaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaacaabejaacaabeka
acaalekaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaaka
afaaaaadabaaaiiaabaaaaiaaiaaaakaafaaaaadabaaafiaaaaapeiaaiaaaaka
acaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiaabaaaaac
acaaapoaadaaoejappppaaaafdeieefceeacaaaaeaaaabaajbaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaacaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaahbaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaa
epfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Time]
Vector 1 [_ProjectionParams]
Vector 2 [_ZBufferParams]
Float 3 [_UVPanX]
Float 4 [_UVPanY]
Float 5 [_UVPanX2]
Float 6 [_UVPanY2]
Float 7 [_AlphaIntensity]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"!!ARBfp1.0
# 20 ALU, 3 TEX
PARAM c[9] = { program.local[0..7],
		{ 1, 0 } };
TEMP R0;
TEMP R1;
MOV R0.w, c[6].x;
MOV R0.z, c[5].x;
MAD R1.xy, R0.zwzw, c[0].x, fragment.texcoord[1];
MOV R0.y, c[4].x;
MOV R0.x, c[3];
MAD R0.xy, R0, c[0].x, fragment.texcoord[0];
TEX R0.w, R0, texture[0], 2D;
TXP R0.x, fragment.texcoord[2], texture[1], 2D;
TEX R1.w, R1, texture[0], 2D;
MAD R0.y, R0.x, c[2].x, c[2];
RCP R0.x, c[1].z;
MUL R0.x, fragment.texcoord[2].z, R0;
RCP R0.y, R0.y;
SLT R0.y, R0.x, R0;
ADD R0.x, R0.w, R1.w;
ABS R0.y, R0;
MUL R0.x, R0, c[7];
CMP R0.y, -R0, c[8], c[8].x;
MUL result.color.w, R0.x, fragment.color.primary;
CMP result.color.xyz, -R0.y, c[8].x, c[8].y;
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Time]
Vector 1 [_ProjectionParams]
Vector 2 [_ZBufferParams]
Float 3 [_UVPanX]
Float 4 [_UVPanY]
Float 5 [_UVPanX2]
Float 6 [_UVPanY2]
Float 7 [_AlphaIntensity]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2
dcl v0.xyzw
mov_pp r0.y, c4.x
mov_pp r0.x, c3
mad r0.xy, r0, c0.x, t0
mov_pp r1.y, c6.x
mov_pp r1.x, c5
mad r1.xy, r1, c0.x, t1
texld r2, r0, s0
texld r1, r1, s0
texldp r0, t2, s1
rcp r1.x, c1.z
mad r0.x, r0, c2, c2.y
rcp r0.x, r0.x
mad r0.x, t2.z, r1, -r0
cmp r0.x, r0, c8, c8.y
add_pp r1.x, r2.w, r1.w
abs_pp r2.x, r0
mul r0.x, r1, c7
cmp r1.xyz, -r2.x, c8.y, c8.x
mul r1.w, r0.x, v0
mov oC0, r1
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 96
Float 32 [_UVPanX]
Float 36 [_UVPanY]
Float 64 [_UVPanX2]
Float 68 [_UVPanY2]
Float 72 [_AlphaIntensity]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcbcpjbcddbjbfmpjonicfgcblggmbeigabaaaaaaliadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefckmacaaaaeaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaaakiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaoaaaaaiccaabaaaaaaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
afaaaaaadbaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dhaaaaaphccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaal
dcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaaaaaaaaaaacaaaaaa
egbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaaaaaaaaaagiacaaaabaaaaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogbkbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaah
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaadiaaaaahiccabaaa
aaaaaaaaakaabaaaaaaaaaaadkbabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 96
Float 32 [_UVPanX]
Float 36 [_UVPanY]
Float 64 [_UVPanX2]
Float 68 [_UVPanY2]
Float 72 [_AlphaIntensity]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedpbceiphhdbkaagoonmbeidanpgglbbjeabaaaaaajiafaaaaaeaaaaaa
daaaaaaaamacaaaamaaeaaaageafaaaaebgpgodjneabaaaaneabaaaaaaacpppp
gmabaaaagiaaaaaaafaacmaaaaaagiaaaaaagiaaacaaceaaaaaagiaaabaaaaaa
aaababaaaaaaacaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaaabaaaaaa
abaaacaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaabaaahaaabaaaeaaaaaaaaaa
aaacppppfbaaaaafafaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiia
abaapplaafaaaaadaaaaadiaaaaappiaabaaoelaabaaaaacabaaaiiaacaaaaka
aeaaaaaeabaaadiaabaappiaaaaaoekaaaaaoelaaeaaaaaeacaaadiaabaappia
abaaoekaaaaabllaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaadabaacpia
abaaoeiaabaioekaecaaaaadacaacpiaacaaoeiaabaioekaaeaaaaaeaaaaabia
aeaaaakaaaaaaaiaaeaaffkaagaaaaacaaaaabiaaaaaaaiaagaaaaacaaaaacia
adaakkkaaeaaaaaeaaaaabiaabaakklaaaaaffiaaaaaaaibfiaaaaaeaaaaahia
aaaaaaiaafaaaakaafaaffkaacaaaaadabaaabiaabaappiaacaappiaafaaaaad
abaaabiaabaaaaiaabaakkkaafaaaaadaaaaaiiaabaaaaiaacaapplaabaaaaac
aaaiapiaaaaaoeiappppaaaafdeieefckmacaaaaeaaaaaaaklaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadicbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaa
aaaaaaaaakiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaa
ahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaoaaaaaiccaabaaaaaaaaaaackbabaaaacaaaaaa
ckiacaaaabaaaaaaafaaaaaadbaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaaphccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaaldcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaa
aaaaaaaaacaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaaaaaaaaa
agiacaaaabaaaaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogbkbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaa
diaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaadaaaaaadoaaaaab
ejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}