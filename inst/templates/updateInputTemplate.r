update&&inputName&&<-function(inputId,value,...,session = getDefaultReactiveDomain()){
message <- drop_nulls(
  list(
    value =  value,
    ...
  )
)
session$sendInputMessage(inputId, message)
}
