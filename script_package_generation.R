pkgs <- c("devtools", "roxygen2", "usethis")
install.packages(pkgs)
library(devtools)
library(roxygen2)
library(usethis)
library(data.table)

# Generate the function

usethis::use_r("PWC_climatefile")

# add dependencies to my files cited

usethis::use_package("gdata")

# coc and license
usethis::use_code_of_conduct()
usethis::use_gpl3_license(name = "CCBy 4.0")

#
devtools::load_all()

#documentacion
roxygen2::roxygenise()

#add data to preprocess it
i <- c("Anguil_INTA", "Parana_SMN", "MarcosJuarez_SMN", "TresArroyos_SMN", "Pergamino_INTA")
for(i in lug){
library(data.table)
file <- fread(paste0("", i, "_datasetFINAL.txt"), fill=TRUE, sep = " ")
colnames(file)<-c("Date", "TMAX", "TMIN", "RH", "WS10", "HELIO", "GR", "ID", "Lat", "Long", "Julian", "PM", "PM_Mes_Rad", "Hargreaves", "Month", "Year", "Yearmon", "Yearmon2", "PRECIP", "Epan" )

Date <-as.Date(file$Date)
v10 <-as.numeric(as.character(file$WS10))
Tmax <- as.numeric(as.character(file$TMAX))
Tmin <-as.numeric(as.character(file$TMIN))
PM <- as.numeric(as.character(file$PM))
SolR <- as.numeric(as.character(file$GR))
PP <- as.numeric(as.character(file$PRECIP))

RangoT <- data.frame(Tmax, Tmin)

#PP (lo tengo en mm, lo quiero en cm)
PPcm<- PP/10
#EVAPO ((1) lo tengo en PM, lo quiero en Epan, (2) lo tengo en mm, lo quiero en cm)
Epan <- PM/0.7
Epancm <- Epan/10
#Tmed
Tmed <- (rowMeans(RangoT,na.rm = TRUE))
#Viento (lo tengo en km/h, lo quiero en cm/s)
v10cms<- (v10*100000)/(60*60)
#SolR (la tengo en MJ/m2, la quiero en Langley)
#1MJ son 1000000 de Joules/1 caloria son 4.1868 joules/1 m2 son 10000 cm2
SolRlang <- (SolR*1000000)/(10000*4.1868)
Parana <- data.frame(Date, PPcm,Epancm,Tmed,v10cms,SolRlang)
usethis::use_data(Parana, overwrite = TRUE)
}
# pruebo
PWCfilegenerator::PWC_fg(data = "Parana",
                          date = "Date",
                          start ="1984-01-03" ,
                          end = "1984-01-07",
                          temp_celsius = "Tmed",
                          precip_cm = "PPcm",
                          ws10_cm_s = "v10cms",
                          pevp_cm = "Epancm",
                          solr_lang = "SolRlang",
                          save_in = "E:/Paquete/WF3"
                         )

