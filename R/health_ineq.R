#' Race-adjusted life expectancy estimates for Americans
#'
#' Includes race-adjusted and non-race-adjusted life expectancy estimates for Americans by state of residence,
#' income quartile, year, and sex; and minimum wage by state and year.
#'
#' @format A tibble with 714 rows and 28 variables:
#' \describe{
#'    \item{stateabbrv}{a factor denoting state abbreviations for the 50 states and Districit of Columbia}
#'    \item{Year}{a numeric denoting the year the life expectation estimate was calculated}
#'    \item{statename}{a factor denoting the 50 state names and District of Colombia}
#'    \item{ra_q1_f}{a numeric denoting life expectancy for race adjusted females with income in the 1st quartile}
#'    \item{ra_q2_f}{a numeric denoting life expectancy for race adjusted females with income in the 2nd quartile}
#'    \item{ra_q3_f}{a numeric denoting life expectancy for race adjusted females with income in the 3rd quartile}
#'    \item{ra_q4_f}{a numeric denoting life expectancy for race adjusted females with income in the 4th quartile}
#'    \item{ra_q1_m}{a numeric denoting life expectancy for race adjusted males with income in the 1st quartile}
#'    \item{ra_q2_m}{a numeric denoting life expectancy for race adjusted males with income in the 2nd quartile}
#'    \item{ra_q3_m}{a numeric denoting life expectancy for race adjusted males with income in the 3rd quartile}
#'    \item{ra_q4_m}{a numeric denoting life expectancy for race adjusted males with income in the 4th quartile}
#'    \item{nr_q1_f}{a numeric denoting life expectancy for non-race adjusted females with income in the 1st quartile}
#'    \item{nr_q2_f}{a numeric denoting life expectancy for non-race adjusted females with income in the 2nd quartile}
#'    \item{nr_q3_f}{a numeric denoting life expectancy for non-race adjusted females with income in the 3rd quartile}
#'    \item{nr_q4_f}{a numeric denoting life expectancy for non-race adjusted females with income in the 4th quartile}
#'    \item{nr_q1_m}{a numeric denoting life expectancy for non-race adjusted males with income in the 1st quartile}
#'    \item{nr_q2_m}{a numeric denoting life expectancy for non-race adjusted males with income in the 2nd quartile}
#'    \item{nr_q3_m}{a numeric denoting life expectancy for non-race adjusted males with income in the 3rd quartile}
#'    \item{nr_q4_m}{a numeric denoting life expectancy for non-race adjusted males with income in the 4th quartile}
#'    \item{ra_q1_mixed}{a numeric denoting life expectancy for race adjusted males and females with income in the 1st quartile}
#'    \item{ra_q2_mixed}{a numeric denoting life expectancy for race adjusted males and females with income in the 2nd quartile}
#'    \item{ra_q3_mixed}{a numeric denoting life expectancy for race adjusted males and females with income in the 3rd quartile}
#'    \item{ra_q4_mixed}{a numeric denoting life expectancy for race adjusted males and females with income in the 4th quartile}
#'    \item{nr_q1_mixed}{a numeric denoting life expectancy for non-race adjusted males and females with income in the 1st quartile}
#'    \item{nr_q2_mixed}{a numeric denoting life expectancy for non-race adjusted males and females with income in the 2nd quartile}
#'    \item{nr_q3_mixed}{a numeric denoting life expectancy for non-race adjusted males and females with income in the 3rd quartile}
#'    \item{nr_q4_mixed}{a numeric denoting life expectancy for non-race adjusted males and females with income in the 4th quartile}
#'    \item{Min_Wage}{a numeric denoting minimum wage in USD}
#'    }
#'
#' @source {The Association between Income and Life Expectancy in the United States, 2001 - 2014. Raj Chetty et al. The Journal of the American Medical Association, April 11, 2016, Vol 315, No. 14. https://healthinequality.org/}
#' @source {Min wage and Poverty data: https://fred.stlouisfed.org/}
#'
"health_ineq"

