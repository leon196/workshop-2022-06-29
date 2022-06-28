Shader "Leon/Vertex Displacement"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Height ("Height", Range(0,1)) = 0.1
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Height;
            float4 _Color;

            struct attribute
            {
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct varying
            {
                float2 uv : TEXCOORD0;
                float4 position : SV_POSITION;
            };

            varying vert (attribute v)
            {
                varying o;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                v.position.y += tex2Dlod(_MainTex, float4(o.uv, 0, 0)).r * _Height;
                o.position = UnityObjectToClipPos(v.position);
                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                fixed4 color = tex2D(_MainTex, i.uv) * _Color;
                return color;
            }
            ENDCG
        }
    }
}
