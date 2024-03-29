extends Node

@export var mob_scene: PackedScene
var score


func new_game():
    score = 0
    $Player.start($PlayerStartPosition.position)
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")
    $Music.play()


func game_over():
    get_tree().call_group("mobs", "queue_free")
    $HUD.show_game_over()

    $ScoreTimer.stop()
    $MobTimer.stop()

    $Music.stop()
    $GameOver.play()


# Called when the node enters the scene tree for the first time.
func _ready():
    # for testing
    # new_game()
    pass

func _on_score_timer_timeout():
    score += 1
    $HUD.update_score(score)


func _on_start_timer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()


func _on_mob_timer_timeout():
    var mob = mob_scene.instantiate()

    var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
    mob_spawn_location.progress_ratio = randf()

    # Set the mob's direction perpendicular to the path direction. aka add 90degrees
    var direction = mob_spawn_location.rotation + PI / 2
    mob.position = mob_spawn_location.position

    direction += randf_range(-PI / 4, PI / 4)
    mob.rotation = direction

    var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
    mob.linear_velocity = velocity.rotated(direction)

    add_child(mob)
