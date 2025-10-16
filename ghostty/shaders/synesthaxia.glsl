// A sophisticated dynamic cursor trail shader with color sampling
// From: https://github.com/Crackerfracks/Synesthaxia.glsl

#define ndcX(x) ((x * 2.0 - iResolution.x) / iResolution.y)
#define ndcY(y) ((y * 2.0 - iResolution.y) / iResolution.y)

vec2 ndc(vec2 coord) {
    return vec2(ndcX(coord.x), ndcY(coord.y));
}

float sdBox(in vec2 p, in vec2 xy, in vec2 b) {
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float sdPara(vec2 p, vec2 xy, vec2 b, float skew) {
    mat2 skewMatrix = mat2(1.0, skew, 0.0, 1.0);
    vec2 transformedP = skewMatrix * (p - xy);
    vec2 d = abs(transformedP) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

vec4 rectColor(vec2 topLeft, vec2 topRight, vec2 bottomLeft, vec2 bottomRight) {
    vec4 colors[4];
    colors[0] = texture(iChannel0, topLeft / iResolution.xy);
    colors[1] = texture(iChannel0, topRight / iResolution.xy);
    colors[2] = texture(iChannel0, bottomLeft / iResolution.xy);
    colors[3] = texture(iChannel0, bottomRight / iResolution.xy);
    
    vec4 mostVivid = colors[0];
    float maxSaturation = length(colors[0].rgb - vec3(dot(colors[0].rgb, vec3(0.299, 0.587, 0.114))));
    
    for (int i = 1; i < 4; i++) {
        float saturation = length(colors[i].rgb - vec3(dot(colors[i].rgb, vec3(0.299, 0.587, 0.114))));
        if (saturation > maxSaturation) {
            maxSaturation = saturation;
            mostVivid = colors[i];
        }
    }
    
    return mostVivid;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif
    
    vec2 uv = ndc(fragCoord);
    
    vec4 currentCursor = vec4(ndc(iCurrentCursor.xy), ndc(iCurrentCursor.zw));
    vec4 previousCursor = vec4(ndc(iPreviousCursor.xy), ndc(iPreviousCursor.zw));
    
    float timeSinceCursorChange = iTime - iTimeCursorChange;
    float duration = 0.6;
    float t = clamp(timeSinceCursorChange / duration, 0.0, 1.0);
    
    // Smooth easing function
    float easedT = t * t * (3.0 - 2.0 * t);
    
    vec2 cursorPos = mix(previousCursor.xy, currentCursor.xy, easedT);
    vec2 cursorSize = mix(previousCursor.zw, currentCursor.zw, easedT);
    
    // Distance calculation for movement-based effects
    float distance = length(currentCursor.xy - previousCursor.xy);
    float distanceThreshold = 0.05;
    
    if (distance > distanceThreshold && timeSinceCursorChange < duration) {
        // Sample colors from cursor corners for dynamic coloring
        vec2 topLeft = iCurrentCursor.xy;
        vec2 topRight = iCurrentCursor.xy + vec2(iCurrentCursor.z, 0.0);
        vec2 bottomLeft = iCurrentCursor.xy + vec2(0.0, iCurrentCursor.w);
        vec2 bottomRight = iCurrentCursor.xy + iCurrentCursor.zw;
        
        vec4 dynamicColor = rectColor(topLeft, topRight, bottomLeft, bottomRight);
        
        // Create trail effect
        float trailWidth = 0.01 * (1.0 - easedT);
        vec2 direction = normalize(currentCursor.xy - previousCursor.xy);
        vec2 perpendicular = vec2(-direction.y, direction.x);
        
        // Calculate distance to trail line
        vec2 toPoint = uv - previousCursor.xy;
        float projLength = dot(toPoint, direction);
        projLength = clamp(projLength, 0.0, distance);
        vec2 projPoint = previousCursor.xy + direction * projLength;
        float distToTrail = length(uv - projPoint);
        
        // Trail intensity based on distance and time
        float trailIntensity = smoothstep(trailWidth, 0.0, distToTrail) * (1.0 - easedT);
        
        // Glow effect around cursor
        float cursorDist = sdBox(uv, cursorPos, cursorSize * 0.5);
        float glowIntensity = exp(-cursorDist * 15.0) * 0.3;
        
        // Combine effects
        vec4 effectColor = dynamicColor * (trailIntensity + glowIntensity);
        fragColor = mix(fragColor, effectColor, effectColor.a * 0.7);
    }
    
    // Always add subtle glow around current cursor
    float currentCursorDist = sdBox(uv, currentCursor.xy, currentCursor.zw * 0.5);
    float currentGlow = exp(-currentCursorDist * 20.0) * 0.2;
    
    if (currentGlow > 0.01) {
        vec2 cursorCenter = iCurrentCursor.xy + iCurrentCursor.zw * 0.5;
        vec4 centerColor = texture(iChannel0, cursorCenter / iResolution.xy);
        fragColor = mix(fragColor, centerColor, currentGlow);
    }
}