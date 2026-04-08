shader_type canvas_item;

uniform vec3 replace_colour : source_color;
uniform sampler2D repeating_texture : filter_nearest, repeat_enable;
uniform float scale;
uniform float texture_size;
uniform vec2 movement_speed;

varying vec2 world_position;

void vertex() {
	// calculate the world position for use in the fragment shader
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	
	// Called for every pixel the material is visible on.
	vec3 texture_original = texture(TEXTURE, UV).rgb;
	vec3 repeating_uv = texture(repeating_texture, UV / REGION_RECT.zw + TIME / 2.0).rgb;
	
	COLOR.rgb = repeating_uv;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
