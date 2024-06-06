extends NeuralNetworkMain
classname Population

var individuals = []
var elite = []

func _init(size, model, config):
    assert(size > 0, "Population size must be greater than 0")
    for i in range(size):
        var individual = {
            "neural_network": NeuralNetwork.new(config),
            "fitness": 0
        }
        individuals.append(individual)

func evaluate(pendulum, cart):
    for individual in individuals:
        individual["fitness"] = FitnessEvaluator.evaluate(individual["neural_network"], pendulum, cart)

func evolve():
    select_elite()
    reproduce()

func select_elite():
    individuals.sort_custom(func(a, b): return a["fitness"] > b["fitness"])
    elite = individuals.slice(0, min(Config.ELITE_COUNT, individuals.size()))

func reproduce():
    var new_individuals = []
    
    for i in range(Config.POPULATION_SIZE):
        var parent1 = elite[randi() % elite.size()]
        var parent2 = elite[randi() % elite.size()]
        
        var child_nn = parent1["neural_network"].crossover(parent2["neural_network"])
        child_nn.mutate(Config.MUTATION_RATE)
        
        var child = {
            "neural_network": child_nn,
            "fitness": 0
        }
        new_individuals.append(child)
    
    individuals = new_individuals

func get_best_individual():
    assert(individuals.size() > 0, "No individuals in population")
    return individuals[0]

func load_best_model(model):
    if not model:
        return
    var best_nn = NeuralNetwork.new(Config.config)
    best_nn.weights1 = model.weights1
    best_nn.weights2 = model.weights2
    var best_individual = {
        "neural_network": best_nn,
        "fitness": 0
    }
    individuals[0] = best_individual

func visualize(node):
    if not node:
        return

    var best_individual = get_best_individual()
    var weights1 = best_individual["neural_network"].weights1
    var weights2 = best_individual["neural_network"].weights2
    
    # Visualize weights1
    for i in range(weights1.size()):
        for j in range(weights1[i].size()):
            var color = Color.from_hsv(0.5 + weights1[i][j] * 0.5, 1, 1)
            node.draw_rect(Rect2(j * 20, i * 20, 20, 20), color)
    
    # Visualize weights2
            node.draw_rect(Rect2(j * 20, (i + weights1.size()) * 20, 20, 20), color)

