#' remove_sub
#'
#' @description a helper function to remove "_" in the column names of a dataframe
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
remove_sub = function(df){
  df_1 = df
  vec_col_name = names(df)

  vec_col_name_new = rep(NA, length(vec_col_name))
  for (i in 1:length(vec_col_name)) {
    vec_col_name_new[[i]] =
      paste(strsplit(vec_col_name, "_")[[i]], collapse=" ")
  }
  names(df_1) = vec_col_name_new
  return(df_1)
}
