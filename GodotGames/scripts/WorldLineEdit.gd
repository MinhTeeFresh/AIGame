extends LineEdit

enum modes{
	chat
}

var playerinput = ""
var api_key = "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"
var max_tokens = 1024
var temperature = 0.5
var url = "https://api.openai.com/v1/chat/completions"
var headers = ["Content-Type: application/json", "Authorization: Bearer " + api_key]
var engine = "gpt-3.5-turbo-0613"
var chat_dock
var http_request :HTTPRequest
var current_mode
var cursor_pos
var code_editor
var settings_menu
var chat_history = []

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _on_request_completed)
	hide()

@onready var player = get_node("../../player")
@onready var chat = get_node("..")
@onready var WorldResponse = get_node("../WorldResponse")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chat.dialog == true:
		show()

func _on_text_submitted(new_text):
	if !new_text.is_empty():
		var currentMode = modes.chat
		playerinput = new_text
		call_GPT(playerinput)
		# playerinput --> AI
		chat.dialog = false
		chat.responded = true
		hide()
		clear()

func call_GPT(prompt):
	chat_history.append({"role": "user", "content": prompt})

	var body = JSON.new().stringify({
		"messages": chat_history,
		"temperature": temperature,
		"max_tokens": max_tokens,
		"model": engine
	})
	var error = http_request.request(url, ["Content-Type: application/json", "Authorization: Bearer " + api_key], HTTPClient.METHOD_POST, body)
	
	if error != OK:
		push_error("Something Went Wrong!")
		
		
		
		
		
		
		
# This GDScript code is used to handle the response from
# a request 
func _on_request_completed(result, responseCode, headers, body):
	printt(result, responseCode, headers, body)
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	if parse_result:
		printerr(parse_result)
		return
	var response = json.get_data()
	if response is Dictionary:
		printt("Response", response)
		if response.has("error"):
			printt("Error", response['error'])
			return
	else:
		printt("Response is not a Dictionary", headers)
		return
	
	var newStr = response.choices[0].message.content
	chat_history.append({"role": "assistant", "content": newStr})
	WorldResponse.response = newStr
	pass
