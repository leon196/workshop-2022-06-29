Shader "Leon/Shade"
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
                float3 view : TEXCOORD0;
                float3 normal : NORMAL;
            };

            varying vert (attribute v)
            {
                varying o;
                o.position = UnityObjectToClipPos(v.position);

                o.view = _WorldSpaceCameraPos - mul(UNITY_MATRIX_M, v.position).xyz;
                o.normal = mul(UNITY_MATRIX_M, float4(v.normal, 0)).xyz;

                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                float3 view = normalize(i.view);
                float3 normal = normalize(i.normal);
                float3 color = dot(view, normal);
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
