# Import CSV
vendors_df <- read.csv(cleanup_rules$source_data_file_path,
                       header = TRUE,
                       sep = ",",
                       quote = "\"",
                       skip = cleanup_rules$source_data_skip_lines)

# Extract the year registered into its own column
vendors_df$Register.Year <- format(as.Date(vendors_df$Register.Date, "%m/%d/%y"), "%Y")

# Clean up City names
sanitized_city_keys <- names(cleanup_rules$sanitize_city)
sanitized_city_values <- unlist(cleanup_rules$sanitize_city, use.names = FALSE)

vendors_df$City <- sapply(vendors_df$City, function (c) {
  cleaned_city_name <- tolower(c)
  cleaned_city_name <- remove_excess_whitespace(cleaned_city_name)
  cleanup_rule_index <- match(cleaned_city_name, sanitized_city_keys)
  if (!is.na(cleanup_rule_index) && cleanup_rule_index > -1) {
    cleaned_city_name <- sanitized_city_values[cleanup_rule_index]
  }
  cleaned_city_name <- capitalize_first_letter(cleaned_city_name)
  return (cleaned_city_name)
})

# Add a column to easily filter for businesses that are in Long Beach
vendors_df$In.Long.Beach <- sapply(vendors_df$City, function (c) {
  if (!is.na(c) && tolower(c) == "long beach") {
    return ("Yes")
  }
  else {
    return ("No")
  }
})

# Clean up Business.Type
vendors_df$Business.Type <- sapply(vendors_df$Business.Type, function (business_type) {
  business_type <- remove_excess_whitespace(business_type)
  if (is.na(business_type) || !is.na(as.numeric(business_type)) || business_type == "") {
    business_type <- "None or not reported"
  }
  return (business_type)
})

# Clean up Commodity.Codes
vendors_df$Commodity.Codes <- sub("^$", "None or not reported", vendors_df$Commodity.Codes)

# Save the row number as a new column named id.
# This will be used to join the main vendors export file with 
# the Commodity Codes and Business Types export files.
vendors_df$id <- 1:nrow(vendors_df)

# Drop the "Business.Type" and "Commodity.Codes" columns since theses will
# be normalized into seperate files
output_vendors_df <- subset(vendors_df, select = -c(Business.Type, Commodity.Codes))

#Export to CSV
output_friendly_csv(output_vendors_df, paste(cleanup_rules$output_directory, "PB_Vendors.csv", sep = "/"))
