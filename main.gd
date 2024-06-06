extends Node2D

@export var pendulum: Node2D
@export var cart: Node2D
@export var model: Resource
@export var enable_visualization: bool = false

var population = []
var elite = []

func _ready():
    randomize()
    population = Population.new(Config.POPULATION_SIZE, model, Config.config)
    load_best_model()

func _process(delta):
    population.evaluate(pendulum, cart)
    population.evolve()
    save_best_model()
    
    if enable_visualization:
        update()

func save_best_model():
    var best_individual = population.get_best_individual()
    model.weights1 = best_individual["neural_network"].weights1
    model.weights2 = best_individual["neural_network"].weights2
    ResourceSaver.save("res://best_model.resource", model)

func load_best_model():
    if ResourceLoader.exists("res://best_model.resource"):
        model = ResourceLoader.load("res://best_model.resource")
        population.load_best_model(model)

func _draw():
    if enable_visualization:
        population.visualize(self)
