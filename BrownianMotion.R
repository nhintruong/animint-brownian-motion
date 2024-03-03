library(ggplot2)
library(animint2)

# Set parameters
n_steps <- 100  # Number of steps in the simulation
sigma <- 1    # Standard deviation of the Gaussian noise
start_pos <- c(0, 0)  # Starting position (x, y)

# Function to generate data for one animation frame
generate_data <- function(i) {
  # Simulate step using independent Gaussian noise for x and y
  step <- rnorm(2, mean = 0, sd = sigma)
  # Update current position
  position <- start_pos + step
  # Create data frame
  df <- data.frame(
    Step = i,
    X = position[1],
    Y = position[2]
  )
  return(df)
}

# Generate data for animation
data_list <- lapply(seq(n_steps), generate_data)
df <- data.frame()
for(i in 1:100){
  df <- rbind(df,data_list[[i]])
}

# Create the animation
ggplot_anim <- ggplot(df, aes(x = X, y = Y,key="Step")) +
  geom_point(showSelected="Step",size = 10, color = "red") +  
  labs(title = "2D Brownian Motion Simulation",
       x = "X", y = "Y") +
  theme_bw()

(viz.duration <- animint(ggplot_anim, duration=list(Step=100)))
viz.duration.time <- viz.duration
viz.duration.time$time <- list(variable="Step", ms=100)
viz.duration.time
