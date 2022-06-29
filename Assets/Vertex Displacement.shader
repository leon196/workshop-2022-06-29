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
                float travel1 = _Time.y * 0.01;
                float travel2 = _Time.y * -0.02;
                float lengthXZ = length(v.position.xz);
                v.position.y += tex2Dlod(_MainTex, float4(o.uv+travel1, 0, 0)).r * _Height;
                v.position.y += tex2Dlod(_MainTex, float4(o.uv+travel2, 0, 0)).r * _Height;
                v.position.y += sin(_Time.y + lengthXZ * 4.) * .1;
                float angle = atan2(v.position.z, v.position.x);
                angle += sin(_Time.y + lengthXZ * 4.) * .1;
                v.position.xz = float2(cos(angle),sin(angle)) * lengthXZ;
                o.position = UnityObjectToClipPos(v.position);
                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                float travel1 = _Time.y * 0.01;
                float travel2 = _Time.y * -0.02;
                fixed4 color = tex2D(_MainTex, i.uv+travel1) * _Color;
                color += tex2D(_MainTex, i.uv+travel2) * _Color;
                return color;
            }
            ENDCG
        }
    }
}
