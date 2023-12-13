library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(ggplot2)
library(DT)
library(plotly)

# Crear la interfaz de usuario
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Desempleo y Género en Latinoamérica y el Caribe",
                  titleWidth = 500),
  
  dashboardSidebar(
    width = 500,
    sidebarMenu(
      menuItem("Gráficos y Tabla", tabName = "graficos_tabla", icon = icon('chart-column'))
    )
  ),
  
  dashboardBody(
    align = "center",
    
    # Tab para gráficos y tabla
    tabItem(
      tabName = "graficos_tabla",
      fluidRow(
        column(12,
               titlePanel("Visualizador de gráficos")
        )
      ),
      fluidRow(
        tags$div(style = "margin-bottom: 20px;"),  # Espacio entre filas
        column(12)  # Espacio adicional si es necesario
      ),
      fluidRow(
        column(3, offset = 1, align = "center",
               selectInput(inputId = "VariableX", 
                           label = "Selecciona la variable para el eje X", 
                           choices = c("empleadoras_mujeres", "empleadores_hombres", "empleo_agricultura_mujeres", "empleo_agricultura_hombres", "empleo_industria_mujeres", "empleo_industria_hombres", "empleo_servicios_mujeres", "empleo_servicios_hombres", "empleo_informal_mujeres", "empleo_informal_hombres", "legislacion_acoso_sexual", "autoempleo_mujeres", "autoempleo_hombres", "empleo_parcial_mujeres", "desempleo_educacion_mujeres", "desempleo_educacion_hombres", "desempleo_mujeres", "desempleo_hombres", "trabajo_domestico_no_remunerado_mujeres", "trabajo_domestico_no_remunerado_hombres")
               )
        ),
        column(3, offset = 1, align = "center", 
               selectInput(inputId = "VariableY", 
                           label = "Selecciona la variable para el eje Y", 
                           choices = c("empleadoras_mujeres", "empleadores_hombres", "empleo_agricultura_mujeres", "empleo_agricultura_hombres", "empleo_industria_mujeres", "empleo_industria_hombres", "empleo_servicios_mujeres", "empleo_servicios_hombres", "empleo_informal_mujeres", "empleo_informal_hombres", "legislacion_acoso_sexual", "autoempleo_mujeres", "autoempleo_hombres", "empleo_parcial_mujeres", "desempleo_educacion_mujeres", "desempleo_educacion_hombres", "desempleo_mujeres", "desempleo_hombres", "trabajo_domestico_no_remunerado_mujeres", "trabajo_domestico_no_remunerado_hombres")
               )
        ),
        column(3, offset = 1, align = "center",
               actionButton("enter_scatter", "Generar gráfico de dispersión")
        )
      ),
      plotlyOutput("scatter_plot"),
      
      fluidRow(
        tags$div(style = "margin-bottom: 20px;"),  # Espacio entre filas
        column(12)  # Espacio adicional si es necesario
      ),
      
      fluidRow(
        column(3, offset = 1, align = "center",
               selectInput(inputId = "VariableLineas", 
                           label = "Selecciona la variable para el gráfico de líneas", 
                           choices = c("empleadoras_mujeres", "empleadores_hombres", "empleo_agricultura_mujeres", "empleo_agricultura_hombres", "empleo_industria_mujeres", "empleo_industria_hombres", "empleo_servicios_mujeres", "empleo_servicios_hombres", "empleo_informal_mujeres", "empleo_informal_hombres", "legislacion_acoso_sexual", "autoempleo_mujeres", "autoempleo_hombres", "empleo_parcial_mujeres", "desempleo_educacion_mujeres", "desempleo_educacion_hombres", "desempleo_mujeres", "desempleo_hombres", "trabajo_domestico_no_remunerado_mujeres", "trabajo_domestico_no_remunerado_hombres")
               )
        ),
        column(3, offset = 1, align = "center",
               actionButton("enter_line_chart", "Generar gráfico de líneas")
        )
      ),
      
      plotOutput("line_chart"),
      
      fluidRow(
        tags$div(style = "margin-bottom: 20px;"),  # Espacio entre filas
        column(12)  # Espacio adicional si es necesario
      ),
      
      fluidRow(
        column(3, offset = 1, align = "center",
               selectInput(inputId = "VariablePuntos", 
                           label = "Selecciona la variable para el gráfico de puntos", 
                           choices = c("empleadoras_mujeres", "empleadores_hombres", "empleo_agricultura_mujeres", "empleo_agricultura_hombres", "empleo_industria_mujeres", "empleo_industria_hombres", "empleo_servicios_mujeres", "empleo_servicios_hombres", "empleo_informal_mujeres", "empleo_informal_hombres", "legislacion_acoso_sexual", "autoempleo_mujeres", "autoempleo_hombres", "empleo_parcial_mujeres", "desempleo_educacion_mujeres", "desempleo_educacion_hombres", "desempleo_mujeres", "desempleo_hombres", "trabajo_domestico_no_remunerado_mujeres", "trabajo_domestico_no_remunerado_hombres")
               )
        ),
        column(3, offset = 1, align = "center",
               actionButton("enter_point_chart", "Generar gráfico de puntos")
        )
      ),
      
      plotOutput("point_chart")
      
    ),
    
    fluidRow(
      tags$div(style = "margin-bottom: 20px;"),  # Espacio entre filas
      column(12)  # Espacio adicional si es necesario
    ),
    
    # Tab para tabla
    tabItem(
      tabName = "graficos_tabla",
      selectInput(inputId = "columna_seleccionada", 
                  label = "Selecciona las columnas:", 
                  choices = c("consecutivo", "pais_region", "codigo_pais_region", "anyo", "empleadoras_mujeres", "empleadores_hombres", "empleo_agricultura_mujeres", "empleo_agricultura_hombres", "empleo_industria_mujeres", "empleo_industria_hombres", "empleo_servicios_mujeres", "empleo_servicios_hombres", "empleo_informal_mujeres", "empleo_informal_hombres", "legislacion_acoso_sexual", "autoempleo_mujeres", "autoempleo_hombres", "empleo_parcial_mujeres", "desempleo_educacion_mujeres", "desempleo_educacion_hombres", "desempleo_mujeres", "desempleo_hombres", "trabajo_domestico_no_remunerado_mujeres", "trabajo_domestico_no_remunerado_hombres")
      ),
      multiple = TRUE,
      DT::dataTableOutput("datatable")
    )
  )
)

