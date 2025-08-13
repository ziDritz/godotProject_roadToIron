class_name DamageEffect
extends SpellEffect

func apply_effect(amount: int, target: Character):
	var health: Health = target.find_child("Health")
	if health == null:
		print("Health componant not found on " + target.name)
		return
	
	health.take_damage(amount)
