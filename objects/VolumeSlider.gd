extends VScrollBar

func _ready():
	self.value = Settings.setting.audio_volume_shift
	_update_label()

func _update_label():
	$Label.text = "Volume: " + ((-self.value) as String) #apparently float->string negates the value?!

var queue_update = false
var timer = 0
func _process(delta):
	if (!queue_update):
		return

	timer = timer + delta

	if (timer >= 3):
		queue_update = false
		Settings.update()


func _on_VolumeSlider_value_changed(value:float):
	Settings.setting.audio_volume_shift = value
	_update_label()
	queue_update = true
