#packages
library(googlesheets4)
library(tidyverse)

#Get data 
j<- read_sheet("https://docs.google.com/spreadsheets/d/1RHiKsdYIVPlScCsBkSR3lW5keFv3N-kOlPUwshgO-lM")

#pull out the type of data marked csv and split out the values by commas into two columns. Then  
datcsv <- j %>%
  filter(TypeData == "csv") %>% 
  select(Timestamp, Values) %>% 
  separate_rows(Values, sep = ", ") %>% 
  arrange((Values)) 

datcsv_distinct <- datcsv %>% 
  distinct(Values, .keep_all = TRUE)

datcsv_counts <- datcsv %>% 
  count(Values, sort = TRUE) %>% 
  arrange((Values))

# Collapse groupings that are different words for the same thing 
dat_coll <- datcsv %>% 
  mutate(Values = as.character(Values)) %>%
  mutate(Values = case_when(
    Values %in% c("creativity", "creative", "creative expression", "Creative", "Creativity") ~ "Creative",
    Values %in% c("empathy", "empathic", "empathetic", "Empathy") ~ "Empathy",
    Values %in% c("inclusive", "inclusivity", "inclusion", "Inclusive", "inclusiveness", "Inclusion", "Inclusivity", "Inclusivityness", "Inclusive community") ~ "Inclusivity",
    Values %in% c("curious", "curiosity", "Curious", "Curiosity") ~ "Curiosity",
    Values %in% c("open", "openness", "Openness to Communication", "Open") ~ "Openness",
    Values %in% c("Compassion", "Compassionate", "compassion", "compassionate") ~ "Compassionate",
    Values %in% c("interestingness", "interesting", "Interesting") ~ "Interesting",
    Values %in% c("Enthusiasm", "Enthusiastic", "enthusiasm", "enthusiastic") ~ "Enthusiastic",
    Values %in% c("helpful", "helpfulness", "Helpful") ~ "Helpful",
    Values %in% c("friendliness", "friendly", "Friendly") ~ "Friendly",
    Values %in% c("care", "Care", "caring", "Caring") ~ "Caring",
    Values %in% c("thoughtful", "Thoguhtful", "Thoughtfulness", "thoughtfulness") ~ "Thoughtful",
    Values %in% c("acceptance", "accepting", "Acceptance", "Accepting") ~ "Acceptance",
    Values %in% c("humor", "humorous", "Humor", "Humorous") ~ "Humor",
        TRUE ~ Values  # Keep original if no match
  ))


datcoll_distinct <- dat_coll %>% 
  distinct(Values, .keep_all = TRUE)

datcoll_counts <- dat_coll %>% 
  count(Values, sort = TRUE) %>% 
  arrange(desc(n))


# Create a new Google Sheet with a custom name
ss <- gs4_create("XOXOCommSurv_ValuesList")

# Write your dataframe (dat_coll) to the new sheet
sheet_write(datcoll_counts, ss = ss)

