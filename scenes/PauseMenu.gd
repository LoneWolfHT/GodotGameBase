extends Control

func _ready():
	show_on_top = true
	pause_mode = PAUSE_MODE_PROCESS

func _on_button_activate(button):
	if (button == "exit"):
		Quit.quit()
	else:
		Pause.unpause()
