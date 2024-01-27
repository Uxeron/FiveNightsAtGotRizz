extends Node2D

signal finished_act(succeeded: bool)

func _on_timer_timeout():
	if randf() > 0.5:
		$juggler.success()
		finished_act.emit(true)
	else:
		$juggler.lose_balls()
		finished_act.emit(false)
