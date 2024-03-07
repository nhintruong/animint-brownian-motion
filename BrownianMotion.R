BrownianMotion <- function(n_balls, sigma, start_pos) {
  
  # Define a color palette based on number of balls
  colors <- rainbow(n_balls)  # Use rainbow palette for distinct colors
  
  # Generate data for animation
  n_steps <- 100 * n_balls
  data_list <- lapply(seq(n_steps), generate_data, sigma = sigma, start_pos = start_pos)
  df <- do.call(rbind, data_list)
  ball <- rep(1:n_balls,each=100)
  
  # Assign colors based on ball index (repeating pattern)
  ball_index <- rep(seq(1:n_balls), each = n_steps / n_balls)
  ball_colors <- colors[ball_index]
  
  # Create the animation
  ggplot_anim <- ggplot(df, aes(x = X, y = Y, color = ball_colors,key=ball)) +
    geom_point(showSelected = "Step", size = 10) +  
    labs(title = "2D Brownian Motion Simulation",
         x = "X", y = "Y") +
    theme_bw()
  
  # Animate the plot
  (viz.duration <- animint(ggplot_anim, duration = list(Step = 100)))
  
  # Set animation time
  viz.duration.time <- viz.duration
  viz.duration.time$time <- list(variable = "Step", ms = 100)
  
  # Return the animated plot
  return(viz.duration.time)
}

# Function to generate data for one animation frame 
generate_data <- function(i, sigma, start_pos) {
  # Simulate step using independent Gaussian noise for x and y
  step <- rnorm(2, mean = 0, sd = sigma)
  # Update current position
  position <- start_pos + step
  # Create data frame
  df <- data.frame(
    Step = i%%100,
    X = position[1],
    Y = position[2]
  )
  return(df)
}

# Example usage
# Set parameters
n_balls <- 5
sigma <- 0.1
start_pos <- c(0, 0)

# Create and display the animation
animation <- BrownianMotion(n_balls, sigma, start_pos)
animation
