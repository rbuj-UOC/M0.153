# Carreguem les biblioteques necessàries
library(shiny)
library(ggplot2)
# Carreguem un conjunt de dades d'exemple (en aquest cas, Iris)
data("iris")
# Definim la interfície de l'aplicació Shiny
ui <- fluidPage(
    titlePanel("Explorador de Dades amb Gràfics"),
    sidebarLayout(
        sidebarPanel(
            # Selector de variables x
            selectInput(
                "x",
                "Seleccioneu la variable X:",
                choices = colnames(iris)
            ),
            # Selector de tipus de gràfic
            selectInput(
                "plot_type",
                "Seleccioneu el tipus de gràfic:",
                choices = c("Bar Plot", "Box Plot")
            )
        ),
        mainPanel(
            # Gràfic resultant
            plotOutput("output_plot")
        )
    )
)
# Definim la lògica de l'aplicació Shiny
server <- function(input, output) {
    # Creeu el gràfic seleccionat
    output$output_plot <- renderPlot({
        x <- input$x
        data <- iris
        if (input$plot_type == "Bar Plot") {
            ggplot(data, aes(x = .data[[x]])) +
                geom_bar() +
                xlab(x) +
                ylab("Frequency")
        } else if (input$plot_type == "Box Plot") {
            ggplot(data, aes(x = .data[[x]], y = .data[["Sepal.Length"]])) +
                geom_boxplot() +
                xlab(x) +
                ylab("Sepal Length")
        }
    })
}
# Executem l'aplicació Shiny
shinyApp(
    ui = ui,
    server = server,
    options = list(
        launch.browser = TRUE
    )
)
