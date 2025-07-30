float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

float ease(float x) {
    return pow(1.0 - x, 3.0);
}

const vec4 TRAIL_COLOR = vec4(1.0, 0.725, 0.161, 1.0);
const vec4 TRAIL_COLOR_ACCENT = vec4(1.0, 0., 0., 1.0);
const float DURATION = 0.1; // Trail duration in seconds
const float TRAIL_WIDTH = 0.01; // Trail thickness
const int TRAIL_SEGMENTS = 300; // Number of trail segments
const float MIN_TRAIL_DISTANCE = 0.2; // Minimum distance to show trail

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif
    
    // Normalization for fragCoord to a space of -1 to 1;
    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);
    
    // Normalization for cursor position and size;
    // cursor xy has the postion in a space of -1 to 1;
    // zw has the width and height
    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));
    
    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    
    float sdfCurrentCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
    
    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float easedProgress = ease(progress);
    
    float lineLength = distance(centerCC, centerCP);
    
    // Original cursor blaze logic (keeps the orange-to-normal transition)
    vec4 trail = mix(TRAIL_COLOR_ACCENT, fragColor, 1. - smoothstep(0., sdfCurrentCursor + .002, 0.004));
    trail = mix(TRAIL_COLOR, trail, 1. - smoothstep(0., sdfCurrentCursor + .002, 0.004));
    fragColor = mix(trail, fragColor, 1. - smoothstep(0., sdfCurrentCursor, easedProgress * lineLength));
    
    // Add trail effect between previous and current cursor positions
    if (lineLength > MIN_TRAIL_DISTANCE && progress < 1.0) {
        vec2 trailDirection = centerCC - centerCP;
        vec2 trailNormal = normalize(trailDirection);
        
        // Sample multiple points along the trail
        for (int i = 0; i < TRAIL_SEGMENTS; i++) {
            float t = float(i) / float(TRAIL_SEGMENTS - 1);
            
            // Position along the trail (from previous to current)
            vec2 trailPos = mix(centerCP, centerCC, t);
            
            // Distance from fragment to trail point
            float distToTrail = distance(vu, trailPos);
            
            // Trail opacity based on time and position
            float timeAlpha = 1.0 - easedProgress;
            float positionAlpha = 1.0 - t * 0.7; // Fade from previous to current
            float alpha = timeAlpha * positionAlpha;
            
            // Trail width that tapers slightly
            float trailWidthAtPoint = TRAIL_WIDTH * (1.0 - t * 0.3);
            
            // Create trail segment
            if (distToTrail < trailWidthAtPoint) {
                float trailStrength = (1.0 - distToTrail / trailWidthAtPoint) * alpha * 0.4;
                vec4 trailColor = mix(TRAIL_COLOR, TRAIL_COLOR_ACCENT, t * 0.5);
                fragColor = mix(fragColor, trailColor, trailStrength);
            }
        }
    }
}
