Shader "Leon/Normal"
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
                float3 normal : NORMAL;
            };

            struct varying
            {
                float4 position : SV_POSITION;
                float3 normal : NORMAL;
            };

            varying vert (attribute v)
            {
                varying o;
                o.position = UnityObjectToClipPos(v.position);
                o.normal = v.normal;
                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                float3 color = normalize(i.normal);
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
