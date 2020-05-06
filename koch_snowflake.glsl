precision mediump float;
uniform float t; // time
uniform vec2  r; // resolution

const float PI = 3.14159265;

vec2 fold(vec2 p, float ang){
    vec2 n=vec2(cos(-ang),sin(-ang));
    p-=2.*min(0.,dot(p,n))*n;
    return p;
}

vec2 koch_fold(vec2 pt) {
    // Fold horizontally
    pt.x = abs(pt.x);
    pt.x-=.5;
    //Fold across PI/6
    pt = fold(pt,PI/6.);
    return pt;
}

vec2 koch_curve(vec2 pt) {
    //Fold and scale a few times
    for(int i=0;i<5;i++){
        pt*=3.;
        pt.x-=1.5;
        pt=koch_fold(pt);
    }
    return pt;
}

float d2hline(vec2 p){
    p.x-=max(0.,min(1.,p.x));
    return length(p)*5.;
}

float color(vec2 pt) {
    pt = pt*.7;
    pt -= vec2(.5,.3);
    pt = fold(pt,-2.*PI/3.);
    pt.x += 1.;
    pt = fold(pt,-PI/3.);
    pt = koch_curve(pt);
    return d2hline(pt)/5.;
}

void main(void){
    vec2 p = (gl_FragCoord.xy * 2.0 - r) / min(r.x, r.y);
    vec3 destColor = vec3(1.0, 0.3, 0.7);
    float f = color(p);
    gl_FragColor = vec4(vec3(destColor*f), 1.0);
}
