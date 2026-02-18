# Carreguem els paquets necessaris
library(shiny)
library(survival)
library(ggplot2)
# Carreguem el conjunt de dades "heart"
data("heart")
# Definim la interfície de l'aplicació Shiny
ui <- fluidPage(
    titlePanel("Conjunt de dades heart"),
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "x", "Seleccioneu la variable X:",
                choices = colnames(heart)
            ),
            selectInput(
                "y", "Seleccioneu la variable Y:",
                choices = colnames(heart)
            ),
            selectInput(
                "plot_type", "Seleccioneu el tipus de gràfic:",
                choices = c(
                    "Gràfic de dispersió" = "scatter",
                    "Línies" = "lines",
                    "Histograma" = "histogram"
                )
            ),
            hr()
        ),
        mainPanel(
            # Dibuixem el gràfic seleccionat
            plotOutput("plot")
        )
    )
)
# Definim la lògica de l'aplicació Shiny
server <- function(input, output) {
    # Creem el gràfic
    output$plot <- renderPlot({
        x <- input$x
        y <- input$y
        plot_type <- input$plot_type
        if (plot_type == "scatter") {
            ggplot(heart, aes(x = .data[[x]], y = .data[[y]])) +
                geom_point() +
                xlab(x) +
                ylab(y) +
                ggtitle("Gràfic de Dispersió")
        } else if (plot_type == "lines") {
            ggplot(heart, aes(x = .data[[x]], y = .data[[y]], group = 1)) +
                geom_line() +
                xlab(x) +
                ylab(y) +
                ggtitle("Gràfic de Línies")
        } else {
            if (is.numeric(heart[[x]])) {
                ggplot(heart, aes(x = .data[[x]])) +
                    geom_histogram(fill = "blue", color = "black", bins = 30) +
                    xlab(x) +
                    ylab("Freqüència") +
                    ggtitle("Histograma")
            } else {
                ggplot(heart, aes(x = .data[[x]])) +
                    geom_bar(fill = "blue", color = "black") +
                    xlab(x) +
                    ylab("Freqüència") +
                    ggtitle("Gràfic de Barres (variable categòrica)")
            }
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
