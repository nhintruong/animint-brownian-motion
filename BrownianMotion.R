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
  temp <- numeric(40 * n)
  for (i in 1:(40 * n)) {
    if (i %% 40 == 0) {
      temp[i] <- 40
    } else {
      temp[i] <- i %% 40
    }
  }
  return(temp)
}

BrownianMotion <- function(n_balls, sigma, start_pos) {
  
  # Define a color palette based on number of balls
  colors <- rainbow(n_balls)  # Use rainbow palette for distinct colors
  
  # Generate data for animation
  n_steps <- 40 * n_balls
  df <- data.frame(X=0,Y=0)
  
  curr_pos <- start_pos
  for(i in 2:n_steps){
    if(i%%40==1)curr_pos <- start_pos
    temp <- generate_data(sigma,curr_pos)
    curr_pos <- temp
    df <- rbind(df,temp)
  }
  
Step <- rep(1:40,length.out=n_balls)
ball <- rep(1:n_balls,each=40)
df <- cbind(df,ball)
df <- cbind(Step=sequence(n_balls),df)

#Making the starting point as origin
for(i in 1:n_balls-1){
    df[1+i*40,2]=0
    df[1+i*40,3]=0
}

#Distance added
Distance <- sqrt(df[,2]^2+df[,3]^2)
df <- cbind(df,Distance)

#Naming the color as Ball number
df$ball <- as.factor(df$ball)
names(colors) <- levels(df$ball)
  
# Create the animation
ggplot_anim <- ggplot() +scale_color_manual(values=colors)+
    geom_point(aes(x = X, y = Y, color = ball,key=ball),showSelected = "Step", size = 10,data=df) +  
    labs(title = "2D Brownian Motion Simulation",
         x = "X", y = "Y") +theme_bw()
  
  # Animate the plot
(viz.duration <- animint(ggplot_anim, duration = list(Step = 300),source="https://github.com/Vatsal-Rajput/Animint2Test",title="BrownianMotion"))
  
  # Set animation time
  viz.duration.time <- viz.duration
  viz.duration.time$time <- list(variable = "Step", ms = 300)
  
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

#Second plot

ggplot_anim2 <- ggplot() +scale_color_manual(values=colors)+
  geom_point(aes(x = X, y = Y, color = ball),size = 8,clickSelects = "Step",alpha=0.7,data=df) +  
  labs(title = "Individual Step",
       x = "X", y = "Y")
(viz.scatter <- animint(ggplot_anim2,duration=list(Step=2000)))

#Time series plot

viz.timeSeries <- viz.scatter
viz.timeSeries$timeSeries <- ggplot()+
  geom_tallrect(aes(
    xmin=Step-0.5, xmax=Step+0.5),
    clickSelects="Step",
    alpha=0.3,
    data=df)+
  geom_line(aes(
    x=Step, y=Distance, group=ball, color=ball),
    clickSelects="ball",
    size=3,
    alpha=0.8,
    data=df)+scale_color_manual(values=colors)+labs(title="Time Series")
viz.timeSeries

