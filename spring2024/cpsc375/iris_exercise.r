# Dataset
iris

iris[1,10,]

# Dataframe
iris$Sepal.Length

# Mean of Sepal Length
mean(iris$Sepal.Length)

#rows <- which(iris$Sepal.Length > 7.6)
#iris[rows]

iris[iris$Sepal.Length > 7.6,]

iris[iris$Sepal.Length > 3.0 & iris$Species == "setosa",]

m <- max(iris$Sepal.Length)
m
r <- which(iris$Sepal.Length == m)
r
iris[r,"Species"]

