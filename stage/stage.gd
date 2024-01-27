extends Node2D

@export var acts: Array[PackedScene]

var current_act: Node2D

signal finished_act(succeeded: bool)

func _ready():
	change_act()

func change_act():
	if current_act != null:
		current_act.queue_free()
	
	current_act = acts.pick_random().instantiate()
	add_child(current_act)
	
	current_act.finished_act.connect(_on_finished_act)


func _on_timer_timeout():
	change_act()

func _on_finished_act(succeeded: bool):
	finished_act.emit(succeeded)
