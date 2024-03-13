library(ggplot2)
library(animint2)

# Function to generate data for one animation frame 
generate_data <- function(sigma, curr_pos){
  # Simulate step using independent Gaussian noise for x and y
  step <- rnorm(2, mean = 0, sd = sigma)
  # Update current position
  position <- curr_pos + step
  return(c(position[1],position[2]))
}

sequence <- function(n) {
  temp <- numeric(100 * n)
  for (i in 1:(100 * n)) {
    if (i %% 100 == 0) {
      temp[i] <- 100
    } else {
      temp[i] <- i %% 100
    }
  }
  return(temp)
}

BrownianMotion <- function(n_balls, sigma, start_pos) {
  
  # Define a color palette based on number of balls
  colors <- rainbow(n_balls)  # Use rainbow palette for distinct colors
  
  # Generate data for animation
  n_steps <- 100 * n_balls
  df <- data.frame(X=0,Y=0)
  
  curr_pos <- start_pos
  for(i in 2:n_steps){
    if(i%%100==1)curr_pos <- start_pos
    temp <- generate_data(sigma,curr_pos)
    curr_pos <- temp
    df <- rbind(df,temp)
  }
  
  Step <- rep(1:100,length.out=n_balls)
  ball <- rep(1:n_balls,each=100)
  df <- cbind(df,ball)
  df <- cbind(Step=sequence(n_balls),df)
  # Assign colors based on ball index (repeating pattern)
  ball_index <- rep(seq(1:n_balls), each = n_steps / n_balls)
  ball_colors <- colors[ball_index]
  
  #Making the starting point as origin
  for(i in 1:n_balls-1){
    df[1+i*100,2]=0
    df[1+i*100,3]=0
  }
  
  # Create the animation
  ggplot_anim <- ggplot(df, aes(x = X, y = Y, color = ball_colors,key=ball)) +
    geom_point(showSelected = "Step", size = 10) +  
    labs(title = "2D Brownian Motion Simulation",
         x = "X", y = "Y") +
    theme_bw()
  
  # Animate the plot
  (viz.duration <- animint(ggplot_anim, duration = list(Step = 200),source="https://github.com/Vatsal-Rajput/Animint2Test",title="BrownianMotion"))
  
  # Set animation time
  viz.duration.time <- viz.duration
  viz.duration.time$time <- list(variable = "Step", ms = 200)
  
  # Return the animated plot
  return(viz.duration.time)
}

# Example usage
# Set parameters
n_balls <- 5
sigma <- 0.5
start_pos <- c(0, 0)

# Create and display the animation
animation <- BrownianMotion(n_balls, sigma, start_pos)
animation
