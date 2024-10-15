
#Appreciation Script 

#Get data 
df <- read_sheet("https://docs.google.com/spreadsheets/d/1jPKow4_vQ8CMUBfIYf_SyXNC-6hJNsg1AP0zcS-pOiY/edit?gid=523732956#gid=523732956", sheet = "Appr")

#split out the codes and duplicate Appreciate_Answ

df_cleaned <- df %>%
  separate_rows(Codes, sep = ", ")  # Separate the 'Codes' column into multiple rows

# Assuming your dataframe is called df_cleaned after running separate_rows
df_final <- df_cleaned %>%
  # Remove rows where Appreciate_Answ or Codes are empty or NA
  filter(!is.na(Appreciate_Answ) & Appreciate_Answ != "") %>%
  # Arrange the dataframe by the 'Codes' column
  arrange(Codes)


# Create a new Google Sheet with a custom name
ss <- gs4_create("XOXOCommSurv_Appreciate")

# Write your dataframe (dat_coll) to the new sheet
sheet_write(df_final, ss = ss)

