library(shiny)
library(bslib)

# Define the UI using a sidebar layout.
ui <- page_sidebar(
  title = "Hello Shiny!",
  sidebar = sidebar(
    sliderInput("bins", "Number of bins:", min = 5, max = 30, value = 10)
  ),
  plotOutput("distPlot")
)

# Define server logic to generate a histogram.
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x <- mtcars$mpg
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         main = "Histogram of MPG", xlab = "Miles Per Gallon")
  })
}

# Create and run the Shiny app.
shinyApp(ui = ui, server = server)