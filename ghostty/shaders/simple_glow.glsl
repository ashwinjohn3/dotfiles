// Simple cursor glow animation for typing
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif
    
    // Normalize coordinates
    vec2 uv = (fragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    vec2 cursorPos = (iCurrentCursor.xy * 2.0 - iResolution.xy) / iResolution.y;
    
    // Time since cursor moved
    float timeSinceChange = iTime - iTimeCursorChange;
    float intensity = exp(-timeSinceChange * 3.0) * 0.8;
    
    // Distance from cursor
    float dist = length(uv - cursorPos);
    float glow = exp(-dist * 25.0) * intensity;
    
    // Orange/yellow glow color
    vec3 glowColor = vec3(1.0, 0.7, 0.2);
    fragColor.rgb = mix(fragColor.rgb, glowColor, glow);
}