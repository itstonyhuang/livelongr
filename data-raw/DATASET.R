## code to prepare `DATASET` dataset goes here


#Instead of loading packages with library(package_name), use package_name::function_name().

life_expect <- readr::read_csv("data-raw/health_ineq.csv")

#renaming the var names
life_expect <- dplyr::rename(life_expect,
                             "ra_q1_f" = "le_raceadj_q1_F",
                             "ra_q2_f" = "le_raceadj_q2_F",
                             "ra_q3_f" = "le_raceadj_q3_F",
                             "ra_q4_f" = "le_raceadj_q4_F",
                             "ra_q1_m" = "le_raceadj_q1_M",
                             "ra_q2_m" = "le_raceadj_q2_M",
                             "ra_q3_m" = "le_raceadj_q3_M",
                             "ra_q4_m" = "le_raceadj_q4_M",
                             "nr_q1_f" = "le_agg_q1_F",
                             "nr_q2_f" = "le_agg_q2_F",
                             "nr_q3_f" = "le_agg_q3_F",
                             "nr_q4_f" = "le_agg_q4_F",
                             "nr_q1_m" = "le_agg_q1_M",
                             "nr_q2_m" = "le_agg_q2_M",
                             "nr_q3_m" = "le_agg_q3_M",
                             "nr_q4_m" = "le_agg_q4_M")

#reducing dataset to just raceadj and non-raceadj based on gender
life_expect <- dplyr::select(life_expect, stateabbrv, statename, year,
                             ra_q1_f, ra_q2_f, ra_q3_f, ra_q4_f,
                             ra_q1_m, ra_q2_m, ra_q3_m, ra_q4_m,
                             nr_q1_f, nr_q2_f, nr_q3_f, nr_q4_f,
                             nr_q1_m, nr_q2_m, nr_q3_m, nr_q4_m)

#creating mixed gender race adj + non-raceadj
ra_q1_mixed <- (life_expect$ra_q1_f + life_expect$ra_q1_m)/2
ra_q2_mixed <- (life_expect$ra_q2_f + life_expect$ra_q2_m)/2
ra_q3_mixed <- (life_expect$ra_q3_f + life_expect$ra_q3_m)/2
ra_q4_mixed <- (life_expect$ra_q4_f + life_expect$ra_q4_m)/2

nr_q1_mixed <- (life_expect$nr_q1_f + life_expect$nr_q1_m)/2
nr_q2_mixed <- (life_expect$nr_q2_f + life_expect$nr_q2_m)/2
nr_q3_mixed <- (life_expect$nr_q3_f + life_expect$nr_q3_m)/2
nr_q4_mixed <- (life_expect$nr_q4_f + life_expect$nr_q4_m)/2

#adding vars to dataset
life_expect <- dplyr::mutate(life_expect, ra_q1_mixed, ra_q2_mixed,
                             ra_q3_mixed, ra_q4_mixed, nr_q1_mixed,
                             nr_q2_mixed, nr_q3_mixed, nr_q4_mixed)


#wrangling raw data on minimum wage
min_wage_raw <- readr::read_csv("data-raw/poverty_data.csv")

min_wage <- tidyr::pivot_longer(min_wage_raw, cols = c("2001-01-01", "2002-01-01",
                                                       "2003-01-01", "2004-01-01",
                                                       "2005-01-01",	"2006-01-01",
                                                       "2007-01-01",	"2008-01-01",
                                                       "2009-01-01",	"2010-01-01",
                                                       "2011-01-01",	"2012-01-01",
                                                       "2013-01-01",	"2014-01-01"),
                                names_to = "Year",
                                values_to = "Min_Wage")

min_wage <- dplyr::rename(min_wage,
                          "State" = "DATE")

min_wage$Year <- gsub("-01-01","", as.character(min_wage$Year))


#merging min wage and health ineq
health_ineq <- merge(life_expect, min_wage,
                     by.x = c("stateabbrv", "year"), by.y = c("State", "Year"))

health_ineq <- dplyr::rename(health_ineq, Year = year)

usethis::use_data(health_ineq, overwrite = TRUE)

#usethis::use_r("choropleth_map")
#usethis::use_r("wage_le_plot")


