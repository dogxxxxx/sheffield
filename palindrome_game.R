first_lgrid <- matrix(NA, nrow = 8, ncol = 8)
first_lgrid[1,] <- c("LeftUp", "Up", "Up", "Up", "Up", "Up", "Up", "RightUp")
first_lgrid[2,] <- c("Left", "Next", "Next", "Next", "Next", "Green", "Next", "Right")
first_lgrid[3,] <- c("Left", "Next", "Next", "Next", "Next", "Next", "Green", "Right")
first_lgrid[4,] <- c("Left", "Next", "Next", "Next", "Next", "Next", "Next", "Right")
first_lgrid[5,] <- c("Left", "Next", "Next", "Next", "Next", "Next", "Next", "Right")
first_lgrid[6,] <- c("Left", "Green", "Next", "Next", "Next", "Next", "Next", "Right")
first_lgrid[7,] <- c("Left", "Next", "Green", "Next", "Next", "Next", "Next", "Right")
first_lgrid[8,] <- c("LeftDown", "Down", "Down", "Down", "Down", "Down", "Down", "RightDown")

lgrid <- matrix(NA, nrow = 8, ncol = 8)
lgrid[1,] <- c("r", "l", "q", "s", "t", "z", "c", "a")
lgrid[2,] <- c("i", "v", "d", "z", "h", "l", "t", "p")
lgrid[3,] <- c("u", "r", "o", "y", "w", "c", "a", "c")
lgrid[4,] <- c("x", "r", "f", "n", "d", "p", "g", "v")
lgrid[5,] <- c("h", "j", "f", "f", "k", "h", "g", "m")
lgrid[6,] <- c("k", "y", "e", "x", "x", "g", "k", "i")
lgrid[7,] <- c("l", "q", "e", "q", "f", "u", "e", "b")
lgrid[8,] <- c("l", "s", "d", "h", "i", "k", "y", "n")
rownames(lgrid) <- c("A", "B", "C", "D", "E", "F", "G", "H")
colnames(lgrid) <- c(1:8)
green_squares_alp <- c(lgrid["F","2"], lgrid["G", "3"], lgrid["B","6"], lgrid["C","7"])

first_step <- function(){
  times <- 1
  first_row <- sample(1:8, 1)
  first_column <- sample(1:8, 1)
  first_sign <- first_lgrid[first_row, first_column]
  while(first_sign != "Next"){
    times = times + 1
    first_row <- sample(1:8, 1)
    first_column <- sample(1:8, 1)
    first_sign <- first_lgrid[first_row, first_column]
  }
  first_token <- lgrid[first_row, first_column]
  token_collected <- list(first_token)
  next_coor <- list(next_row = first_row, next_column = first_column, token_collected = token_collected, times = times, fourth = "dd")
  
  next_coor <- list(first_row, first_column,token_collected, times, "dd")
  return(next_coor)
}

