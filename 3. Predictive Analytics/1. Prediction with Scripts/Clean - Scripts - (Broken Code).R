#Data were collected from a number of sites including:
#http://thescriptlab.com/screenwriting-101/screenplay/download-scripts#
#http://www.dailyscript.com/movie.html

#Instead of code below use this site to convert pdf to texts

#http://pdftotext.com/


library(tm)
# folder with 1000s of PDFs
dest <- "/Users/jjespinoza/Documents/HollywoodModels/0. Data/1. Raw Data /0. TV Scripts - 2011-2015/5. 2015"
# make a vector of PDF file names
myfiles <- list.files(path = dest, pattern = "pdf",  full.names = TRUE)
# convert each PDF file that is named in the vector into a text file 
# text file is created in the same directory as the PDFs
# note that my pdftotext.exe is in a different location to yours
lapply(myfiles, function(i) system(paste('"/Users/jjespinoza/Documents/HollywoodModels/0. Data/1. Raw Data /0. TV Scripts - 2011-2015/xpdfbin-mac-3.04/bin64/pdftotext.exe"', paste0('"', i, '"')), wait = FALSE) )





