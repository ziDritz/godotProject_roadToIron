class_name Health
extends Node




signal max_health_changed(max_health: int, diff: int)
signal health_changed(health: int, diff: int)
signal died(_owner: Node)

@export var max_health: int = 3 : set = _set_max_health, get = get_max_health
@export var immortality: bool = false : set = _set_immortality, get = get_immortality

var parent: Node = get_parent()
var immortality_timer: Timer = null

@onready var health: int: set = _set_health, get = get_health




func init(_max_health: int):
	parent = get_parent()
	_set_max_health(_max_health)
	

func take_damage(amount: int):
	_set_health(health - amount)

func receive_heal(amount: int):
	_set_health(health + amount)


func _set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health


func get_max_health() -> int:
	return max_health


func _set_immortality(value: bool):
	immortality = value


func get_immortality() -> bool:
	return immortality


func _set_temporary_immortality(time: float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	
	if immortality_timer.timeout.is_connected(_set_immortality):
		immortality_timer.timeout.disconnect(_set_immortality)
	
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(_set_immortality.bind(false))
	immortality = true
	immortality_timer.start()


func _set_health(value: int):
	if value < health and immortality:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	if clamped_value != health:
		var difference = clamped_value - health
		health = clamped_value
		health_changed.emit(health, difference)
		
		if health <= 0:
			_die()


func get_health():
	return health


func _die():
	died.emit(owner)
