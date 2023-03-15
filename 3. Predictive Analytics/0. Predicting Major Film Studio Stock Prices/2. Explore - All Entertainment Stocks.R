

plots <- function(x) {
        plot(stocks[[x]], type = 'l', col="red",
        ylab = "Stock Price", xlab = "Date", 
        main = paste0(tickers[[x]], " Stock Price"))
        print(tickers[[x]]); summary(stocks[[x]])
        
}

summary <- sapply(seq(1:length(tickers)), plots)
colnames(summary) <- tickers
