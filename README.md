# Brownian Motion Simulation in R

This repository contains code to simulate 2D Brownian motion and visualize it as an animation using the `ggplot2` and `animint2` libraries in R.

## Brownian Motion

Brownian motion describes the random movement of particles suspended in a fluid due to collisions with microscopic molecules of the fluid. This code simulates this motion for multiple particles.

## Functionality

The provided R script (`BrownianMotion.R`) offers a function `BrownianMotion` that:

* Simulates Brownian motion for a specified number of particles (`n_balls`).
* Defines a random starting position (`start_pos`) for the particles.
* Sets the standard deviation (`sigma`) of the random walk steps.
* Generates an animation using `ggplot2` and `animint2` to visualize the particle trajectories.

## Usage

1. **Clone the repository:**

```bash
git clone [https://github.com/your-username/brownian-motion-animation.git](https://github.com/your-username/brownian-motion-animation.git)
```
2. **Installation**

Make sure you have the following R packages installed: `ggplot2`, `animint2`, and `rnorm`. You can install them using the following command in your R console:

```R
install.packages(c("ggplot2", "animint2", "rnorm"))
```
3. **Run the simulation:**

## Customization
You can modify the number of particles (n_balls), standard deviation (sigma), and starting position (start_pos) within the BrownianMotion function to achieve different simulation behaviors.

## Dependencies
* ggplot2: For creating the animation plot.
* animint2: For animating the plot.
* rnorm: For generating random numbers from a normal distribution.

## Contributing
This README file provides clear instructions, explains the functionality, and encourages contributions.
