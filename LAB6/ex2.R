# Carreguem els paquets necessaris
library(shiny)
library(ggplot2)
library(dplyr)
# Carreguem el conjunt de dades per defecte
if (file.exists("data.csv")) {
    dataset <- read.csv("data.csv")
} else if (file.exists("LAB6/data.csv")) {
    dataset <- read.csv("LAB6/data.csv")
} else {
    stop("No s'ha trobat el fitxer de dades.")
}
# Definim la interfície de l'aplicació shiny
ui <- fluidPage(
    titlePanel("Explorador de conjunt de dades"),
    sidebarLayout(
        sidebarPanel(
            selectInput("x", "Seleccioneu la variable X:",
                choices = names(dataset), selected = names(dataset)[1]
            ),
            selectInput("y", "Seleccioneu la variable Y:",
                choices = names(dataset), selected = names(dataset)[2]
            ),
            selectInput(
                "plot_type",
                "Seleccioneu el tipus de gràfic:",
                c("scatterplot", "barplot", "boxplot", "histogram")
            ),
            actionButton("show_summary", "Resum estadístic")
        ),
        mainPanel(
            uiOutput("compatibility_box"),
            plotOutput("plot"),
            verbatimTextOutput("summary_text")
        )
    )
)
#  Definim la lògica de l'aplicació shiny
server <- function(input, output, session) {
    data <- reactive({
        dataset
    })

    compatibility_reason <- reactive({
        req(data(), input$x, input$plot_type)

        x_is_numeric <- is.numeric(data()[[input$x]])
        y_is_numeric <- if (!is.null(input$y) && nzchar(input$y)) {
            is.numeric(data()[[input$y]])
        } else {
            FALSE
        }

        if (input$plot_type == "scatterplot" && (!x_is_numeric || !y_is_numeric)) {
            return("El scatterplot requereix variables numèriques tant a X com a Y.")
        }

        if (input$plot_type == "histogram" && !x_is_numeric) {
            return("L'histograma requereix una variable numèrica a X.")
        }

        if (input$plot_type == "boxplot" && !y_is_numeric) {
            return("El boxplot requereix una variable numèrica a Y.")
        }

        NULL
    })

    output$compatibility_box <- renderUI({
        reason <- compatibility_reason()
        if (is.null(reason)) {
            return(NULL)
        }

        div(
            style = "border: 1px solid #f1c40f; background-color: #fff8e1; padding: 12px; border-radius: 6px; margin-bottom: 12px;",
            strong("Incompatibilitat de variables per al tipus de gràfic seleccionat."),
            p(reason, style = "margin: 8px 0 4px 0;"),
            p("Per a més informació, consulteu el resum estadístic de les variables.", style = "margin: 0;")
        )
    })

    output$plot <- renderPlot({
        req(data())
        validate(need(is.null(compatibility_reason()), compatibility_reason()))

        if (input$plot_type == "scatterplot") {
            ggplot(data(), aes(x = .data[[input$x]], y = .data[[input$y]])) +
                geom_point()
        } else if (input$plot_type == "barplot") {
            ggplot(data(), aes(x = .data[[input$x]])) +
                geom_bar()
        } else if (input$plot_type == "boxplot") {
            ggplot(data(), aes(x = .data[[input$x]], y = .data[[input$y]])) +
                geom_boxplot()
        } else if (input$plot_type == "histogram") {
            ggplot(data(), aes(x = .data[[input$x]])) +
                geom_histogram()
        }
    })
    output$summary_text <- renderPrint({
        req(data())
        if (input$show_summary > 0) {
            summary(data())
        }
    })
}
# Executem l'aplicació shiny
shinyApp(
    ui = ui,
    server = server,
    options = list(
        launch.browser = TRUE
    )
)
