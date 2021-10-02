#' @export
StatWhiskerPlot= R6::R6Class(
  'StatWhiskerPlot',
  inherit=AoStat,
  public = list(
    aes=ops(x = , y = "x", flippable=TRUE),
    layer_params=ops(width = num(NULL), na.rm = TF(FALSE), coef = num(1.5)),
setup_data = function(data, params,scales) {
  data <- flip_data(data, params$flipped_aes)
  data$x <- data$x %||% 0
  flip_data(data, params$flipped_aes)
},
setup_params = function(data, params,scales) {
  params$flipped_aes=scales$y$is_discrete
  data <- flip_data(data,params$flipped_aes)

  has_x <- !(is.null(data$x) && is.null(params$x))
  has_y <- !(is.null(data$y) && is.null(params$y))
  if (!has_x && !has_y) {
    abort("stat_boxplot() requires an x or y aesthetic.")
  }

  params$width <- params$width %||% (resolution(data$x %||% 0) * 0.75)
  flip_data(data, params$flipped_aes)
  params
},
compute_group = function(data, scales, width = NULL, na.rm = FALSE, coef = 1.5, flipped_aes = FALSE) {
  data <- flip_data(as.list(data), flipped_aes)
  qs <- c(0, 0.25, 0.5, 0.75, 1)

  if (!is.null(data$weight)) {
    mod <- quantreg::rq(y ~ 1, weights = weight, data = data, tau = qs)
    stats <- as.numeric(stats::coef(mod))
  } else {
    stats <- as.numeric(stats::quantile(data$y, qs))
  }
  names(stats) <- c("ymin", "lower", "middle", "upper", "ymax")
  iqr <- diff(stats[c(2, 4)])

  outliers <- data$y < (stats[2] - coef * iqr) | data$y > (stats[4] + coef * iqr)
  if (any(outliers)) {
    stats[c(1, 5)] <- range(c(stats[2:4], data$y[!outliers]), na.rm = TRUE)
  }

  if (length(unique(data$x)) > 1)
    width <- diff(range(data$x)) * 0.9

  df <- as.list(stats)
  df$outliers <- list(data$y[outliers])

  df$ymax_final <- max(data$y)
  df$ymin_final <- min(data$y)
  if (is.null(data$weight)) {
    n <- sum(!is.na(data$y))
  } else {
    # Sum up weights for non-NA positions of y and weight
    n <- sum(data$weight[!is.na(data$y) & !is.na(data$weight)])
  }

  df$notchupper <- df$middle + 1.58 * iqr / sqrt(n)
  df$notchlower <- df$middle - 1.58 * iqr / sqrt(n)

  df$x <- if (is.factor(data$x)) data$x[1] else mean(range(data$x))
  df$width <- width
  df$relvarwidth <- sqrt(n)
  df$flipped_aes <- flipped_aes
  flip_data(df, flipped_aes)
}
)
)

stat_whisker=StatWhiskerPlot$new()$build_fn()
