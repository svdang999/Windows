# Compress files older than xxx days script
# Tested in Windows Server
$limit = (Get-Date).AddDays(-24)
$path = "C:\Test\2015\tim-exrate-auto\api\Log"

# Get files older than the $limit.
$folders = Get-ChildItem -Path $path -directory -Force | Where-Object {($_.LastWriteTime -lt $limit)}

# Zip folders into files
foreach ($folder in $folders) {
	Add-Content $path\compress-file.log "`nStart compress folder $path\$folder at $(get-date -Format yyyy-MMM-dd_hh:mm:ss)" 
	Compress-Archive -Path ($folder.FullName + "\*") -DestinationPath ($folder.FullName + ".zip") -CompressionLevel fastest -force
	# Delete folder after zipped
 	Add-Content $path\compress-file.log "`nfolder compressed, cleanup folder $folder" 
	Remove-Item -LiteralPath ($folder.FullName) -Force -Recurse
}
