# Created by Freeknight
# 2021/12/02
# 说明：
#-------------------------------------------------
tool
extends EditorPlugin
#-------------------------------------------------
func get_name(): 
	return "FKMonitor"
#-------------------------------------------------
func _enter_tree():
	add_custom_type(
		"FKMonitor", 
		"VBoxContainer",
		load("res://addons/FKMonitor/Scripts/FKMonitorVBoxContainer.gd"),
		load("res://addons/FKMonitor/Assets/Icons/icon.svg")
	)
#-------------------------------------------------
func _exit_tree():
	remove_custom_type("FKMonitor")
#-------------------------------------------------
