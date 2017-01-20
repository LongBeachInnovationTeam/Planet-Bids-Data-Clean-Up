capitalize_first_letter <- function (str) {
  s <- strsplit(str, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2), sep = "", collapse = " ")
}

remove_excess_whitespace <- function (str) {
  return (gsub("\\s+", " ", str))
}

output_friendly_csv <- function (df, output_dir) {
  friendly_column_names <- gsub(".", " ", names(df), fixed = TRUE)
  write.table(df,
              file = output_dir,
              sep = ",",
              eol = "\r\n",
              row.names = FALSE,
              col.name = friendly_column_names,
              qmethod="double")
}

drop_blanks <- function (df) {
  return (df[!apply(df, 1, function(x) any(x == "")), ])
}