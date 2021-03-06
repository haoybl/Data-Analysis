#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
#						Database Connectivity
#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------

library(RODBC)
# Connect to ODBC ##
# Connect to the DataSource defined under d/b  ##

CHANNEL <- odbcConnect("OD_DP","Platform","ugam@1234")

#---------------------------------------------------------------------------------------------------------------
#  					    View list of all tables 
#---------------------------------------------------------------------------------------------------------------


sqlTables(CHANNEL)

#---------------------------------------------------------------------------------------------------------------
#					   Select particular table 
#---------------------------------------------------------------------------------------------------------------


TB_Retailer_Product_History <- sqlTables(CHANNEL, errors = FALSE, as.is = TRUE,
                               catalog = "Platform_Officedepot_UAT", schema = "dbo", 
                               tableName = "tb_Retailer_Product_History", 
                               tableType = "TABLE", literal = FALSE)

TB_fin_data <- sqlTables(CHANNEL, errors = FALSE, as.is = TRUE,
                                         catalog = "Platform_Officedepot_UAT", schema = "dbo", 
                                         tableName = "tb_fin_data", 
                                         tableType = "TABLE", literal = FALSE)

#---------------------------------------------------------------------------------------------------------------
#					Reading tables from ODBC d/b 
#---------------------------------------------------------------------------------------------------------------



system.time(TB_Retailer_Product_History_DF <- as.data.frame(sqlFetch(CHANNEL,"tb_Retailer_Product_History")))
system.time(TB_fin_data_DF <- as.data.frame(sqlFetch(CHANNEL,"TB_fin_data")))

class(TB_Retailer_Product_History_DF);dim(TB_Retailer_Product_History_DF)
names(TB_Retailer_Product_History_DF)


#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
