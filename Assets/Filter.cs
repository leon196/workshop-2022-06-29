using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[ImageEffectAllowedInSceneView]
public class Filter : MonoBehaviour
{
    public Material filter;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (filter != null)
        {
            Graphics.Blit(source, destination, filter);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
