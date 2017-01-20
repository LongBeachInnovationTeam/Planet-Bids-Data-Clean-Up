# Split the Business.Type column split into multiple rows
business_type_df <- cSplit(vendors_df,
                           "Business.Type",
                           sep = ",",
                           direction = "long",
                           stripWhite = TRUE)

# Only keep these columns in the data frame
columns_to_keep <- c("id", "Business.Type")
business_type_df <- subset(business_type_df, select = columns_to_keep)

# Delete rows with blank values
business_type_df <- drop_blanks(business_type_df)

# Output CSV
output_friendly_csv(business_type_df, paste(cleanup_rules$output_directory, "PB_Vendors_Business_Types.csv", sep = "/"))
