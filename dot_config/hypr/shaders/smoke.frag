#version 300 es
// Ether by nimitz 2014 (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// Contact the author for other licensing options

precision mediump float;

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D tex;

out vec4 fragColor;

mat2 m(float a){float c=cos(a), s=sin(a);return mat2(c,-s,s,c);}

float map(vec3 p){
    p.xz*= m(time*0.4);p.xy*= m(time*0.3);
    vec3 q = p*2.+time;
    return length(p+vec3(sin(time*0.7)))*log(length(p)+1.) + sin(q.x+sin(q.z+sin(q.y)))*0.5 - 1.;
}

void main(){	
	
  vec2 p = gl_FragCoord.xy/1200.0 - vec2(.9,.5);
    vec3 cl = vec3(0.);
    float d = 2.5;
    for(int i=0; i<=5; i++)	{
		vec3 p = vec3(0,0,5.) + normalize(vec3(p, -1.))*d;
        float rz = map(p);
		float f =  clamp((rz - map(p+.1))*0.5, -.1, 1. );
        vec3 l = vec3(0.1,0.3,.4) + vec3(5., 2.5, 3.)*f;
        cl = cl*l + smoothstep(2.5, .0, rz)*.7*l;
		d += min(rz, 1.);
	}

  vec4 smokeFX = vec4(cl, 1.); 
  vec2 uv = gl_FragCoord.xy / vec2(1920.0, 1200.0);

  vec4 original = texture(tex, uv);
  
  fragColor = ((original * 1.8) + (smokeFX * 1.2)) / 2.0;
}
