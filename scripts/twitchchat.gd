extends Node

var config_file_path: String = "res://.twitch_client"
var _config_file = ConfigFile.new()

@onready var plinko: PlinkoGameMaster = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(FileAccess.file_exists(config_file_path), "Configuration file missing!")
	assert(_config_file.load(config_file_path) == OK, "There was an error loading the configuration.")
	$"../TwitchIRCClient".open_connection()
	print("Opened Connection")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_value(section: String, key: String) -> Variant:
	return _config_file.get_value(section, key, null)


func _on_twitch_irc_client_logger(message: String, timestamp: String) -> void:
	for s in message.strip_edges().split("\r\n"):
		prints("msg recvd ", timestamp, s)


func _on_twitch_irc_client_connection_opened() -> void:
	print("Twitch chat connected")
	print("get value ", get_value("authentication", "nick"))
	var nick: String = get_value("authentication", "nick")
	var oauth_token: String = get_value("authentication", "oauth_token")
	$"../TwitchIRCClient".authenticate(nick, oauth_token)


func _on_twitch_irc_client_authentication_completed(was_successful: bool) -> void:
	if was_successful:
		# Join the desired Twitch channel.
		var channel: String = get_value("connection", "channel")
		$"../TwitchIRCClient".join(channel)
	else:
		$"../TwitchIRCClient".close_connection()


func _on_twitch_irc_client_message_received(username: String, message: String, tags: Dictionary) -> void:
	match message.get_slice(" ", 0).to_lower():
		"!ball":
			var position: int = int(message.get_slice(" ", 1))
			if position < 1 || position > 385:
				return
			position -= 195
			print("Drop ball at " + str(position) + " for user '" + tags['display-name'] + "'")
			plinko.create_ball(tags['display-name'], position)
