#ggplot codes
geomCode<-function(type,data,x,y,ymin=NULL,ymax=NULL,group=NULL,color=NULL,linetype=NULL,shape=NULL){
  # browser()
	# if (is.null(data)||!is.null(x)||!is.null(y)||!is.null(ymin))
  if (is.null(data)&&is.null(x)&&is.null(y)&&is.null(ymin))
		return()
  # browser()
  name<-data
	type<-GetTypeText(type)
	data<-GetDataText(name)
	x<-GetXText(x)
	y<-GetYText(y)
	ymin<-GetYText(ymin)
	ymax<-GetYText(ymax)
	group<-GetGroupText(group)
	color<-GetGroupText(color)
	linetype<-GetGroupText(linetype)
	shape<-GetGroupText(shape)
	if(is.null(x)&&is.null(y)&&(is.null(ymin)&&is.null(ymax))){return()}else{
  	if(!is.null(y)||!(is.null(ymin)&&is.null(ymax))){
  	  geomCode<-SetEveryY(type,data,x,y,ymin,ymax,group,color,linetype,shape)
  	}else{
  	  geomCode<-GetGeomCode(type,data,x,y,ymin,ymax,group,color,linetype,shape)
  	}
	}
	return(geomCode)

}

#anasisy Y
SetEveryY<-function(type,data,x,y,ymin=NULL,ymax=NULL,group=NULL,color=NULL,linetype=NULL,shape=NULL){
  if(is.null(y)&&(is.null(ymin)&&is.null(ymax)))
    return()
  if(!is.null(y)){
    j<-1L
    geomCode<-c()
    for(i in y){
      geomCode[j]<-GetGeomCode(type,data,x,i,ymin,ymax,group,color,linetype,shape)
      j<-j+1
    }
    geomCodes<-paste(geomCode,collapse ="+")
    geomCodes
  }else{
    GetGeomCode(type,data,x,y,ymin,ymax,group,color,linetype,shape)
  }
}



#Get ggplot Geom Codes
GetGeomCode<-function(type,data,x,y,ymin=NULL,ymax=NULL,group=NULL,color=NULL,linetype=NULL,shape=NULL){
  if(is.null(type))
    return()
  # browser()
  ls1<-paste(sep=",",collapse =",",c(x,y,ymin,ymax,group,color,linetype,shape))
  aes<-paste(sep="","aes","(",ls1,")")

  j<-1
  Code<-c()
  for(i in type){
    Code[j]<-paste(sep="",i,"(",paste(sep=",",data,aes),")")
                   j<-j+1
  }
  Codes<-paste(Code,collapse ="+")
  Codes
}


GetTypeText<-function(data){
	if(is.null(data))
		return()
  GetTypeText<-paste(sep="","geom_",data)
  GetTypeText
}

GetDataText<-function(data){
  if(is.null(data))
  return()
  GetDataText<-textp("data",data)
  GetDataText
}



GetXText<-function(data){
  if(is.null(data))
  return()
  GetXText<-textp("x",data)
  GetXText
}



# GetYText<-function(data){
#   if(is.null(data))
#   return()
#   GetYText<-textp("y",data)
#   GetYText
# }
GetYText<-function(data){
  if(is.null(data))
    return()
  name<-substitute(data)
  GetYText<-textp(name,data)
  GetYText
}



GetGroupText<-function(data){
  # browser()
  if(is.null(data))
  return(NULL)
  n<-length(data)
  name<-substitute(data)
  # browser()
  if(n==1){
    GetGroupText<-textp(name,data)
    GetGroupText
  }else{
    text<-paste(sep="",collapse=",",c(data))
    text<-paste(sep="",collapse="","interaction(",text,",","sep = ':'",")")
    GetGroupText<-textp(name,text)
    GetGroupText
  }
}

#textp int
textp1<-function(name,data){
  if(is.null(data)||is.null(name))
  return()
  if(is.character(data)){
  GetDataText<-paste(sep="",name,"=",data)
  }
  else{
  GetDataText<-paste(sep="",name,"=",substitute(data))
  }
  GetDataText
}

#textp final
textp<-function(name,data){
  if(is.null(data)||is.null(name))
  return()
  GetDataText<-paste(sep="",name,"=",data)
  GetDataText
}
