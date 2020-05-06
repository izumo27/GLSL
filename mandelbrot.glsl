precision mediump float;
uniform float t; // time
uniform vec2  r; // resolution

const int ITETARION = 10000; // 振動 or 発散を判断する上限

vec3 color(float h){
  float r = (h>=18.0 ? 1.0 : (h>=9.0 ? 0.5 : 0.0));
  h=mod(h, 9.0);
  float g = (h>=6.0 ? 1.0 : (h>=3.0 ? 0.5 : 0.0));
  h=mod(h, 3.0);
  float b = (h>=2.0 ? 1.0 : (h>=1.0 ? 0.5 : 0.0));
  return vec3(r, g, b);
}

void main() {
  vec2 p = (gl_FragCoord.xy * 2.0 - r) / min(r.x, r.y);
  p=(p-vec2(1.45, 0)*0.5*exp2(min(t, 9.0)))/(0.5*exp2(min(t, 9.0)));
  vec2 z = vec2(0);     // Zn   (xは実部、yは虚部)
  vec2 zNext = vec2(0); // Zn+1 (xは実部、yは虚部)
  vec2 c = p.xy;        // 複素平面上の座標 (xは実部、yは虚部)
  bool diverge = false; // 発散する true, しない false。発散しないならマンデルブローセット。
  int elapsed = 0;

  for (int i = 0; i < ITETARION; ++i) {
    zNext.x = pow(z.x, 2.0) - pow(z.y, 2.0);
    zNext.y = 2.0 * z.x * z.y;
    z = zNext + c;
    if (length(z) > 2.0) {
      diverge = true;
      break;
    }
    elapsed = i;
  }
  if(diverge) {
    float h = mod(float(elapsed),27.0);
    gl_FragColor = vec4(color(h), 1.0);
  } else {
    gl_FragColor = vec4(vec3(0.0), 1.0);
  }
}
