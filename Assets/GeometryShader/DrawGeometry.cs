using UnityEngine;

[ExecuteInEditMode]
public class DrawGeometry : MonoBehaviour
{
    public Material material;
    public int count = 10000;

    void OnRenderObject()
    {
        if (material != null)
        {
            material.SetPass(0);
            Graphics.DrawProceduralNow(MeshTopology.Points, count, 1);
        }
    }
}
