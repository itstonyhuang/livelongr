#' Plot choropleth map of life expectancy
#'
#' @param data A data frame containing life expectancies by state, year, and wealth quartile
#' @param quartile The income quartile to filter on (1, 2, 3, or 4)
#' @param sex A sex to filter on ("m" for male, "f" for female, or "mixed" for both)
#' @param year A particular year to filter on
#' @param ra (optional) A race adjusted filter (TRUE for race-adjusted, FALSE for race-unadjusted)
#'
#' @details If provided, the year or years must fall within the range of years for which
#' there is data within the selected data frame.
#'
#' @return A choropleth map of life expectancy across states for a given year and sex
#' @examples
#' choropleth(health_ineq, quartile = 4, sex = "mixed", year = 2005)
#' choropleth(health_ineq, quartile = 1, sex = "m", year = 2001, ra = FALSE)
#' @export

choropleth <- function(data, quartile, sex, year, ra = TRUE){

  #checking inputs
  if (!is.numeric(quartile) || !quartile %in% 1:4){
    stop("Error: quartile input must be an integer from 1-4")
  }

  if (sex != "m" & sex != "f" & sex != "mixed"){
    stop("Error: sex input must be either 'm', 'f', or 'mixed' for male, female, and mixed, respectively")
  }

  if (!is.numeric(year) || !all(year %in% unique(data$Year))){
    stop("Error: year input must be an integer and in the dataset")
  }

  if (!is.logical(ra)){
    stop("Error: race adjusted (ra) input must be a logical, i.e. TRUE or FALSE")
  }

  if(ra == TRUE){
    race = "ra_q"
  }

  if(ra == FALSE){
    race = "nr_q"
  }

  #data wrangling
  data <- data |> dplyr::filter(Year == year) |>
    dplyr::select(stateabbrv, Year, statename, paste0(race, quartile, "_", sex)) |>
    dplyr::rename(selected_le = paste0(race, quartile, "_", sex))

  #adding lon and lat coordinates for each state using their capital
  coord <- read.csv("https://raw.githubusercontent.com/jasperdebie/VisInfo/master/us-state-capitals.csv")
  coord <- subset(coord, select = -description)

  #adding the district of columbia; lat and lon retrieved from google
  dc <- data.frame(name = "District Of Columbia", latitude = 38.9072, longitude = 77.0369)
  coord <- rbind(coord, dc)

  combined <- dplyr::inner_join(data, coord, by = c("statename" = "name"))

  #state shape polygon
  shape <- geojsonio::geojson_read("https://rstudio.github.io/leaflet/json/us-states.geojson",
                                   what = "sp")
  shape@data[["name"]][9] <- "District Of Columbia"
  #removes the 52nd row, which contains Puerto Rico
  shape <- shape[-52,]

  #merging spatial and dataframe and supressing the warning
  data_shape <- suppressWarnings(tigris::geo_join(shape, combined, "name", "statename"))

  #color palette
  pal_le <- leaflet::colorNumeric("Greens", domain=data_shape$selected_le)

  #popup
  popup_le <- paste("<b>", data_shape$statename, "</b>",
                    "<br/> Life expectancy: ", round(data_shape$selected_le, digit = 2),
                    "years in ", data_shape$Year)

  #choropleth map
  leaflet::leaflet() |>
    leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron) |>
    leaflet::setView(-96.5, 39.5, zoom = 4) |>
    leaflet::addPolygons(data = data_shape,
                         fillColor = ~pal_le(data_shape$selected_le),
                         fillOpacity = 0.9,
                         weight = 0.2,
                         smoothFactor = 0.2,
                         popup = ~popup_le) |>
    leaflet::addLegend(pal = pal_le,
                       values = data_shape$selected_le,
                       position = "bottomright",
                       title = paste("Life Expectancy <br/>", "Year: ", year,
                                     "<br/> Quartile: ", quartile, "<br/> Sex: ", sex,
                                     "<br/> Race Adjusted: ", tolower(ra)))
}

