extends Area2D

signal hit
signal create_bomb(pos, dir)
export var speed = 100
var screen_size
var dir = 3
var shoot_timer = 0

func _ready():
	hide()
	screen_size = get_viewport_rect().size

func _process(delta):
    shoot_timer += delta
    var velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
        dir = 2
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        dir = 4
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
        dir = 3
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
        dir = 1
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
    if Input.is_action_pressed("ui_select") and shoot_timer > 0.5:
        emit_signal("create_bomb", position, dir)
        shoot_timer = 0
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
	player_hit()

func player_hit():
    hide()
    emit_signal("hit")
    $CollisionShape2D.set_deferred("disabled", true)


func _on_Player_area_entered(area):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	#print(area.get_overlapping_areas())
	#var space_state = get_world_2d().direct_space_state
	#var result = space_state.intersect_point(point)
