#' Replace Column Values with Shorter Version
#'
#' This function shortens the character column values in a data frame by removing vowels after the first character,
#' and also provides an option to disable this vowel removal. It replaces spaces with underscores and removes characters after a slash.
#' If no column names are provided, the function attempts to find and use the first character column in the data frame.
#'
#' @param df A data frame.
#' @param col_names A character vector specifying the names of the columns to be abbreviated.
#' If NULL (default), the function attempts to use the first character column.
#' @param remove_vowels A logical value indicating whether to remove vowels from column values after the first character. Default is FALSE.
#' @importFrom textclean replace_non_ascii
#' @return A data frame with specified columns abbreviated.
#' @export
#'
#' @examples
#' df <- data.frame(
#'   col1 = c("Hutan lahan kering sekunder / bekas tebangan", "Savanna / Padang rumput"),
#'   col2 = c("Hutan lahan kering sekunder", "Savanna"),
#'   stringsAsFactors = FALSE
#' )
#' abbreviate_by_column(df, c("col1", "col2"), remove_vowels=TRUE)
abbreviate_by_column <- function(df, col_names = NULL, remove_vowels= FALSE) {

  # Check if df is a data frame
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  # Check if df has at least one column
  if(ncol(df) < 1) {
    stop("df must have at least one column")
  }

  # If col_names is NULL, find the first character column
  if(is.null(col_names)) {
    col_names <- names(df)[which(sapply(df, is.character))[1]]
  }

  # Check if the provided col_names exist in df
  if(!all(col_names %in% names(df))) {
    stop("Some column names provided are not columns in df")
  }

  # Define the abbreviation function
  abbreviate_string <- function(input_string, remove_vowels = FALSE) {

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

  # Apply the abbreviation function to the selected columns
  for (col_name in col_names) {
    df[[col_name]] <- unlist(lapply(df[[col_name]], abbreviate_string))
  }

  return(df)
}
