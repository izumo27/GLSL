precision mediump float;
uniform float t; // time
uniform vec2  r; // resolution

#define T t + i * 0.628318

void main(){
  vec2 p=(gl_FragCoord.xy)/min(r.x,r.y);

  float f = 0.0;
  for(float i = 0.0; i < 10.0; i++){
    float s = sin(T) * 0.5,c = cos(T) * 0.5;
    f += (1.0 / 1e3 / abs(length(p + vec2(c, s)) - 0.5))*min(1.0, float(int(t)/2));
  }
  gl_FragColor = vec4(vec3(f), 1.0);
}
