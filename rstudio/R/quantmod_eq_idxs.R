# Quantitative ALM, Financial Econometrics & Derivatives 
# ML/DL using R, Python, Tensorflow by Sang-Heon Lee 
#
# https://kiandlee.blogspot.com
#--------------------------------------------------------#
# read historical prices of stock indices
#========================================================#

graphics.off(); rm(list = ls())

library(quantmod)
library(stringr) # trim

#-------------------------------------------------
# Symbols of stock indices, as of 2022-08-14
#-------------------------------------------------
vstr_symbol <- "
    Symbol    ,    Name
    ^GSPC     ,    S&P 500   
    ^DJI      ,    Dow 30
    ^IXIC     ,    Nasdaq
    ^NYA      ,    NYSE COMPOSITE (DJ)
    ^XAX      ,    NYSE AMEX COMPOSITE INDEX   
    ^BUK100P  ,    Cboe UK 100
    ^RUT      ,    Russell 2000
    ^VIX      ,    CBOE Volatility Index
    ^FTSE     ,    FTSE 100
    ^GDAXI    ,    DAX PERFORMANCE-INDEX
    ^FCHI     ,    CAC 40
    ^STOXX50E ,    ESTX 50 PR.EUR
    ^N100     ,    Euronext 100 Index
    ^BFX      ,    BEL 20
    ^N225     ,    Nikkei 225
    ^HSI      ,    HANG SENG INDEX
    000001.SS ,    SSE Composite Index
    399001.SZ ,    Shenzhen Index
    ^STI      ,    STI Index
    ^AXJO     ,    S&P/ASX 200
    ^AORD     ,    ALL ORDINARIES
    ^BSESN    ,    S&P BSE SENSEX
    ^JKSE     ,    Jakarta Composite Index
    ^KLSE     ,    FTSE Bursa Malaysia KLCI
    ^NZ50     ,    S&P/NZX 50 INDEX GROSS
    ^KS11     ,    KOSPI Composite Index
    ^TWII     ,    TSEC weighted index
    ^GSPTSE   ,    S&P/TSX Composite index
    ^BVSP     ,    IBOVESPA
    ^MXX      ,    IPC MEXICO   
    ^TA125.TA ,    TA-125   
    ^JN0U.JO  ,    Top 40 USD Net TRI Index
    "

#-------------------------------------------
# split symbols and make vector
#-------------------------------------------
df <- read.table(text = str_trim(vstr_symbol), 
                 sep = ",", header = TRUE)
df <- as.data.frame(df); df

df$Symbol <- str_trim(gsub("[\t\r\n,]", "", df$Symbol))
df$Name   <- str_trim(gsub("[\t\r\n,]", "", df$Name))
df
nc <- nrow(df) # number of index

#-------------------------------------------
# read price information
#-------------------------------------------
sdate <- as.Date("2001-01-01")
edate <- as.Date("2022-08-12")
getSymbols(df$Symbol, from=sdate, to=edate)


#-------------------------------------------
# collect only adjusted prices
#-------------------------------------------
price <- NULL
for(i in 1:nc) {
  eval(parse(text=paste0(
    "price <- cbind(price,`",
    gsub("\\^","",df$Symbol[i]),"`[,6])")))
}

# modify column Name as only symbol
colnames(price) <- gsub(".Adjusted", "", 
                        colnames(price))

# convert to data.frame with the first column as Date
df.price <- cbind(time=time(price), as.data.frame(price))
rownames(df.price) <- NULL

# partial selection of complete cases 
# by S&P 500, Nikkei 225, HANG SENG INDEX
df.price <- df.price[complete.cases(
  df.price[,c("GSPC","N225","HSI")]),]

#-------------------------------------------
# print time series of daily prices
#-------------------------------------------
head(df.price,3)
tail(df.price,3)
