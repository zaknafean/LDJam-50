extends LinkButton

func _on_BtnDiscord_pressed():
	if OS.get_name() != 'HTML5':
		OS.shell_open('https://discord.gg/X99yEtAZAJ')
	else:
		JavaScript.eval('window.location.replace("https://discord.gg/X99yEtAZAJ")')
