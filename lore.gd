extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	DialogueManager.show_dialogue_balloon(load("res://dialogues/lore.dialogue"), "lore_start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
