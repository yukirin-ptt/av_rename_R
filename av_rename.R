## Library
list.of.packages <- c("rvest", "tidyverse", "stringr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(rvest)
library(tidyverse)
library(stringr)

## read stdin args
args <- commandArgs(trailingOnly=TRUE)
file.path <- args[1]
file.path.names <- list.files(file.path)
# file.path <- "/Volumes/Untitled/AAAAA_not named/"
print(paste("All", length(file.path.names), "files." ))

######### crawler and parser functions
CleanAVFileName <- function(original.file.name){
    ## Helper function of GetAVFileName()
    ## Cleans original file name to av serial number
    ## Input: "21bt.net-SNIS830C.avi" => output: "SNIS830"
    str_extract(string = original.file.name, "[A-Za-z]{2,5}\\-?\\d{2,5}")
}

GetAVFileName <- function(file.name){
    ## Transform a unorganized av file name to a "Actress - Viedo title - [serial number]" format
    ## Input: "21bt.net-SNIS830C.avi" => 
    ## output: "橋本ありな - 橋本ありなの濃厚接吻とフェラチオ尽くし - [SNIS-830].avi"
    
    ##  
    result <- c()
    
    ## get serial number and file extention
    serial.number　<- CleanAVFileName(file.name) 
    file.extension = str_extract(string = file.name, "\\.[A-Za-z0-9]{3}$")
    
    ## call arzon serach api
    search.url <- paste("https://www.arzon.jp/index.php?action=adult_customer_agecheck&agecheck=1&redirect=https%3A%2F%2Fwww.arzon.jp%2Fitemlist.html%3Ft%3D%26m%3Dall%26s%3D%26q%3D", 
                        serial.number, sep="")
    search.result <- read_html(search.url,encoding="UTF-8") 
    ## get all results and their paths of corresponding description page
    search.result %>% 
        html_nodes("div dl a") %>% 
        html_attr("href") %>%
        grep("item", ., value = TRUE) %>%
        unique() -> search.result.paths
    
    ## get informations from each description page
    for(path in search.result.paths){
        item.url <- paste("https://www.arzon.jp", path, sep="")
        item.content <- read_html(item.url, encoding="UTF-8")
        
        ## video title
        item.content %>%
            html_nodes("h1") %>%
            as.character() %>%
            gsub("<h1>|</h1>", "", .) %>%
            trimws() -> item.title
        ## details of video
        item.content %>% 
            html_nodes("table.item") %>%
            html_table() %>%
            `[[`(1) -> item.content.table
        
        item.content.table %>%
            filter(str_detect(X1, "女優")) %>%
            `$`(X2) %>%
            gsub("\\n\\s+", " ", .) -> item.actress.name
        
        item.content.table %>%
            filter(str_detect(X1, "品番")) %>%
            `$`(X2) %>%
            paste("[", ., "]", sep="")-> item.actress.sn
        
        # pre-defined format
        n <- paste(item.actress.name," - ", item.title," - ", item.actress.sn, file.extension, sep="")
        result <- c(result, n)
    }
    
    ## check outputs
    result.check <- str_detect(result, "廃盤") 
    if(all(result.check)){
        return(result)
    }else{
        return(result[!result.check])
    }
}

Main <- function(file.path.names){
    for(i in 1:length(file.path.names)){
        ## get processed file name
        file.name.to.process <- file.path.names[i] 
        result.av.name <- GetAVFileName(file.name.to.process)
        
        ## print the result
        print(file.name.to.process)
        print(result.av.name)
        
        if(is.null(result.av.name) == F){ 
            cat("OK to rename? Press Enter/return to rename as the first result, 
                n to ignore this file and pass the renaming, 
                m to rename with a user defined file name> ")
            accept <- scan("stdin", character(), n=1, blank.lines.skip=F)
            
            if(accept == ""){
                from.name <- paste(file.path, file.name.to.process, sep="")
                to.name <- paste(file.path, result.av.name[1], sep="")
                file.rename(from=from.name, to=to.name)
            }else if(accept == "n"){
                print("Ignored.")
            }else if(accept == "m"){
                input.file.name <- readline(prompt="New file name please:")
                from.name <- paste(file.path, file.name.to.process, sep="")
                to.name <- paste(file.path, input.file.name, sep="")
                file.rename(from=from.name, to=to.name)
            }
        }else{
            print("No result, renaming passed.")
        }
    }
}



## Run
Main(file.path.names)
