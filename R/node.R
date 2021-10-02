#' Modify a shiny tag.

#' @name node
#' @param x a shiny tag

#' @export
node=function(x){
  htmlTree$new(x)
}
htmlTree = R6::R6Class(
  'htmlTree',
  public = list(
    node=NULL,
    areas=list(),
    initialize = function(node) {
      assert_class(node,'shiny.tag')
      self$node=node

    },
    find=function(...){


      private$.find(node=self$node,index=NULL,self_node=expr(self$node),attrs=list(...))
      return(invisible(self))
    },
    html=function(value){
      if(length(value)==1){
        value=rep(value,length(self$areas))
      }
      if(length(value)>1){
        assert_length(value,length(self$areas))
      }
      tmp=lapply(self$areas,eval,envir=current_env())
      tmp=map2(tmp,value,function(x,y){
        x[[3]]<-y
        return(x)
      })
      print("here")
      map2(self$areas,tmp,function(a,x,env){
        eval(expr(!!a<-!!x),envir=env)
      },env=current_env())
      return(self$node)
    },
    attr=function(attr,value=NULL){
      assert_string(attr,null.ok = TRUE)
      if(is.null(attr)&&is.null(value)){

        return(self$node[[2]])
      }
      if(is.null(value)&&nnull(attr)){
        return(self$node[[2]][[attr]])
      }
      if(is.null(attr)&&nnull(value)){
        assert_named(value)
        dnames<-names(value)
        map2(dnames,value,function(x,y){
          self$node[[2]][[x]]=y
        })
        return(self$node)
      }
      assert_length(value,len=1)
      self$node[[2]][[attr]]=value
      return(self$node)
    },
    set_data=function(data){
      assert_named(data)
      attrs<-names(data)
      map2(attrs,data,self$data)
      return(invisible(self$node))
    },
    data=function(attr=NULL,value=NULL){
      assert_string(attr,null.ok = TRUE)
      if(is.null(attr)&&is.null(value)){
        wd_names<-self$attrs%starts_with%"data-"
        out=self$node[[2]][wd_names]
        names(out)<-str_remove(self$attrs[wd_names],'^data-')
        return(out)
      }
      if(is.null(value)&&nnull(attr)){
        return(self$node[[2]][[paste0("data-",attr)]])
      }
      if(is.null(attr)&&nnull(value)){
        g_stop('`attr` name must not be NULL. Use set_data() to set multiple attributes at once')
      }
       if(length(value)>1||is.list(value)){
         value=jsonlite::toJSON(value,auto_unbox = T)
       }
      self$node[[2]][[paste0("data-",attr)]]=value
      return(self$node)
    },

    next_level=function(exp_in,index){

      tmp=expr(ex[[!!index]])
      tmp[[2]]<-exp_in
      tmp
    }
  ),
  private = list(
    .find=function(node=self$node,index=NULL,self_node=expr(self$node),attrs){
      if(!is.null(index)){

        self_node<- self$next_level(self_node,index)
        #print(deparse(self_expr))
      }
      x<-tag_type(node)

      switch(x,
             'constant'=FALSE,
             'tag'={
               test<-tagAssertAttributes(node,attrs)

               if(test){
                 append(self$areas)<-self_node
               }else{
                 self_node<- self$next_level(self_node,3)
                 map2(node[[3]],
                      1:length(node[[3]]),
                      private$.find,
                      self_node = self_node,
                      attrs = attrs)
               }
             },
             'taglist'={
               map2(node[[3]],
                    1:length(node[[3]]),
                    self$.find,
                    self_node = self_node,
                    attrs = attrs)
             })
      return()
    }
  ),
  active = list(
    attrs = function(value) {
      if (missing(value)) {
        return(names(self$node$attribs))
      }
      stop("attrs is read only")

    }
  )
)
tagAssertAttribute=function(name,value,tag){
  if(name=='class'){
    present_classes<- str_split(unlist(tag[[2]][names(tag[[2]])=='class']),"\\s+") %>% unlist()
    if(len0(   present_classes))return(FALSE)
    classes<-unlist(str_split(value,"\\s+"))
    return(all(classes%in% present_classes))
  }

  tmp<-tag[[2]][[name]]
  if(is.null(tmp))return(FALSE)

  return(tmp==value)
}
tagAssertAttributes=function(tag,attrs){
  dots<-assert_named(attrs)
  all(map2(names(dots),dots,tagAssertAttribute,tag=tag) %>% unlist())
}
tag_type=function(x){

  if(is(x,'shiny.tag')){
    return('tag')
  }
  if(is(x,"list")){
    return("taglist")
  }
  if(checkmate::test_atomic(x)){
    return('constant')
  }
  g_stop("dont know how to handle type:{class(x)}")
}
