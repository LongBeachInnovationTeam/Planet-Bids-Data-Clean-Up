# Load dependencies
if (!require("pacman")) install.packages("pacman")
pacman::p_load(rjson, splitstackshape)

# Import useful functions
source("Scripts/util.R")

# Read in script configuration and cleanup rules
cleanup_config_json <- paste(readLines("Scripts/cleanup_rules.json"), collapse = "")
cleanup_rules <- fromJSON(cleanup_config_json)

source("Scripts/process_vendors.R")
source("Scripts/process_business_types.R")
source("Scripts/process_commodity_codes.R")