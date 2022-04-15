extends Screen


func _on_Credits_meta_clicked(meta):
	# `meta` is not guaranteed to be a String, so convert it to a String
	# to avoid script errors at run-time.
	if OS.get_name() != 'HTML5':
		OS.shell_open(str(meta))
