extends Node2D

signal finished_act(succeeded: bool)

@export var dancers: Array[Node2D]
@export var dancing_sprites: Array[Texture]

@export var win_texture: Texture
@export var fail_texturer: Texture

var current_sprite := 0

var is_win := false


func _on_shaking_timeout():
	if is_win:
		return
	
	for dancer in dancers:
		dancer.transform.x *= -1


func _on_texture_change_timeout():
	if is_win:
		return
	
	current_sprite = (current_sprite + 1) % dancing_sprites.size()
	
	for dancer in dancers:
		dancer.texture = dancing_sprites[current_sprite]


func win():
	is_win = true
	
	for dancer in dancers:
		dancer.texture = win_texture


func lose():
	is_win = true
	
	for dancer in dancers:
		dancer.texture = win_texture
	
	dancers.pick_random().texture = fail_texturer


func _on_end_timer_timeout():
	if randf() > 0.5:
		lose()
		finished_act.emit(true)
	else:
		lose()
		finished_act.emit(false)
