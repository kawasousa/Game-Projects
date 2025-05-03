shader_type canvas_item;

uniform float screen_width = 1920;
uniform float screen_height = 1080;
uniform vec2 center = vec2(0.5);
uniform vec2 player = vec2(0.5);

uniform float progress : hint_range(0,1);
uniform float pixel_size = 15;
uniform float circle_size : hint_range(0,2) = 1.5;
uniform float curtains : hint_range(0,1) = 1;

void fragment() {
        if (distance(vec2(0.5), vec2(UV.y, UV.y)) < curtains * (1.0 - progress)) {
            COLOR.a = 0.0;
        }
}