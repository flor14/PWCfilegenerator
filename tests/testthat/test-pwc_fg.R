context("test-pwc_fg")

test_that("subset works", {
    path <- tempfile()
    on.exit(unlink(path))

    expect_true(file.exists(path))
  })

})

test_that("subset works", {
  expect_equal(2 * 2, 4)
})
