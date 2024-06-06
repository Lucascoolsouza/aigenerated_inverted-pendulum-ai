extends Resource

var weights1
var weights2

func _init(config):
    weights1 = initialize_weights(config["input_size"], config["hidden_size"])
    weights2 = initialize_weights(config["hidden_size"], config["output_size"])

func initialize_weights(rows, cols):
    var weights = []
    for i in range(rows):
        var row = []
        for j in range(cols):
            row.append(randf() * 2 - 1)
        weights.append(row)
    return weights

func forward_propagation(inputs):
    var hidden_layer = matrix_multiply(inputs, weights1)
    hidden_layer = activate(hidden_layer)
    var output_layer = matrix_multiply(hidden_layer, weights2)
    output_layer = activate(output_layer)
    return output_layer[0]

func matrix_multiply(a, b):
    var result = []
    for i in range(b.size()):
        var sum = 0
        for j in range(a.size()):
            sum += a[j] * b[i][j]
        result.append(sum)
    return result

func activate(values):
    return values.map(func(value): return sigmoid(value))

func sigmoid(x):
    return 1.0 / (1.0 + exp(-x))

func crossover(other):
    var child_nn = NeuralNetwork.new(Config.config)
    child_nn.weights1 = crossover_weights(weights1, other.weights1)
    child_nn.weights2 = crossover_weights(weights2, other.weights2)
    return child_nn

func crossover_weights(weights1, weights2):
    var child_weights = []

    for i in range(weights1.size()):
        var row = []
        for j in range(weights1[i].size()):
            row.append(weights1[i][j] if randf() < 0.5 else weights2[i][j])
        child_weights.append(row)

    return child_weights

func mutate(mutation_rate):
    mutate_weights(weights1, mutation_rate)
    mutate_weights(weights2, mutation_rate)

func mutate_weights(weights, mutation_rate):
    for i in range(weights.size()):
        for j in range(weights[i].size()):
            if randf() < mutation_rate:
                weights[i][j] = randf() * 2 - 1
