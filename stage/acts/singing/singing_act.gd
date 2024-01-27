extends Node2D

signal finished_act(succeeded: bool)

func _on_timer_timeout():
	
	if randf() > 0.5:
		$Singer.become_good()
		finished_act.emit(true)
	else:
		$Singer.become_bad()
		finished_act.emit(false)
