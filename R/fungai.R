#' fungai
#' @description
#' the basic method to talk to fungai
#'
#' @param llm_model a llm model
#' @param prompt    a prompt for the model
#' @param ...       pass thru for chat

#' @returns fungai responses
#' @export
fungai <- \(llm_model = "llama3.2-vision",
            prompt    = "hello, fungai!! tell me something about morels!"){


  fungai_prompt <- system.file("prompts", "fungai-prompt.md", package = "fungai") |>
                   base::readLines() |>
                   base::paste(collapse = "\n")

chat <-  ellmer::chat_ollama(
         system_prompt = fungai_prompt,
         model         = llm_model,
         api_args = list(temperature = 1)
         )

  chat$chat(prompt)

}
