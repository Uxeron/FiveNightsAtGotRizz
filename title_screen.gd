extends Control

@export_file("*.tscn") var path_to_game_scene:String

@onready var name_label:Label = $NameLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SolanaService.wallet.connect("on_logged_in",confirm_login)	


func confirm_login(login_success:bool) -> void:
	if login_success:
		#SceneLoader.load_scene(path_to_game_scene)
		var wallet_address = SolanaService.wallet.get_pubkey().get_value()
		name_label.text = wallet_address
		#change_scene();
		
		#Needs phantom wallet plugin


func change_scene():
	get_tree().change_scene_to_file(path_to_game_scene)

func _on_login_btn_pressed():
	SolanaService.wallet.try_login();

func _on_play_as_guest_btn_pressed():
	change_scene();
