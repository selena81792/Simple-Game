extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
signal kill()

func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play():
	print("Explosion.play")
	call_deferred("show")
	$AnimatedSprite.call_deferred("play")
	
	

func _on_Explosion_body_entered(body):
	play()
	body.free()
	emit_signal("kill")
	print("Explosion.on_explosion_body")

