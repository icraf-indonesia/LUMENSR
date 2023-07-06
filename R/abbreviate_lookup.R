#' Abbreviate a column of a lookup table
#'
#' This function takes a data frame (df) and the name of a column (col_name) as input, and returns a modified
#' version of the data frame with an additional `abbr` column containing the abbreviated versions of the text
#' in the specified column.
#' The abbreviation is done by removing vowels from the words, except if the vowel is the first character of the word.
#' If no column name is specified, the function will use the first character column in the data frame.
#' If the input data frame does not have at least one column, or if the specified column does not exist or
#' is not a character column, the function will stop and return an error message.
#'
#' @param df A data frame that is used as a lookup table. Must have at least one column.
#' @param col_name The name of the column to abbreviate. If NULL, the first character column is used.
#' @param remove_vowels Remove vowels from words to make it shorter, TRUE/FALSE
#'
#' @return A tibble with an additional `abbr` column containing the abbreviated versions of the text
#' in the specified column.
#'
#' @importFrom dplyr mutate
#' @importFrom stringr str_detect
#' @importFrom textclean replace_non_ascii
#' @export
abbreviate_lookup <- function(df, col_name = NULL, remove_vowels = FALSE) {

  # Check if df is a data frame
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  # Check if df has at least one column
  if(ncol(df) < 1) {
    stop("df must have at least one column")
  }

  # If col_name is NULL, find the first character column
  if(is.null(col_name)) {
    col_name <- names(df)[which(sapply(df, is.character))[1]]
  }

  # Check if the provided col_name exists in df
  if(!(col_name %in% names(df))) {
    stop("col_name is not a column in df")
  }

  # Check if col_name is a character column
  if(!is.character(df[[col_name]])) {
    stop("col_name must be a character column")
  }

  # Define the abbreviation function
  abbreviate_string <- function(input_string, remove_vowels = remove_vowels) {

    # Remove characters after the slash, if any
    string <- textclean::replace_non_ascii(input_string)
    string <- strsplit(string," / ")[[1]][1]


    if(remove_vowels == TRUE){
    # Replace spaces with underscores
    string <- gsub(" ", "_", string)

    # Split string into words
    words <- strsplit(string, "_")[[1]]

    # Abbreviate each word by removing the vowels (but keep the first character even if it's a vowel)
    words <- sapply(words, function(word) {
      ifelse(grepl("^[aeiouAEIOU]", word),
             paste0(substr(word, 1, 1), gsub("[aeiouAEIOU]", "", substr(word, 2, nchar(word)))),
             gsub("[aeiouAEIOU]", "", word)
      )
    })

    # Combine words back into a single string
    string <- paste(words, collapse = "_")
    }

    return(string)
  }

  # Apply the abbreviation function to the selected column
  df$abbr <- unlist(lapply(df[[col_name]], abbreviate_string))

  return(df)
}
