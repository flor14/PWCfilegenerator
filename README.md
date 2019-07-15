# PWCfilegenerator

The goal of `PWCfilegenerator` is to obtain the weather file necessary to obtain the weather files for the models PRZM5 and PWC, that actually free to download from the [USEPA].

## Installation

You can install `PWCfilegenerator` from this GitHub repo using the following code:

``` r
install.packages("devtools") # if you have not installed "devtools" package
library(devtools)
devtools::install_github("flor14/PWCfilegenerator")
```

## Example

This is a basic example:

``` r
# The input dataset is a weather file with the following columns: dates, precipitation, panevaporation, temperature, wind speed and solar radiation in the units mentioned in [PRZM5 manual]().

# Example of a dataset
data <- data.frame( date = c("01/01/81", "02/01/81", "03/01/81", "04/01/81"),
            precip = c(0.00, 0.10, 0.00, 0.00),
            evap = c(0.30, 0.21, 0.28, 0.28),
            tmed = c(9.5, 6.3, 3.5, 5),
            wind = c(501.6, 368.0, 488.3, 404.5),
            solrad = c(240.3, 244.3, 303.0, 288.5))


PWCfilegenerator::PWC_fg(data = data, # Name of your dataset
                          date = "date", # Name of the column with dates
                          format = "%d/%m/%y", # Format in which the weather file is stored
                          start ="01/01/81", # Start day of the weather file to create
                          end = "04/01/81", # End day of the weather file to create
                          precip_cm = "precip", # Name of the column with precipitation values
                          temp_celsius = "tmed", # Name of the column with temperature values
                          pevp_cm = "evap", # Name of the column with panevaporation values
                          ws10_cm_s = "wind", # Name of the column with wind speed values
                          solr_lang = "solrad", # Name of the column with solar radiation values
                          save_in = "F:/Paquete/WF5" 
                         )

```

## Community guidelines

Report Issues:

- Questions, feedback, bug reports: please open an issue in the issue tracker of the project [here](https://github.com/flor14/PWC_filegenerator/issues).

Contribution to the software:

- Please open an issue in the issue tracker of the project that describes the changes you would like to make to the software and open a pull request with the changes. The description of the pull request must references the corresponding issue.

