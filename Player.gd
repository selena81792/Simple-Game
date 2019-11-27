extends Area2D

signal hit
export var speed = 100
var screen_size


func _ready():
	hide()
	screen_size = get_viewport_rect().size

func _process(delta):
    var velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
    position += velocity * delta
    position.x = clamp(position.x, 80, screen_size.x - 80)
    position.y = clamp(position.y, 60, screen_size.y - 80)

    if velocity.x != 0:
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 0
    elif velocity.y < 0:
        $AnimatedSprite.animation = "up"
    elif velocity.y > 0:
        $AnimatedSprite.animation = "down"

func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
    emit_signal("hit")
    $CollisionShape2D.set_deferred("disabled", true)
