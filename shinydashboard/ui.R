library(shiny)

fluidPage(
  tabsetPanel(
    id = 'dataset',
    tabPanel("Import Value From 2018 To 2021", DT::dataTableOutput("dataset1",width = "100%", height = "100%")),
    tabPanel("Export Value From 2018 To 2021", DT::dataTableOutput("dataset2",width = "100%", height = "100%")),
    tabPanel("Import Volume From 2018 To 2021", DT::dataTableOutput("dataset3",width = "100%", height = "100%")),
    tabPanel("Import Volume From 2018 To 2021", DT::dataTableOutput("dataset4"),width = "100%", height = "100%"),
    tabPanel("Monthly Covid Cases", DT::dataTableOutput("dataset5", width = "100%", height = "400px")),
  )
)