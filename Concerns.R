#Concerns Script 

#Get data 
p <- read_sheet("https://docs.google.com/spreadsheets/d/1jPKow4_vQ8CMUBfIYf_SyXNC-6hJNsg1AP0zcS-pOiY/edit?gid=523732956#gid=523732956", sheet = "Concern")

#split out the codes and duplicate Concerns

p_cleaned <- p %>%
  separate_rows(Codes, sep = ", ")  # Separate the 'Codes' column into multiple rows

# Assuming your dataframe is called p_cleaned after running separate_rows
p_final <- p_cleaned %>%
  # Remove rows where Concerns or Codes are empty or NA
  filter(!is.na(Concerns) & Concerns != "") %>%
  # Arrange the dataframe by the 'Codes' column
  arrange(Codes)


# Create a new Google Sheet with a custom name
ss <- gs4_create("XOXOCommSurv_Concerns")

# Write your dataframe (dat_coll) to the new sheet
sheet_write(p_final, ss = ss)