//
//  EffectMergerLumaLevelsPIX.metal
//  PixelKit Shaders
//
//  Created by Hexagons on 2017-11-26.
//  Copyright © 2017 Hexagons. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#import "random_header.metal"

struct VertexOut{
    float4 position [[position]];
    float2 texCoord;
};

struct Uniforms {
    float brightness;
    float darkness;
    float contrast;
    float gamma;
    float opacity;
};

fragment float4 effectMergerLumaLevelsPIX(VertexOut out [[stage_in]],
                                          texture2d<float>  inTexA [[ texture(0) ]],
                                          texture2d<float>  inTexB [[ texture(1) ]],
                                          const device Uniforms& in [[ buffer(0) ]],
                                          sampler s [[ sampler(0) ]]) {
    
    float pi = 3.14159265359;
    int max_res = 16384 - 1;
    
    float u = out.texCoord[0];
    float v = out.texCoord[1];
    float2 uv = float2(u, v);
    
    float4 c = inTexA.sample(s, uv);
    
    float4 cb = inTexB.sample(s, uv);
    float lum = (cb.r + cb.g + cb.b) / 3;
    
    float opacity = (1.0 - (1.0 - in.opacity) * lum);
    float a = c.a * opacity;
    
    c *= 1 / (1.0 - in.darkness * lum);
    c -= 1.0 / (1.0 - in.darkness * lum) - 1;
    
    c *= 1.0 - (1.0 - in.brightness) * lum;
    
    c -= 0.5;
    c *= 1.0 + in.contrast * lum;
    c += 0.5;
    
    c = pow(c, 1 / max(0.001, 1.0 - (1.0 - in.gamma) * lum));
    
    c *= opacity;
    
    return float4(c.r, c.g, c.b, a);
}


