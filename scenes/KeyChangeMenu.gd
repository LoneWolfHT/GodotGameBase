extends Control

export(Dictionary) var actions = {
	#"jump"    : {"label": "Jump"   , "key": to_inputevent(KEY_SPACE)},
}

var ActionNode = preload("res://objects/KeyChangeEntry.tscn")

func _ready():
	$Panel/Scroll/KeyList.anchor_right = 1

	if (!Settings.setting.keybinds.empty()):
		for action in Settings.setting.keybinds.keys():
			if (actions.has(action)):
				actions[action].key = to_inputevent(OS.find_scancode_from_string(Settings.setting.keybinds[action]))
			else: # remove action bind we don't have anymore
				Settings.setting.keybinds.erase(action)

	for action in actions:
		if (!InputMap.has_action(action)):
			add_keybind_entry(action)

	Settings.update() # Save any setting changes by add_keybind_entry above

func add_keybind_entry(entry):
	var keychangeentry = ActionNode.instance()

	keychangeentry.ACTION = entry
	keychangeentry.LABEL = actions[entry].label + " - "

	InputMap.add_action(entry)
	InputMap.action_add_event(entry, actions[entry].key)

	Settings.setting.keybinds[entry] = OS.get_scancode_string(actions[entry].key.scancode)

	$Panel/Scroll/KeyList.add_child(keychangeentry)

func to_inputevent(x):
	var out = InputEventKey.new()

	out.set_scancode(x)

	return out
