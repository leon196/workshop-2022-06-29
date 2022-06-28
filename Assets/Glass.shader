Shader "Leon/Glass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Strength ("Strength", Float) = 0.1
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "Queue"="Transparent-400" }
        Cull Off

        GrabPass
        {
            "_BackgroundTexture"
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform sampler2D _MainTex, _BackgroundTexture;
            float4 _MainTex_ST;
            float _Strength;

            struct attribute
            {
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct varying
            {
                float2 uv : TEXCOORD0;
                float4 position : SV_POSITION;
                float4 screen : TEXCOORD1;
            };

            varying vert (attribute v)
            {
                varying o;
                o.position = UnityObjectToClipPos(v.position);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.screen = ComputeGrabScreenPos(o.position);
                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                float4 offset = tex2D(_MainTex, i.uv).r * _Strength;
                float4 color = tex2Dproj(_BackgroundTexture, i.screen + offset);
                return color;
            }
            ENDCG
        }
    }
}
