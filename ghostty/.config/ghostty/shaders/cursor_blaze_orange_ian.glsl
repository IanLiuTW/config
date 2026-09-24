float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

vec2 toNorm(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float ease(float x) {
    return pow(1.0 - x, 3.0);
}

// Distance from point p to line segment ab
float distToSegment(vec2 p, vec2 a, vec2 b) {
    vec2 ab = b - a;
    float t = clamp(dot(p - a, ab) / dot(ab, ab), 0.0, 1.0);
    return distance(p, a + t * ab);
}

// Returns how far along the segment (0=a, 1=b) the closest point is
float projOnSegment(vec2 p, vec2 a, vec2 b) {
    vec2 ab = b - a;
    return clamp(dot(p - a, ab) / dot(ab, ab), 0.0, 1.0);
}

const vec4 TRAIL_COLOR = vec4(1.0, 0.725, 0.161, 1.0);
const vec4 TRAIL_COLOR_ACCENT = vec4(1.0, 0., 0., 1.0);
const float DURATION = 0.25;
const float TRAIL_WIDTH = 0.025;
const float MIN_TRAIL_DISTANCE = 0.2;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = toNorm(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(toNorm(iCurrentCursor.xy, 1.), toNorm(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(toNorm(iPreviousCursor.xy, 1.), toNorm(iPreviousCursor.zw, 0.));

    vec2 centerCC = vec2(currentCursor.x + (currentCursor.z / 2.), currentCursor.y - (currentCursor.w / 2.));
    vec2 centerCP = vec2(previousCursor.x + (previousCursor.z / 2.), previousCursor.y - (previousCursor.w / 2.));

    float sdfCurrentCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);

    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float easedProgress = ease(progress);

    float lineLength = distance(centerCC, centerCP);

    // Cursor blaze glow (orange-to-normal transition at cursor position)
    vec4 trail = mix(TRAIL_COLOR_ACCENT, fragColor, 1. - smoothstep(0., sdfCurrentCursor + .002, 0.004));
    trail = mix(TRAIL_COLOR, trail, 1. - smoothstep(0., sdfCurrentCursor + .002, 0.004));
    fragColor = mix(trail, fragColor, 1. - smoothstep(0., sdfCurrentCursor, easedProgress * lineLength));

    // Trail effect — gradient wipe from previous to current cursor
    if (lineLength > MIN_TRAIL_DISTANCE && progress < 1.0) {
        float dist = distToSegment(vu, centerCP, centerCC);
        float t = projOnSegment(vu, centerCP, centerCC);

        // The trail head sweeps from 0→1 over time; trail behind it fades out
        float head = easedProgress;
        // Only show trail behind the head, with a soft leading edge
        float leadingEdge = smoothstep(head, head - 0.5, t);
        // Fade out from tail (old position) over time
        float tailFade = smoothstep(0.0, head * 0.6, t);

        float trailWidthAtPoint = TRAIL_WIDTH * (1.0 - t * 0.3);

        if (dist < trailWidthAtPoint) {
            float edgeSoftness = 1.0 - dist / trailWidthAtPoint;
            float trailStrength = edgeSoftness * leadingEdge * tailFade * 0.8;
            vec4 trailColor = mix(TRAIL_COLOR, TRAIL_COLOR_ACCENT, t * 0.5);
            fragColor = mix(fragColor, trailColor, trailStrength);
        }
    }
}
