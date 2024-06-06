extends Resource

var weights1: Array:Array
var weights2: Array:Array

func _init(config):
    weights1 = initialize_weights(config["input_size"], config["hidden_size"])
    weights2 = initialize_weights(config["hidden_size"], config["output_size"])

func initialize_weights(rows: int, cols: int):
    var weights: Array:Array = []
    for i in range(rows):
        var row: Array = []
        for j in range(cols):
            row.append(randf() * 2 - 1)
        weights.append(row)
    return weights

func forward_propagation(inputs: Array) -> float:
    if len(inputs) != weights1[0].size():
        raise ValueError("Input size does not match the expected input size.")
    var hidden_layer: Array = matrix_multiply(inputs, weights1)
    hidden_layer = activate(hidden_layer)
    var output_layer: Array = matrix_multiply(hidden_layer, weights2)
    output_layer = activate(output_layer)
    return output_layer[0]

func matrix_multiply(a: Array, b: Array) -> Array:
    if len(a) != len(b[0]):
        raise ValueError("Input matrices have incompatible dimensions.")
    var result: Array = []
    for i in range(len(b)):
        var sum: float = 0
        for j in range(len(a[0])):
            sum += a[i][j] * b[i][j]
        result.append(sum)
    return result

func activate(values: Array) -> Array:
    return values.map(func(value: float): return sigmoid(value))

func sigmoid(x: float) -> float:
    return 1.0 / (1.0 + exp(-x))

func crossover(other: NeuralNetwork) -> NeuralNetwork:
    if Config.config != other.Config.config:
        raise ValueError("Cannot crossover NeuralNetworks with different configurations.")
    var child_nn = NeuralNetwork.new(Config.config)
    child_nn.weights1 = crossover_weights(weights1, other.weights1)
    child_nn.weights2 = crossover_weights(weights2, other.weights2)
    return child_nn

func crossover_weights(weights1: Array(Array), weights2: Array(Array)) -> Array(Array):
    var child_weights: Array(Array) = []

    for i in range(weights1.size()):
        var row: Array = []
        for j in range(weights1[i].size()):
            row.append(weights1[i][j] if randf() < 0.5 else weights2[i][j])
        child_weights.append(row)

    return child_weights

func mutate(mutation_rate: float):
    mutate_weights(weights1, mutation_rate)
    mutate_weights(weights2, mutation_rate)




