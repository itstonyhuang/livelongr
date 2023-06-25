#' Plot life expectancy by minimum wage
#'
#' @param data A data frame containing life expectancies by state, year, wealth quartile, and minimum wage.
#' @param quartile The income quartile to filter on (1, 2, 3, or 4).
#' @param state (optional) A state or set of states to filter on (abbreviated state names; default: all states).
#' @param year (optional) A year or set of years to filter on (default: all years).
#' @param sex (optional) A sex to filter on ("m", "f", or "mixed"; default: mixed).
#'
#' @details If provided, the year or years must fall within the range of years for which
#' there is data within the selected data frame.
#'
#' @return A scatterplot of life expectancy by minimum wage.
#' @examples
#' wage_le_plot(health_ineq, quartile = 2, state = "MA", year = c(2000, 2001))
#' wage_le_plot(health_ineq, quartile = 4, year = 2013, state = "CT", sex = "f")
#' @export

wage_le_plot <- function(data, quartile, state = NULL, year = NULL, sex = NULL) {

  # Check inputs

  #Check if quartile input is a number 1-4
  if(!is.numeric(quartile) || !quartile %in% 1:4) {
    stop("Error: quartile input must be an integer 1-4")
  }

  # Check if state input is a valid state acronym
  if(!is.null(state)) {
    if(!is.character(state) || any(!state %in% unique(data$stateabbrv))) {
      stop("Error: state input must be a valid state acronym")
    }
  }

  # Check if year input is within year range defined in dataset
  valid_years <- unique(data$Year)

  if (length(year) == 1) {
    if (!(year %in% valid_years)) {
      stop("No data found for the input year.")
    }
  } else if (length(year) > 1) {
    if (!all(year %in% valid_years)) {
      warning("One or more input years are missing data.")
    }
  }

  # Check if sex input is "m", "f", or "mixed"
  if(!is.null(sex)) {
    if(!is.character(sex) || !(sex %in% c("m", "f", "mixed"))) {
      stop("Error: sex input must be one of the following: \"m\", \"f\", or \"mixed\"")
    }
  }

  # Check if state or state & year input combination has a minimum wage value
  if (!is.null(year)) {
    state_year <- subset(data, stateabbrv %in% state & Year %in% year)
  } else {
    state_year <- subset(data, stateabbrv %in% state)
  }

  if (any(is.na(state_year$Min_Wage))) {
    warning("No minimum wage values found for at least one specified state/year combination.")
  }

  ## Check if year input is a number 2001-2014
  #if(!is.null(year)) {
   # if(!is.numeric(year) || any(year < 2001) || any(year > 2014)) {
    #  stop("Error: year input must be a number between 2001 and 2014")
    #}
 # }



  ## Filter data by quartile
  #data <- dplyr::filter(data, str_detect(names(.), paste0("_q", quartile)))

    # %>% select(stateabbrv, year, Min_Wage, matches(paste0("_q", quartile)), matches("mixed"))

  # Filter data by state if provided
  if (!is.null(state)) {
    data <- dplyr::filter(data, stateabbrv %in% state)
  }

  # Filter data by year if provided
  if (!is.null(year)) {
    data <- dplyr::filter(data, Year %in% year)
  }


  # Filter data by sex if provided
  # Plot scatterplot of life expectancy by minimum wage
  # Add caption/label about year, state, sex

   if (!is.null(sex)) {
     ggplot2::ggplot(data,
                     ggplot2::aes(x = Min_Wage,
                                  y = get(paste0("ra_q", quartile, "_", sex)),
                                  color = stateabbrv)) +
      ggplot2::geom_point() +
      # ggplot2::geom_smooth(method = "lm", se = FALSE) +
      ggplot2::labs(title = paste("Life Expectancy by Minimum Wage, Quartile", quartile),
           x = "Minimum Wage",
           y = paste("Life Expectancy (sex:", sex, ")")) +
      ggplot2::theme_bw()
  }
  else {
    ggplot2::ggplot(data,
                    ggplot2::aes(x = Min_Wage,
                                 y = get(paste0("ra_q", quartile, "_mixed")),
                                 color = stateabbrv)) +
      ggplot2::geom_point() +
      # ggplot2::geom_smooth(method = "lm", se = FALSE) +
      ggplot2::labs(title = paste("Life Expectancy by Minimum Wage, Quartile", quartile),
           x = "Minimum Wage",
           y = paste("Life Expectancy (sex: mixed)")) +
      ggplot2::theme_bw()
  }

  }
