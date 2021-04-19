
# Set the stage
# Run this as administrator
Set-ExecutionPolicy Bypass -Scope Process

# Install these modules if they are not already installed.  (probably not)
Install-Module -Name ImportExcel
Import-Module -Name ImportExcel

# Check the Import Excel Module is available.
Get-Module -Name ImportExcel  


# Set the location where the Excel file is located.
# Set the file name and the extension too.
# The file is a csv.
$location = “C:\Users\moais\OneDrive\Documents\2021\1 Backups\4 Apr\Apr 16\”
$file = "Survey Apr 16 2021"
$extension = ".csv"
$full = $location + $file + $extension

$all = Get-Content $full


#  Set the server name, Database name schema and the table name.
$SQLServerInstance    = "DESKTOP-5V655NJ"
$DatabaseName         = "DSP"
$SchemaName           = "dbo"
$TableName            = "UserQuestions"

,(Import-Excel -path $Full -ErrorAction Stop)
Write-SqlTableData -serverinstance $SQLServerInstance -DatabaseName $DatabaseName -SchemaName $SchemaName  -TableName $TableName  -force -ErrorAction Stop

#Import the data into a powershell object
$data = import-csv $full

#Write-SqlTableData -serverInstance $SQLServerInstance  -database $DatabaseName  -TableName $TableName  -SchemaName $SchemaName  -InputData  $data  -PassThru

 $CSVImport = Import-CSV -Path $full
 ForEach ($CSVLine in $CSVImport){

 $PlayerID =[int] $CSVLine.PLayerID
 $QuestionSeq=$CSVLine.QuestionSeq
 $Question=$CSVLine.Question
 $Response=$CSVLine.Response
 $SQLInsert = "INSERT INTO [dbo].UserQuestions (PlayerID,	QuestionSeq,	Question,	Response)
  VALUES('$PlayerID', '$QuestionSeq', '$Question', '$Response');"
 Invoke-SQLCmd -ServerInstance  $SQLServerInstance  -Database $DatabaseName  -Query $SQLInsert
 }

