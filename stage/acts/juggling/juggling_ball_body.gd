extends RigidBody2D

@export var speed := 700.0

var follow_path := true
@onready var path_to_follow = get_parent()

var marked_done := false

func _ready():
	if follow_path:
		path_to_follow.progress = randf() * 1000

func _physics_process(delta):
	if follow_path:
		path_to_follow.progress += speed * delta
	
	print(path_to_follow.progress)

func get_lost():
	follow_path = false
	freeze = false

func mark_done():
	marked_done = true
