
# dictionary tool ----
check_dictionary_for_keyword <- function(keyword = "yellow cap"){
fungai::mushroom_dictionary |>
  dplyr::filter(stringr::str_detect(information, keyword))
}

check_dictionary_tool <- ellmer::tool(
  check_dictionary_for_keyword,
  "checks the mushroom dictionary for any keyword(s) or phrases.",
  keyword = ellmer::type_string(
    "'keyword' is a string like 'yellow cap', can include regex."
  )
)

# image tool ----
check_for_image_and_encode <- function(prompt = "this is a prompt"){
  stringr::str_extract(prompt, "\\S+\\.(png|jpg|jpeg)") |>
  ellmer::content_image_file()
}

check_image_tool <- ellmer::tool(
  check_for_image_and_encode,
  "checks the prompt for an image, if one exists encode it.",
  prompt = ellmer::type_string(
    "'prompt' is any question recieved, check for an image path."
  )
)
