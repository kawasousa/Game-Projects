shader_type canvas_item;

uniform sampler2D mask;
uniform float scale : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec2 offset = vec2(0.5,0.5);
	vec4 mask_color = texture(mask, UV * scale);
	COLOR.a = 1.0 - mask_color.a;
}

