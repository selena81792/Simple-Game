extends RigidBody2D

func _ready():
    $AnimatedSprite.animation = "down"

func _on_Visibility_screen_exited():
    queue_free()
