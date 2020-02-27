#R Studio API Code
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#Data Import 
library(stringi)
citations <- stri_read_lines("../data/citations.txt")
citations_txt <- citations[stri_isempty(citations)==FALSE]
length(citations)-length(citations_txt)

#Data Cleaning
library(tidyverse)
library(stringr)
library(rebus)
sample(citations_txt, 10)
citations_tbl <- enframe(citations_txt, name=NULL, value="cite") %>% mutate(line=row_number()) %>%
  mutate(cite= str_remove_all(cite,pattern="\"|\'")) %>%
  mutate(year=str_extract(cite, pattern = "\\d{4}")) %>%
  mutate(page_start=str_match(cite, pattern="((\\d+)\\-(\\d+))")[,3]) %>%
  mutate(perf_ref=str_detect(cite, pattern = or("performance", "Performance", "PERFORMANCE"))) %>%
  mutate(title=str_match(cite, pattern= "\\d{4}\\)\\.\\s?([:graph:][^.(]+)")[,2]) %>%
  mutate(first_author = str_match(cite, pattern="^\\*?\\s?([:upper:][:graph:]+\\,?\\s*[:upper:]\\.?\\s*?[:upper:]?\\.?\\s*?[:upper:]?\\.)")[,2])
