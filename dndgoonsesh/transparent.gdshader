shader_type canvas_item;
uniform float transparency : hint_range(0, 1) = 1;
void vertex() {
}

void fragment() {
	COLOR.a = transparency;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
