treemap_s <- function(data, area, xlim = c(0, 1), ylim = c(0, 1), layout = "squarified") {

  # Remove any rows where area <= 0
  data <- copy(data[area>0])

  # Stop if there are no rows
  if (nrow(data) == 0) {
    stop("Must provide some rows with area > 0")
  }

  # Sort the data by area, largest to smallest
  setorder(data,-area)

  # Scale areas to sum to plot area
  plot_area <- diff(xlim) * diff(ylim)
  data$area=plot_area*data$area / sum(data$area)

  # Generate the tile layout, in either row- or column-first order

    tile_f <- next_tile_f(xlim[1], xlim[2], ylim[1], ylim[2])

  layout <- tile_f(
    data,
    area,
    xmin = xlim[1],
    xmax = xlim[2],
    ymin = ylim[1],
    ymax = ylim[2],
    layout = layout
  )



  # Return layout
  layout
}

worst_ar <- function(areas, long_dim) {

  # Calculate the short dimension of the row
  short_dim <- sum(areas) / long_dim

  # Calculate the tile dimensions along the long axis
  tile_long_dims <- areas / short_dim

  # Calculate the tile aspect ratios
  aspect_ratios <- tile_long_dims / short_dim
  aspect_ratios <- ifelse(aspect_ratios < 1, 1 / aspect_ratios, aspect_ratios)

  # Return the worst aspect ratio
  max(aspect_ratios)
}

#' Select the next tiling direction based on the aspect ratio of the remaining
#' area
#'

#' @noRd
next_tile_f <- function(xmin, xmax, ymin, ymax) {

  if (diff(c(xmin, xmax)) >= diff(c(ymin, ymax))) {
    return(tile_column)
  } else {
    return(tile_row)
  }
}

#' Place tiles in an area of defined dimensions, beginning with a row.
#'
#' @noRd
tile_row <- function(data, area, xmin, xmax, ymin, ymax, layout) {

  # For each possible number of tiles in the row, calculate the worst aspect
  # ratio of a tile in the row and select the number of tiles that provides
  # the least worst ratio
  row_n <- which.min(vapply(
    seq_len(nrow(data)),
    function(x) worst_ar(data$area[1:x], xmax - xmin),
    FUN.VALUE = double(1)
  ))

  # Determine the coordinates for the selected number of tiles
  tiles <- data[1:row_n]
  row_long_dimension <- xmax - xmin
  row_short_dimension <- sum(tiles$area) / row_long_dimension
  tiles[,xdim :=area / row_short_dimension]
  tiles[,xmax := xmin + cumsum(xdim)]
  tiles[,xmin := xmax - xdim]
  tiles[,ymin := ymin]
  tiles[,ymax := ymin + row_short_dimension]
  tiles[,xdim := NULL]
  tiles[,area := NULL]

  # Update the remaining area
  ymin <- ymin + row_short_dimension
  setcolorder(tiles,c("ymax",'ymin','xmin','xmax'))
  # Remove the placed tiles from the data frame
  data <- data[-(1:row_n)]

  # If there are no more tiles to place, return the tile coordinates
  if (nrow(data) == 0) {
    return(tiles)

    # If there are more tiles to place, fill in the remaining area with the
    # appropriate function
  } else {
    tile_f <- next_tile_f(xmin, xmax, ymin, ymax)

    return(rbindlist(.(tiles, tile_f(data, area, xmin, xmax, ymin, ymax, layout)),fill=T))
  }
}

#' Place tiles in an area of defined dimensions, beginning with a column.
#'
#' @noRd
tile_column <- function(data, area, xmin, xmax, ymin, ymax, layout) {

  # For each possible number of tiles in the column, calculate the worst
  # aspect ratio of a tile in the column and select the number of tiles that
  # provides the least worst ratio
  column_n <- which.min(vapply(
    seq_len(nrow(data)),
    function(x) worst_ar(data$area[1:x], ymin - ymax),
    FUN.VALUE = double(1)
  ))

  # Determine the coordinates for the selected number of tiles
  tiles <- data[1:column_n]
  column_long_dimension <- ymax - ymin
  column_short_dimension <- sum(tiles$area) / column_long_dimension
  tiles[,ydim:=area / column_short_dimension]
  tiles[,ymax:= ymin + cumsum(ydim)]
  tiles[,ymin:= ymax - ydim]
  tiles[,xmin:= xmin]
  tiles[,xmax:=xmin +column_short_dimension]
  tiles[,ydim:=NULL]
  tiles[,area:= NULL]

  # Update the remaining area
  xmin <- xmin + column_short_dimension

  # Remove the placed tiles from the data frame
  setcolorder(tiles,c("ymax",'ymin','xmin','xmax'))
  data <- data[-(1:column_n)]

  # If there are no more tiles to place, return the tile coordinates
  if (nrow(data) == 0) {
    return(tiles)

    # If there are more tiles to place, fill in the remaining area with the
    # appropriate function
  } else {
    tile_f <- next_tile_f(xmin, xmax, ymin, ymax)

    return(rbindlist(.(tiles, tile_f(data, area, xmin, xmax, ymin, ymax, layout)),fill=TRUE))
  }
}

