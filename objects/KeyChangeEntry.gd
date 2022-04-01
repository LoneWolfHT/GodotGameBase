extends HBoxContainer

export var ACTION = "Action"
export var LABEL  = "Action Label"

var grabbing_key = false

func _ready():
	refresh()

func refresh(refresh_others = true):
	if (refresh_others):
		for entry in get_parent().get_children():
			if (entry != self && entry.has_method("refresh")):
				entry.refresh(false)

	$Label.text = LABEL

	if (grabbing_key):
		$Button.text = "Press key to assign (esc to cancel)"
		$Button.disabled = true
		$Button.pressed = true
	else:
		var actionlist = InputMap.get_action_list(ACTION)

		$Button.disabled = false
		$Button.pressed = false

		if actionlist.empty():
			$Button.text = "Unbound"
		else:
			$Button.text = actionlist[0].as_text()

			# Color the text red if it matches another action binding
			for i in InputMap.get_actions():
				if (i.left(3) != "ui_" && i != ACTION && InputMap.action_has_event(i, actionlist[0])):
					$Button.set("custom_colors/font_color", Color.red)
					$Button.set("custom_colors/font_color_hover", Color.red)
					$Button.set("custom_colors/font_color_focus", Color.red)
					return

			$Button.set("custom_colors/font_color", get_color("font_color", "Button"))
			$Button.set("custom_colors/font_color_hover", get_color("font_color_hover", "Button"))
			$Button.set("custom_colors/font_color_focus", get_color("font_color_focus", "Button"))

func _input(event):
	if (!grabbing_key):
		return

	if event is InputEventKey:
		grabbing_key = false

		if (event.as_text() == "Escape"):
			refresh()
			return

		# Only allow one bound key per action, since it's easily changeable
		if !InputMap.get_action_list(ACTION).empty():
			InputMap.action_erase_events(ACTION)

		InputMap.action_add_event(ACTION, event)

		Settings.setting.keybinds[ACTION] = OS.get_scancode_string(event.scancode)
		Settings.update()

		refresh()

func _on_Button_toggled(button_pressed:bool):
	grabbing_key = button_pressed
	refresh()
