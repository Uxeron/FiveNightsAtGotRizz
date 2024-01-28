class_name Score
extends Control

signal score_0

@export var progress_viewers: ProgressBar
@export var progress_ratings: ProgressBar
@export var progress_engagement: ProgressBar

@export var text_viewers: RichTextLabel
@export var text_ratings: RichTextLabel
@export var text_engagement: RichTextLabel

@export var noise: NoiseTexture2D

var color_good: Color = Color("27AE60")
var color_bad: Color = Color("C0392B")

var current_score: float = 0.8
var target_score: float = 0.8
var score_change_rate: float = 0.2
var score_fall_rate: float = 0.02
var noise_target: int = 0
var noise_image: Image
var is_fancy_text: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	while noise_image == null:
		noise_image = noise.get_image()
		await(get_tree().create_timer(0.1).timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if noise_image == null:
		return
	
	target_score -= score_fall_rate * delta
	
	if target_score <= 0.0:
		score_0.emit()
	
	var score_change_raw: float = target_score - current_score
	if score_change_raw > 0.2:
		is_fancy_text = true
		text_viewers.text = "[wave amp=25.0 freq=10.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8][center][b]Viewers"
		text_ratings.text = "[wave amp=25.0 freq=10.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8][center][b]Ratings"
		text_engagement.text = "[wave amp=25.0 freq=10.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8][center][b]Engagement"
	
	if is_fancy_text and score_change_raw < 0.02:
		is_fancy_text = false
		text_viewers.text = "[center][b]Viewers"
		text_ratings.text = "[center][b]Ratings"
		text_engagement.text = "[center][b]Engagement"

	var score_change: float = max(-score_change_rate, min(score_change_rate, score_change_raw))
	current_score += score_change * delta
	
	noise_target += 1
	if noise_target >= noise_image.get_width():
		noise_target -= noise_image.get_width()
		
	var noise_target2 = noise_target + 100
	if noise_target2 >= noise_image.get_width():
		noise_target2 -= noise_image.get_width()
		
	var noise_target3 = noise_target + 200
	if noise_target3 >= noise_image.get_width():
		noise_target3 -= noise_image.get_width()
	
	progress_viewers.value = (current_score + ((noise_image.get_pixel(noise_target, 0).r - 0.5) / 10.0)) * 100.0
	progress_viewers.value = max(0.0, min(100.0, progress_viewers.value))
	
	progress_ratings.value = (current_score + ((noise_image.get_pixel(noise_target2, 0).r - 0.5) / 10.0)) * 100.0
	progress_ratings.value = max(0.0, min(100.0, progress_ratings.value))
	
	progress_engagement.value = (current_score + ((noise_image.get_pixel(noise_target3, 0).r - 0.5) / 10.0)) * 100.0
	progress_engagement.value = max(0.0, min(100.0, progress_engagement.value))
	
	var stylebox: StyleBoxFlat = progress_viewers.get_theme_stylebox("fill")
	stylebox.bg_color = color_bad.lerp(color_good, progress_viewers.value / 100.0)
	progress_viewers.add_theme_stylebox_override("fill", stylebox)
	
	stylebox = progress_ratings.get_theme_stylebox("fill")
	stylebox.bg_color = color_bad.lerp(color_good, progress_ratings.value / 100.0)
	progress_ratings.add_theme_stylebox_override("fill", stylebox)
	
	stylebox = progress_engagement.get_theme_stylebox("fill")
	stylebox.bg_color = color_bad.lerp(color_good, progress_engagement.value / 100.0)
	progress_engagement.add_theme_stylebox_override("fill", stylebox)
