extends Sprite2D

@export var notes_normal: GPUParticles2D
@export var notes_broken: GPUParticles2D
@export var notes_amazing: GPUParticles2D


func become_bad():
	notes_normal.emitting = false
	notes_broken.emitting = true

func become_good():
	notes_normal.emitting = false
	notes_amazing.emitting = true