treemap <- function(
  data,
  groups,
  layout = "squarified",
  start = "bottomleft",
  xlim = c(0, 1),
  ylim = c(0, 1)
) {
  assert_subset(groups,choices=names(data))
  # Check arguments
  if (missing(data))
    stop("`data` is required", call. = FALSE)


  if (!'area' %in% names(data))
    stop("Column area not found in data", call. = FALSE)





  if (!layout %in% c("squarified", "scol", "srow", "fixed"))
    stop("Invalid value for `layout`", call. = FALSE)

  if (!(is.numeric(xlim) & length(xlim) == 2 & xlim[1] < xlim[2]))
    stop("`xlim` must be a numeric vector of length 2, with the minimum less than the maximum")

  if (!(is.numeric(ylim) & length(ylim) == 2 & ylim[1] < ylim[2]))
    stop("`ylim` must be a numeric vector of length 2, with the minimum less than the maximum")


  # Set layout function




  # Set list of subgrouping levels

  # Work down subgrouping levels, laying out treemaps for each level

  layout <- do_layout(data, groups, xlim, ylim,layout=layout)

  # Flip the coordinates to set the starting corner
  if (start == "topleft") {
    new_ymax <- max(layout$ymax) - layout$ymin
    new_ymin <- max(layout$ymax) - layout$ymax
    layout$ymax <- new_ymax
    layout$ymin <- new_ymin
  } else if (start == "topright") {
    new_ymax <- max(layout$ymax) - layout$ymin
    new_ymin <- max(layout$ymax) - layout$ymax
    layout$ymax <- new_ymax
    layout$ymin <- new_ymin
    new_xmax <- max(layout$xmax) - layout$xmin
    new_xmin <- max(layout$xmax) - layout$xmax
    layout$xmax <- new_xmax
    layout$xmin <- new_xmin
  } else if (start == "bottomright") {
    new_xmax <- max(layout$xmax) - layout$xmin
    new_xmin <- max(layout$xmax) - layout$xmax
    layout$xmax <- new_xmax
    layout$xmin <- new_xmin
  }
  layout
}

do_layout <- function(data, groups, xlim = c(0, 1), ylim = c(0, 1),layout) {

  # If there are no subgrouping levels below this one, return a layout for
  # the given observations

  if (length(groups) == 0)
    return(treemap_s(data=data, area='area', xlim=xlim, ylim=ylim, layout=layout))

  # Otherwise, generate a layout for this subgrouping level and fill each
  # subgroup with its own layout


  # Sum areas for groups at this subgrouping level
  current_group=groups[1]
  this_level_data <- data[,.(area=sum(area)),keyby=c( current_group)]
  # Generate layout for this subgrouping level
  layoutkey <- treemap_s(this_level_data , "area", xlim, ylim, layout=layout)
  setkeyv(layoutkey, current_group)
  # For each group at this subgrouping level, generate sub-layouts


  generate_sublayout <- function(data,layoutkey,groups,layout) {

    groupdata <- data[area > 0]
    if (nrow(groupdata) == 0)
      return()

    # Generate sub-layout

    sublayout <- do_layout(
      groupdata,
      groups[-1],
      xlim = c(layoutkey$xmin, layoutkey$xmax),
      ylim = c(layoutkey$ymin, layoutkey$ymax),
      layout=layout
    )

    sublayout
  }

  #groups <- as.character(unique(data[[groups[1]]]))
  #do.call("rbind", lapply(groups, generate_sublayout))
  data[,generate_sublayout(.SD,layoutkey[.BY],groups=groups,layout=layout),by=c(current_group)]
}

draw_div=function(data){
  sdcols=c("xmin",'xmax','ymin','ymax')

  xrange=range(c(data$xmin,data$xmax))
  yrange=range(c(data$ymin,data$ymax))
  dx=data[,lapply(.SD,function(x)rescale(x,from=xrange)),.SDcols=c("xmin",'xmax')]

  dy=data[,lapply(.SD,function(x)rescale(x,from=yrange)),.SDcols=c("ymin",'ymax')]

  gdat<-cbind(dx,dy,data[,.(fill,value)])
  data[,.(value=divmark(gdat,style=.(position='absolute'),class='treediv border border-white'),xmin=min(xmin),xmax=max(xmax),ymin=min(ymin),ymax=max(ymax),fill='transparent')]
}

draw_layout <- function(data, groups) {

  # If there are no subgrouping levels below this one, return a layout for
  # the given observations
  if (length(groups) == 0)
    return(data)

  current_group=groups[1]


  #groups <- as.character(unique(data[[groups[1]]]))
  #do.call("rbind", lapply(groups, generate_sublayout))
  draw_div(data[,  draw_layout(.SD,groups=groups[-1]),by=c(current_group)])
}

draw_sub <- function(data,groups) {


  sublayout <- draw_layout(
    data,
    groups[-1])

  sublayout
}


