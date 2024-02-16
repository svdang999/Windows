# Compress files older than xxx days script
# Tested in Windows Server
$limit = (Get-Date).AddDays(-30)
$path = "C:\Test\2015\test\api\Log"

# Get files older than the $limit.
$folders = Get-ChildItem -Path $path -directory -Force | Where-Object {($_.LastWriteTime -lt $limit)}

# Zip folders into files
foreach ($folder in $folders) {
	write-host "start compress folder" $folder
	Compress-Archive -Path ($folder.FullName + "\*") -DestinationPath ($folder.FullName + ".zip") -CompressionLevel fastest -force
	# Delete folder after zipped
	write-host "folder compressed, cleanup folder" $folder
	Remove-Item -LiteralPath ($folder.FullName) -Force -Recurse
}
