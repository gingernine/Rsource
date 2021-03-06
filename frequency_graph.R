# 変動回数を計算する

maindir <- "C:\\Users\\kklab\\Desktop\\yurispace\\integration_cpp\\source"
datayear <- "\\2007"
unit <- 10

filepath <- paste(maindir, datayear, "\\Expectations_", unit, "pieces.csv", sep="", collapse=NULL)
data <- read.csv(filepath, header=T)

par(lwd = 2)
plot(1:length(data[,1]), 60/data[,2], pch=3, ylim=c(0,6), cex=2, cex.lab=2,
     xlab = "o: actual data,  +: predicted data",
     ylab = "move frequency per minute")
par(new=T)
plot(1:length(data[,1]), 60*data[,5]/data[,3], ylim=c(0,6), pch=1, cex=1,
     xlab="", ylab="")

###########################発表資料#########################################
par(lwd = 2, mar=c(5, 6, 4, 2))
plot(1:length(data[,1]), 60/data[,2], pch=3, ylim=c(0,6), col=2, cex=2, cex.main=4, cex.lab=4,
     cex.axis=3, cex.lab=3,
     main = "", xlab="時系列", ylab="変動回数/分")
text(x=100, y=6, cex=4, label = "黒: 実測値")
text(x=100, y=5, cex=4, label="赤: 期待値", col=2)
par(new=T)
plot(1:length(data[,1]), 60*data[,5]/data[,3], ylim=c(0,6), col=1, pch=1, cex=1,
     xlab="", ylab="")
############################################################################

prd <- 60/data[-255,2]
act <- 60*data[-255,5]/data[-255,3]
sqrt(sum((prd - act)^2)/length(prd)) # RMSE
mean(abs(prd - act)/act)
sd(abs(prd - act)/act)

n <- 0
for (i in 1:nrow(data)) {
    if (data[i, 2]==Inf) {
        n <- n+1
    }
}

noninf <- matrix(0, nrow=(nrow(data)-n), ncol=ncol(data))
p <- 1
for (i in 1:nrow(data)) {
    if (data[i, 2]==Inf) {
        next
    }
    for(j in 1:ncol(data)) {
        noninf[p, j] <- data[i, j]
    }
    p <- p+1
}

prd <- 60/noninf[,2]
act <- 60*noninf[,5]/noninf[,3]
sqrt(sum((prd - act)^2)/length(prd)) # RMSE
mean(abs(prd - act)/act)
sd(abs(prd - act)/act)

