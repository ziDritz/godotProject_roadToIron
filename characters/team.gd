class_name Team
extends Node




signal ally_character_selected(character: Character)
signal target_selected(character: Character)

enum TeamStateEnum { IDLE, SELECT_ALLY_CHARACTER, SELECT_SPELL, SELECT_TARGET, CAST_SPELL }

@export var team_characters: Array[Character] = []
@export var placeholders: Array[Node2D] = []
@export var character_ids: Array[String] = []

var is_active: bool = false
var character_manager: CharacterManager
var selected_character: Character
var selected_spell_id: String
var target: Character
var current_team_state: TeamStateEnum
var _on_character_manager_character_clicked_callable: Callable = func(character: Character): pass
var _on_game_ui_spell_button_pressed_callable: Callable = func(): pass
var _on_game_ui_spell_button_2_pressed_callable: Callable = func(): pass




func init():
	character_manager = get_parent()
	
	for x in range(character_ids.size()):
		var character = character_manager.get_character(character_ids[x])
		character.reparent(self)
		character.position = placeholders[x].position
		placeholders[x].queue_free()


func set_state(state: TeamStateEnum):
	current_team_state = state
	
	match current_team_state:
		TeamStateEnum.IDLE:
			print(name + " set to IDLE state")
			
			_on_character_manager_character_clicked_callable = func(character: Character): pass
			_on_game_ui_spell_button_pressed_callable = func(): pass
			_on_game_ui_spell_button_2_pressed_callable = func(): pass
			
			
			if selected_character != null: 
				selected_character.is_selected = false
				print(selected_character.name + " is no longer selected")
			selected_character = null
			
			
		TeamStateEnum.SELECT_ALLY_CHARACTER:
			print(name + " set to SELECT_ALLY_CHARACTER state")
			
			_on_game_ui_spell_button_pressed_callable = func(): pass
			_on_game_ui_spell_button_2_pressed_callable = func(): pass
			selected_character = null
			target == null
			
			_on_character_manager_character_clicked_callable = func(character: Character):
				for child in get_children():
					if child == character:
						selected_character = character
						selected_character.is_selected = true
						selected_character.set_is_selected(true)
						print(character.name + " is selected" )
						ally_character_selected.emit(selected_character)
						break
					
				set_state(TeamStateEnum.SELECT_SPELL)
		
		
		TeamStateEnum.SELECT_SPELL:
			print(name + " set to SELECT_SPELL state")
			
			_on_character_manager_character_clicked_callable = func(character: Character): pass
			
			_on_game_ui_spell_button_pressed_callable = func(): 
				selected_spell_id = selected_character.spell_caster.spell_book[0]
				print(selected_spell_id + " spell ID is selected")
				set_state(TeamStateEnum.SELECT_TARGET)
				
			_on_game_ui_spell_button_2_pressed_callable = func():
				selected_spell_id = selected_character.spell_caster.spell_book[1]
				print(selected_spell_id + " spell ID is selected")
				set_state(TeamStateEnum.SELECT_TARGET)


		TeamStateEnum.SELECT_TARGET:
			print(name + " set to SELECT_TARGET state")
			
			_on_character_manager_character_clicked_callable = func(character: Character):
				target = character
				print("Target is " + character.name)
				target_selected.emit(target)
				set_state(TeamStateEnum.CAST_SPELL)
			
			
		TeamStateEnum.CAST_SPELL:
			print(name + " set to CAST_SPELL state")
			
			_on_game_ui_spell_button_pressed_callable = func(): pass
			_on_game_ui_spell_button_2_pressed_callable = func(): pass
			_on_character_manager_character_clicked_callable = func(character: Character): pass
			
			selected_character.spell_caster.cast_spell(selected_spell_id, target)
			
			set_state(TeamStateEnum.SELECT_ALLY_CHARACTER)
			
			pass


func set_idle_state():
	set_state(TeamStateEnum.IDLE)


func set_select_ally_character_state():
	set_state(TeamStateEnum.SELECT_ALLY_CHARACTER)


func _on_turn_system_on_turn_end() -> void:
	set_state(TeamStateEnum.IDLE)


func _on_character_manager_character_clicked(character: Character) -> void:
	_on_character_manager_character_clicked_callable.call(character)


func _on_game_ui_spell_button_pressed() -> void:
	_on_game_ui_spell_button_pressed_callable.call()

func _on_game_ui_spell_button_2_pressed() -> void:
	_on_game_ui_spell_button_2_pressed_callable.call()
