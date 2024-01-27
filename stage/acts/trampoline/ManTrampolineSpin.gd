extends Sprite2D

@export var moving_speed := 200.0
@export var rotating_speed := 10.0

var follow_path := true
@onready var path_to_follow = get_parent()


func _physics_process(delta):
	if follow_path:
		path_to_follow.progress += moving_speed * delta

func _process(delta):
	rotation += rotating_speed * delta
