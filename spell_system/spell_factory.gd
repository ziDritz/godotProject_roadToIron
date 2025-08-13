class_name SpellFactory
extends Node




var spell_database: Array[Spell] = [] # Contain spell resources

enum SpellEffectID { 
	HEAL, 
	DAMAGE
}



func _ready() -> void:
	# Load all spell resources in spell_database: Array
	for file in ResourceLoader.list_directory("res://spell_system/spell_database"):
		var ressource_file = "res://spell_system/spell_database/" + file
		var spell: Spell = load(ressource_file) as Spell
		spell_database.append(spell)


func get_spell(spell_id: String) -> Spell:
	for spell in spell_database:
		if spell.id == spell_id: return spell
	
	print("Spell resource not found")
	return null


func get_spell_effect(spell_effect_id: SpellEffectID) -> SpellEffect:
	var spell_effect: SpellEffect
	
	match spell_effect_id:
		SpellEffectID.HEAL: spell_effect = HealEffect.new()
		SpellEffectID.DAMAGE: spell_effect = DamageEffect.new()
	
	if spell_effect == null:
		print("Spell effect not found")
		return
	
	return spell_effect
