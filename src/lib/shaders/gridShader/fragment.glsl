
varying vec2 vUv;
uniform vec2 mousePoint;

void main() {
    float thickness = 0.04;
    float factor = min( float(mod((vUv.x + 0.1) * 16.0, 1.0) < thickness) 
    + float(mod((vUv.y + 0.2) * 16.0, 1.0) < thickness), 1.35 )
    - (smoothstep(0.18, 0.25, distance(vUv, vec2(0.5) + vec2(0.0, 0.05)))
    * smoothstep(0.01, 0.25, distance(vUv, mousePoint)));
    

    gl_FragColor = vec4(0.0, 0.0, 0.0, max(0.0, factor - 0.95));
}