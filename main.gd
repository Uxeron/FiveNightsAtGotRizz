extends Node

@export var button_good: Button
@export var button_bad: Button

@export var viewport_main_texture_rect: TextureRect
@export var viewport_crowd: NodePath
@export var viewport_scene: NodePath

@export var cutting_label: RichTextLabel
@export var cutting_label_container: PanelContainer

@export var joystick_controller: JoystickController

@export var audience: Audience

@export var stage: Stage

@export var main_screen_label: Label

@export var score: Score

@export var audience_area: Area2D

@export var zoomed_audience_sprite: Sprite2D

var main_viewport_texture: ViewportTexture

var camera_switch_running: bool = false

enum PERFORMACE_OUTCOME {
	SUCCESS,
	FAIL,
	NONE
}

var last_performance_outcome: PERFORMACE_OUTCOME = PERFORMACE_OUTCOME.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_dialogue_balloon(preload("res://dialogues/lore.dialogue"), "lore_start")
	var tree = get_tree()
	DialogueManager.dialogue_ended.connect(func(_discard): tree.paused = false)
	get_tree().paused = true
	
	main_viewport_texture = viewport_main_texture_rect.texture
	button_good.pressed.connect(func(): run_camera_switch(true))
	button_bad.pressed.connect(func(): run_camera_switch(false))
	stage.finished_act.connect(func(succeeded: bool): 
		last_performance_outcome = PERFORMACE_OUTCOME.SUCCESS if succeeded else PERFORMACE_OUTCOME.FAIL)
	
	stage.finished_act.connect(func(succeeded: bool):
		audience.set_people_state(AudiencePerson.STATE.CLAPPING, 0.05) \
		if succeeded else \
		audience.set_people_state(AudiencePerson.STATE.LAUGHING, 0.05))
	
	stage.new_act.connect(func(): last_performance_outcome = PERFORMACE_OUTCOME.NONE)
	stage.new_act.connect(func(): audience.set_people_state(AudiencePerson.STATE.NEUTRAL, 1.0))


func run_camera_switch(was_good: bool):
	if camera_switch_running:
		return
	
	camera_switch_running = true
	button_good.disabled = true
	button_bad.disabled = true
	
	stage.freeze_act()
	
	if was_good and last_performance_outcome == PERFORMACE_OUTCOME.SUCCESS:
		audience.set_people_state(AudiencePerson.STATE.CLAPPING, 0.2)
	if not was_good and last_performance_outcome == PERFORMACE_OUTCOME.FAIL:
		audience.set_people_state(AudiencePerson.STATE.LAUGHING, 0.2)
	
	joystick_controller.is_active = true
	cutting_label_container.visible = true
	cutting_label.text = cutting_label.text.substr(0, cutting_label.text.length() - 1) + "3"
	
	await(get_tree().create_timer(1).timeout)
	cutting_label.text = cutting_label.text.substr(0, cutting_label.text.length() - 1) + "2"
	
	await(get_tree().create_timer(1).timeout)
	cutting_label.text = cutting_label.text.substr(0, cutting_label.text.length() - 1) + "1"
	
	await(get_tree().create_timer(1).timeout)
	main_screen_label.text = "Cam2 zoom"
	joystick_controller.is_active = false
	cutting_label_container.visible = false
	main_viewport_texture.viewport_path = viewport_crowd
	
	# Calculate score
	var current_score = score.target_score
	var audience_image: Image = main_viewport_texture.get_image()
	
	var found_pixels: int = 0
	for y in range(audience_image.get_size().y):
		for x in range(audience_image.get_size().x):
			var color: Color = audience_image.get_pixel(x, y)
			if last_performance_outcome == PERFORMACE_OUTCOME.SUCCESS and color == Color("6ABE30"):
				score.target_score += 0.00003
				found_pixels += 1
			if last_performance_outcome == PERFORMACE_OUTCOME.FAIL and color == Color("5B6EE1"):
				score.target_score += 0.00003
				found_pixels += 1
	
	print("Score change: ", score.target_score - current_score)
	print("Pixels found: ", found_pixels)
	
	# Reset
	await(get_tree().create_timer(3).timeout)
	joystick_controller.is_active = true
	main_viewport_texture.viewport_path = viewport_scene
	
	main_screen_label.text = "Cam3 stage"
	camera_switch_running = false
	button_good.disabled = false
	button_bad.disabled = false

	stage.do_tv_splash()
	
