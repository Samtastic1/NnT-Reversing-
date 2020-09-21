Shader "Hidden/Camera-DepthTexture" {
Properties {
 _MainTex ("", 2D) = "white" {}
 _Cutoff ("", Float) = 0.5
 _Color ("", Color) = (1,1,1,1)
 _ExtrusionAmount ("Extrusion Amount", Range(-2,2)) = 0.5
}
SubShader { 
 Tags { "RenderType"="AtsFoliageTerrain" }
 Pass {
  Tags { "RenderType"="AtsFoliageTerrain" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_Wind]
Float 11 [_Windows]
"!!ARBvp1.0
# 70 ALU
PARAM c[14] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..11],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R3.x, c[0].w;
DP3 R3.y, R3.x, c[8];
ADD R0.y, vertex.color.x, R3;
ADD R0.x, vertex.color.y, R0.y;
ADD R0.zw, vertex.position.xyxz, c[9].y;
DP3 R0.x, vertex.position, R0.x;
ADD R0.xy, R0, R0.zwzw;
MUL R1, R0.xxyy, c[12];
ADD R0.x, vertex.color.z, R3.y;
FRC R1, R1;
MUL R1, R1, c[13].x;
ADD R1, R1, c[0].x;
FRC R1, R1;
MUL R1, R1, c[13].x;
ADD R1, R1, -c[0].w;
ADD R2.x, vertex.color.y, R0;
MOV R0.y, R0.x;
DP3 R0.x, vertex.position, R2.x;
ABS R1, R1;
MAD R2, -R1, c[13].x, c[13].y;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[12];
FRC R0, R0;
MUL R0, R0, c[13].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[13].x;
MUL R1, R1, R1;
MUL R1, R1, R2;
ADD R3.zw, R1.xyxz, R1.xyyw;
MUL R2.xyz, R3.w, c[10];
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[13].x, c[13].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
SLT R1.xy, c[0].z, vertex.normal.xzzw;
SLT R1.zw, vertex.normal.xyxz, c[0].z;
ADD R1.zw, R1.xyxy, -R1;
MUL R2.w, vertex.color.y, c[13].z;
MUL R1.xy, vertex.normal.xzzw, R2.w;
MUL R1.xz, R1.xyyw, R1.zyww;
MUL R1.y, vertex.color.z, c[0];
MUL R2.xyz, vertex.color.z, R2;
MAD R2.xyz, R3.zwzw, R1, R2;
ADD R3.zw, R0.xyxz, R0.xyyw;
MAD R4.xyz, R2, c[10].w, vertex.position;
ADD R0.w, -R3.x, c[11].x;
MUL R0.xyz, R3.w, c[10];
MUL R2.xyz, vertex.color.z, c[10];
ABS R0.w, R0;
SGE R0.w, c[0].z, R0;
ABS R0.w, R0;
SGE R3.x, c[0].z, R0.w;
MUL R1.y, vertex.color.x, c[0];
MUL R0.xyz, vertex.color.x, R0;
MAD R0.xyz, R3.zwzw, R1, R0;
MAD R1.xyz, R0, c[10].w, vertex.position;
MUL R0.xyz, vertex.color.x, c[10];
MAD R0.xyz, R0, R3.y, R1;
MOV R0.w, vertex.position;
MAD R2.xyz, R2, R3.y, R4;
MOV R2.w, vertex.position;
ADD R1, R2, -R0;
MAD R0, R1, R3.x, R0;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 70 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [_Wind]
Float 10 [_Windows]
"vs_2_0
; 83 ALU
def c11, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c12, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c13, 2.00000000, 3.00000000, 0.10000000, 0.22500001
def c14, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r3.x, c11.x, r0
add r1.z, v5, r3.x
add r0.y, v5.x, r3.x
add r0.x, v5.y, r0.y
add r2.x, v5.y, r1.z
mov r1.w, r1.z
dp3 r1.z, v0, r2.x
add r1.xy, v0.xzzw, c8.y
dp3 r0.x, v0, r0.x
add r0.xy, r0, r1
mul r0, r0.xxyy, c12
add r1.xy, r1, r1.zwzw
frc r0, r0
mul r1, r1.xxyy, c12
mad r0, r0, c11.y, c11.z
frc r1, r1
frc r0, r0
mad r1, r1, c11.y, c11.z
frc r1, r1
mad r0, r0, c11.y, c11.w
mad r2, r1, c11.y, c11.w
abs r0, r0
mad r1, -r0, c13.x, c13.y
mul r0, r0, r0
mul r0, r0, r1
abs r1, r2
add r3.zw, r0.xyxz, r0.xyyw
mad r0, -r1, c13.x, c13.y
mul r1, r1, r1
mul r0, r1, r0
mul r1.xyz, r3.w, c9
slt r2.xy, -v2.xzzw, v2.xzzw
slt r2.zw, v2.xyxz, -v2.xyxz
sub r2.zw, r2.xyxy, r2
mul r1.w, v5.y, c13.z
mul r2.xy, v2.xzzw, r1.w
mul r4.xz, r2.xyyw, r2.zyww
mul r2.xyz, v5.z, r1
mov r1.w, c11.x
mov r1.xz, r4
mul r1.y, v5.z, c13.w
mad r1.xyz, r3.zwzw, r1, r2
add r3.zw, r0.xyxz, r0.xyyw
mul r2.xyz, r3.w, c9
mad r1.xyz, r1, c9.w, v0
mul r0.xyz, v5.z, c9
mad r0.xyz, r0, r3.x, r1
mul r1.xyz, v5.x, r2
mov r0.w, c10.x
sge r2.x, c11, r0.w
sge r0.w, c10.x, r1
mul r0.w, r0, r2.x
sge r1.w, c14.x, r0
mul r4.y, v5.x, c13.w
mad r1.xyz, r3.zwzw, r4, r1
mad r2.xyz, r1, c9.w, v0
sge r0.w, r0, c14.x
mul r0.w, r0, r1
mul r1.xyz, v5.x, c9
mad r1.xyz, r1, r3.x, r2
max r0.w, -r0, r0
slt r2.x, c14, r0.w
add r0.w, -r2.x, c11.x
mov r1.w, v0
mul r1, r0.w, r1
mov r0.w, v0
mad r1, r2.x, r0, r1
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
mov oT0.xy, v3
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 48 [_Wind]
Float 64 [_Windows]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddjdgccdkliinmjdoojlilmjjmchngpahabaaaaaaomakaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjiajaaaaeaaaabaaggacaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacafaaaaaa
biaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaiadp
bpaaaeadakaabaaaaaaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaadkiacaaaacaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaackbabaaaafaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaabaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaaaaaaaafgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaalpbkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaa
egaobaiaibaaaaaaabaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaa
abaaaaaaegaobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaa
fgahbaaaabaaaaaaagacbaaaabaaaaaadiaaaaakfcaabaaaabaaaaaafgbebaaa
afaaaaaaaceaaaaamnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahdcaabaaa
acaaaaaaagaabaaaabaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagbibaaaacaaaaaadbaaaaak
dcaabaaaadaaaaaaigbabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
adaaaaaaclaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahkcaabaaa
abaaaaaakgaobaaaacaaaaaaagaebaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaafaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaa
aaaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadcaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaagbabaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
bcaaaaabdgaaaaagbcaabaaaabaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaabaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaa
dkiacaaaacaaaaaaaoaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
kgakbaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaangafbaaaabaaaaaa
igaabaaaabaaaaaadiaaaaakfcaabaaaacaaaaaafgbgbaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahdcaabaaaadaaaaaaagaabaaa
acaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaagbibaaaacaaaaaadbaaaaakdcaabaaaaeaaaaaa
igbabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
mcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaaaeaaaaaaclaaaaaf
mcaabaaaadaaaaaakgaobaaaadaaaaaadiaaaaahkcaabaaaacaaaaaakgaobaaa
adaaaaaaagaebaaaadaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
kgbkbaaaafaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaajgahbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
kgbkbaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabfaaaaabdiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaa
egbabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 48 [_Wind]
Float 64 [_Windows]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedelcekiomgodgkmifmehfdbbaoolobpffabaaaaaameapaaaaaeaaaaaa
daaaaaaaaeafaaaakeaoaaaagmapaaaaebgpgodjmmaeaaaammaeaaaaaaacpopp
heaeaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaadaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaaaaaaaeaaaeaaaaaaaaaa
acaaamaaadaaaiaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafalaaapkamnmmpmdp
amaceldpaaaamadomlkbefdofbaaaaafamaaapkaaaaaialpaaaaiadpaaaaaaea
aaaaaalpfbaaaaafanaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaafiaafaaapjaamaaaaadaaaaadiaacaaoijbacaaoijaamaaaaad
aaaaamiaacaaiejaacaaiejbacaaaaadaaaaadiaaaaaooibaaaaoeiaafaaaaad
aaaaaeiaafaaffjaanaakkkaafaaaaadaaaaamiaaaaakkiaacaaiejaafaaaaad
aaaaadiaaaaaoeiaaaaaooiaabaaaaacabaaabiaaiaappkaabaaaaacabaaacia
ajaappkaabaaaaacabaaaeiaakaappkaaiaaaaadabaaabiaabaaoeiaamaaffka
acaaaaadacaaamiaabaaaaiaafaacejaacaaaaadabaaagiaacaapiiaafaaffja
aiaaaaadacaaaciaaaaaoejaabaaffiaaiaaaaadacaaabiaaaaaoejaabaakkia
acaaaaadadaaapiaaaaakajaadaaffkaacaaaaadaeaaapiaacaakfiaadaapfia
acaaaaadacaaapiaacaapaiaadaaoeiaafaaaaadacaaapiaacaaoeiaalaaoeka
bdaaaaacacaaapiaacaaoeiaaeaaaaaeacaaapiaacaaoeiaamaakkkaamaappka
bdaaaaacacaaapiaacaaoeiaaeaaaaaeacaaapiaacaaoeiaamaakkkaamaaaaka
cdaaaaacacaaapiaacaaoeiaafaaaaadadaaapiaaeaaoeiaalaaoekabdaaaaac
adaaapiaadaaoeiaaeaaaaaeadaaapiaadaaoeiaamaakkkaamaappkabdaaaaac
adaaapiaadaaoeiaaeaaaaaeadaaapiaadaaoeiaamaakkkaamaaaakacdaaaaac
adaaapiaadaaoeiaafaaaaadaeaaapiaadaaoeiaadaaoeiaaeaaaaaeadaaapia
adaaoeiaanaaaakbanaaffkaafaaaaadadaaapiaadaaoeiaaeaaoeiaacaaaaad
abaaaoiaadaaheiaadaacaiaafaaaaadadaaahiaabaakkiaabaaoekaafaaaaad
adaaahiaadaaoeiaafaaaajaafaaaaadaaaaamiaafaaiejaanaappkaaeaaaaae
abaaaoiaabaaoeiaaaaagaiaadaajaiaaeaaaaaeabaaaoiaabaaoeiaabaappka
aaaajajaafaaaaadadaaahiaafaaaajaabaaoekaaeaaaaaeabaaaoiaadaajaia
abaaaaiaabaaoeiaafaaaaadadaaapiaacaaoeiaacaaoeiaaeaaaaaeacaaapia
acaaoeiaanaaaakbanaaffkaafaaaaadacaaapiaacaaoeiaadaaoeiaacaaaaad
acaaahiaacaanniaacaamiiaafaaaaadadaaahiaacaaffiaabaaoekaafaaaaad
adaaahiaadaaoeiaafaakkjaaeaaaaaeaaaaahiaacaaoeiaaaaanmiaadaaoeia
aeaaaaaeaaaaahiaaaaaoeiaabaappkaaaaaoejaafaaaaadacaaahiaafaakkja
abaaoekaaeaaaaaeaaaaahiaacaaoeiaabaaaaiaaaaaoeiaabaaaaacabaaabia
amaaaakaacaaaaadaaaaaiiaabaaaaiaacaaaakaafaaaaadaaaaaiiaaaaappia
aaaappiaanaaaaadaaaaaiiaaaaappibaaaappiabcaaaaaeacaaahiaaaaappia
abaapjiaaaaaoeiaafaaaaadaaaaapiaacaaffiaafaaoekaaeaaaaaeaaaaapia
aeaaoekaacaaaaiaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaacaakkiaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaadaaoeja
ppppaaaafdeieefcjiajaaaaeaaaabaaggacaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
apaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacafaaaaaabiaaaaaibcaabaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaiadpbpaaaeadakaabaaa
aaaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaaaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaacaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaackbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaabkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
fgafbaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaa
abaaaaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
abaaaaaaegaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaia
mbaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaa
agacbaaaabaaaaaadiaaaaakfcaabaaaabaaaaaafgbebaaaafaaaaaaaceaaaaa
mnmmmmdnaaaaaaaaghggggdoaaaaaaaadiaaaaahdcaabaaaacaaaaaaagaabaaa
abaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaagbibaaaacaaaaaadbaaaaakdcaabaaaadaaaaaa
igbabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
mcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaadaaaaaaclaaaaaf
mcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahkcaabaaaabaaaaaakgaobaaa
acaaaaaaagaebaaaacaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaafaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
abaaaaaaagajbaaaacaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
pgipcaaaaaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
agbabaaaafaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabcaaaaabdgaaaaag
bcaabaaaabaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
dkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaadkiacaaaacaaaaaa
aoaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akbabaaaafaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkbabaaa
afaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaakgakbaaaabaaaaaa
aaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamado
mlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaia
ibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaangafbaaaabaaaaaaigaabaaaabaaaaaa
diaaaaakfcaabaaaacaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaa
ghggggdoaaaaaaaadiaaaaahdcaabaaaadaaaaaaagaabaaaacaaaaaaigbabaaa
acaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaagbibaaaacaaaaaadbaaaaakdcaabaaaaeaaaaaaigbabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaa
kgaobaiaebaaaaaaadaaaaaaagaebaaaaeaaaaaaclaaaaafmcaabaaaadaaaaaa
kgaobaaaadaaaaaadiaaaaahkcaabaaaacaaaaaakgaobaaaadaaaaaaagaebaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaakgbkbaaaafaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaajgahbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaa
adaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgbkbaaaafaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabfaaaaabdiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaadaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahafaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 68 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcihbcmidipncjckijdfdikcakiikcehiabaaaaaakiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaaaaaa
eaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaeaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 68 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgabamhokjojenfakjgelcnkbfkdngedhabaaaaaagaacaaaaaeaaaaaa
daaaaaaaoeaaaaaaneabaaaacmacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
hiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaeaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadaaaacpiaaaaappiaaaaaffkb
ebaaaaabaaaaapiaabaaaaacaaaacpiaabaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoiaaaaaaeaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaeaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="AtsFoliage" }
 Pass {
  Tags { "RenderType"="AtsFoliage" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_Wind]
"!!ARBvp1.0
# 39 ALU
PARAM c[13] = { { -0.5, 0.22500001, 0, 1 },
		state.matrix.mvp,
		program.local[5..10],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 2, 3, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[0].w;
DP3 R2.x, R0.x, c[8];
ADD R0.x, vertex.color, R2;
ADD R1.x, vertex.color.y, R0;
MOV R0.y, R0.x;
ADD R0.zw, vertex.position.xyxz, c[9].y;
DP3 R0.x, vertex.position, R1.x;
ADD R0.xy, R0.zwzw, R0;
MUL R0, R0.xxyy, c[11];
FRC R0, R0;
MUL R0, R0, c[12].x;
ADD R0, R0, c[0].x;
FRC R0, R0;
MUL R0, R0, c[12].x;
ADD R0, R0, -c[0].w;
ABS R0, R0;
MAD R1, -R0, c[12].x, c[12].y;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.zw, R0.xyxz, R0.xyyw;
MUL R0.xyz, R2.w, c[10];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[0].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[0].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[12].z;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R0.y, vertex.color.z, c[0];
MAD R0.xyz, R2.zwzw, R0, R1;
MAD R1.xyz, R0, c[10].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[10];
MOV R0.w, vertex.position;
MAD R0.xyz, R0, R2.x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 39 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [_Wind]
"vs_2_0
; 42 ALU
def c10, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c11, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c12, 2.00000000, 3.00000000, 0.10000000, 0.22500001
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.xyz, c7
dp3 r2.x, c10.x, r0
add r0.y, v5.x, r2.x
add r0.x, v5.y, r0.y
add r0.zw, v0.xyxz, c8.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c11
frc r0, r0
mad r0, r0, c10.y, c10.z
frc r0, r0
mad r0, r0, c10.y, c10.w
abs r0, r0
mad r1, -r0, c12.x, c12.y
mul r0, r0, r0
mul r0, r0, r1
add r2.zw, r0.xyxz, r0.xyyw
mul r0.xyz, r2.w, c9
mul r1.xyz, v5.z, r0
slt r0.xy, -v2.xzzw, v2.xzzw
slt r0.zw, v2.xyxz, -v2.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v5.y, c12.z
mul r0.xy, r1.w, v2.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r0.y, v5.z, c12.w
mad r0.xyz, r2.zwzw, r0, r1
mad r1.xyz, r0, c9.w, v0
mul r0.xyz, v5.z, c9
mad r0.xyz, r0, r2.x, r1
mov r0.w, v0
dp4 r1.w, r0, c3
dp4 r1.z, r0, c2
dp4 r1.x, r0, c0
dp4 r1.y, r0, c1
mov oPos, r1
mov oT1.xy, r1.zwzw
mov oT0.xy, v3
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 48 [_Wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedpddcmpkjondpdncaajelmkpgkihajcepabaaaaaakeagaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfaafaaaaeaaaabaafeabaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacaeaaaaaa
dgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
aaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaa
acaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaa
bkbabaaaafaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaa
aaaaaaaaaaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldp
aaaamadomlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaa
egaobaiaibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaa
dbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
igbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaia
ebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadiaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdn
aaaaaaaaghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaa
agbibaaaacaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaa
acaaaaaadcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaa
agajbaaaabaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaa
aaaaaaaaadaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaa
afaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaadaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 48 [_Wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedjoecogonfejfcbnfekpkmblgpchjibacabaaaaaaaaakaaaaaeaaaaaa
daaaaaaaiiadaaaaoaaiaaaakiajaaaaebgpgodjfaadaaaafaadaaaaaaacpopp
piacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
acaaamaaadaaahaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafakaaapkamnmmpmdp
amaceldpaaaamadomlkbefdofbaaaaafalaaapkaaaaaiadpaaaaaaeaaaaaaalp
aaaaialpfbaaaaafamaaapkaaaaaaaeaaaaaeaeamnmmmmdnghggggdobpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaafiaafaaapjaabaaaaacaaaaabiaahaappkaabaaaaacaaaaacia
aiaappkaabaaaaacaaaaaeiaajaappkaaiaaaaadaaaaabiaaaaaoeiaalaaaaka
acaaaaadabaaaciaaaaaaaiaafaaaajaacaaaaadaaaaaciaabaaffiaafaaffja
aiaaaaadabaaabiaaaaaoejaaaaaffiaacaaaaadacaaapiaaaaakajaacaaffka
acaaaaadabaaapiaabaafaiaacaaoeiaafaaaaadabaaapiaabaaoeiaakaaoeka
bdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaalaaffkaalaakkka
bdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapiaabaaoeiaalaaffkaalaappka
cdaaaaacabaaapiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaoeiaaeaaaaae
abaaapiaabaaoeiaamaaaakbamaaffkaafaaaaadabaaapiaabaaoeiaacaaoeia
acaaaaadaaaaaoiaabaaheiaabaacaiaafaaaaadabaaahiaaaaakkiaabaaoeka
afaaaaadabaaahiaabaaoeiaafaakkjaamaaaaadacaaadiaacaaoijbacaaoija
amaaaaadacaaamiaacaaiejaacaaiejbacaaaaadacaaadiaacaaooibacaaoeia
afaaaaadabaaaiiaafaaffjaamaakkkaafaaaaadacaaamiaabaappiaacaaieja
afaaaaadacaaafiaacaaneiaacaapgiaafaaaaadacaaaciaafaakkjaamaappka
aeaaaaaeaaaaaoiaaaaaoeiaacaajaiaabaajaiaaeaaaaaeaaaaaoiaaaaaoeia
abaappkaaaaajajaafaaaaadabaaahiaafaakkjaabaaoekaaeaaaaaeaaaaahia
abaaoeiaaaaaaaiaaaaapjiaafaaaaadabaaapiaaaaaffiaaeaaoekaaeaaaaae
abaaapiaadaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoa
adaaoejappppaaaafdeieefcfaafaaaaeaaaabaafeabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadhcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacaeaaaaaadgaaaaag
bcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaa
dkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaa
aoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaa
akbabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkbabaaa
afaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaafgafbaaaaaaaaaaa
aaaaaaaipcaabaaaacaaaaaaagbkbaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaagafbaaaabaaaaaaegaobaaaacaaaaaadiaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaamnmmpmdpamaceldpaaaamado
mlkbefdobkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadcaaaaappcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaaabaaaaaaegaobaia
ibaaaaaaabaaaaaadcaaaabapcaabaaaabaaaaaaegaobaiambaaaaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaeaeadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaahocaabaaaaaaaaaaafgahbaaaabaaaaaaagacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaak
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaa
acaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
diaaaaakfcaabaaaadaaaaaafgbgbaaaafaaaaaaaceaaaaamnmmmmdnaaaaaaaa
ghggggdoaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaadaaaaaaagbibaaa
acaaaaaadiaaaaahkcaabaaaadaaaaaaagaebaaaacaaaaaakgaobaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaaadaaaaaaagajbaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaapgipcaaaaaaaaaaa
adaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaadaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahafaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapahaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 64 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhembpkcpialldgghahlkmcnbncolpbjeabaaaaaakiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaaaaaa
eaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaaeaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 64 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddnmdkkmeegambpmnlphkcdklhamoamppabaaaaaagaacaaaaaeaaaaaa
daaaaaaaoeaaaaaaneabaaaacmacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
hiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaeaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadaaaacpiaaaaappiaaaaaaakb
ebaaaaabaaaaapiaabaaaaacaaaacpiaabaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoiaaaaaaeaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaaeaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="AtsGrass" }
 Pass {
  Tags { "RenderType"="AtsGrass" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 5 [_World2Object]
Vector 9 [_WavingTint]
Vector 10 [_WaveAndDistance]
"!!ARBvp1.0
# 37 ALU
PARAM c[19] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.mvp,
		program.local[5..10],
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, 6.4088488 },
		{ 3.1415927, -0.00019840999, 0.0083333002, -0.16161616 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 },
		{ 0, 8, 0.5 },
		{ 0.47193992, 0.18877596, 0.094387978 } };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R0.xyz, vertex.position.z, c[12];
MAD R1, vertex.position.x, c[11], R0.xyyz;
MOV R0, c[0];
MAD R0, R0, c[10].x, R1;
FRC R0, R0;
MUL R0, R0, c[12].w;
ADD R0, R0, -c[13].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[13].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[13].z, R0;
MAD R0, R1, c[13].y, R0;
MUL R0, R0, c[14];
MUL R1, R0, R0;
MUL R2.x, vertex.color.w, c[10].z;
MUL R0, R1, R2.x;
DP4 R2.x, R0, c[16];
DP4 R2.z, R0, c[15];
MOV R2.y, c[17].x;
DP3 R2.w, R2, c[7];
DP3 R2.z, R2, c[5];
MAD R0.xz, -R2.zyww, c[17].y, vertex.position;
MOV R0.yw, vertex.position;
MOV R2.x, c[17].z;
ADD R2.xyz, -R2.x, c[9];
DP4 R1.x, R1, c[18].xxyz;
MAD R1.xyz, R1.x, R2, c[17].z;
MUL R1.xyz, vertex.color, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MUL result.color.xyz, R1, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.color.w, vertex.color;
END
# 37 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WavingTint]
Vector 9 [_WaveAndDistance]
"vs_2_0
; 40 ALU
def c10, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c11, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c12, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c13, 6.40884876, -3.14159274, 0.00833330, -0.00019841
def c14, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c15, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c16, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c17, 0.00000000, 8.00000000, -0.50000000, 0.50000000
def c18, 0.47193992, 0.18877596, 0.09438798, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mul r0.xyz, v0.z, c10
mad r1, v0.x, c11, r0.xyyz
mov r0.x, c9
mad r0, c12, r0.x, r1
frc r0, r0
mad r0, r0, c13.x, c13.y
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c10.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c13.z, r0
mad r0, r1, c13.w, r0
mul r0, r0, c14
mul r1, r0, r0
mul r2.x, v5.w, c9.z
mul r0, r1, r2.x
dp4 r2.z, r0, c15
dp4 r2.x, r0, c16
mov r2.y, c17.x
dp3 r0.y, r2, c6
dp3 r0.x, r2, c4
mad r2.xz, -r0.xyyw, c17.y, v0
mov r2.yw, v0
dp4 r0.w, r2, c3
dp4 r0.z, r2, c2
dp4 r0.y, r2, c1
dp4 r0.x, r2, c0
mov r3.xyz, c8
add r2.xyz, c17.z, r3
dp4 r1.x, r1, c18.xxyz
mad r1.xyz, r1.x, r2, c17.w
mul r1.xyz, v5, r1
mov oPos, r0
mov oT1.xy, r0.zwzw
mul oD0.xyz, r1, c12.y
mov oT0.xy, v3
mov oD0.w, v5
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
ConstBuffer "UnityTerrain" 256
Vector 0 [_WavingTint]
Vector 16 [_WaveAndDistance]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0
eefiecedgeafbolbeffbokefgnnmgehkkeolemegabaaaaaalaagaaaaadaaaaaa
cmaaaaaapeaaaaaagiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaafaaaaeaaaabaafaabaaaafjaaaaaeegiocaaa
aaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagiaaaaacadaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaa
aceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaa
agbabaaaaaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaa
aaaaaaaadcaaaaanpcaabaaaaaaaaaaaagiacaaaabaaaaaaabaaaaaaaceaaaaa
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejma
nlapejmanlapejmadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaalfhocflolfhocflo
lfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
gfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaabaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfalj
egaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaadkbabaaaafaaaaaa
ckiacaaaabaaaaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
fnjicmdpfnjicmdphnbdikdohnbdakdodiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaadddddddpbbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaa
aceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakecaabaaaaaaaaaaa
egaobaaaabaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaai
kcaabaaaaaaaaaaafgafbaaaaaaaaaaaagiicaaaaaaaaaaabcaaaaaadcaaaaak
gcaabaaaaaaaaaaaagiccaaaaaaaaaaabaaaaaaakgakbaaaaaaaaaaafgahbaaa
aaaaaaaadcaaaaangcaabaaaaaaaaaaafgagbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaebaaaaaaebaaaaaaaaagbcbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaaaaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaalocaabaaaaaaaaaaaagijcaaa
abaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaalpdcaaaaam
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaafaaaaaaaaaaaaahhccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaabaaaaaadkbabaaaafaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
ConstBuffer "UnityTerrain" 256
Vector 0 [_WavingTint]
Vector 16 [_WaveAndDistance]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0_level_9_1
eefiecedebfjjnggcagckfliogonfhcadcigiggoabaaaaaaieakaaaaaeaaaaaa
daaaaaaaaaaeaaaaeiajaaaabaakaaaaebgpgodjmiadaaaamiadaaaaaaacpopp
haadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaaaa
aeaaabaaaaaaaaaaaaaabaaaabaaafaaaaaaaaaaaaaabcaaabaaagaaaaaaaaaa
abaaaaaaacaaahaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafajaaapkakgjleedn
ipmchfdnipmchfdokgjlmednfbaaaaafakaaapkakgjlmedmaknhkddnmnmmemdo
lfhocflofbaaaaafalaaapkajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaaf
amaaapkaekbfmneanlapejmagfiiaidmehamfaljfbaaaaafanaaapkaihiofmdo
blmmlhdokpajjddoihiofmdpfbaaaaafaoaaapkafnjicmdphnbdikdohnbdakdo
dddddddpfbaaaaafapaaapkaaaaaaalpaaaaaadpaaaaaaebaaaaaaaafbaaaaaf
baaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbbaaapkakgjlmedl
aknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaafiaafaaapjaafaaaaadaaaaapiaaaaakkjaakaajeka
aeaaaaaeaaaaapiaaaaaaajaajaaoekaaaaaoeiaabaaaaacabaaabiaaiaaaaka
aeaaaaaeaaaaapiaabaaaaiaalaaoekaaaaaoeiabdaaaaacaaaaapiaaaaaoeia
aeaaaaaeaaaaapiaaaaaoeiaamaaaakaamaaffkaafaaaaadabaaapiaaaaaoeia
aaaaoeiaafaaaaadacaaapiaaaaaoeiaabaaoeiaaeaaaaaeaaaaapiaacaaoeia
akaappkaaaaaoeiaafaaaaadacaaapiaabaaoeiaacaaoeiaafaaaaadabaaapia
abaaoeiaacaaoeiaaeaaaaaeaaaaapiaacaaoeiaamaakkkaaaaaoeiaaeaaaaae
aaaaapiaabaaoeiaamaappkaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaanaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaajaaaaadabaaabiaaaaaoeiaaoaajaka
afaaaaadabaaabiaabaaaaiaaoaappkaabaaaaacacaaabiaapaaaakaacaaaaad
abaaaoiaacaaaaiaahaajakaaeaaaaaeabaaahiaabaaaaiaabaapjiaapaaffka
afaaaaadabaaahiaabaaoeiaafaaoejaacaaaaadaaaaahoaabaaoeiaabaaoeia
afaaaaadabaaabiaafaappjaaiaakkkaafaaaaadaaaaapiaaaaaoeiaabaaaaia
ajaaaaadabaaabiaaaaaoeiabbaaoekaajaaaaadaaaaabiaaaaaoeiabaaaoeka
afaaaaadaaaaagiaabaaaaiaagaaoakaaeaaaaaeaaaaadiaafaaoikaaaaaaaia
aaaaojiaaeaaaaaeaaaaadiaaaaaoeiaapaakkkbaaaaoijaafaaaaadabaaapia
aaaaffjaacaaoekaaeaaaaaeabaaapiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaapiaadaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaaioaafaappjaabaaaaacabaaadoaadaaoejappppaaaa
fdeieefceaafaaaaeaaaabaafaabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
adaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedm
aknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaa
aceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaagiacaaaabaaaaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaea
mnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmnea
ekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejma
diaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaacaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocflo
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaagfiiaidmgfiiaidm
gfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
abaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdo
kpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaadkbabaaaafaaaaaackiacaaaabaaaaaa
abaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaa
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaafnjicmdpfnjicmdp
hnbdikdohnbdakdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
dddddddpbbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaakgjlmedl
aknhkddmaknhkdlmmnmmmmdnbbaaaaakecaabaaaaaaaaaaaegaobaaaabaaaaaa
aceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaikcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagiicaaaaaaaaaaabcaaaaaadcaaaaakgcaabaaaaaaaaaaa
agiccaaaaaaaaaaabaaaaaaakgakbaaaaaaaaaaafgahbaaaaaaaaaaadcaaaaan
gcaabaaaaaaaaaaafgagbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaeb
aaaaaaebaaaaaaaaagbcbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaalocaabaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaalpdcaaaaamhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaa
aaaaaaahhccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaabaaaaaadkbabaaaafaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaa
adaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhpjibpacogkcjhcocfaoploeimbbimhgabaaaaaaniabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddekkjenaooggnbjphigiglfanepfeemlabaaaaaakaacaaaaaeaaaaaa
daaaaaaapeaaaaaapiabaaaagmacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
iiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaaeaaaaae
aaaacpiaaaaappiaaaaapplaaaaaaakbebaaaaabaaaaapiaabaaaaacaaaacpia
abaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
"!!ARBvp1.0
# 4 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 4 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT0.xy, r0.zwzw
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedkdpbakmbpflfgbofglakchagpggdidbhabaaaaaaleabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafdeieefcniaaaaaaeaaaabaa
dgaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedcmjoibphhjefadiknlkohphbedneigmbabaaaaaaheacaaaaaeaaaaaa
daaaaaaaomaaaaaammabaaaaeaacaaaaebgpgodjleaaaaaaleaaaaaaaaacpopp
iaaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaad
aaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcniaaaaaaeaaaabaadgaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 4 ALU
dcl t0.xy
rcp r0.x, t0.y
mul r0.x, t0, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedcbejcgfjfchfioiockkbgpdagbgpkifoabaaaaaaneaaaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
eefiecedddomjckbhjkfhaokccgpbcigcfdhmblaabaaaaaadmabaaaaaeaaaaaa
daaaaaaajeaaaaaaneaaaaaaaiabaaaaebgpgodjfmaaaaaafmaaaaaaaaacpppp
diaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaacaaaacpia
aaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TransparentCutout" }
 Pass {
  Tags { "RenderType"="TransparentCutout" }
  Fog { Mode Off }
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
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
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
ConstBuffer "$Globals" 64
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
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, c[1].w;
SLT R0.x, R0, c[0];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 8 ALU, 2 TEX
dcl_2d s0
def c2, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mov_pp r0.x, c0
mad_pp r0.x, r0.w, c1.w, -r0
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_Cutoff]
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkabpjaolinfpciimmagdipdbaohmnfemabaaaaaaleabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaa
eaaaaaaadnaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 32 [_Cutoff]
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedaoikchpgfapehkccmlgkmhiiaofoihdpabaaaaaahmacaaaaaeaaaaaa
daaaaaaapeaaaaaapaabaaaaeiacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
iiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaae
aaaacpiaaaaappiaabaappiaaaaaaakbebaaaaabaaaaapiaabaaaaacaaaacpia
acaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
acaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeBark" }
 Pass {
  Tags { "RenderType"="TreeBark" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_Scale]
Vector 11 [_SquashPlaneNormal]
Float 12 [_SquashAmount]
Vector 13 [_Wind]
"!!ARBvp1.0
# 36 ALU
PARAM c[16] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..13],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.30000001, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
DP3 R0.x, R0.x, c[8];
ADD R0.x, vertex.color, R0;
ADD R0.z, vertex.color.y, R0.x;
MUL R2.xyz, vertex.position, c[10];
MOV R0.y, R0.x;
DP3 R0.x, R2, R0.z;
ADD R0.xy, R0, c[9].y;
MUL R0, R0.xxyy, c[14];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R0, R0;
MAD R1, -R0, c[0].y, c[0].w;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R3.xy, R0.xzzw, R0.ywzw;
MUL R0.xyz, R3.y, c[13];
MUL R1.xyz, vertex.texcoord[1].y, R0;
MUL R0.w, vertex.color.y, c[15].y;
MUL R0.xz, R0.w, vertex.normal;
MUL R0.y, vertex.texcoord[1], c[15].x;
MAD R0.xyz, R3.xyxw, R0, R1;
MAD R0.xyz, R0, c[13].w, R2;
MAD R1.xyz, vertex.texcoord[1].x, c[13], R0;
DP3 R0.x, R1, c[11];
ADD R0.x, R0, c[11].w;
MUL R0.xyz, R0.x, c[11];
ADD R1.xyz, -R0, R1;
MOV R0.w, c[0].x;
MAD R0.xyz, R0, c[12].x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
Vector 12 [_Wind]
"vs_2_0
; 42 ALU
def c13, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c14, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c15, 2.00000000, 3.00000000, 0.30000001, 0.10000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c13.x, r0
add r0.x, v5, r0
mov r0.y, r0.x
mul r2.xyz, v0, c9
add r0.x, v5.y, r0
dp3 r0.x, r2, r0.x
add r0.xy, r0, c8.y
mul r0, r0.xxyy, c14
frc r0, r0
mad r0, r0, c13.y, c13.z
frc r0, r0
mad r0, r0, c13.y, c13.w
abs r0, r0
mad r1, -r0, c15.x, c15.y
mul r0, r0, r0
mul r0, r0, r1
add r3.xy, r0.xzzw, r0.ywzw
mul r0.xyz, r3.y, c12
mul r1.xyz, v4.y, r0
mul r0.w, v5.y, c15
mov r1.w, c13.x
mul r0.xz, r0.w, v2
mul r0.y, v4, c15.z
mad r0.xyz, r3.xyxw, r0, r1
mad r0.xyz, r0, c12.w, r2
mad r1.xyz, v4.x, c12, r0
dp3 r0.x, r1, c10
add r0.x, r0, c10.w
mul r0.xyz, r0.x, c10
add r1.xyz, -r0, r1
mad r1.xyz, r0, c11.x, r1
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT0.xy, r0.zwzw
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [_Wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
ConstBuffer "UnityTerrain" 256
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityTerrain" 3
"vs_4_0
eefiecedjmappaephljdacopmhngjcgikhcgkcpdabaaaaaaiiagaaaaadaaaaaa
cmaaaaaapeaaaaaaciabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafdeieefcfiafaaaaeaaaabaafgabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafpaaaaadhcbabaaa
aaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaad
dcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagiaaaaacaeaaaaaa
dgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
aaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaa
acaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakbabaaaafaaaaaaaaaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkbabaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaaaaaaaaaegiccaaa
adaaaaaaafaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaakgakbaaa
aaaaaaaaaaaaaaaipcaabaaaaaaaaaaaagafbaaaaaaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaacaaaaaaegaobaiaibaaaaaa
aaaaaaaaegaobaiaibaaaaaaaaaaaaaadcaaaabapcaabaaaaaaaaaaaegaobaia
mbaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaaaaaaaaahdcaabaaaaaaaaaaangafbaaaaaaaaaaa
igaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaafgbfbaaa
aeaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaaaaaaaaabkbabaaaaeaaaaaa
diaaaaahccaabaaaaaaaaaaabkbabaaaafaaaaaaabeaaaaamnmmmmdndiaaaaah
fcaabaaaadaaaaaafgafbaaaaaaaaaaaagbcbaaaacaaaaaadgaaaaafecaabaaa
aaaaaaaaabeaaaaajkjjjjdodcaaaaajhcaabaaaaaaaaaaaigaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagbabaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
baaaaaaiicaabaaaaaaaaaaaegiccaaaadaaaaaaakaaaaaaegacbaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaadaaaaaaakaaaaaa
dcaaaaalhcaabaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaa
akaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaadaaaaaa
alaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [_Wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
ConstBuffer "UnityTerrain" 256
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityTerrain" 3
"vs_4_0_level_9_1
eefiecedckohhbecigejjbejeeijddjphifmpfjmabaaaaaapaajaaaaaeaaaaaa
daaaaaaajeadaaaapeaiaaaalmajaaaaebgpgodjfmadaaaafmadaaaaaaacpopp
omacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
acaaamaaadaaahaaaaaaaaaaadaaafaaabaaakaaaaaaaaaaadaaakaaacaaalaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkamnmmpmdpamaceldpaaaamado
mlkbefdofbaaaaafaoaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaaf
apaaapkaaaaaaaeaaaaaeaeamnmmmmdnjkjjjjdobpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaabaaaaacaaaaabiaahaappkaabaaaaacaaaaaciaaiaappkaabaaaaac
aaaaaeiaajaappkaaiaaaaadaaaaabiaaaaaoeiaaoaaaakaacaaaaadaaaaacia
aaaaaaiaafaaaajaacaaaaadaaaaaeiaaaaaffiaafaaffjaafaaaaadabaaahia
aaaaoejaakaaoekaaiaaaaadaaaaabiaabaaoeiaaaaakkiaacaaaaadaaaaapia
aaaafaiaacaaffkaafaaaaadaaaaapiaaaaaoeiaanaaoekabdaaaaacaaaaapia
aaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaaoaaffkaaoaakkkabdaaaaacaaaaapia
aaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaaoaaffkaaoaappkacdaaaaacaaaaapia
aaaaoeiaafaaaaadacaaapiaaaaaoeiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
apaaaakbapaaffkaafaaaaadaaaaapiaaaaaoeiaacaaoeiaacaaaaadaaaaadia
aaaaoniaaaaaoiiaafaaaaadacaaahiaaaaaffiaabaaoekaafaaaaadacaaahia
acaaoeiaaeaaffjaafaaaaadadaaaciaaaaaffiaaeaaffjaafaaaaadaaaaacia
afaaffjaapaakkkaafaaaaadadaaafiaaaaaffiaacaaoejaabaaaaacaaaaaeia
apaappkaaeaaaaaeaaaaahiaaaaamiiaadaaoeiaacaaoeiaaeaaaaaeaaaaahia
aaaaoeiaabaappkaabaaoeiaaeaaaaaeaaaaahiaaeaaaajaabaaoekaaaaaoeia
aiaaaaadaaaaaiiaalaaoekaaaaaoeiaacaaaaadaaaaaiiaaaaappiaalaappka
aeaaaaaeabaaahiaaaaappiaalaaoekbaaaaoeiabcaaaaaeacaaahiaamaaaaka
aaaaoeiaabaaoeiaafaaaaadaaaaapiaacaaffiaaeaaoekaaeaaaaaeaaaaapia
adaaoekaacaaaaiaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaacaakkiaaaaaoeia
acaaaaadaaaaapiaaaaaoeiaagaaoekaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcfiafaaaaeaaaabaa
fgabaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafjaaaaaeegiocaaaadaaaaaa
amaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaaddcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagiaaaaacaeaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaadkiacaaaacaaaaaaaoaaaaaabaaaaaakbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakbabaaaafaaaaaaaaaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaafaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaaaaaaaaaegiccaaaadaaaaaaafaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaakgakbaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaagafbaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
acaaaaaaegaobaiaibaaaaaaaaaaaaaaegaobaiaibaaaaaaaaaaaaaadcaaaaba
pcaabaaaaaaaaaaaegaobaiambaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaahdcaabaaa
aaaaaaaangafbaaaaaaaaaaaigaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaaeaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaa
aaaaaaaabkbabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaabkbabaaaafaaaaaa
abeaaaaamnmmmmdndiaaaaahfcaabaaaadaaaaaafgafbaaaaaaaaaaaagbcbaaa
acaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaajkjjjjdodcaaaaajhcaabaaa
aaaaaaaaigaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaagbabaaaaeaaaaaaegiccaaaaaaaaaaa
adaaaaaaegacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaaadaaaaaa
akaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaadaaaaaaakaaaaaadcaaaaalhcaabaaaabaaaaaapgapbaiaebaaaaaa
aaaaaaaaegiccaaaadaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaadaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapadaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaa"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 4 ALU
dcl t0.xy
rcp r0.x, t0.y
mul r0.x, t0, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedcbejcgfjfchfioiockkbgpdagbgpkifoabaaaaaaneaaaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
eefiecedddomjckbhjkfhaokccgpbcigcfdhmblaabaaaaaadmabaaaaaeaaaaaa
daaaaaaajeaaaaaaneaaaaaaaiabaaaaebgpgodjfmaaaaaafmaaaaaaaaacpppp
diaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaacaaaacpia
aaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeLeaf" }
 Pass {
  Tags { "RenderType"="TreeLeaf" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Vector 13 [_Time]
Vector 14 [_Scale]
Vector 15 [_SquashPlaneNormal]
Float 16 [_SquashAmount]
Vector 17 [_Wind]
"!!ARBvp1.0
# 50 ALU
PARAM c[20] = { { 0, 1, 2, -0.5 },
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[9..17],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 3, 0.30000001, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0, vertex.normal.y, c[6];
MAD R1, vertex.normal.x, c[5], R0;
ADD R0.xyz, R1, c[0].x;
ABS R2.x, vertex.attrib[14].w;
ADD R2.w, -R2.x, c[0].y;
MAD R0.xyz, R0, R2.w, vertex.position;
MAD R1, vertex.normal.z, c[7], R1;
ADD R3, R1, c[0].x;
DP4 R3.y, R3, R3;
MOV R0.w, c[0].y;
DP3 R0.w, R0.w, c[12];
MUL R2.xyz, R0, c[14];
ADD R0.w, vertex.color.x, R0;
ADD R0.x, vertex.color.y, R0.w;
MOV R0.y, R0.w;
DP3 R0.x, R2, R0.x;
ADD R0.xy, R0, c[13].y;
MUL R0, R0.xxyy, c[18];
FRC R0, R0;
MAD R0, R0, c[0].z, c[0].w;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].y;
ABS R0, R0;
MUL R1, -R0, c[0].z;
ADD R1, R1, c[19].x;
MUL R0, R0, R0;
MUL R0, R0, R1;
RSQ R3.y, R3.y;
MAD R1.xy, R3.y, R3.xzzw, -vertex.normal.xzzw;
ADD R3.xy, R0.xzzw, R0.ywzw;
MAD R0.xy, R2.w, R1, vertex.normal.xzzw;
MUL R0.xy, vertex.color.y, R0;
MUL R0.xz, R0.xyyw, c[19].z;
MUL R1.xyz, R3.y, c[17];
MOV R0.w, c[0].y;
MUL R1.xyz, vertex.texcoord[1].y, R1;
MUL R0.y, vertex.texcoord[1], c[19];
MAD R0.xyz, R3.xyxw, R0, R1;
MAD R0.xyz, R0, c[17].w, R2;
MAD R1.xyz, vertex.texcoord[1].x, c[17], R0;
DP3 R0.x, R1, c[15];
ADD R0.x, R0, c[15].w;
MUL R0.xyz, R0.x, c[15];
ADD R1.xyz, -R0, R1;
MAD R0.xyz, R0, c[16].x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 50 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_invtrans_modelview0]
Matrix 8 [_Object2World]
Vector 12 [_Time]
Vector 13 [_Scale]
Vector 14 [_SquashPlaneNormal]
Float 15 [_SquashAmount]
Vector 16 [_Wind]
"vs_2_0
; 55 ALU
def c17, 0.00000000, 1.00000000, 2.00000000, -0.50000000
def c18, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c19, 2.00000000, -1.00000000, 3.00000000, 0.30000001
def c20, 0.10000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r0, v2.y, c5
mad r1, v2.x, c4, r0
add r0.xyz, r1, c17.x
abs r0.w, v1
add r3.w, -r0, c17.y
mad r0.xyz, r0, r3.w, v0
mov r2.xyz, c11
dp3 r0.w, c17.y, r2
mad r1, v2.z, c6, r1
add r2, r1, c17.x
dp4 r2.y, r2, r2
mul r3.xyz, r0, c13
add r0.w, v5.x, r0
add r0.x, v5.y, r0.w
mov r0.y, r0.w
dp3 r0.x, r3, r0.x
add r0.xy, r0, c12.y
mul r0, r0.xxyy, c18
frc r0, r0
mad r0, r0, c17.z, c17.w
frc r0, r0
mad r0, r0, c19.x, c19.y
abs r0, r0
mul r1, r0, r0
mad r0, -r0, c19.x, c19.z
mul r0, r1, r0
rsq r2.y, r2.y
mad r1.xy, r2.y, r2.xzzw, -v2.xzzw
add r2.xy, r0.xzzw, r0.ywzw
mad r0.xy, r3.w, r1, v2.xzzw
mul r0.xy, v5.y, r0
mul r0.xz, r0.xyyw, c20.x
mul r1.xyz, r2.y, c16
mov r0.w, c17.y
mul r1.xyz, v4.y, r1
mul r0.y, v4, c19.w
mad r0.xyz, r2.xyxw, r0, r1
mad r0.xyz, r0, c16.w, r3
mad r1.xyz, v4.x, c16, r0
dp3 r0.x, r1, c14
add r0.x, r0, c14.w
mul r0.xyz, r0.x, c14
add r1.xyz, -r0, r1
mad r0.xyz, r0, c15.x, r1
dp4 r1.w, r0, c3
dp4 r1.z, r0, c2
dp4 r1.x, r0, c0
dp4 r1.y, r0, c1
mov oPos, r1
mov oT1.xy, r1.zwzw
mov oT0.xy, v3
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 80
Vector 48 [_Wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 128 [glstate_matrix_invtrans_modelview0]
Matrix 192 [_Object2World]
ConstBuffer "UnityTerrain" 256
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityTerrain" 3
"vs_4_0
eefiecednnmmlibjabgflpepigpnpolinlncokmoabaaaaaaieaiaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapadaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcdaahaaaaeaaaabaammabaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafpaaaaad
hcbabaaaaaaaaaaafpaaaaadicbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaaddcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacaeaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaajaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaalaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaaiaaaaaabaaaaaaiecaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaakaaaaaabbaaaaahccaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakdcaabaaa
aaaaaaaaigaabaaaaaaaaaaafgafbaaaaaaaaaaaigbabaiaebaaaaaaacaaaaaa
aaaaaaaiecaabaaaaaaaaaaadkbabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
dcaaaaajdcaabaaaaaaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaaigbabaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaabkbabaaaafaaaaaaabeaaaaamnmmmmdn
diaaaaahfcaabaaaabaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaaapaaaaai
bcaabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaacaaaaaaaiaaaaaaapaaaaai
ccaabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaacaaaaaaajaaaaaaapaaaaai
ecaabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaacaaaaaaakaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaafaaaaaa
dgaaaaagbcaabaaaacaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
acaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaadkiacaaa
acaaaaaaaoaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaacaaaaaadkaabaaa
aaaaaaaaakbabaaaafaaaaaaaaaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaa
bkbabaaaafaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaaipcaabaaaacaaaaaaagafbaaaacaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaa
dcaaaaappcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaacaaaaaaegaobaaaacaaaaaadcaaaaappcaabaaaacaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaadaaaaaaegaobaiaibaaaaaa
acaaaaaaegaobaiaibaaaaaaacaaaaaadcaaaabapcaabaaaacaaaaaaegaobaia
mbaaaaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaahdcaabaaaacaaaaaangafbaaaacaaaaaa
igaabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaafgbfbaaa
aeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaacaaaaaabkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaaabeaaaaajkjjjjdodcaaaaajhcaabaaaabaaaaaa
igaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagbabaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaaadaaaaaaakaaaaaa
egacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
adaaaaaaakaaaaaadcaaaaalhcaabaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egiccaaaadaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaadaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaadaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 80
Vector 48 [_Wind]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 128 [glstate_matrix_invtrans_modelview0]
Matrix 192 [_Object2World]
ConstBuffer "UnityTerrain" 256
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityTerrain" 3
"vs_4_0_level_9_1
eefiecedanjpcajhkogbonedfaldpobcfilmdkapabaaaaaaceanaaaaaeaaaaaa
daaaaaaammaeaaaaaeamaaaammamaaaaebgpgodjjeaeaaaajeaeaaaaaaacpopp
ceaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
acaaaiaaahaaahaaaaaaaaaaadaaafaaabaaaoaaaaaaaaaaadaaakaaacaaapaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbbaaapkamnmmpmdpamaceldpaaaamado
mlkbefdofbaaaaafbcaaapkaaaaaiadpaaaaaaeaaaaaaalpaaaaialpfbaaaaaf
bdaaapkaaaaaaaeaaaaaeaeamnmmmmdnjkjjjjdobpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaaiaaaaad
aaaaaciaacaaoejaaiaaoekaaiaaaaadaaaaaiiaacaaoejaakaaoekaaiaaaaad
aaaaabiaacaaoejaahaaoekaaiaaaaadaaaaaeiaacaaoejaajaaoekaajaaaaad
aaaaaciaaaaaoeiaaaaaoeiaahaaaaacaaaaaciaaaaaffiaaeaaaaaeaaaaadia
aaaaoiiaaaaaffiaacaaoijbcdaaaaacaaaaaeiaabaappjaacaaaaadaaaaaeia
aaaakkibbcaaaakaaeaaaaaeaaaaadiaaaaakkiaaaaaoeiaacaaoijaafaaaaad
aaaaaiiaafaaffjabdaakkkaafaaaaadabaaafiaaaaaneiaaaaappiaafaaaaad
aaaaadiaacaaoejaahaaoekaacaaaaadacaaabiaaaaaffiaaaaaaaiaafaaaaad
aaaaadiaacaaoejaaiaaoekaacaaaaadacaaaciaaaaaffiaaaaaaaiaafaaaaad
aaaaadiaacaaoejaajaaoekaacaaaaadacaaaeiaaaaaffiaaaaaaaiaaeaaaaae
aaaaahiaacaaoeiaaaaakkiaaaaaoejaafaaaaadaaaaahiaaaaaoeiaaoaaoeka
abaaaaacacaaabiaalaappkaabaaaaacacaaaciaamaappkaabaaaaacacaaaeia
anaappkaaiaaaaadaaaaaiiaacaaoeiabcaaaakaacaaaaadacaaaciaaaaappia
afaaaajaacaaaaadaaaaaiiaacaaffiaafaaffjaaiaaaaadacaaabiaaaaaoeia
aaaappiaacaaaaadacaaapiaacaafaiaacaaffkaafaaaaadacaaapiaacaaoeia
bbaaoekabdaaaaacacaaapiaacaaoeiaaeaaaaaeacaaapiaacaaoeiabcaaffka
bcaakkkabdaaaaacacaaapiaacaaoeiaaeaaaaaeacaaapiaacaaoeiabcaaffka
bcaappkacdaaaaacacaaapiaacaaoeiaafaaaaadadaaapiaacaaoeiaacaaoeia
aeaaaaaeacaaapiaacaaoeiabdaaaakbbdaaffkaafaaaaadacaaapiaacaaoeia
adaaoeiaacaaaaadacaaadiaacaaoniaacaaoiiaafaaaaadadaaahiaacaaffia
abaaoekaafaaaaadadaaahiaadaaoeiaaeaaffjaafaaaaadabaaaciaacaaffia
aeaaffjaabaaaaacacaaaeiabdaappkaaeaaaaaeabaaahiaacaamiiaabaaoeia
adaaoeiaaeaaaaaeaaaaahiaabaaoeiaabaappkaaaaaoeiaaeaaaaaeaaaaahia
aeaaaajaabaaoekaaaaaoeiaaiaaaaadaaaaaiiaapaaoekaaaaaoeiaacaaaaad
aaaaaiiaaaaappiaapaappkaaeaaaaaeabaaahiaaaaappiaapaaoekbaaaaoeia
bcaaaaaeacaaahiabaaaaakaaaaaoeiaabaaoeiaafaaaaadaaaaapiaacaaffia
aeaaoekaaeaaaaaeaaaaapiaadaaoekaacaaaaiaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaacaakkiaaaaaoeiaacaaaaadaaaaapiaaaaaoeiaagaaoekaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaadoaadaaoejappppaaaafdeieefcdaahaaaaeaaaabaammabaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafpaaaaad
hcbabaaaaaaaaaaafpaaaaadicbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaaddcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
giaaaaacaeaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaajaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaalaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaaiaaaaaabaaaaaaiecaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaakaaaaaabbaaaaahccaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakdcaabaaa
aaaaaaaaigaabaaaaaaaaaaafgafbaaaaaaaaaaaigbabaiaebaaaaaaacaaaaaa
aaaaaaaiecaabaaaaaaaaaaadkbabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
dcaaaaajdcaabaaaaaaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaaigbabaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaabkbabaaaafaaaaaaabeaaaaamnmmmmdn
diaaaaahfcaabaaaabaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaaapaaaaai
bcaabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaacaaaaaaaiaaaaaaapaaaaai
ccaabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaacaaaaaaajaaaaaaapaaaaai
ecaabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaacaaaaaaakaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaafaaaaaa
dgaaaaagbcaabaaaacaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
acaaaaaadkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaadkiacaaa
acaaaaaaaoaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahccaabaaaacaaaaaadkaabaaa
aaaaaaaaakbabaaaafaaaaaaaaaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaa
bkbabaaaafaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaaipcaabaaaacaaaaaaagafbaaaacaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaamnmmpmdp
amaceldpaaaamadomlkbefdobkaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaa
dcaaaaappcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalpbkaaaaaf
pcaabaaaacaaaaaaegaobaaaacaaaaaadcaaaaappcaabaaaacaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaadaaaaaaegaobaiaibaaaaaa
acaaaaaaegaobaiaibaaaaaaacaaaaaadcaaaabapcaabaaaacaaaaaaegaobaia
mbaaaaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaahdcaabaaaacaaaaaangafbaaaacaaaaaa
igaabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaafgbfbaaa
aeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaacaaaaaabkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaaabeaaaaajkjjjjdodcaaaaajhcaabaaaabaaaaaa
igaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagbabaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaaadaaaaaaakaaaaaa
egacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
adaaaaaaakaaaaaadcaaaaalhcaabaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egiccaaaadaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaadaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaadaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapahaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaiaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apadaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 64 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhembpkcpialldgghahlkmcnbncolpbjeabaaaaaakiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaaaaaa
eaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaaeaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Float 64 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddnmdkkmeegambpmnlphkcdklhamoamppabaaaaaagaacaaaaaeaaaaaa
daaaaaaaoeaaaaaaneabaaaacmacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
hiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaeaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadaaaacpiaaaaappiaaaaaaakb
ebaaaaabaaaaapiaabaaaaacaaaacpiaabaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoiaaaaaaeaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaaeaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeOpaque" }
 Pass {
  Tags { "RenderType"="TreeOpaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Matrix 5 [_TerrainEngineBendTree]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
"!!ARBvp1.0
# 17 ALU
PARAM c[12] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[9];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[10];
ADD R0.w, R0, c[10];
MUL R1.xyz, R0.w, c[10];
ADD R0.xyz, -R1, R0;
MOV R0.w, c[0].y;
MAD R0.xyz, R1, c[11].x, R0;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_TerrainEngineBendTree]
Vector 8 [_Scale]
Vector 9 [_SquashPlaneNormal]
Float 10 [_SquashAmount]
"vs_2_0
; 19 ALU
def c11, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
mul r1.xyz, v0, c8
mov r1.w, c11.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
add r0.xyz, r0, -r1
mad r1.xyz, v1.w, r0, r1
dp3 r0.x, r1, c9
add r0.x, r0, c9.w
mul r0.xyz, r0.x, c9
add r1.xyz, -r0, r1
mad r1.xyz, r0, c10.x, r1
mov r1.w, c11.y
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT0.xy, r0.zwzw
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Matrix 96 [_TerrainEngineBendTree]
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0
eefiecedangbkaiglbdcpjendgheifdlekloebiaabaaaaaadiadaaaaadaaaaaa
cmaaaaaahmaaaaaalaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafdeieefciaacaaaaeaaaabaakaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaamaaaaaa
fpaaaaadhcbabaaaaaaaaaaafpaaaaadicbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
aaaaaaaaegiccaaaabaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegbcbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaa
afaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgbpbaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaa
abaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaabaaaaaaakaaaaaadcaaaaalhcaabaaaabaaaaaapgapbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaagiacaaaabaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Matrix 96 [_TerrainEngineBendTree]
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0_level_9_1
eefiecedidoodahmgfoolllhhnpfmlmnkjbfgblhabaaaaaanaaeaaaaaeaaaaaa
daaaaaaameabaaaaemaeaaaajmaeaaaaebgpgodjimabaaaaimabaaaaaaacpopp
eaabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaaaa
aeaaabaaaaaaaaaaabaaafaaaeaaafaaaaaaaaaaabaaakaaacaaajaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
afaaaaadaaaaahiaaaaaoejaafaaoekaafaaaaadabaaahiaaaaaffiaahaaoeka
aeaaaaaeabaaahiaagaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahiaaiaaoeka
aaaakkiaabaaoeiaaeaaaaaeabaaahiaaaaaoejaafaaoekbabaaoeiaaeaaaaae
aaaaahiaabaappjaabaaoeiaaaaaoeiaaiaaaaadaaaaaiiaajaaoekaaaaaoeia
acaaaaadaaaaaiiaaaaappiaajaappkaaeaaaaaeabaaahiaaaaappiaajaaoekb
aaaaoeiabcaaaaaeacaaahiaakaaaakaaaaaoeiaabaaoeiaafaaaaadaaaaapia
acaaffiaacaaoekaaeaaaaaeaaaaapiaabaaoekaacaaaaiaaaaaoeiaaeaaaaae
aaaaapiaadaaoekaacaakkiaaaaaoeiaacaaaaadaaaaapiaaaaaoeiaaeaaoeka
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefciaacaaaaeaaaabaakaaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaamaaaaaafpaaaaadhcbabaaaaaaaaaaa
fpaaaaadicbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagiaaaaac
acaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegiccaaaabaaaaaa
afaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaa
ahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
aiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egbcbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaafaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgbpbaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaaabaaaaaaakaaaaaaegacbaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaabaaaaaa
akaaaaaadcaaaaalhcaabaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
abaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaa"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 4 ALU
dcl t0.xy
rcp r0.x, t0.y
mul r0.x, t0, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedcbejcgfjfchfioiockkbgpdagbgpkifoabaaaaaaneaaaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
eefiecedddomjckbhjkfhaokccgpbcigcfdhmblaabaaaaaadmabaaaaaeaaaaaa
daaaaaaajeaaaaaaneaaaaaaaiabaaaaebgpgodjfmaaaaaafmaaaaaaaaacpppp
diaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaacaaaacpia
aaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeTransparentCutout" }
 Pass {
  Tags { "RenderType"="TreeTransparentCutout" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 5 [_TerrainEngineBendTree]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
"!!ARBvp1.0
# 18 ALU
PARAM c[12] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[9];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[10];
ADD R0.w, R0, c[10];
MUL R1.xyz, R0.w, c[10];
ADD R0.xyz, -R1, R0;
MOV R0.w, c[0].y;
MAD R0.xyz, R1, c[11].x, R0;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_TerrainEngineBendTree]
Vector 8 [_Scale]
Vector 9 [_SquashPlaneNormal]
Float 10 [_SquashAmount]
"vs_2_0
; 20 ALU
def c11, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mul r1.xyz, v0, c8
mov r1.w, c11.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
add r0.xyz, r0, -r1
mad r1.xyz, v1.w, r0, r1
dp3 r0.x, r1, c9
add r0.x, r0, c9.w
mul r0.xyz, r0.x, c9
add r1.xyz, -r0, r1
mad r1.xyz, r0, c10.x, r1
mov r1.w, c11.y
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Matrix 96 [_TerrainEngineBendTree]
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0
eefiecedmgigggkcjekbmipjdecnnjbjngmimhkjabaaaaaakiadaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckmacaaaaeaaaabaa
klaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
amaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadicbabaaaabaaaaaafpaaaaad
dcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egiccaaaabaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegbcbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaafaaaaaa
egacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgbpbaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaaabaaaaaa
akaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaabaaaaaaakaaaaaadcaaaaalhcaabaaaabaaaaaapgapbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaabaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaa
acaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Matrix 96 [_TerrainEngineBendTree]
Vector 80 [_Scale]
Vector 160 [_SquashPlaneNormal]
Float 176 [_SquashAmount]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0_level_9_1
eefiecedkmmcmkhgdlecjcggbdheibbhdgafciklabaaaaaafiafaaaaaeaaaaaa
daaaaaaanmabaaaajaaeaaaaaaafaaaaebgpgodjkeabaaaakeabaaaaaaacpopp
fiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaaaa
aeaaabaaaaaaaaaaabaaafaaaeaaafaaaaaaaaaaabaaakaaacaaajaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaaaaaoejaafaaoekaafaaaaad
abaaahiaaaaaffiaahaaoekaaeaaaaaeabaaahiaagaaoekaaaaaaaiaabaaoeia
aeaaaaaeabaaahiaaiaaoekaaaaakkiaabaaoeiaaeaaaaaeabaaahiaaaaaoeja
afaaoekbabaaoeiaaeaaaaaeaaaaahiaabaappjaabaaoeiaaaaaoeiaaiaaaaad
aaaaaiiaajaaoekaaaaaoeiaacaaaaadaaaaaiiaaaaappiaajaappkaaeaaaaae
abaaahiaaaaappiaajaaoekbaaaaoeiabcaaaaaeacaaahiaakaaaakaaaaaoeia
abaaoeiaafaaaaadaaaaapiaacaaffiaacaaoekaaeaaaaaeaaaaapiaabaaoeka
acaaaaiaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaacaakkiaaaaaoeiaacaaaaad
aaaaapiaaaaaoeiaaeaaoekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaacaaoejappppaaaafdeieefc
kmacaaaaeaaaabaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaae
egiocaaaabaaaaaaamaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadicbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegiccaaaabaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegbcbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaafaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgbpbaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaa
egiccaaaabaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaabaaaaaaakaaaaaadcaaaaalhcaabaaaabaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaakaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagiacaaaabaaaaaaalaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaiaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaa
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmipiblfmemhpadgbjmijnkfonaegciknabaaaaaakiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaaaaaa
eaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbfceklabcddndgkomkgongggbidlobjoabaaaaaagaacaaaaaeaaaaaa
daaaaaaaoeaaaaaaneabaaaacmacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
hiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadaaaacpiaaaaappiaaaaaaakb
ebaaaaabaaaaapiaabaaaaacaaaacpiaabaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoiaaaaaaeaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeBillboard" }
 Pass {
  Tags { "RenderType"="TreeBillboard" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_TreeBillboardCameraRight]
Vector 6 [_TreeBillboardCameraUp]
Vector 7 [_TreeBillboardCameraFront]
Vector 8 [_TreeBillboardCameraPos]
Vector 9 [_TreeBillboardDistances]
"!!ARBvp1.0
# 19 ALU
PARAM c[10] = { { 0 },
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
TEMP R1;
ADD R0.xyz, vertex.position, -c[8];
DP3 R0.x, R0, R0;
SLT R0.x, c[9], R0;
MAD R0.z, R0.x, -vertex.texcoord[0].y, vertex.texcoord[0].y;
MAD R0.xy, -vertex.texcoord[1], R0.x, vertex.texcoord[1];
ADD R0.z, -R0.y, R0;
MAD R1.xyz, R0.x, c[5], vertex.position;
MAD R0.y, R0.z, c[8].w, R0;
MOV R0.w, vertex.position;
MAD R1.xyz, R0.y, c[6], R1;
ABS R0.x, R0;
MUL R0.xyz, R0.x, c[7];
MAD R0.xyz, R0, c[6].w, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
SLT result.texcoord[0].y, c[0].x, vertex.texcoord[0];
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 19 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_TreeBillboardCameraRight]
Vector 5 [_TreeBillboardCameraUp]
Vector 6 [_TreeBillboardCameraFront]
Vector 7 [_TreeBillboardCameraPos]
Vector 8 [_TreeBillboardDistances]
"vs_2_0
; 23 ALU
def c9, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
add r0.xyz, v0, -c7
dp3 r0.x, r0, r0
slt r0.x, c8, r0
max r0.x, -r0, r0
slt r0.x, c9, r0
add r0.z, -r0.x, c9.y
mul r0.xy, r0.z, v2
mad r0.z, r0, v1.y, -r0.y
mad r1.xyz, r0.x, c4, v0
mad r0.y, r0.z, c7.w, r0
mov r1.w, v0
mad r1.xyz, r0.y, c5, r1
abs r0.x, r0
mul r0.xyz, r0.x, c6
mad r1.xyz, r0, c5.w, r1
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
slt oT0.y, c9.x, v1
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Vector 180 [_TreeBillboardCameraRight] 3
Vector 192 [_TreeBillboardCameraUp]
Vector 208 [_TreeBillboardCameraFront]
Vector 224 [_TreeBillboardCameraPos]
Vector 240 [_TreeBillboardDistances]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0
eefiecedaeokifhajhookfneomejbnifmodfhhakabaaaaaaaiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaamabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpeacaaaaeaaaabaalnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
acaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaoaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadbaaaaaibcaabaaaaaaaaaaaakiacaaaabaaaaaaapaaaaaaakaabaaa
aaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
abaaaaaabkbabaaaacaaaaaadhaaaaamhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
ccaabaaaaaaaaaaadkiacaaaabaaaaaaaoaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaajgihcaaaabaaaaaaalaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadiaaaaajncaabaaaaaaaaaaaagaabaiaibaaaaaa
aaaaaaaaagijcaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaamaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaigadbaaaaaaaaaaapgipcaaaabaaaaaaamaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaahbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkbabaaaacaaaaaaabaaaaahcccabaaaabaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaafbccabaaaabaaaaaaakbabaaa
acaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Vector 180 [_TreeBillboardCameraRight] 3
Vector 192 [_TreeBillboardCameraUp]
Vector 208 [_TreeBillboardCameraFront]
Vector 224 [_TreeBillboardCameraPos]
Vector 240 [_TreeBillboardDistances]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0_level_9_1
eefiecedmpeepckgcagncaleeljfedhbioipciegabaaaaaaoiafaaaaaeaaaaaa
daaaaaaaamacaaaaaiafaaaajaafaaaaebgpgodjneabaaaaneabaaaaaaacpopp
jeabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaabaaalaaafaaafaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
akaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaamaaaaadaaaaacoa
akaaaakaacaaffjaacaaaaadaaaaahiaaaaaoejaaiaaoekbaiaaaaadaaaaabia
aaaaoeiaaaaaoeiaamaaaaadaaaaabiaajaaaakaaaaaaaiaabaaaaacabaaadia
adaaoejaabaaaaacabaaaeiaacaaffjaaeaaaaaeaaaaahiaaaaaaaiaabaaoeib
abaaoeiaaeaaaaaeabaaahiaafaapjkaaaaaaaiaaaaaoejabcaaaaaeabaaaiia
aiaappkaaaaakkiaaaaaffiacdaaaaacaaaaabiaaaaaaaiaafaaaaadaaaaahia
aaaaaaiaahaaoekaaeaaaaaeabaaahiaagaaoekaabaappiaabaaoeiaaeaaaaae
aaaaahiaaaaaoeiaagaappkaabaaoeiaafaaaaadabaaapiaaaaaffiaacaaoeka
aeaaaaaeabaaapiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaadaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaacaaaajappppaaaafdeieefcpeacaaaaeaaaabaalnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
acaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaoaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadbaaaaaibcaabaaaaaaaaaaaakiacaaaabaaaaaaapaaaaaaakaabaaa
aaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
abaaaaaabkbabaaaacaaaaaadhaaaaamhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
ccaabaaaaaaaaaaadkiacaaaabaaaaaaaoaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaajgihcaaaabaaaaaaalaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadiaaaaajncaabaaaaaaaaaaaagaabaiaibaaaaaa
aaaaaaaaagijcaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaamaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaigadbaaaaaaaaaaapgipcaaaabaaaaaaamaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaahbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkbabaaaacaaaaaaabaaaaahcccabaaaabaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaafbccabaaaabaaaaaaakbabaaa
acaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapadaaaa
hhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[1] = { { 0, 0.0010004044 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0].y;
MOV result.color, c[0].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c0, -0.00100040, 0.00000000, 1.00000000, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedljdikeenlhienfmnbikhpdmfkefegeaaabaaaaaajaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaa
eaaaaaaadeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
gpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedepbnmblnandlfedgoaeemfpkapckokanabaaaaaadmacaaaaaeaaaaaa
daaaaaaaniaaaaaalaabaaaaaiacaaaaebgpgodjkaaaaaaakaaaaaaaaaacpppp
hiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkagpbcidlkaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoela
aaaioekaacaaaaadaaaacpiaaaaappiaaaaaaakaebaaaaabaaaaapiaabaaaaac
aaaacpiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcnaaaaaaa
eaaaaaaadeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
gpbcidlkdbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="GrassBillboard" }
 Pass {
  Tags { "RenderType"="GrassBillboard" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Vector 5 [_WavingTint]
Vector 6 [_WaveAndDistance]
Vector 7 [_CameraPosition]
Vector 8 [_CameraRight]
Vector 9 [_CameraUp]
"!!ARBvp1.0
# 48 ALU
PARAM c[17] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.mvp,
		program.local[5..9],
		{ 0.012, 0.02, 0.059999999, 0.024 },
		{ 0.0060000001, 0.02, 0.050000001, 6.4088488 },
		{ 3.1415927, -0.00019840999, 0.0083333002, -0.16161616 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 },
		{ 0.47193992, 0.18877596, 0.094387978, 0.5 },
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R0.xyz, vertex.position, -c[7];
DP3 R0.x, R0, R0;
SLT R0.x, c[6].w, R0;
MAD R0.xy, -vertex.attrib[14], R0.x, vertex.attrib[14];
MAD R1.xyz, R0.x, c[8], vertex.position;
MAD R3.xyz, R0.y, c[9], R1;
MUL R0.x, R3.z, c[6].y;
MUL R1.xyz, R0.x, c[11];
MUL R0.x, R3, c[6].y;
MAD R1, R0.x, c[10], R1.xyyz;
MOV R0, c[0];
MAD R0, R0, c[6].x, R1;
FRC R0, R0;
MUL R0, R0, c[11].w;
ADD R0, R0, -c[12].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[12].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[12].z, R0;
MAD R0, R1, c[12].y, R0;
MUL R0, R0, R0;
MUL R0, R0, R0;
MUL R1, R0, vertex.attrib[14].y;
DP4 R2.x, R1, c[14];
DP4 R2.y, R1, c[13];
MAD R1.xz, -R2.xyyw, c[6].z, R3;
MOV R1.y, R3;
MOV R1.w, vertex.position;
ADD R2.xyz, R1, -c[7];
DP3 R2.x, R2, R2;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
ADD R2.x, -R2, c[6].w;
MUL R1.y, R2.x, c[7].w;
MUL R1.w, R1.y, c[0].y;
DP4 R0.x, R0, c[15].xxyz;
MOV R1.x, c[15].w;
ADD R1.xyz, -R1.x, c[5];
MAD R0.xyz, R0.x, R1, c[15].w;
MIN R0.w, R1, c[16].x;
MUL R0.xyz, R0, vertex.color;
MAX result.color.w, R0, c[16].y;
MUL result.color.xyz, R0, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 48 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_WavingTint]
Vector 5 [_WaveAndDistance]
Vector 6 [_CameraPosition]
Vector 7 [_CameraRight]
Vector 8 [_CameraUp]
"vs_2_0
; 54 ALU
def c9, 0.00000000, 1.00000000, 6.40884876, -3.14159274
def c10, 0.00600000, 0.02000000, 0.05000000, -0.16161616
def c11, 0.01200000, 0.02000000, 0.06000000, 0.02400000
def c12, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c13, 0.00833330, -0.00019841, -0.50000000, 0.50000000
def c14, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c15, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c16, 0.47193992, 0.18877596, 0.09438798, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_texcoord0 v3
dcl_color0 v5
add r0.xyz, v0, -c6
dp3 r0.x, r0, r0
slt r0.x, c5.w, r0
max r0.x, -r0, r0
slt r0.x, c9, r0
add r0.x, -r0, c9.y
mul r0.xy, r0.x, v1
mad r1.xyz, r0.x, c7, v0
mad r3.xyz, r0.y, c8, r1
mul r0.x, r3.z, c5.y
mul r1.xyz, r0.x, c10
mul r0.x, r3, c5.y
mad r0, r0.x, c11, r1.xyyz
mov r1.x, c5
mad r0, c12, r1.x, r0
frc r0, r0
mad r0, r0, c9.z, c9.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c10.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c13.x, r0
mad r0, r1, c13.y, r0
mul r0, r0, r0
mul r0, r0, r0
mul r1, r0, v1.y
dp4 r2.y, r1, c14
dp4 r2.x, r1, c15
mad r1.xz, -r2.xyyw, c5.z, r3
mov r1.y, r3
add r2.xyz, r1, -c6
mov r1.w, v0
dp3 r3.x, r2, r2
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
add r1.x, -r3, c5.w
mul r1.w, r1.x, c6
mov r1.xyz, c4
dp4 r0.x, r0, c16.xxyz
mul r1.w, r1, c12.y
add r1.xyz, c13.z, r1
mad r0.xyz, r0.x, r1, c13.w
min r0.w, r1, c9.y
mul r0.xyz, r0, v5
mov oPos, r2
mov oT1.xy, r2.zwzw
max oD0.w, r0, c9.x
mul oD0.xyz, r0, c12.y
mov oT0.xy, v3
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Vector 0 [_WavingTint]
Vector 16 [_WaveAndDistance]
Vector 32 [_CameraPosition]
Vector 48 [_CameraRight] 3
Vector 64 [_CameraUp] 3
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0
eefiecedfjjncchmbejohkoohfjmhihbgaaafhndabaaaaaalaahaaaaadaaaaaa
cmaaaaaapeaaaaaagiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaagaaaaeaaaabaajaabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
hcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaacaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaadkiacaaaabaaaaaaabaaaaaaakaabaaaaaaaaaaadhaaaaamdcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadcaaaaakncaabaaaaaaaaaaaagaabaaaaaaaaaaaagijcaaa
abaaaaaaadaaaaaaagbjbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaaigadbaaaaaaaaaaadiaaaaaidcaabaaa
abaaaaaaigaabaaaaaaaaaaafgifcaaaabaaaaaaabaaaaaadiaaaaakpcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaakgjlmedlaknhkddmaknhkddmmnmmemdn
dcaaaaampcaabaaaabaaaaaaagaabaaaabaaaaaaaceaaaaakgjleedmaknhkddm
ipmchfdnkgjlmedmegaobaaaacaaaaaadcaaaaanpcaabaaaabaaaaaaagiacaaa
abaaaaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
abaaaaaabkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaabaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
abaaaaaadcaaaaampcaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaabaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaabaaaaaa
fgbfbaaaabaaaaaabbaaaaakicaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
fnjicmdpfnjicmdphnbdikdohnbdakdodiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaadddddddpbbaaaaakbcaabaaaabaaaaaaegaobaaaacaaaaaa
aceaaaaakgjlmedmaknhcddnipmcpflnkgjlmednbbaaaaakecaabaaaabaaaaaa
egaobaaaacaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdndcaaaaal
fcaabaaaaaaaaaaaagacbaiaebaaaaaaabaaaaaakgikcaaaabaaaaaaabaaaaaa
agacbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaacaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dkiacaaaabaaaaaaabaaaaaaapcaaaaiiccabaaaabaaaaaapgipcaaaabaaaaaa
acaaaaaafgafbaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaaamhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Vector 0 [_WavingTint]
Vector 16 [_WaveAndDistance]
Vector 32 [_CameraPosition]
Vector 48 [_CameraRight] 3
Vector 64 [_CameraUp] 3
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0_level_9_1
eefiecedibekdgcekfjkfcdgdliehpeknhbegeglabaaaaaaamamaaaaaeaaaaaa
daaaaaaaiiaeaaaanaakaaaajialaaaaebgpgodjfaaeaaaafaaeaaaaaaacpopp
baaeaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaabaaaaaaafaaafaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
akaaapkakgjlmedlaknhkddmmnmmemdnlfhocflofbaaaaafalaaapkajkjjjjdp
aaaaaaeamnmmmmdpjkjjjjeafbaaaaafamaaapkaekbfmneanlapejmagfiiaidm
ehamfaljfbaaaaafanaaapkafnjicmdphnbdikdohnbdakdodddddddpfbaaaaaf
aoaaapkakgjleedmaknhkddmipmchfdnkgjlmedmfbaaaaafapaaapkakgjlmedm
aknhcddnipmcpflnkgjlmednfbaaaaafbaaaapkakgjlmedlaknhkddmaknhkdlm
mnmmmmdnfbaaaaafbbaaapkaaaaaaalpaaaaaadpaaaaaaaaaaaaiadpbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaafiaafaaapjaacaaaaadaaaaahiaaaaaoejaahaaoekbaiaaaaad
aaaaabiaaaaaoeiaaaaaoeiaamaaaaadaaaaabiaagaappkaaaaaaaiaaeaaaaae
aaaaadiaaaaaaaiaabaaoejbabaaoejaaeaaaaaeaaaaaniaaaaaaaiaaiaajeka
aaaajejaaeaaaaaeaaaaahiaaaaaffiaajaaoekaaaaapiiaafaaaaadabaaadia
aaaaoiiaagaaffkaafaaaaadacaaapiaabaaffiaakaajekaaeaaaaaeabaaapia
abaaaaiaaoaaoekaacaaoeiaabaaaaacacaaabiaagaaaakaaeaaaaaeabaaapia
acaaaaiaalaaoekaabaaoeiabdaaaaacabaaapiaabaaoeiaaeaaaaaeabaaapia
abaaoeiaamaaaakaamaaffkaafaaaaadacaaapiaabaaoeiaabaaoeiaafaaaaad
adaaapiaabaaoeiaacaaoeiaaeaaaaaeabaaapiaadaaoeiaakaappkaabaaoeia
afaaaaadadaaapiaacaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeia
aeaaaaaeabaaapiaadaaoeiaamaakkkaabaaoeiaaeaaaaaeabaaapiaacaaoeia
amaappkaabaaoeiaafaaaaadabaaapiaabaaoeiaabaaoeiaafaaaaadabaaapia
abaaoeiaabaaoeiaafaaaaadacaaapiaabaaoeiaabaaffjaajaaaaadaaaaaiia
abaaoeiaanaajakaafaaaaadaaaaaiiaaaaappiaanaappkaajaaaaadabaaabia
acaaoeiaapaaoekaajaaaaadabaaaeiaacaaoeiabaaaoekaaeaaaaaeaaaaafia
abaaoeiaagaakkkbaaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaae
abaaapiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkia
abaaoeiaacaaaaadaaaaahiaaaaaoeiaahaaoekbaiaaaaadaaaaabiaaaaaoeia
aaaaoeiaacaaaaadaaaaabiaaaaaaaibagaappkaafaaaaadaaaaabiaaaaaaaia
ahaappkaacaaaaadaaaaabiaaaaaaaiaaaaaaaiaalaaaaadaaaaabiaaaaaaaia
bbaakkkaakaaaaadaaaaaioaaaaaaaiabbaappkaaeaaaaaeabaaapiaaeaaoeka
aaaappjaabaaoeiaabaaaaacaaaaabiabbaaaakaacaaaaadaaaaahiaaaaaaaia
afaaoekaaeaaaaaeaaaaahiaaaaappiaaaaaoeiabbaaffkaacaaaaadaaaaahia
aaaaoeiaaaaaoeiaafaaaaadaaaaahoaaaaaoeiaafaaoejaaeaaaaaeaaaaadma
abaappiaaaaaoekaabaaoeiaabaaaaacaaaaammaabaaoeiaabaaaaacabaaadoa
adaaoejappppaaaafdeieefceaagaaaaeaaaabaajaabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
hcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaacaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaadkiacaaaabaaaaaaabaaaaaaakaabaaaaaaaaaaadhaaaaamdcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadcaaaaakncaabaaaaaaaaaaaagaabaaaaaaaaaaaagijcaaa
abaaaaaaadaaaaaaagbjbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaaigadbaaaaaaaaaaadiaaaaaidcaabaaa
abaaaaaaigaabaaaaaaaaaaafgifcaaaabaaaaaaabaaaaaadiaaaaakpcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaakgjlmedlaknhkddmaknhkddmmnmmemdn
dcaaaaampcaabaaaabaaaaaaagaabaaaabaaaaaaaceaaaaakgjleedmaknhkddm
ipmchfdnkgjlmedmegaobaaaacaaaaaadcaaaaanpcaabaaaabaaaaaaagiacaaa
abaaaaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
abaaaaaabkaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaabaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
abaaaaaadcaaaaampcaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaabaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaabaaaaaa
fgbfbaaaabaaaaaabbaaaaakicaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
fnjicmdpfnjicmdphnbdikdohnbdakdodiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaadddddddpbbaaaaakbcaabaaaabaaaaaaegaobaaaacaaaaaa
aceaaaaakgjlmedmaknhcddnipmcpflnkgjlmednbbaaaaakecaabaaaabaaaaaa
egaobaaaacaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdndcaaaaal
fcaabaaaaaaaaaaaagacbaiaebaaaaaaabaaaaaakgikcaaaabaaaaaaabaaaaaa
agacbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaacaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dkiacaaaabaaaaaaabaaaaaaapcaaaaiiccabaaaabaaaaaapgipcaaaabaaaaaa
acaaaaaafgafbaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaaamhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaadaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapadaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapahaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhpjibpacogkcjhcocfaoploeimbbimhgabaaaaaaniabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddekkjenaooggnbjphigiglfanepfeemlabaaaaaakaacaaaaaeaaaaaa
daaaaaaapeaaaaaapiabaaaagmacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
iiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaaeaaaaae
aaaacpiaaaaappiaaaaapplaaaaaaakbebaaaaabaaaaapiaabaaaaacaaaacpia
abaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="Grass" }
 Pass {
  Tags { "RenderType"="Grass" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_WavingTint]
Vector 6 [_WaveAndDistance]
Vector 7 [_CameraPosition]
"!!ARBvp1.0
# 42 ALU
PARAM c[15] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.mvp,
		program.local[5..7],
		{ 0.012, 0.02, 0.059999999, 0.024 },
		{ 0.0060000001, 0.02, 0.050000001, 6.4088488 },
		{ 3.1415927, -0.00019840999, 0.0083333002, -0.16161616 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 },
		{ 0.47193992, 0.18877596, 0.094387978, 0.5 },
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R0.x, vertex.position.z, c[6].y;
MUL R1.xyz, R0.x, c[9];
MUL R0.x, vertex.position, c[6].y;
MAD R1, R0.x, c[8], R1.xyyz;
MOV R0, c[0];
MAD R0, R0, c[6].x, R1;
FRC R0, R0;
MUL R0, R0, c[9].w;
ADD R0, R0, -c[10].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[10].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[10].z, R0;
MAD R0, R1, c[10].y, R0;
MUL R0, R0, R0;
MUL R1, R0, R0;
MUL R2.x, vertex.color.w, c[6].z;
MUL R0, R1, R2.x;
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[12];
MAD R0.xz, -R2.xyyw, c[6].z, vertex.position;
MOV R0.yw, vertex.position;
ADD R2.xyz, R0, -c[7];
DP3 R2.x, R2, R2;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
ADD R2.x, -R2, c[6].w;
MUL R0.y, R2.x, c[7].w;
MUL R0.w, R0.y, c[0].y;
MOV R0.x, c[13].w;
MIN R0.w, R0, c[14].x;
ADD R0.xyz, -R0.x, c[5];
DP4 R1.x, R1, c[13].xxyz;
MAD R0.xyz, R1.x, R0, c[13].w;
MUL R0.xyz, vertex.color, R0;
MAX result.color.w, R0, c[14].y;
MUL result.color.xyz, R0, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 42 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_WavingTint]
Vector 5 [_WaveAndDistance]
Vector 6 [_CameraPosition]
"vs_2_0
; 45 ALU
def c7, 0.00600000, 0.02000000, 0.05000000, -0.16161616
def c8, 0.01200000, 0.02000000, 0.06000000, 0.02400000
def c9, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c10, 6.40884876, -3.14159274, 0.00833330, -0.00019841
def c11, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c12, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c13, 0.47193992, 0.18877596, 0.09438798, -0.50000000
def c14, 0.50000000, 1.00000000, 0.00000000, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mul r0.x, v0.z, c5.y
mul r1.xyz, r0.x, c7
mul r0.x, v0, c5.y
mad r1, r0.x, c8, r1.xyyz
mov r0.x, c5
mad r0, c9, r0.x, r1
frc r0, r0
mad r0, r0, c10.x, c10.y
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c7.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c10.z, r0
mad r0, r1, c10.w, r0
mul r0, r0, r0
mov r2.yw, v0
mul r1, r0, r0
mul r2.x, v5.w, c5.z
mul r0, r1, r2.x
dp4 r2.z, r0, c11
dp4 r2.x, r0, c12
mad r2.xz, -r2, c5.z, v0
add r0.xyz, r2, -c6
dp3 r3.x, r0, r0
dp4 r0.w, r2, c3
dp4 r0.z, r2, c2
dp4 r0.x, r2, c0
dp4 r0.y, r2, c1
mov oPos, r0
add r0.x, -r3, c5.w
mov oT1.xy, r0.zwzw
mul r0.w, r0.x, c6
mov r0.xyz, c4
mul r0.w, r0, c9.y
min r0.w, r0, c14.y
add r0.xyz, c13.w, r0
dp4 r1.x, r1, c13.xxyz
mad r0.xyz, r1.x, r0, c14.x
mul r0.xyz, v5, r0
max oD0.w, r0, c14.z
mul oD0.xyz, r0, c9.y
mov oT0.xy, v3
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Vector 0 [_WavingTint]
Vector 16 [_WaveAndDistance]
Vector 32 [_CameraPosition]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0
eefiecedaohfmmmcaelohhbnmgcnhnaodnjnmbkeabaaaaaabeahaaaaadaaaaaa
cmaaaaaapeaaaaaagiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefckeafaaaaeaaaabaagjabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaadaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagiaaaaacadaaaaaadiaaaaaidcaabaaaaaaaaaaaigbabaaaaaaaaaaa
fgifcaaaabaaaaaaabaaaaaadiaaaaakpcaabaaaabaaaaaafgafbaaaaaaaaaaa
aceaaaaakgjlmedlaknhkddmaknhkddmmnmmemdndcaaaaampcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaakgjleedmaknhkddmipmchfdnkgjlmedmegaobaaa
abaaaaaadcaaaaanpcaabaaaaaaaaaaaagiacaaaabaaaaaaabaaaaaaaceaaaaa
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejma
nlapejmanlapejmadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaalfhocflolfhocflo
lfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
gfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaabaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfalj
egaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaadkbabaaaafaaaaaackiacaaaabaaaaaaabaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaafnjicmdpfnjicmdphnbdikdo
hnbdakdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadddddddp
bbaaaaakbcaabaaaacaaaaaaegaobaaaabaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmednbbaaaaakecaabaaaacaaaaaaegaobaaaabaaaaaaaceaaaaa
kgjlmedlaknhkddmaknhkdlmmnmmmmdndcaaaaalfcaabaaaabaaaaaaagacbaia
ebaaaaaaacaaaaaakgikcaaaabaaaaaaabaaaaaaagbcbaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaaabaaaaaaegaobaaa
acaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaakgakbaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaadgaaaaafccaabaaaabaaaaaa
bkbabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaia
ebaaaaaaabaaaaaaacaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dkiacaaaabaaaaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadicaaaaiiccabaaaabaaaaaabkaabaaaaaaaaaaadkiacaaa
abaaaaaaacaaaaaaaaaaaaalocaabaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaalpdcaaaaamhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaa
aaaaaaahhccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
dccabaaaacaaaaaaegbabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityTerrain" 256
Vector 0 [_WavingTint]
Vector 16 [_WaveAndDistance]
Vector 32 [_CameraPosition]
BindCB  "UnityPerDraw" 0
BindCB  "UnityTerrain" 1
"vs_4_0_level_9_1
eefiecedejhhbdiabbmcbbbnnbdpkkiedlpaldleabaaaaaabealaaaaaeaaaaaa
daaaaaaacmaeaaaaniajaaaakaakaaaaebgpgodjpeadaaaapeadaaaaaaacpopp
leadaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaabaaaaaaadaaafaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
aiaaapkajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafajaaapkaekbfmnea
nlapejmagfiiaidmehamfaljfbaaaaafakaaapkakgjlmedlaknhkddmmnmmemdn
lfhocflofbaaaaafalaaapkafnjicmdphnbdikdohnbdakdodddddddpfbaaaaaf
amaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafanaaapkakgjlmedl
aknhkddmaknhkdlmmnmmmmdnfbaaaaafaoaaapkaaaaaaalpaaaaaadpaaaaaaaa
aaaaiadpfbaaaaafapaaapkakgjleedmaknhkddmipmchfdnkgjlmedmbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
afaaaaadaaaaadiaaaaaoijaagaaffkaafaaaaadabaaapiaaaaaffiaakaajeka
aeaaaaaeaaaaapiaaaaaaaiaapaaoekaabaaoeiaabaaaaacabaaabiaagaaaaka
aeaaaaaeaaaaapiaabaaaaiaaiaaoekaaaaaoeiabdaaaaacaaaaapiaaaaaoeia
aeaaaaaeaaaaapiaaaaaoeiaajaaaakaajaaffkaafaaaaadabaaapiaaaaaoeia
aaaaoeiaafaaaaadacaaapiaaaaaoeiaabaaoeiaaeaaaaaeaaaaapiaacaaoeia
akaappkaaaaaoeiaafaaaaadacaaapiaabaaoeiaacaaoeiaafaaaaadabaaapia
abaaoeiaacaaoeiaaeaaaaaeaaaaapiaacaaoeiaajaakkkaaaaaoeiaaeaaaaae
aaaaapiaabaaoeiaajaappkaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadabaaabiaafaappjaagaakkka
afaaaaadabaaapiaaaaaoeiaabaaaaiaajaaaaadaaaaabiaaaaaoeiaalaajaka
afaaaaadaaaaabiaaaaaaaiaalaappkaajaaaaadacaaabiaabaaoeiaamaaoeka
ajaaaaadacaaaeiaabaaoeiaanaaoekaaeaaaaaeabaaafiaacaaoeiaagaakkkb
aaaaoejaabaaaaacabaaaciaaaaaffjaacaaaaadaaaaaoiaabaajaiaahaajakb
aiaaaaadaaaaaciaaaaapjiaaaaapjiaacaaaaadaaaaaciaaaaaffibagaappka
afaaaaadaaaaaciaaaaaffiaahaappkaacaaaaadaaaaaciaaaaaffiaaaaaffia
alaaaaadaaaaaciaaaaaffiaaoaakkkaakaaaaadaaaaaioaaaaaffiaaoaappka
abaaaaacacaaabiaaoaaaakaacaaaaadaaaaaoiaacaaaaiaafaajakaaeaaaaae
aaaaahiaaaaaaaiaaaaapjiaaoaaffkaacaaaaadaaaaahiaaaaaoeiaaaaaoeia
afaaaaadaaaaahoaaaaaoeiaafaaoejaafaaaaadaaaaapiaaaaaffjaacaaoeka
aeaaaaaeaaaaapiaabaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaadaaoeka
abaakkiaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaadaaoejappppaaaafdeieefckeafaaaaeaaaabaagjabaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaadaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacadaaaaaadiaaaaaidcaabaaaaaaaaaaaigbabaaa
aaaaaaaafgifcaaaabaaaaaaabaaaaaadiaaaaakpcaabaaaabaaaaaafgafbaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkddmmnmmemdndcaaaaampcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaakgjleedmaknhkddmipmchfdnkgjlmedm
egaobaaaabaaaaaadcaaaaanpcaabaaaaaaaaaaaagiacaaaabaaaaaaabaaaaaa
aceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejma
nlapejmanlapejmanlapejmadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaalfhocflo
lfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaehamfaljehamfaljehamfalj
ehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaadkbabaaaafaaaaaackiacaaaabaaaaaa
abaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaa
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaafnjicmdpfnjicmdp
hnbdikdohnbdakdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
dddddddpbbaaaaakbcaabaaaacaaaaaaegaobaaaabaaaaaaaceaaaaakgjlmedm
aknhcddnipmcpflnkgjlmednbbaaaaakecaabaaaacaaaaaaegaobaaaabaaaaaa
aceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdndcaaaaalfcaabaaaabaaaaaa
agacbaiaebaaaaaaacaaaaaakgikcaaaabaaaaaaabaaaaaaagbcbaaaaaaaaaaa
diaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaaaaaaaaaagaabaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaadgaaaaafccaabaaa
abaaaaaabkbabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaa
agijcaiaebaaaaaaabaaaaaaacaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaajgahbaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadkiacaaaabaaaaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadicaaaaiiccabaaaabaaaaaabkaabaaaaaaaaaaa
dkiacaaaabaaaaaaacaaaaaaaaaaaaalocaabaaaaaaaaaaaagijcaaaabaaaaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaalpdcaaaaamhcaabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
afaaaaaaaaaaaaahhccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaadaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhpjibpacogkcjhcocfaoploeimbbimhgabaaaaaaniabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddekkjenaooggnbjphigiglfanepfeemlabaaaaaakaacaaaaaeaaaaaa
daaaaaaapeaaaaaapiabaaaagmacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
iiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaaeaaaaae
aaaacpiaaaaappiaaaaapplaaaaaaakbebaaaaabaaaaapiaabaaaaacaaaacpia
abaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
Fallback Off
}