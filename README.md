# Inverted Pendulum AI

This project demonstrates the use of a genetic algorithm to train a neural network controller for balancing an inverted pendulum on a cart. The AI learns to control the cart's movement in order to keep the pendulum upright.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Visualization](#visualization)
- [Contributing](#contributing)
- [License](#license)

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/your-username/inverted-pendulum-ai.git
   ```

2. Open the project in Godot Engine.

3. Build and run the project.

## Usage

1. Open the project in Godot Engine.

2. Attach the `Main.gd` script to the main node in your Godot scene.

3. Set the `pendulum` and `cart` variables in the editor to reference the corresponding nodes in your scene.

4. Optionally, enable the `enable_visualization` flag in the editor to visualize the neural network weights.

5. Run the project to start the AI training process.

6. The AI will automatically save the best model weights to a file named `best_model.resource`.

7. To load the best model weights, ensure that the `best_model.resource` file exists in the project directory.

## Configuration

The `Config.gd` file contains various configuration parameters for the AI:

- `INPUT_SIZE`: The number of input neurons in the neural network.
- `HIDDEN_SIZE`: The number of hidden neurons in the neural network.
- `OUTPUT_SIZE`: The number of output neurons in the neural network.
- `POPULATION_SIZE`: The size of the population in each generation.
- `ELITE_COUNT`: The number of elite individuals to preserve in each generation.
- `MUTATION_RATE`: The probability of mutation for each gene during reproduction.
- `PENDULUM_LENGTH`: The length of the pendulum.
- `CART_WIDTH`: The width of the cart.
- `CART_HEIGHT`: The height of the cart.
- `THRESHOLD`: The threshold angle for considering the pendulum balanced.

Modify these parameters in the `Config.gd` file to customize the AI behavior.

## Project Structure

The project is structured as follows:

- `Main.gd`: The main script that controls the overall flow of the program.
- `Config.gd`: Contains the configuration parameters for the AI.
- `Population.gd`: Handles the population management, evaluation, and evolution.
- `NeuralNetwork.gd`: Represents the neural network model.
- `FitnessEvaluator.gd`: Contains utility functions for evaluating the fitness of individuals.

## Visualization

The project includes an optional visualization feature that allows you to visualize the weights of the best individual's neural network. To enable visualization, set the `enable_visualization` flag to `true` in the editor for the main node.

When visualization is enabled, the weights of the best individual's neural network will be displayed as colored rectangles, with the color representing the weight value.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
