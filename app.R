library(shiny)
library(bslib)
library(tidyverse)

# Define the UI using a sidebar layout.
ui <- page_sidebar(
  title = "Hello Shiny!",
  sidebar = sidebar(
    sliderInput("bins", "Number of bins:", min = 5, max = 30, value = 10),
    selectInput(
      "cyl_filter",
      "Filter by cylinders:",
      choices = c("All", sort(unique(mtcars$cyl))),
      selected = "All"
    )
  ),
  plotOutput("distPlot")
)

# Define server logic to generate a histogram.
server <- function(input, output) {
  filtered_data <- reactive({
    cyl <- input$cyl_filter
    if (is.null(cyl) || cyl == "All") {
      mtcars
    } else {
      mtcars |>
        filter(cyl == as.numeric(cyl))
    }
  })

  output$distPlot <- renderPlot({
    filtered_data() |>
      ggplot(aes(x = mpg)) +
      geom_histogram(
        bins = input$bins,
        fill = "#75AADB",
        color = "white"
      ) +
      labs(
        title = "Histogram of MPG",
        x = "Miles Per Gallon",
        y = "Count"
      ) +
      theme_minimal()
  })
}

# Create and run the Shiny app.
shinyApp(ui = ui, server = server)
