#' @importFrom R6 R6Class
#' @export
enterApp = R6Class(
  'enterApp',
  public = list(
    initialize = function(user='user',pw='pw') {
      private$.randomSalt=create_unique_id()
      private$.table = data.table(
        pw = sha256(pw, key = private$.randomSalt),
        user = sha256(user, key = private$.randomSalt)
      )
    },
    reset_user_password=function(user,pw,new_user,new_pw){
      setkey(private$.table)
      user_enter=sha256(user, key = private$.randomSalt)
      pw_enter <-sha256(pw, key = private$.randomSalt)

      user_new=sha256(new_user, key = private$.randomSalt)
      pw_new <-sha256(new_pw, key = private$.randomSalt)
      out<-private$.table[user==user_enter&pw==pw_enter]
      if(nrow(out)>0){
        g_stop('user/password combination not found')
      }
      private$.table[user==user_enter&pw==pw_enter,
                     c('user','pw'):=.list( user_new,pw_new)]
    },
    enter=function(user_enter,pw_enter){
      setkey(private$.table)
      user_enter=sha256(user_enter, key = private$.randomSalt)
      pw_enter <-sha256(pw_enter, key = private$.randomSalt)
      out<-private$.table[user==user_enter&pw==pw_enter]
      if(nrow(out)>0){
        private$.login_attempts=0
        return(TRUE)
      }
      private$.login_attempts<-
        private$.login_attempts+1
      glue("Username and password incorrect({private$.login_attempts})")
    },
    new_user=function(user,pw){
      private$.table = rbindlist(list(private$.table,data.table(
        pw = sha256(pw, key = private$.randomSalt),
        user = sha256(user, key = private$.randomSalt)
      )))
    }
  ),
  private = list(
    .randomSalt=NULL,
    .table=NULL,
    .login_attempts=0
  )
)

