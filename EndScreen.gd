extends RichTextLabel

@export var top_panel: Control
@export var score: Score
var menu: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	score.score_0.connect(func(): end_game())


func end_game():
	get_tree().paused = true
	visible = true
	top_panel.modulate = Color(0.2, 0.2, 0.2)
	await get_tree().create_timer(5.0).timeout
	get_parent().add_sibling(menu)
	get_tree().paused = false
	get_parent().get_parent().remove_child(get_parent())
