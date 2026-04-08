extends TileMapLayer
class_name TileMapLayerWithBetterOneWay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tile_set:
		tile_set.add_physics_layer()
		#print(tile_map_data)
		#for i in tile_map_data:
			#print("poo")
