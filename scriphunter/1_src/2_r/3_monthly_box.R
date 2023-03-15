library(XML) #used to parse out HTML pages
library(lubridate) #used for date manipulation


# Step 1: construct URLs
# Extract current month & current year to includ in url

month <- as.character(month(Sys.Date()))
year <- as.character(year(Sys.Date()))

urls <- paste("http://www.boxofficemojo.com/monthly/?view=releasedate&yr=", year, "&month=", month, sep = "")

#Step 2: extracting HTML table of interest
df <- as.data.frame(readHTMLTable(urls)[[4]],stringsAsFactors=FALSE)

#Step 3: Adding the variables names to data frame
names(df) <- c("rank", "movie", "studio", "total_gross", "total_theatres", "opening_gross", "opening_theatres", "open_date", "close_date")
df <- df[-1,]

# Step 4: Removing special characters from numerical fields
clean_df <- function(df) {
        clean <- function(col) {
                col <- gsub("$", "", col, fixed = TRUE)
                col <- gsub("%", "", col, fixed = TRUE)
                col <- gsub(",", "", col, fixed = TRUE)
                col <- gsub("^", "", col, fixed = TRUE)
                return(col)
        }     
        df <- sapply(df, clean)
        df <- as.data.frame(df, stringsAsFactors=FALSE)
        return(df)
}
df <- clean_df(df)        

# Step 4: set variable type for processing/filtering
s <- c(1, 4, 5, 6, 7)
df[, s] <- sapply(df[, s], as.numeric)

#Step 5: filtering films that made less than 1 million (?: check with Miguel if this is right number)
df <- df[df[, "total_gross"] > 1000000, ]

#Step 6: deleting rows with rank missing (this is false data)
df <- df[!is.na(df$rank),]

#Last Step: saving dataset to locally
write.csv(df, paste0("/Users/jje/Documents/00__mytools/3_mojo/2_data/1_raw/3_monthly_box", year, "_", month, ".csv"), row.names = FALSE)

