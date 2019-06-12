library(knitr)

purl(input = "objectsndata.Rmd",
     output = "Files/Course Scripts/objectsndata.R",
     documentation = 2)

purl(input = "datamanagement.Rmd",
     output = "Files/Course Scripts/datamanagement.R",
     documentation = 2)

purl(input = "datamanagement_eurostat.Rmd",
     output = "Files/Course Scripts/datamanagement_eurostat.R",
     documentation = 2)


purl(input = "dataviz.Rmd",
     output = "Files/Course Scripts/dataviz.R",
     documentation = 2)
