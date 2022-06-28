Shader "Leon/Position"
{
    Properties
    {
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
            

            struct attribute
            {
                float4 position : POSITION;
            };

            struct varying
            {
                float4 position : SV_POSITION;
                float3 world : TEXCOORD0;
            };

            varying vert (attribute v)
            {
                varying o;
                o.position = UnityObjectToClipPos(v.position);
                o.world = mul(UNITY_MATRIX_M, v.position).xyz;
                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                float3 color = frac(abs(i.world));
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
