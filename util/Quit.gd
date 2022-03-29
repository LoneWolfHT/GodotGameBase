extends Node

signal on_quit

func _notification(notif):
	if (notif == MainLoop.NOTIFICATION_WM_QUIT_REQUEST || notif == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		emit_signal("on_quit")

func quit():
	emit_signal("on_quit")

	get_tree().quit()
