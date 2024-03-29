extends Panel

@export var button_start: Button
@export var button_login: Button
@export var button_credits: Button
@export var button_quit: Button

@export var label_address: Label

var game: Node = preload("res://main.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	SolanaService.wallet.connect("on_logged_in",confirm_login)
	game.get_child(1).menu = self
	
	button_start.pressed.connect(func(): start_game())
	button_login.pressed.connect(func(): SolanaService.wallet.try_login())
	button_credits.pressed.connect(func(): pass)
	button_quit.pressed.connect(func(): get_tree().quit())
	
	#DialogueManager.show_dialogue_balloon(preload("res://dialogues/lore.dialogue"), "lore_start")

func start_game():
	game = preload("res://main.tscn").instantiate()
	game.get_child(1).menu = self
	add_sibling(game)
	get_tree().current_scene = game
	get_parent().remove_child(self)

func confirm_login(login_success:bool) -> void:
	if login_success:
		var wallet_address = SolanaService.wallet.get_pubkey().get_value()
		button_login.text = "Login success!"
		button_login.disabled = true
		label_address.text = "Wallet address: " + wallet_address
	else:
		print("Failed")

