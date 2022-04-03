shader_type canvas_item;

uniform float brightness;

void fragment() {
	float value = 0.0;
	if (brightness == 1.0)
		value = 0.0;
	if (brightness == 2.0)
		value = .4;
    vec4 tex = texture(TEXTURE, UV);
    COLOR.rgb = tex.rgb + vec3(value);
    COLOR.a = tex.a;
}