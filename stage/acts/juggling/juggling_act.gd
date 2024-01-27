extends Node2D

func _on_timer_timeout():
	if randf() > 0.5:
		$juggler.success()
	else:
		$juggler.lose_balls()
