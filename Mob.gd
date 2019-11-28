extends RigidBody2D

export var speed = 150

func _ready():
    $AnimatedSprite.animation = "down"

func set_animation(velocity):
    $debug.text = str(velocity.x) + "\n" + str(velocity.y)
    if velocity.x > 1 or velocity.x < -1:
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 1
    elif velocity.y < 1:
        $AnimatedSprite.animation = "up"
    elif velocity.y > 1:
        $AnimatedSprite.animation = "down"

func _on_Visibility_screen_exited():
    queue_free()

func _on_start_game():
    queue_free()