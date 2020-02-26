#R Studio API Code
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#Data Import 
library(stringi)
citations <- stri_read_lines("../data/citations.txt")
citations_txt <- citations[stri_isempty(citations)==FALSE]
length(citations)-length(citations_txt)

