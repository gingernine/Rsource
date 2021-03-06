
maindir <- "C:\\Users\\kklab\\Desktop\\yurispace\\board_fluctuation\\src\\nikkei_needs_output"
year <- "\\2007\\correlation\\time_span\\"

timespan <- c( "", "1", "2", "5", "15", "30", "60", "120", "300" )
filename <- c( "datasize_bid.csv", "datasize_ask.csv" )
len <- length(filename)
for (i in 1:len) {
    
    #読み込むファイル，書き込むファイルの名前を設定する．
    rfilename <- paste(maindir, year, filename[i], sep = "")
    wfilename <- paste(maindir, year, "statistics_summary_", filename[i], ".csv", sep = "")
    pngname <- paste(maindir, year, "hist_", filename[i], sep = "")
    pngnameask <- paste(maindir, year, "hist_ask", timespan[i], ".png", sep = "")
    
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

        #ヒストグラムを作成する．
        pngname <- paste(maindir, year, "hist_", filename[i], timespan[j], ".png", sep = "")
        png(pngname)
        hist(data[, j], n=25, 
             main = paste("histgram of the size of data of timespan", timespan[j], sep = "_"),
             xlab = "")
        dev.off()
    }
    write.csv(summary, wfilename, quote = F, row.names = T)
}

