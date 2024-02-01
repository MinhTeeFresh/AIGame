extends Node

enum modes{
	chat
}

var api_key = ""
var max_tokens = 1024
var temperature = 0.5
var url = "https://api.openai.com/v1/chat/completions"
var headers = ["Content-Type: application/json", "Authorization: Bearer " + api_key]
var engine = "gpt-3.5-turbo"
var chat_dock
var http_request :HTTPRequest
var current_mode
var cursor_pos
var code_editor
var settings_menu

