class_name Audience
extends Node2D

@export var person_scene: PackedScene
@export var audience_size: Vector2
@export var audience_spacing: Vector2

var people: Array[AudiencePerson]

# Called when the node enters the scene tree for the first time.
func _ready():
	for y in range(audience_size.y):
		for x in range(audience_size.x):
			var person = person_scene.instantiate()
			person.position = Vector2(x, y) * audience_spacing + audience_spacing
			if y % 2 == 1:
				person.position.x += audience_spacing.x / 2.0
			add_child(person)
			people.append(person)


func set_people_state(state: AudiencePerson.STATE, percentage: float):
	if percentage < 1.0:
		people.shuffle()
	
	for i in range(int(people.size() * percentage)):
		people[i].state = state
