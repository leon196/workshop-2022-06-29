Shader "Leon/Geometry"
{
	Properties
	{
		_Size ("Size", Float) = 0.0035
	}
	SubShader
	{
		Pass
		{
			Tags { "RenderType"="Opaque" }

			CGPROGRAM
			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "../Hash.cginc"

			struct attribute
			{
				uint id : SV_VertexID;
			};

			struct varying
			{
				float4 position : SV_POSITION;
				float4 color : COLOR;
			};
			
			struct varyingGeometry
			{
				float4 position : SV_POSITION;
				float4 color : COLOR;
			};

			varying vert (attribute v)
			{
				varying o;
				float3 rng = hash31(v.id)*2-1;
				rng.y = 0.;
				rng.xz *= 10;
				o.position = mul(UNITY_MATRIX_M, float4(rng, 1));
				o.color = float4(0,1,0,1);
				return o;
			}

			[maxvertexcount(20)]
			void geom (point varying input[1], inout TriangleStream<varyingGeometry> stream)
			{
				varying v = input[0];
				varyingGeometry o;
				o.color = v.color;
				
				float size = 0.01;
				float height = 1;
				float4 offset = 0;
				float4 pos = v.position;

				float3 z = normalize(pos - _WorldSpaceCameraPos);
				float3 x = normalize(cross(z, float3(0,1,0)));
				float3 y = float3(0,1,0);

				offset.xyz = -x*size;
				o.position = mul(UNITY_MATRIX_VP, pos+offset);
				stream.Append(o);

				offset.xyz = x*size;
				o.position = mul(UNITY_MATRIX_VP, pos+offset);
				stream.Append(o);

				offset.xyz = float3(0,1,0);
                o.position = mul(UNITY_MATRIX_VP, pos+offset);
				stream.Append(o);
                
				stream.RestartStrip();
			}

			fixed4 frag (varying i) : SV_Target
			{
				return saturate(i.color);
			}
			ENDCG
		}
	}
}
