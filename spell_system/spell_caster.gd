class_name SpellCaster
extends Node




signal spell_casted(spell: Spell, target: Node2D)
signal spell_received(spell: Spell, caster: Node2D)

@export var spell_factory: SpellFactory

var spell_book: Array[String] = []
var current_mana: int = 100
var max_mana: int = 100
var is_selecting_target: bool = false




func init(_spell_book: Array[String]):
	spell_book = _spell_book


func add_spell(spell_id: String):
	spell_book.append(spell_id)
	
	
func remove_spell(spell: Spell):
	spell_book.erase(spell)


func cast_spell(spell_id: String, target: Character):
	if target.find_child("SpellCaster") == null:
		print("SpellCaster componant not found on " + target.id)
		return
	
	var spell: Spell = spell_factory.get_spell(spell_id)
			
	target.find_child("SpellCaster").receive_spell(spell)
	print(spell.id + " launched on " + target.name)


func receive_spell(spell: Spell):
	spell.apply_effect(owner, spell_factory)
