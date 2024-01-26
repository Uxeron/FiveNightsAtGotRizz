extends Node

@export var button_good: Button
@export var button_bad: Button

@export var viewport_sprite_crowd: Sprite2D

@export var viewport_main_texture_rect: TextureRect
@export var viewport_crowd: NodePath
@export var viewport_scene: NodePath

@export var pan_speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed("camera_left"):
		viewport_sprite_crowd.position.x += pan_speed
	if event.is_action_pressed("camera_right"):
		viewport_sprite_crowd.position.x -= pan_speed
	if event.is_action_pressed("camera_up"):
		viewport_sprite_crowd.position.y += pan_speed
	if event.is_action_pressed("camera_down"):
		viewport_sprite_crowd.position.y -= pan_speed
