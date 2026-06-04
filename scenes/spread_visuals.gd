extends Node2D

@export var SpreadCurve:Curve
@export var baseSpread:float = 0.4 # of PI
@export var maxDistance:float = 300.0 # pixels
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw() -> void:
	var angle = position.angle_to(get_global_mouse_position()-global_position)
	var distance = global_position.distance_to(get_global_mouse_position())
	var currentSpread = baseSpread*SpreadCurve.sample(clampf(distance/maxDistance,0.0,1.0))
	draw_circle(Vector2.ZERO,5.0,Color.RED,false)
	draw_line(Vector2.from_angle(angle)*10.0,Vector2.from_angle(angle)*maxDistance,Color.RED)
	draw_arc(Vector2.ZERO,10.0,angle-(currentSpread),angle+(currentSpread),32,Color.RED)
	draw_arc(Vector2.ZERO,clampf(distance,15,maxDistance),angle-(currentSpread),angle+(currentSpread),32,Color.RED)
	draw_line(Vector2.from_angle(angle-currentSpread)*10.0,Vector2.from_angle(angle-currentSpread)*clampf(distance,15,maxDistance),Color.RED)
	draw_line(Vector2.from_angle(angle+currentSpread)*10.0,Vector2.from_angle(angle+currentSpread)*clampf(distance,15,maxDistance),Color.RED)
	pass
