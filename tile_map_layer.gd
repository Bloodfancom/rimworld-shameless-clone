@tool
extends TileMapLayer


@export var terrainSeed: int
@export var generateTerain: bool
@export var clearTerain: bool
@export var mapWidth: int
@export var mapHeight: int
@export var grassThreshold: float
@export var grass2Threshold: float
@export var dirtThreshold: float
@export var rockThreshold: float


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if generateTerain:
		generateTerain = false
		GenerateTerrain()
	if clearTerain:
		clearTerain = false
		clear()
	 



func GenerateTerrain():
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	
	var rng = RandomNumberGenerator.new()
	if terrainSeed == 0:
		noise.seed = rng.randi()
	else:
		noise.seed = terrainSeed	
	
	print("Generating Terrain...")
	for x in range(mapWidth):
		for y in range(mapHeight):
			if noise.get_noise_2d(x,y) > grassThreshold:
				set_cell(Vector2(x,y),0,Vector2(0,0))
			elif noise.get_noise_2d(x,y) > grass2Threshold:
				set_cell(Vector2(x,y),0,Vector2(1,0))
			elif noise.get_noise_2d(x,y) > dirtThreshold:
				set_cell(Vector2(x,y),0,Vector2(2,0))
			elif noise.get_noise_2d(x,y) > rockThreshold:
				set_cell(Vector2(x,y),0,Vector2(3,0))
			else:
				set_cell(Vector2(x,y),0,Vector2(0,1))
