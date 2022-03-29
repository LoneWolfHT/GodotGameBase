extends Node

var BASE_VOL = -8

var sounds = {}

# You can add sounds here
func _ready():
	pass

func new_sound(name, volume):
	var audionode = AudioStreamPlayer.new()

	audionode.volume_db = BASE_VOL + volume
	audionode.stream = load("res://assets/" + name + ".mp3")
	sounds[name] = {"node": audionode, "playpos": 0, volume = volume}

	add_child(audionode)

	print("Loaded Audio")

var _time = 0
func _process(delta):
	_time += delta

	if _time >= 0.5:
		_time = 0

		for sound in sounds:
			sounds[sound].node.volume_db = (BASE_VOL - (Settings.audio_volume_shift / 2)) + sounds[sound].volume

func play(sound_name):
	if sounds[sound_name]:
		print("Playing sound " + sound_name)
		sounds[sound_name].node.play()

func play_low(sound_name, vol_shift):
	if sounds[sound_name]:
		print("Playing sound " + sound_name)
		sounds[sound_name].node.volume_db = (BASE_VOL - (Settings.audio_volume_shift / 2)) + sounds[sound_name].volume + vol_shift
		sounds[sound_name].node.play()

func resume(sound_name):
	if sounds[sound_name]:
		print("Resuming sound " + sound_name)
		sounds[sound_name].node.play(sounds[sound_name].playpos)

func stop(sound_name):
	if sounds[sound_name]:
		print("Stopping sound " + sound_name)
		sounds[sound_name].playpos = sounds[sound_name].node.get_playback_position()
		sounds[sound_name].node.stop()
