extends Node

var PauseNode = preload("../scenes/PauseMenu.tscn").instance()

var paused = false

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

	PauseNode.visible = false

	add_child(PauseNode)

func _notification(notif):
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

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if (paused):
			unpause()
		else:
			pause()
