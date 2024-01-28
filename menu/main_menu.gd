extends Panel

@export var button_start: Button
@export var button_login: Button
@export var button_credits: Button
@export var button_quit: Button

var game: Node = preload("res://main.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	button_start.pressed.connect(func(): add_sibling(game); self.queue_free())
	button_login.pressed.connect(func(): pass)
	button_credits.pressed.connect(func(): pass)
	button_quit.pressed.connect(func(): get_tree().quit())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
