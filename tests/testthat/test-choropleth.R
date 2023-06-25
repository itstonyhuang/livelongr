test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("errors when given an invalid quartile input", {
  expect_error(choropleth(data = health_ineq, quartile = 5, sex = "mixed", year = 2014))
})

test_that("errors when given an invalid sex input", {
  expect_error(choropleth(data = health_ineq, quartile = 2, sex = mixed, year = 2002))
})

test_that("errors when given an invalid year", {
  expect_error(choropleth(data = health_ineq, quartile = 1, sex = "f", year = 2023))
})

test_that("errors when given an invalid ra", {
  expect_error(choropleth(data = health_ineq, quartile = 4, sex = "m", year = 2010, ra = hi))
} )

test_that("returns plot object", {
  plot_obj <- choropleth(data = health_ineq, quartile = 4, sex = "mixed", 2010)
  expect_true("leaflet" %in% class(plot_obj))
})
