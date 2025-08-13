class_name Spell
extends Resource

@export var id: String
@export var mana_cost: int
@export var cooldown: float
@export var spell_effect_id: SpellFactory.SpellEffectID
@export var effect_amount: int


func apply_effect(target: Character, spell_factory: SpellFactory):
	var spell_effect: SpellEffect = spell_factory.get_spell_effect(spell_effect_id)
	
	spell_effect.apply_effect(effect_amount, target)
