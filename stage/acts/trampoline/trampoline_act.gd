extends Node2D

signal finished_act(succeeded: bool)

func _on_timer_timeout():
	if randf() > 0.5:
		$JumpPath/PathFollow2D/RigidBody2D.win()
		finished_act.emit(true)
		$YesAudio.play()
	else:
		$JumpPath/PathFollow2D/RigidBody2D.fall()
		finished_act.emit(false)
		$FailAudio.play()
