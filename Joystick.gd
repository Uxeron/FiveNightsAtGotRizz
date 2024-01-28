class_name JoystickController
extends Panel

@export var viewport_crowd_full: SubViewport
@export var viewport_crowd: SubViewport

@export var viewport_sprite_crowd: Sprite2D

@export var drag_area: Area2D

@export var joystick_sprite: Sprite2D
@export var joystick_shaft: Line2D
@export var joystick_range: float = 40.0
@export var camera_speed: float = 600.0

var camera_position: Vector2 = Vector2.ZERO

var is_active: bool = true
var is_joystick_dragged: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	drag_area.dragged.connect(func(is_pressed): is_joystick_dragged = is_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Always reset the simulated joystick position
	joystick_sprite.position = size / 2.0
	joystick_sprite.position.y -= 50.0
	
	# If mouse was outside the joystick when the button was released,
	#  the joystick won't get the release event.
	# This is a failsafe to make sure we don't keep dragging it.
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		is_joystick_dragged = false
	
	if not is_active:
		return

	var motion_vector: Vector2 = Vector2.ZERO
	
	if is_joystick_dragged:
		motion_vector = get_viewport().get_mouse_position() - joystick_sprite.global_position
		motion_vector /= joystick_range
	else:
		if Input.is_action_pressed("camera_left"):
			motion_vector.x -= Input.get_action_strength("camera_left")
		if Input.is_action_pressed("camera_right"):
			motion_vector.x += Input.get_action_strength("camera_right")
		if Input.is_action_pressed("camera_up"):
			motion_vector.y -= Input.get_action_strength("camera_up")
		if Input.is_action_pressed("camera_down"):
			motion_vector.y += Input.get_action_strength("camera_down")
	
	motion_vector = motion_vector.normalized() * min(motion_vector.length(), 1.0)
	
	joystick_sprite.position += motion_vector * joystick_range
	viewport_sprite_crowd.position -= motion_vector * camera_speed * delta
	
	# Keep camera within the crowd
	viewport_sprite_crowd.position.x = min(0.0, max(-viewport_crowd_full.size.x + viewport_crowd.size.x, viewport_sprite_crowd.position.x))
	viewport_sprite_crowd.position.y = min(0.0, max(-viewport_crowd_full.size.y + viewport_crowd.size.y, viewport_sprite_crowd.position.y))
	
	joystick_shaft.points[1] = joystick_sprite.position - joystick_shaft.position

