extends Camera2D

var targetPos = Vector2.ZERO # var that we keep the pos that we smoothly move to
var targetZoom = Vector2(1.2,1.2) # var that we keep the zoom that we smoothly move to
@export var speed:float = 150.0
@export var zoomSpeed:float = 0.2


func _process(delta: float) -> void:
	# very basic 'move pos' stuff
	if Input.is_action_pressed("W"):
		targetPos += Vector2(0,-delta*speed)
	if Input.is_action_pressed("A"):
		targetPos += Vector2(-delta*speed,0)
	if Input.is_action_pressed("S"):
		targetPos += Vector2(0,delta*speed)
	if Input.is_action_pressed("D"):
		targetPos += Vector2(delta*speed,0)
	# lerping to target pos
	global_position = lerp(global_position,targetPos,5*delta)
	if Input.is_action_just_pressed("mouseWheelUp"):
		if targetZoom < Vector2(5,5):
			targetZoom += Vector2(zoomSpeed,zoomSpeed)
			#zoom += Vector2(.2,.2)
	if Input.is_action_just_pressed("mouseWheelDown"):
		if targetZoom > Vector2(.7,.7):
			targetZoom -= Vector2(zoomSpeed,zoomSpeed)
			#zoom -= Vector2(.2,.2)
	zoom = lerp(zoom,targetZoom,5*delta)
