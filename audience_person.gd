class_name AudiencePerson
extends Sprite2D

@export var texture_clapping: Texture2D
@export var texture_neutral: Array[Texture2D]
@export var texture_laughing: Array[Texture2D]

var a: bool = false

enum STATE {
	CLAPPING,
	NEUTRAL,
	LAUGHING
}

var state: STATE = STATE.NEUTRAL:
	set(st):
		state = st
		$Area2D.position += Vector2(0.1, 0.1)
		match st:
			STATE.CLAPPING:
				clap_face()
			STATE.NEUTRAL:
				neutral_face()
			STATE.LAUGHING:
				laugh_face()


func _ready():
	self.state = STATE.NEUTRAL
	
	$FaceAnimTimer.wait_time = 1 + randf()
	
	$AnimationPlayer.current_animation = 'clap'


func _on_timer_timeout():
	if state == STATE.NEUTRAL:
		neutral_face()


func neutral_face():
	texture = texture_neutral.pick_random()
	if randf() > 0:
		transform.x *= -1
	
	$FaceClapHandLeft.visible = false
	$FaceClapHandRight.visible = false


func clap_face():
	texture = texture_clapping
	
	$FaceClapHandLeft.visible = true
	$FaceClapHandRight.visible = true


func laugh_face():
	texture = texture_laughing.pick_random()
	
	$FaceClapHandLeft.visible = false
	$FaceClapHandRight.visible = false


func _on_laugh_timer_timeout():
	if state == STATE.LAUGHING:
		texture = texture_laughing.pick_random()
