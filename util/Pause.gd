extends Node

# Add check_for_pause_key() to your scene's _input() to pause when pressing ESC
# Add pause_on_focus_lost() to your scene's _notification() to pause when focus is lost

var PauseNode = preload("../scenes/PauseMenu.tscn").instance()

var paused = false

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

	PauseNode.visible = false

	add_child(PauseNode)

func pause_on_focus_lost(notif):
	if (notif == MainLoop.NOTIFICATION_WM_FOCUS_OUT):
		pause()

func pause(pausenode = PauseNode):
	if (paused):
		return

	pausenode.visible = true

	get_tree().paused = true
	paused = true

func unpause(remove_node = false):
	if (!paused):
		return

	get_tree().paused = false

	if (remove_node):
		PauseNode.queue_free()
	else:
		PauseNode.visible = false

	paused = false

func check_for_pause_key():
	if Input.is_action_just_pressed("Pause_pause"):
		if (paused):
			unpause()
		else:
			pause()
