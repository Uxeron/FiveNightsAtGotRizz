class_name Stage
extends Node2D

@export var acts: Array[PackedScene]
@export var tv_splash: PackedScene

var current_act: Node2D

signal finished_act(succeeded: bool)
signal new_act()

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
	
	if $ActTimer.is_stopped():
		$ActTimer.start()
	
	act_frozen = false
	
	#new_act.emit()

func _on_act_timer_timeout():
	do_tv_splash()

func _on_finished_act(succeeded: bool):
	finished_act.emit(succeeded)

func freeze_act():
	act_frozen= true
	
	$ActTimer.stop()


func do_tv_splash():
	$ActTimer.set_paused(true)
	
	if current_act != null:
		current_act.queue_free()
	
	current_act = tv_splash.instantiate()
	add_child(current_act)
	
	$SplashTimer.start()
	new_act.emit()

func _on_splash_timer_timeout():
	$ActTimer.set_paused(false)
	change_act()
