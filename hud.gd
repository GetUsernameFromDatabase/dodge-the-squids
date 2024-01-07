extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

var default_message


func _ready():
    default_message = $Message.text


func show_message(text: String):
    $Message.text = text
    $Message.show()
    $MessageTimer.start()


func show_game_over():
    show_message("Game Over")
    await $MessageTimer.timeout

    $Message.text = default_message
    $Message.show()

    await get_tree().create_timer(0.5).timeout
    $StartButton.show()


func update_score(score: int):
    $ScoreLabel.text = str(score)


func _on_start_button_pressed():
    $StartButton.hide()
    start_game.emit()


func _on_message_timer_timeout():
    $Message.hide()
