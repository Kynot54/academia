# Load ggplot into memory
load(ggplot2)

# Boxplot
b1 <- c(36, 42, 100, 28, 17, 12, 9, 4, 1)

b1 <- sort(b1)

med <- median(b1)

quant <- quantile(b1)

quant

interQuantRange <- IQR(b1)

lowerFence <- (9 - 1.5*interQuantRange)

upperFence <- (36 + 1.5*interQuantRange)

mydata <- data.frame(num=b1)
ggplot(data=mydata) + geom_boxplot(mapping = aes(y=num))

# Classwork
airquality
View(airquality)

ggplot(data=airquality) + geom_boxplot(mapping = aes(y=Ozone))

ozoneSorted <- sort(airquality$Ozone)

airMean <- mean(ozoneSorted, na.rm=TRUE)

quantileAir <- quantile(ozoneSorted, na.rm=TRUE)

quantileAir

airIQR <- IQR(ozoneSorted, na.rm=TRUE) 

lowerFenceAir <- (8 - 1.5 * airIQR)
upperFenceAir <- (78 + 1.5 * airIQR)
