extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPAWN_OFFSET = 30
signal explode()
const VELOCITY = 4
var dir;
var exploded = false
var explosion_time = 0
onready var Explosion_scene = preload("res://Explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if(not exploded):
		if(dir == 1):
			velocity.y = -1*VELOCITY
			velocity.x = 0
		elif(dir == 2):
			velocity.y = 0
			velocity.x = VELOCITY
		elif(dir == 4):
			velocity.y = 0
			velocity.x = -1*VELOCITY
		else:
			velocity.y = VELOCITY
			velocity.x = 0
	position.x += velocity.x
	position.y += velocity.y
	if(exploded):
		explosion_time += delta
	if(explosion_time > 1):
		queue_free()
	
func start(posit, direction):
	$Timer.start(1);
	if(posit.x == 0 and posit.y == 0):
		pass
	position = posit
	if(direction == 2):
		position.x += SPAWN_OFFSET
	elif(direction == 1):
		position.y -= SPAWN_OFFSET
	elif(direction == 4):
		position.x -= SPAWN_OFFSET
	else:
		position.y += SPAWN_OFFSET
	dir = direction
	show()


func _on_Bomb_body_entered(body):
	explode()
	
func explode():
	print("Bomb.explode")
	var explosion = Explosion_scene.instance()
	explosion.call_deferred("play")
	emit_signal("explode")
	call_deferred("add_child",explosion)
	$Sprite.hide()
	exploded = true
	
