extends Node2D


func _on_timer_timeout():
	
	if randf() > 0.5:
		$Singer.become_good()
	else:
		$Singer.become_bad()
