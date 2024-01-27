extends Sprite2D

@export var juggler_textures: Array[Texture]
@export var juggler_end_texture: Texture
@export var juggling_ball: PackedScene
@export var texture_change_tempo := 0.25
@export var number_of_balls := 5

var current_texture_lifetime := 0.0
var current_texture = 0

var balls: Array

var is_done := false

func _ready():
	texture = juggler_textures[current_texture]
	
	for i in number_of_balls:
		var new_ball := juggling_ball.instantiate()
		balls.append(new_ball)
		
		$Path2D.add_child(new_ball)


func _process(delta):
	if is_done:
		return
	
	current_texture_lifetime += delta
	
	if current_texture_lifetime >= texture_change_tempo:
		current_texture_lifetime = 0.0
		
		current_texture = (current_texture + 1) % juggler_textures.size()
		texture = juggler_textures[current_texture]


func lose_balls():
	for ball in balls:
		ball.get_lost()


func success():
	for ball in balls:
		ball.mark_done()
	
	texture = juggler_end_texture
	
	is_done = true

