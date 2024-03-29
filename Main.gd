extends Node

export (PackedScene) var Mob
var score
var in_game = false
onready var bomb_scene = preload("res://Bomb.tscn")

func _ready():
	randomize()
	

func game_over():
    $ScoreTimer.stop()
    $MobTimer.stop()
    $HUD.show_game_over()
    in_game = false

func new_game():
    score = 0
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.show_message("Start!")
    in_game = true

func _on_StartTimer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()

func _on_ScoreTimer_timeout():
    score += 1
    $HUD.update_score(score)

func _on_MobTimer_timeout():
    $MobPath/MobSpawnLocation.set_offset(randi())
    var mob = Mob.instance()
    add_child(mob)
    var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    mob.position = $MobPath/MobSpawnLocation.position
    mob.linear_velocity = Vector2(mob.speed, 0)
    mob.linear_velocity = mob.linear_velocity.rotated(direction)
    mob.set_animation(mob.linear_velocity)
    $HUD.connect("start_game", mob, "_on_start_game")



func _on_Player_create_bomb(position, dir):
	if(in_game):
		var bomb = bomb_scene.instance();
		add_child(bomb)
		bomb.start(position, dir)


