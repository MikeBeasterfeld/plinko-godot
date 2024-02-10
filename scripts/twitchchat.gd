extends Node

var config_file_path: String = "res://.twitch_client"
var _config_file = ConfigFile.new()
var queue: Array = []

@onready var plinko: PlinkoGameMaster = $".."
@onready var twitch_irc_client: TwitchIRCClient = $"../TwitchIRCClient"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(FileAccess.file_exists(config_file_path), "Configuration file missing!")
	assert(_config_file.load(config_file_path) == OK, "There was an error loading the configuration.")
	twitch_irc_client.open_connection()
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
	twitch_irc_client.authenticate(nick, oauth_token)


func _on_twitch_irc_client_authentication_completed(was_successful: bool) -> void:
	if was_successful:
		# Join the desired Twitch channel.
		var channel: String = get_value("connection", "channel")
		twitch_irc_client.join(channel)
	else:
		twitch_irc_client.close_connection()


func _on_twitch_irc_client_message_received(_username: String, message: String, tags: Dictionary) -> void:
	match message.get_slice(" ", 0).to_lower():
		"!ball":
			var position: int = int(message.get_slice(" ", 1))
			if position < 1 || position > 385:
				return
			position -= 195
			var display_name: String = tags['display-name']
			print("Queue drop ball at " + str(position) + " for user '" + display_name + "'")
			#plinko.create_ball(display_name, position)
			queue.push_back([display_name, position])


func _on_timer_timeout() -> void:
	if queue.size() > 0:
		var ball_drop: Array = queue.pop_front()
		plinko.create_ball(ball_drop[0], ball_drop[1])

