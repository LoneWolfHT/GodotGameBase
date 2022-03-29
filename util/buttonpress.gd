extends Button

export(String) var button_name = "button_name"
export(String, FILE, "*.tscn") var load_scene
export(NodePath) var signal_target = self

func _ready():
	if typeof(signal_target) == TYPE_NODE_PATH:
		signal_target = get_node(signal_target)

	if (self.connect("button_up", signal_target, "_on_button_activate", [ button_name ]) != OK):
		push_error("[util->buttonpress]: Failed to connect signal to given node")

	if load_scene:
		if (self.connect("button_up", self, "_on_loadscene_request", [ load_scene ]) != OK):
			push_error("[util->buttonpress] Failed to connect sceneload func to buttonpress signal")

	print("[util->buttonpress]: Loaded")

# func _on_button_activate(button):
# 	print("button default booped: ", button)

func _on_loadscene_request(scenepath):
	if (get_tree().change_scene(scenepath) != OK):
		push_error("[util->buttonpress] Failed to change scene on buttonpress")
