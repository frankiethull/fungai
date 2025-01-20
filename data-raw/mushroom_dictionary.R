## code to prepare `DATASET` dataset goes here


# @@@@ retrieve mushroom link list @@@@ #

mush_url <- "https://www.mushroom.world/mushrooms/namelist"

mush_page <- rvest::read_html(mush_url)

distinct_mush_links <- mush_page |>
  rvest::html_elements("a.alist-link") |>
  rvest::html_attr("href")

# for each link, do:
get_shroom_information <- \(endpoint){

  # link builder:
  root <- "https://www.mushroom.world"
  #endpoint <- distinct_mush_links[[1]]
  shroom_url <- paste0(root, endpoint)

  shroom_html <- rvest::read_html(shroom_url)

  shroom_body <- shroom_html |>
    rvest::html_element("main")

  # information about it:
  shroom_labels <- shroom_body |>
    rvest::html_nodes("div.mush-labelus") |>
    rvest::html_text()

  shroom_values <- shroom_body |>
    rvest::html_nodes("div.mush-textus") |>
    rvest::html_text()

  shroom_description <- shroom_body |>
    rvest::html_nodes("div.mush-longtextus") |>
    rvest::html_text()

  # get the sci and common name:
  shroom_name <- shroom_body |>
    rvest::html_node("b.mush-captiontext") |>
    rvest::html_text() |>
    stringr::str_trim() |>
    stringr::str_replace_all("\\s+", " ")

  # build a long data:
  shroom_data <- data.frame(
    mushroom_name      = rep(shroom_name, length(shroom_labels)),
    category           = shroom_labels,
    information        = c(shroom_values, shroom_description)
  )

  return(shroom_data)
}


mushroom_dictionary <- purrr::map_df(distinct_mush_links, get_shroom_information)

usethis::use_data(mushroom_dictionary, overwrite = TRUE)
