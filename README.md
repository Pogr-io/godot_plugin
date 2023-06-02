# godot_plugin
- [ ] Core Plugin Structure
- [x] implement  Multi-Threaded API Calls
- [ ] Try using only godot-cpp at first (HTTPRequest)
- [x] Add URL Base to Project Settings
- [x] Build_ID & Client_ID in project settings

init ~ [GET] to a specific URL with Header Information such as Build_ID, and Client_ID which are stored as 2 fields within the settings for the plugin<br>
end ~ [GET] when the game is closing, hit a specific URL with HEader  Information such as Build_ID, and Client_ID which are stored as 2 fields within the settings for the plugin<br>
event ~ [POST] to a specific URL a specific json payload<br>
data ~ [POST] to a specific URL a specific json payload<br>
monitor ~ [POST] to a specific URL memory, cpu, etc information on the game client's environment.<br>
