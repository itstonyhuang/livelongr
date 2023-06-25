test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("errors when given invalid quartile input", {
  expect_error(wage_le_plot(data = health_ineq, quartile = 0, state = "MA"))
})

test_that("errors when given invalid state input", {
  expect_error(wage_le_plot(data = health_ineq, quartile = 2, state = "invalid"))
})

test_that("errors when given invalid year input", {
  expect_error(wage_le_plot(data = health_ineq, quartile = 2, state = "MA", year = 1999))
})

test_that("errors when given invalid sex input", {
  expect_error(wage_le_plot(data = health_ineq, quartile = 1, state = "CT", sex = "3"))
})

test_that("returns warning for missing minimum wage values", {
  expect_warning(wage_le_plot(data = health_ineq, quartile = 2, state = "AL", year = 2006))
})

test_that("returns plot object", {
  plot_obj <- wage_le_plot(data = health_ineq, quartile = 2, state = "MA")
  expect_true("ggplot" %in% class(plot_obj))
})
