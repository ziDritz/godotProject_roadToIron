class_name Character
extends Area2D




signal clicked(_self: Character)

@export var is_selected: bool = false

@onready var spell_caster: SpellCaster = $SpellCaster
@onready var turn_character: TurnCharacter = $TurnCharacter
@onready var health_label: Label = $HealthLabel
@onready var health: Health = $Health
@onready var sprite_2D: Sprite2D = $Sprite2D
@onready var selection_overlay: Sprite2D = $SelectionOverlay




func _ready():
	health_label.text = "Life: " + str(health.health)


func init(_name: String, _health_max: int, _spell_book: Array[String], _image: CompressedTexture2D):
	name = _name
	health.init(_health_max)
	spell_caster.init(_spell_book)
	sprite_2D.texture = _image 


func set_is_selected(_bool: bool):
	if _bool: selection_overlay.visible = true
	if not _bool: selection_overlay.visible = false


func _on_health_died(_owner: Node) -> void:
	queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			clicked.emit(self)
