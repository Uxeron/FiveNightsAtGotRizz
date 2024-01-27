extends RigidBody2D

@export var moving_speed := 200.0
@export var rotating_speed := 10.0

@onready var path_to_follow = get_parent()

var falling := false
var is_win := false

@export var win_texture: Texture

func _physics_process(delta):
	if !falling:
		path_to_follow.progress += moving_speed * delta

func _process(delta):
	if !falling and !is_win:
		rotation += rotating_speed * delta

func fall():
	falling = true
	
	freeze = false


func win():
	is_win = true
	$ManTrampolineSpin.texture = win_texture
	
	rotation = 0
	
	get_parent().loop = false
