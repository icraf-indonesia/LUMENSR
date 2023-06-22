#' Prepare data for creating a Sankey plot with multiple transitions
#'
#' This function prepares a data frame for creating a Sankey plot with multiple
#' transitions. The Sankey plot represents the flow from one set of values to
#' another, where the width of the flow is proportional to its quantity.
#'
#' @author Dony Indiarto
#'
#' @param df The data frame containing the data.
#' @param col_order A vector of column names in the order of the transitions.
#' @param value_col The name of the column to use as the values of the links.
#' @return A list containing two data frames: 'nodes' and 'links'.
prepare_sankey <- function(df, col_order, value_col) {

  # Create the nodes data frame
  # The nodes are all the unique values from the columns specified in col_order
  nodes <- data.frame(name = unique(as.character(unlist(df[col_order]))))

  # Initialize the links data frame
  links <- NULL

  # Iterate over the column names in col_order
  # For each pair of consecutive columns, create a new set of links
  for(i in 1:(length(col_order)-1)) {

    # Create the new links data frame
    # 'source' is the index in the nodes data frame of the value from the current column
    # 'target' is the index in the nodes data frame of the value from the next column
    # 'value' is the value from the value_col column
    # Note: we subtract 1 from the indices because networkD3 uses 0-based indexing
    new_links <- data.frame(
      source = match(df[[col_order[i]]], nodes$name) - 1,
      target = match(df[[col_order[i+1]]], nodes$name) - 1,
      value = df[[value_col]]
    )

    # Add the new links to the links data frame
    links <- rbind(links, new_links)
  }

  # Return the nodes and links data frames
  return(list(nodes = nodes, links = links))
}
