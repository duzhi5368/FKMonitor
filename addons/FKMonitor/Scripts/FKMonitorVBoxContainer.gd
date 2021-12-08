# Created by Freeknight
# 2021/12/02
# 说明：
#-------------------------------------------------
extends VBoxContainer
#-------------------------------------------------
const TextDict = preload("./Text_zhCN.gd").TextDict
#-------------------------------------------------
export var background_color := Color(0.0, 0.0, 0.0, 0.5)
export var plot_graphs := true
export var graph_color := Color.orange
export var normalize_units := true
export var history := 100
export var graph_height := 50
#-------------------------------------------------
export var fps := true
export var process := true
export var physics_process := true
export var static_memory := true
export var dynamic_memory := true
export var max_static_memory := false
export var max_dynamic_memory := false
export var max_message_buffer := false
export var objects := true
export var resources := false
export var nodes := true
export var orphan_nodes := false
export var objects_drawn := false
export var vertices_drawn := false
export var material_changes := false
export var shader_changes := false
export var surface_changes := false
export var draw_calls_3d := false
export var items_2d := false
export var draw_calls_2d := true
export var video_memory := false
export var texture_memory := false
export var vertex_memory := false
export var max_video_memory := false
export var active_objects_2d := false
export var collision_pairs_2d := false
export var islands_2d := false
export var active_objects_3d := false
export var collision_pairs_3d := false
export var islands_3d := false
export var audio_output_latency := false
#-------------------------------------------------
var _timer: Timer
var _font: DynamicFont = load("res://addons/FKMonitor/Assets/Fonts/SourceHanSerifSC_Regular.tres")
var _debug_graph = load("res://addons/FKMonitor/Scripts/FKMonitorOverlayDebugGraph.gd")
var _graphs := []
#-------------------------------------------------
func _ready():
	if rect_min_size.x == 0:
		rect_min_size.x = 300
	rebuild_ui()
#-------------------------------------------------
func clear() -> void:
	for graph in _graphs:
		graph.queue_free()
	_graphs = []
#-------------------------------------------------
func rebuild_ui() -> void:
	clear()
	if fps:
		_create_graph_for(Performance.TIME_FPS, TextDict["FPS"])
	if process:
		_create_graph_for(Performance.TIME_PROCESS, TextDict["Process"], "s")
	if physics_process:
		_create_graph_for(Performance.TIME_PHYSICS_PROCESS, TextDict["PhysProcess"], "s")
	if static_memory:
		_create_graph_for(Performance.MEMORY_STATIC, TextDict["StaMemory"], "B")
	if dynamic_memory:
		_create_graph_for(Performance.MEMORY_DYNAMIC, TextDict["DynMemory"], "B")
	if max_static_memory:
		_create_graph_for(Performance.MEMORY_STATIC_MAX, TextDict["MaxStaMemory"], "B")
	if max_dynamic_memory:
		_create_graph_for(Performance.MEMORY_DYNAMIC_MAX, TextDict["MaxDynMemory"], "B")
	if max_message_buffer:
		_create_graph_for(Performance.MEMORY_MESSAGE_BUFFER_MAX, TextDict["MaxMessageBuf"])
	if objects:
		_create_graph_for(Performance.OBJECT_COUNT, TextDict["Objects"])
	if resources:
		_create_graph_for(Performance.OBJECT_RESOURCE_COUNT, TextDict["Resources"])
	if nodes:
		_create_graph_for(Performance.OBJECT_NODE_COUNT, TextDict["Nodes"])
	if orphan_nodes:
		_create_graph_for(Performance.OBJECT_ORPHAN_NODE_COUNT, TextDict["OrpNodes"])
	if objects_drawn:
		_create_graph_for(Performance.RENDER_OBJECTS_IN_FRAME, TextDict["DrawnObjs"])
	if vertices_drawn:
		_create_graph_for(Performance.RENDER_VERTICES_IN_FRAME, TextDict["DrawnVers"])
	if material_changes:
		_create_graph_for(Performance.RENDER_MATERIAL_CHANGES_IN_FRAME, TextDict["ChangedMaterials"])
	if shader_changes:
		_create_graph_for(Performance.RENDER_SHADER_CHANGES_IN_FRAME, TextDict["ChangedShaders"])
	if surface_changes:
		_create_graph_for(Performance.RENDER_SURFACE_CHANGES_IN_FRAME, TextDict["ChangedSurface"])
	if draw_calls_3d:
		_create_graph_for(Performance.RENDER_DRAW_CALLS_IN_FRAME, TextDict["3DDrawCalls"])
	if items_2d:
		_create_graph_for(Performance.RENDER_2D_ITEMS_IN_FRAME, TextDict["2DItems"])
	if draw_calls_2d:
		_create_graph_for(Performance.RENDER_2D_DRAW_CALLS_IN_FRAME, TextDict["2DDrawCalls"])
	if video_memory:
		_create_graph_for(Performance.RENDER_VIDEO_MEM_USED, TextDict["VidMemory"], "B")
	if texture_memory:
		_create_graph_for(Performance.RENDER_TEXTURE_MEM_USED, TextDict["TexMemory"], "B")
	if vertex_memory:
		_create_graph_for(Performance.RENDER_VERTEX_MEM_USED, TextDict["VerMemory"], "B")
	if max_video_memory:
		_create_graph_for(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL, TextDict["MaxVidMemory"], "B")
	if active_objects_2d:
		_create_graph_for(Performance.PHYSICS_2D_ACTIVE_OBJECTS, TextDict["2DActiveObjs"])
	if collision_pairs_2d:
		_create_graph_for(Performance.PHYSICS_2D_COLLISION_PAIRS, TextDict["2DColPairs"])
	if islands_2d:
		_create_graph_for(Performance.PHYSICS_2D_ISLAND_COUNT, TextDict["2DIslands"])
	if active_objects_3d:
		_create_graph_for(Performance.PHYSICS_3D_ACTIVE_OBJECTS, TextDict["3DActiveObjs"])
	if collision_pairs_3d:
		_create_graph_for(Performance.PHYSICS_3D_COLLISION_PAIRS, TextDict["3DColPairs"])
	if islands_3d:
		_create_graph_for(Performance.PHYSICS_3D_ISLAND_COUNT, TextDict["3DIslands"])
	if audio_output_latency:
		_create_graph_for(Performance.AUDIO_OUTPUT_LATENCY, TextDict["AudioLatency"], "s")
#-------------------------------------------------
func _process(_delta) -> void:
	for item in _graphs:
		item.update()
#-------------------------------------------------
func _create_graph_for(monitor: int, name: String, unit: String = "") -> void:
	var graph = _debug_graph.new()
	graph.monitor = monitor
	graph.monitor_name = name
	graph.font = _font
	graph.rect_min_size.y = graph_height
	graph.max_points = history
	graph.background_color = background_color
	graph.graph_color = graph_color
	graph.plot_graph = plot_graphs
	graph.unit = unit
	graph.normalize_units = normalize_units

	add_child(graph)
	_graphs.push_back(graph)
#-------------------------------------------------
