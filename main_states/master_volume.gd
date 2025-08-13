extends HSlider

@onready var master_volume: HSlider = $"."
var audio_bus_name: String = "Master"
var audio_bus_id: int

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	master_volume.value = AudioServer.get_bus_volume_db(audio_bus_id)

func _on_value_changed(slider_value: float) -> void:
	AudioServer.set_bus_volume_db(audio_bus_id, slider_value)
