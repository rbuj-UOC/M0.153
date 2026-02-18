library(shiny)
library(Biostrings)
# Definim la interfície de l'aplicació shiny
ui <- fluidPage(
    titlePanel("Comptador d'Ocurrències de Patrons d'ADN"),
    sidebarLayout(
        sidebarPanel(
            textInput("secuencia", "Introduïu una seqüència d'ADN:"),
            textInput("patron", "Introduïu el patró a buscar:"),
            actionButton("comptador", "Comptar ocurrències"),
            br(),
            verbatimTextOutput("resultat")
        ),
        mainPanel()
    )
)
# Definim la lògica de l'aplicació Shiny
server <- function(input, output) {
    output$resultat <- renderPrint({
        req(input$comptador)
        isolate({
            # Obtenim la seqüència d'ADN introduïda
            adn_sequencia <- DNAString(input$secuencia)
            # Obtenim el patró introduït
            patro <- DNAString(input$patron)
            # Comptem les ocurrències del patró a la seqüència
            comptador <- countPattern(patro, adn_sequencia)
            # Retornem el resultat
            paste("Nombre d'ocurrències:", comptador)
        })
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
