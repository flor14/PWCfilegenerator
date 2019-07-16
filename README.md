# PWC file generator package

* The goal of `PWCfilegenerator` is to obtain the weather file necessary to run the models Pesticide in Water Calculator (PWC) v1.52 and Pesticide Root Zone Model (PRZM5) v5.02. 

* These models used in pesticide risk assessment are available to download for free from the [USEPA website](https://www.epa.gov/pesticide-science-and-assessing-pesticide-risks/models-pesticide-risk-assessment). 

* The function `PWCfilegenerator::PWC_fg()` converts a weather dataset to the file format read as input for PRZM5 and PWC.

Despite PWC model presents a simple and intuitive interface for its users, the weather files required to run the model should be previously available to facilitate its use for researchers without programming skills, environmental managers, and regulators.

The function to convert a weather dataset in the PWC input file present in the `PWCfilegenerator` package could increase the use of pesticide fate models in countries where pesticide risk assessment is still underdeveloped.

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
# The weather dataset used as input require the following data:
# dates, precipitation, panevaporation, temperature, wind speed and solar radiation 
# in the units described in [PRZM5 manual](http://bit.ly/2k6yV26).  

# Example of a small dataset
data <- data.frame( date = c("01/01/81", "02/01/81", "03/01/81", "04/01/81"),
            precip = c(0.00, 0.10, 0.00, 0.00),
            evap = c(0.30, 0.21, 0.28, 0.28),
            tmed = c(9.5, 6.3, 3.5, 5),
            wind = c(501.6, 368.0, 488.3, 404.5),
            solrad = c(240.3, 244.3, 303.0, 288.5))

# Function to convert and save the weather file as a .dvf 
PWCfilegenerator::PWC_fg(data = data, # Name of your dataset 
                          date = "date", # Column name for dates
                          format = "%d/%m/%y", # Date format
                          start ="02/01/81", # Date to start the weather file
                          end = "03/01/81", # Date to end the weather file 
                          precip_cm = "precip", # Column name for precipitation (cm/day)
                          pevp_cm = "evap", # Column name for panevaporation data (cm/day)
                          temp_celsius = "tmed", # Column name for temperature (Celsius)
                          ws10_cm_s = "wind", # Column name for wind speed values (cm/sec)
                          solr_lang = "solrad", # Column name for solar radiation (Langley)
                          save_in = "F:/Paquete/weatherfile" # Path to save the final weather file. Extension .dvf do not need to be specified.                )  
                                      

```

## Community guidelines

Report Issues:

- Questions, feedback, bug reports: please open an issue in the issue tracker of the project [here](https://github.com/flor14/PWC_filegenerator/issues).

Contribution to the software:

- Please open an issue in the issue tracker of the project that describes the changes you would like to make to the software and open a pull request with the changes. The description of the pull request must references the corresponding issue.

