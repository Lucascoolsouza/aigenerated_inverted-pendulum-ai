extends NeuralNetworkMain
classname FitnessEvaluator

static func evaluate(neural_network, pendulum, cart):
    if not pendulum or not cart:
        return 0

    var fitness = 0
    var score = 0
    var distance = 0
    
    while is_balanced(pendulum):
        var inputs = get_inputs(pendulum, cart)
        var output = neural_network.forward_propagation(inputs)
        apply_output(output, cart)
        
        score += 1
        distance = abs(cart.position.x)
        fitness = calculate_fitness(score, distance, pendulum)
    
    return fitness

static func calculate_fitness(score, distance, pendulum):
    if pendulum:
        return score / (1 + abs(pendulum.rotation) + distance)
    else:
        return 0

static func get_inputs(pendulum, cart):
    if pendulum and cart:
        return [
            pendulum.rotation,
            pendulum.global_position.direction_to(cart.global_position).x,
            pendulum.global_position.direction_to(cart.global_position).y,
            pendulum.angular_velocity,
            cart.linear_velocity.x
        ]
    else:
        return []

static func apply_output(output, cart):
    if cart:
        cart.linear_velocity.x = output

static func is_balanced(pendulum):
    if pendulum:
        return abs(pendulum.rotation) < Config.THRESHOLD
    else:
        return false