# Crear el servidor
server <- function(input, output, session) {
  
  datos_reactivos <- reactive({
    read_csv("Datos/datos_empleo_genero.csv")
  })
  
  grafico_dispersion <- eventReactive(input$enter_scatter, {
    plot_ly(data = datos_reactivos(), x = ~get(input$VariableX), y = ~get(input$VariableY), type = "scatter", mode = "markers") |>
      layout(title = "Gráfico de Dispersión",
             xaxis = list(title = input$VariableX),
             yaxis = list(title = input$VariableY))
  })
  
  output$scatter_plot <- renderPlotly({
    grafico_dispersion()
  })
  
  grafico_lineas <- eventReactive(input$enter_line_chart, {
    ggplot(datos_reactivos(), aes_string(x = "anyo", y = input$VariableLineas, color = input$VariableLineas)) +
      geom_line() +
      labs(title = "Gráfico de líneas") +
      theme_minimal()
  })
  
  output$line_chart <- renderPlot({
    grafico_lineas()
  })
  
  grafico_puntos <- eventReactive(input$enter_point_chart, {
    ggplot(datos_reactivos(), aes_string(x = input$VariablePuntos, y = input$VariablePuntos, color = input$VariablePuntos)) +
      geom_point() +
      labs(title = "Gráfico de puntos") +
      theme_minimal()
  })
  
  output$point_chart <- renderPlot({
    grafico_puntos()
  })
  
  output$datatable <- DT::renderDataTable({
    datos_reactivos() |> 
      select(input$columna_seleccionada)
  }, options = list(columnDefs = list(list(className = 'dt-center', targets = "_all"))))
}

# Ejecutar la aplicación
shinyApp(ui, server)
