
maindir <- "C:\\Users\\kklab\\Desktop\\yurispace\\board_fluctuation\\src\\nikkei_needs_output"
year <- "\\2007\\correlation\\correlation\\"
rfilename <- paste(maindir, year, "correlation.csv", sep = "", collapse = NULL)

timespan <- c( "", "1", "2", "5", "15", "30", "60", "120", "300" )
len <- length(timespan)
for (i in 1:len) {
    
    #読み込むファイル，書き込むファイルの名前を設定する．
    if (i == 1) {
        rfilename <- paste(maindir, year, "correlation", timespan[i], ".csv", sep = "")
        wfilename <- paste(maindir, year, "statistics_summary", timespan[i], ".csv", sep = "")
        pngnamebid <- paste(maindir, year, "hist_bid", timespan[i], ".png", sep = "")
        pngnameask <- paste(maindir, year, "hist_ask", timespan[i], ".png", sep = "")
    } else {
        rfilename <- paste(maindir, year, "correlation_", timespan[i], "_.csv", sep = "")
        wfilename <- paste(maindir, year, "statistics_summary_span_", timespan[i], "_.csv", sep = "")
        pngnamebid <- paste(maindir, year, "hist_bid_span_", timespan[i], "_.png", sep = "")
        pngnameask <- paste(maindir, year, "hist_ask_span_", timespan[i], "_.png", sep = "")
    }
    
    data <- read.csv(rfilename, sep=",", header = T)
    
    #基本統計量をファイルに書き出す．
    c <- ncol(data)
    r <- nrow(data)
    summary <- matrix(0, nrow = c-1, ncol = 7) #結果書き出し用の行列
    colnames(summary) <- c("Mean", "S.D.", "Median", "Kurtosis", "Skewness", "Minimum", "Maximum")
    rownames(summary) <- colnames(data)[2:c]
    for (j in 2:c) {
        Mean <- mean(data[,j], na.rm = TRUE)
        SD <- sd(data[,j], na.rm = TRUE)
        Median <- median(data[,j], na.rm = TRUE)
        Kurtosis <- mean((data[,j] - Mean)^4, na.rm = TRUE)/(SD^4)
        Skewness <- mean((data[,j] - Mean)^3, na.rm = TRUE)/(SD^3)
        summary[j-1,] <- c(Mean, SD, Median, Kurtosis, Skewness, min(data[,j], na.rm = TRUE), max(data[,j], na.rm = TRUE))
    }
    write.csv(summary, wfilename, quote = F, row.names = T)
    
    #相関係数のヒストグラムを作成する．
    png(pngnamebid)
    hist(data[,2], n=25, 
         main = "histgram of the correlation of the series of the best bid price changes",
         xlab = "")
    dev.off()
    png(pngnameask)
    hist(data[,3], n=25, 
         main = "histgram of the correlation of the series of the best ask price changes",
         xlab = "")
    dev.off()
}

