extends Node2D
classname NeuralNetworkMain

@export var pendulum: Node2D
@export var cart: Node2D
@export var model: Resource
@export var enable_visualization: bool = false

var population: Array[Dictionary] = []
var elite: Array[Dictionary] = []

func _ready() -> void:
	"""
	Initializes the main script when the node is ready.
	"""
	
	# Type hints
	assert(pendulum is Node2D, "Pendulum must be of type Node2D.")
	assert(cart is Node2D, "Cart must be of type Node2D.")
	assert(model is Resource, "Model must be of type Resource.")
	
	if pendulum == null or cart == null or model == null:
		print("ERROR: Required nodes or resource are not set")
		return
	
	randomize()
	population = Population.new(Config.POPULATION_SIZE, model, Config.config)
	load_best_model()

    if pendulum == null or cart == null or model == null:
        print("ERROR: Required nodes or resource are not set")
        return
    
    randomize()
    population = Population.new(Config.POPULATION_SIZE, model, Config.config)
    load_best_model()

func _process(delta):
    if pendulum == null or cart == null or model == null:
        print("ERROR: Required nodes or resource are not set")
        return
    
    population.evaluate(pendulum, cart)
    population.evolve()
    save_best_model()
    
    if enable_visualization:
        update()

func save_best_model():
    if model == null:
        print("ERROR: The model resource is not set")
        return
    
    var best_individual = population.get_best_individual()
    if best_individual == null or best_individual.get("neural_network") == null:
        print("ERROR: The best individual is not set")
        return
    
    model.weights1 = best_individual["neural_network"].weights1
    model.weights2 = best_individual["neural_network"].weights2
    ResourceSaver.save("res://best_model.resource", model)

func load_best_model():
    if ResourceLoader.exists("res://best_model.resource"):
        model = ResourceLoader.load("res://best_model.resource")
        if model == null:
            print("ERROR: The model resource could not be loaded")
            return

        population.load_best_model(model)

func _draw():
    if enable_visualization:
        if population.size() == 0:
            print("ERROR: The population is empty")
        else:
            population.visualize(self)


