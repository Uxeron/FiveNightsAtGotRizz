extends Node2D

@export var acts: Array[PackedScene]

var current_act: Node2D

signal finished_act(succeeded: bool)


var act_frozen := false


func _ready():
	change_act()

func _input(event):
	return
	
	if event.is_action_pressed("jump"):
		if act_frozen:
			change_act()
			print('c')
		else:
			freeze_act()
			print('f')

func change_act():
	if current_act != null:
		current_act.queue_free()
	
	current_act = acts.pick_random().instantiate()
	add_child(current_act)
	
	current_act.finished_act.connect(_on_finished_act)
	
	if $Timer.is_stopped():
		$Timer.start()
	
	act_frozen = false


func _on_timer_timeout():
	change_act()

func _on_finished_act(succeeded: bool):
	finished_act.emit(succeeded)

func freeze_act():
	act_frozen= true
	
	$Timer.stop()
