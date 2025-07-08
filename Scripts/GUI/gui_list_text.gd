extends Node2D

var list:GUIList
var font:Font
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	font = get_node("/root/main/TextModule").font
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw() -> void:
	draw_set_transform(Vector2i(list.BorderWidth,list.BorderWidth)+list.Rect.position)
	#draw_string(font,Vector2(0,8),str(list.offset))
	for i in range(0,list.Items.size()):
		#draw_circle(Vector2(0,20*i),4,Color.WHITE)
		if list.offset>16+20*i||16+20*i-list.offset>list.Rect.size.y:continue
		draw_string(font,Vector2(0,16+20*i-list.offset),list.Items[i],HORIZONTAL_ALIGNMENT_CENTER,list.Rect.size.x-(list.BorderWidth*2))
		if i<list.Items.size()-1:draw_line(Vector2(8,20+20*i-list.offset),Vector2(list.Rect.size.x-8-(list.BorderWidth*2),20+20*i-list.offset),Color(Color.WHITE,0.1))
		if i==list.SelectedItem:
			var animSize = clamp(list.hoverAnim,0,6)
			draw_line(Vector2(3,0+20*i-list.offset),Vector2(3,(20*(animSize/6.0))+20*i-list.offset),Color(1,1,1,list.colorCurve.sample(list.colorAnim/30.0)),3)
			draw_line(Vector2(list.Rect.size.x-3-(list.BorderWidth*2),20-(20*(animSize/6.0))+20*i-list.offset),Vector2(list.Rect.size.x-3-(list.BorderWidth*2),20+20*i-list.offset),Color(1,1,1,list.colorCurve.sample(list.colorAnim/30.0)),3)
			if animSize<6:draw_rect(Rect2(2,20*i-list.offset,list.Rect.size.x-(list.BorderWidth*2),20),Color(1,1,1,0.1*(1-(animSize/6.0))))
			if list.click>0:draw_rect(Rect2(2,20*i-list.offset,list.Rect.size.x-(list.BorderWidth*2),20),Color(1,1,1,list.click/8.0))
