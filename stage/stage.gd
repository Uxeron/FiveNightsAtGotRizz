extends Node2D

@export var acts: Array[PackedScene]

var current_act: Node2D

func _ready():
	change_act()

func change_act():
	if current_act != null:
		current_act.queue_free()
	
	current_act = acts.pick_random().instantiate()
	add_child(current_act)


func _on_timer_timeout():
	change_act()
