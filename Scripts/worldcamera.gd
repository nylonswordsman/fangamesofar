extends Camera2D

var targetPos = Vector2.ZERO 
@export var speed:float = 150.0
# var that we keep the pos that we smoothly move to


func _process(delta: float) -> void:
	
	if Input.is_action_pressed("W"):
		targetPos += Vector2(0,-delta*speed)
	if Input.is_action_pressed("A"):
		targetPos += Vector2(-delta*speed,0)
	if Input.is_action_pressed("S"):
		targetPos += Vector2(0,delta*speed)
	if Input.is_action_pressed("D"):
		targetPos += Vector2(delta*speed,0)
	# very basic 'move pos' stuff
	
	
	
	global_position = lerp(global_position,targetPos,5*delta) 
	# lerping to the target pos