at_right <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row - 1):(current_row + 1), 1)
  next_column <- sample((current_column - 1):current_column, 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row - 1):(current_row + 1), 1)
    next_column <- sample((current_column - 1):current_column, 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_left <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row - 1):(current_row + 1), 1)
  next_column <- sample((current_column):(current_column + 1), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row - 1):(current_row + 1), 1)
    next_column <- sample((current_column):(current_column + 1), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_up <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row):(current_row + 1), 1)
  next_column <- sample((current_column - 1):(current_column + 1), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row):(current_row + 1), 1)
    next_column <- sample((current_column - 1):(current_column + 1), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_down <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row - 1):(current_row), 1)
  next_column <- sample((current_column - 1):(current_column + 1), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row - 1):(current_row), 1)
    next_column <- sample((current_column - 1):(current_column + 1), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_leftup <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row):(current_row + 1), 1)
  next_column <- sample((current_column):(current_column + 1), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row):(current_row + 1), 1)
    next_column <- sample((current_column):(current_column + 1), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_rightup <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row):(current_row + 1), 1)
  next_column <- sample((current_column - 1):(current_column), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row):(current_row + 1), 1)
    next_column <- sample((current_column - 1):(current_column), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_rightdown <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row - 1):(current_row), 1)
  next_column <- sample((current_column - 1):(current_column), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row - 1):(current_row), 1)
    next_column <- sample((current_column - 1):(current_column), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_leftdown <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row - 1):(current_row), 1)
  next_column <- sample((current_column):(current_column + 1), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row - 1):(current_row), 1)
    next_column <- sample((current_column):(current_column + 1), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

at_next <- function(current_row, current_column, token_collected, times){
  next_row <- sample((current_row - 1):(current_row + 1), 1)
  next_column <- sample((current_column - 1):(current_column + 1), 1)
  while(next_row==current_row && next_column==current_column){
    next_row <- sample((current_row - 1):(current_row + 1), 1)
    next_column <- sample((current_column - 1):(current_column + 1), 1)
  }
  return(list("next_row" = next_row, "next_column" = next_column, "token_collected" = token_collected, "times" = times))
}

next_step <- function(row, column, token_list, times, fourth, p){
  if(first_lgrid[row, column]=="Right"){
    next_square_list <- at_right(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="RightUp"){
    next_square_list <- at_rightup(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="RightDown"){
    next_square_list <- at_rightdown(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="Up"){
    next_square_list <- at_up(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="Down"){
    next_square_list <- at_down(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="Left"){
    next_square_list <- at_left(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="LeftUp"){
    next_square_list <- at_leftup(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="LeftDown"){
    next_square_list <- at_leftdown(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="Green"){
    next_square_list <- at_next(row, column, token_list, times)
  } else if(first_lgrid[row, column]=="Next"){
    next_square_list <- at_next(row, column, token_list, times)
  }
  next_square_list[[5]] <- fourth
  # Green squares rules
  if(first_lgrid[next_square_list[[1]], next_square_list[[2]]] == "Green"){
    prob <- runif(1)
    if(prob<p){
      next_square_list[[3]] <- list("f", "f", "h", "k")
      next_square_list[[5]] <- "f"
    } else{
      next_square_list[[3]] <- next_square_list[[3]][next_square_list[[3]] != lgrid[next_square_list[[1]], next_square_list[[2]]]]
    }
  } else{
    # get the alphabet
    token <- lgrid[next_square_list[[1]], next_square_list[[2]]]
    # set the rules of getting the token or not
    if(length(next_square_list[[3]]) < 3){
      next_square_list[[3]] <- append(next_square_list[[3]], token)
    } else if((length(next_square_list[[3]]) == 3)&&(token %in% next_square_list[[3]])){
      next_square_list[[3]] <- append(next_square_list[[3]], token)
      next_square_list[[5]] <- token
    } else if(length(next_square_list[[3]]) == 4){
      if((length(next_square_list[[3]][duplicated(next_square_list[[3]])])==1)){
        if((token!=next_square_list[[5]])&&(token%in%next_square_list[[3]])){
          next_square_list[[3]] <- append(next_square_list[[3]], token)
        }
      } else if(length(next_square_list[[3]][duplicated(next_square_list[[3]])])==3){
        next_square_list[[3]] <- append(next_square_list[[3]], token)
      } else if(length(next_square_list[[3]][next_square_list[[3]]%in%next_square_list[[5]]])==2){
        next_square_list[[3]] <- append(next_square_list[[3]], token)
      } else if((length(next_square_list[[3]][next_square_list[[3]]%in%next_square_list[[5]]])==3)&&(token%in%next_square_list[[3]])){
        next_square_list[[3]] <- append(next_square_list[[3]], token)
      }
    }
  }
  times <- times + 1
  next_square_list[[4]] <- times
  return(next_square_list)
}

run <- function(a, p=1){
  while(length(a[[3]]) < 5){
    a <- next_step(a[[1]], a[[2]], a[[3]], a[[4]], a[[5]], p=p)
  }
  # if(length(a[[3]])==5){
  #   print(unlist(a[[3]]))
  # }
  return(a[[4]])
}
# get the average amounts of steps
test_result <- list()
p <- readline(prompt = "enter p for green squares: ")
p <- as.numeric(p)
for(i in 1:50000){
  next_coor <- first_step()
  test_result[[i]] <- run(next_coor, p)
}
print(mean(unlist(test_result)))