extends PathFollow2D

@export var get_lost_instantly := false

func _ready():
	if get_lost_instantly:
		get_lost()

func get_lost():
	$JugglingBallBody.get_lost()

func mark_done():
	loop = false
	
	$JugglingBallBody.mark_done()
