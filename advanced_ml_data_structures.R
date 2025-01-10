ID <- c(1,2,3,4,5,6)
wave_size <- c(6,1,7,7,2,10)
wave_period <- c(15,6,10,12,2,2)
wind_speed <- c(5,9,4,3,10,20)
good_surf <- c("yes", "no", "yes", "yes", "no", "no")
df1 <- data.frame(ID, wave_size, wave_period, wind_speed, good_surf)
print(df1)

knitr::kable(df1, caption = 'Data for a predicting a good day for surfing.', col.names = c('ID', 'Wave Size (ft)', 'Wave Period (secs)', 'Wind Speed (MPH/hr)', 'Good to Surf'), align = "lcccl")

# Function to calculate Euclidean distance between two points
euclidean_distance <- function(x1, x2) {
  sqrt(sum((x1 - x2) ^ 2))
}

# K-nearest neighbor function using df1
knn_predict <- function(query_point, df1, k = 1) {
  # Extract the features from df1
  features <- df1[, c("wave_size", "wave_period", "wind_speed")]
  target <- df1$good_surf
  
  # Calculate distances between query point and all points in df1
  distances <- apply(features, 1, function(row) euclidean_distance(query_point, row))
  
  # Find the indices of the k nearest neighbors
  nearest_neighbors <- order(distances)[1:k]
  
  # Get the labels of the nearest neighbors
  nearest_labels <- target[nearest_neighbors]
  
  # Return the most common label (majority vote)
  prediction <- names(sort(table(nearest_labels), decreasing = TRUE))[1]
  
  return(prediction)
}

# Define query points
query_points <- data.frame(
  wave_size = c(8, 8, 6),
  wave_period = c(15, 2, 11),
  wind_speed = c(2, 18, 4)
)

# Predict the label for each query point using df1
for (i in 1:nrow(query_points)) {
  query <- query_points[i, ]
  prediction <- knn_predict(query, df1, k = 1)  # Using k = 1 (Nearest Neighbor)
  
  cat("Query", i, ": Wave Size =", query$wave_size, "ft, Wave Period =", query$wave_period, "secs, Wind Speed =", query$wind_speed, "MPH/hr \n")
  cat("Prediction (Good to Surf):", prediction, "\n\n")
}


ID <- c(1,2,3,4,5)
money <- c(3,1,0,0,0)
free <- c(0,2,0,0,1)
of <- c(0,1,1,1,0)
gambling <- c(0,1,1,0,0)
fun <- c(0,1,1,3,0)
machine <- c(0,0,0,1,1)
learning <- c(0,0,0,1,1)
spam <- c("true", "true", "true", "false", "false")
df3 <- data.frame(ID, money, free, of, gambling, fun, machine, learning, spam)
print(df3)
```
    print_kd_tree(node$left, depth + 1)
  }
  
  if (!is.null(node$right)) {
    print_kd_tree(node$right, depth + 1)
  }
}

# Print the constructed k-d tree
print_kd_tree(kd_tree)


# Function to calculate Euclidean distance between two points
euclidean_distance <- function(query, point) {
  return(sqrt((query["Size"] - point["Size"])^2 + (query["Rent"] - point["Rent"])^2))
}

# Nearest neighbor search function
find_nearest_neighbor <- function(node, query, depth = 0, best = NULL) {
  if (is.null(node)) {
    return(best)  # Return the best so far if the node is null
  }
  
  # Calculate distance between the query and the current node
  current_distance <- euclidean_distance(query, node$data)
  
  # Update best if the current node is closer
  if (is.null(best) || current_distance < euclidean_distance(query, best$data)) {
    best <- node
  }
  
  # Determine whether to go left or right in the tree
  feature <- ifelse(depth %% 2 == 0, "Rent", "Size")  # Alternate between Rent and Size
  
  # Traverse the tree
  if (query[[feature]] < node$data[[feature]]) {
    best <- find_nearest_neighbor(node$left, query, depth + 1, best)
  } else {
    best <- find_nearest_neighbor(node$right, query, depth + 1, best)
  }
  
  # Check the other side of the tree if necessary
  difference <- abs(query[[feature]] - node$data[[feature]])
  if (difference < euclidean_distance(query, best$data)) {
    if (query[[feature]] < node$data[[feature]]) {
      best <- find_nearest_neighbor(node$right, query, depth + 1, best)
    } else {
      best <- find_nearest_neighbor(node$left, query, depth + 1, best)
    }
  }
  
  return(best)
}

# Query to find nearest neighbor for
query <- data.frame(Size = 1000, Rent = 2200)

# Find nearest neighbor using the kd_tree
nearest_neighbor <- find_nearest_neighbor(kd_tree, query[1, ])

# Print the nearest neighbor found
print("Nearest Neighbor:")
print(nearest_neighbor$data)


