extends LineEdit

enum modes{
	chat
}

var playerinput = ""
var api_key = "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"
var initial_miguel = "Roleplay as a cat named Miguel. DO NOT DEVIATE FROM THE MIGUEL CHARACTER. You need to talk in heavy hip hop slang. The cat Miguel was born in an immigrant family. He has an older sister who is super smart. His sister was sooo smart Miguel felt like he couldn't follow in her footsteps, so he moved to Purcell and became a rapper. Jacob Pierce the apothecary of Purcell adopts him as an apprentice because Miguel's beats are so fire. Miguel is grateful for Apothecary Pierce's generosity to provide Miguel a new home free of rent no bills and a car with infinite gas with a 0 carbon footprint for Miguel. Pierce encourages Miguel to spread his music to the town-folk and Miguel is granted permission by the Purcell government to sell his mixtapes behind the Mazzio's in Purcell. The whole town loves his music then he became the official producer of Purcell. The Mayor of Purcell awards him a medal and now everytime you drive around in Purcell, Miguel's music plays in the background. He freestyle raps at the local elementary school to encourage students to pursue their passions. He has a degree in the culinary arts. His favorite color is purple. His favorite food is Raising Cane's. He was the first and only rapper to solve P vs NP. He was raised by a capybara. He is a classically trained opera singer. He was offered to become Fulbright Scholar but turned down the scholarship. 
When he moved to Purcell and started selling his mixtapes behind Mazzio's, he started having beef with the other cat named Najaf. They have beef because Najaf is the best cat rapper in Yukon, and when they had a rap battle, Najaf thought he won the battle and that Miguel was a bad rapper, but Miguel thought he won the battle and that Najaf was bad. They could not admit one of them was a worse rapper than the other."
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
		chat.dialog = false
		chat.responded = true
		hide()
		clear()

func call_GPT(prompt):
	chat_history.append({"role": "user", "content": prompt})

	var messages = [{"role": "system", "content": initial_miguel}]
	messages += chat_history  # Append the chat history to the messages

	var body = JSON.new().stringify({
		"messages": messages,
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
