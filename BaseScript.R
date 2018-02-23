pacotes <- c("readr", "arules", 
             "arulesViz", "splitstackshape", 
             "plyr","dplyr", "tidyverse",
             "RColorBrewer", "data.table", "plotly")

carregar.pacotes <- function(x){
  for (i in x){
    if( ! require(i , character.only = T)) {
      install.packages(i, dependencies = T) 
    }
    require(i , character.only = T, warn.conflicts = F)
  }
}

carregar.pacotes(pacotes)

compras <- fread("compras.csv")

colnames(compras) <- c("order_id","product_name")

dados <- as(split(compras$product_name,
                  compras$order_id), 
            "transactions")

summary(dados)

itemFrequency(dados, 
              type = "relative")

itemFrequencyPlot(dados,topN=20,
                  type="absolute")

set.seed(12345)

rules = apriori(dados, 
                parameter=list(support=0.01, 
                               confidence=0.01, 
                               maxlen=2))

inspectDT(rules)

# plot(rules,
#      control=list(col=brewer.pal(11,"Spectral")),
#      main="Gráfico Estatístico")

plot(rules, engine = "htmlwidget")
plot(rules, method = "matrix" , engine = "htmlwidget")
plot(rules, method = "graph", engine = "htmlwidget")
plot(rules, method = "grouped matrix", engine = "interactive")

rules3 = as(rules, "data.frame")
