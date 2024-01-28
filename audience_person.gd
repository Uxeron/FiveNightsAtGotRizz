class_name AudiencePerson
extends Sprite2D

@export var texture_clapping: Texture2D
@export var texture_neutral: Texture2D
@export var texture_laughing: Texture2D

enum STATE {
	CLAPPING,
	NEUTRAL,
	LAUGHING
}

var state: STATE = STATE.NEUTRAL:
	set(st):
		state = st
		match st:
			STATE.CLAPPING:
				texture = texture_clapping
			STATE.NEUTRAL:
				texture = texture_neutral
			STATE.LAUGHING:
				texture = texture_laughing
