commodity_codes_df <- cSplit(vendors_df,
                             "Commodity.Codes",
                             sep = "  ",
                             direction = "long",
                             stripWhite = TRUE)

# Only keep these columns in the data frame
columns_to_keep <- c("id", "Commodity.Codes")
commodity_codes_df <- subset(commodity_codes_df, select = columns_to_keep)

# Delete rows with blank values
commodity_codes_df <- drop_blanks(commodity_codes_df)

# Output CSV
output_friendly_csv(commodity_codes_df, paste(cleanup_rules$output_directory, "PB_Vendors_Commodity_Codes.csv", sep = "/"))
