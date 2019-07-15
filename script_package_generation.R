pkgs <- c("devtools", "roxygen2", "usethis")
install.packages("exampletestr")
library(exampletestr)
library(devtools)
library(roxygen2)
library(usethis)
library(data.table)

# Generate the function

usethis::use_r("PWC_climatefile")

# add dependencies to my files cited

usethis::use_package("gdata")
usethis::use_package("lubridate")

# coc and license
usethis::use_code_of_conduct()
usethis::use_gpl3_license(name = "CCBy 4.0")



#documentacion
roxygen2::roxygenise()


data <- data.frame( date = c("01/01/81", "02/01/81", "03/01/81", "04/01/81"),
            precip = c(0.00, 0.10, 0.00, 0.00),
            evap = c(0.30, 0.21, 0.28, 0.28),
            tmed = c(9.5, 6.3, 3.5, 5),
            wind = c(501.6, 368.0, 488.3, 404.5),
            solrad = c(240.3, 244.3, 303.0, 288.5))

usethis::use_data(data, overwrite = TRUE)

as.Date("02/01/1981", format("%d/%m/%Y"))
# pruebo

data(data)
#

devtools::load_all()
PWCfilegenerator::PWC_fg(data = data,
                          date = "date",
                          format = "%d/%m/%y",
                          start ="01/01/81" ,
                          end = "04/01/81",
                          precip_cm = "precip",
                          temp_celsius = "tmed",
                          pevp_cm = "evap",
                          ws10_cm_s = "wind",
                          solr_lang = "solrad",
                          save_in = "E:/Paquete/WF4"
                         )

#una vez que esta el paquete lo puedo instalar con
devtools::install()

# Testing
# se debe hacer desde el archivo de la funcion
usethis::use_test()

devtools::test_file()

devtools::test_coverage_file()

#generate a readme
usethis::use_readme_rmd()
usethis::use_readme_md()

