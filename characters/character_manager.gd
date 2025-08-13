class_name CharacterManager
extends Node




signal character_clicked(character: Character)

const CHARACTER_SCENE = preload("res://characters/character.tscn") 

var character_database: Array[CharacterResource] = []
@export var teams: Array[Team] = []


func _ready() -> void:
	# Load all character resources
	for file in ResourceLoader.list_directory("res://characters/character_database"):
		var ressource_file = "res://characters/character_database/" + file
		var character_resource: CharacterResource = load(ressource_file) as CharacterResource
		character_database.append(character_resource)
		print(character_resource.name + " added to character resource database")

	for team in teams:
		team.init()


func get_character(character_name: String):
	for character_resource in character_database:
		if character_name == character_resource.name:
			var character = CHARACTER_SCENE.instantiate()
			add_child(character)
			character.init(character_resource.name, character_resource.health_max, character_resource.spell_book, character_resource.image)
			character.clicked.connect(_on_character_clicked)
			return character # the new Character need to be reparent by the receiver (ex: char1.reparent(self))
	
	print("Character not found in database")


func _on_character_clicked(character: Character) -> void:
	character_clicked.emit(character)
