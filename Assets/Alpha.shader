Shader "Leon/Alpha"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha 
        ZWrite Off

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
            };

            float4 _Color;

            varying vert (attribute v)
            {
                varying o;
                o.position = UnityObjectToClipPos(v.position);
                return o;
            }

            fixed4 frag (varying i) : SV_Target
            {
                fixed4 col = _Color;
                return col;
            }
            ENDCG
        }
    }
}
