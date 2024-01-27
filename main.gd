extends Node

@export var button_good: Button
@export var button_bad: Button

@export var viewport_main_texture_rect: TextureRect
@export var viewport_crowd: NodePath
@export var viewport_scene: NodePath

@export var cutting_label: RichTextLabel
@export var cutting_label_container: PanelContainer

@export var joystick_controller: JoystickController

var main_viewport_texture: ViewportTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	main_viewport_texture = viewport_main_texture_rect.texture
	button_good.pressed.connect(func(): run_camera_switch(true))
	button_bad.pressed.connect(func(): run_camera_switch(false))


func run_camera_switch(was_good: bool):
	joystick_controller.is_active = true
	cutting_label_container.visible = true
	cutting_label.text = cutting_label.text.substr(0, cutting_label.text.length() - 1) + "3"
	
	await(get_tree().create_timer(1).timeout)
	cutting_label.text = cutting_label.text.substr(0, cutting_label.text.length() - 1) + "2"
	
	await(get_tree().create_timer(1).timeout)
	cutting_label.text = cutting_label.text.substr(0, cutting_label.text.length() - 1) + "1"
	
	await(get_tree().create_timer(1).timeout)
	joystick_controller.is_active = false
	cutting_label_container.visible = false
	main_viewport_texture.viewport_path = viewport_crowd
	
	# TODO: Calculate score
	
	await(get_tree().create_timer(5).timeout)
	joystick_controller.is_active = true
	main_viewport_texture.viewport_path = viewport_scene
	
