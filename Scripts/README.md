# Scripts

This folder contains following R scripts and files:

  * **README.md**			                                
    - This README file
  * **[process_business_types.R](process_business_types.R)**
    - Contains the "Business Type" data source that is cleaned and has the "Business.Type" column split out into multiple rows
    - Includes the id from "PB_Vendors.csv" to allow data joins
    - Will create the `PB_Vendors_Business_Types.csv` output file
  * **[cleanup_rules.json](cleanup_rules.json)**
    - A JSON configuration file that configures the path for the source data file and clean up rules/mapping
  * **[process_vendors.R](process_vendors.R)**
    - Imports the cleaned data sets with the "Commodity Codes" and "Business Type" columns not split out:
      - Creates the "Regsiter Year" column based on the "Register.Date" column
      - Cleans up City names using rules from [cleanup_rules.json](cleanup_rules.json)
      - Creates the "In.Long.Beach" column with "Yes" or "No" by checking the City column
      - Turns blanks and nulls in the "Business.Type" column into the "Not reported" indicator
      - Turns blanks and nulls in the "Commodity.Codes" column into the "Not reported" indicator
      - Creates the "id" column for each registered vendor by the observation (row) number in the data frame
      - Will create the `PB_Vendors.csv` output file with the "Business.Type" and "Commodity.Code" columns excluded
  * **[process_commodity_codes.R](process_commodity_codes.R)**
      - Contains the "Commodity Codes" data source that is cleaned and has the "Commodity.Code" column split out into multiple rows
      - Includes the id from "PB_Vendors.csv" to allow data joins
      - Will create the `PB_Commodity_Codes.csv` output file
  * **[util.R](util.R)**
    - Useful functions used by the other scripts

