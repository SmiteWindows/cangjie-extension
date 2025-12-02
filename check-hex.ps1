#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$filePath = "D:\新建文件夹\qianwenai\cangjie-extension\validate-ps1-simple.ps1"

# Read the file content as bytes
$bytes = [System.IO.File]::ReadAllBytes($filePath)

# Show hex view of the param block
$paramBlockStart = [Array]::IndexOf($bytes, [byte]60)  # Find '<' character which starts the help block
$paramBlockBytes = $bytes[($paramBlockStart + 1)..(min $bytes.Length ($paramBlockStart + 500))]

Write-Host "Hex dump of the param block area:"
Write-Host "=" * 80

$hexString = [BitConverter]::ToString($paramBlockBytes) -replace "-", " "
Write-Host $hexString

# Convert bytes to string for inspection
$paramBlockString = [System.Text.Encoding]::UTF8.GetString($paramBlockBytes)
Write-Host ""
Write-Host "String content:"
Write-Host "=" * 80
Write-Host $paramBlockString

# Show detailed byte analysis around line 50
Write-Host ""
Write-Host "Detailed analysis around line 50:"
Write-Host "=" * 80

# Find the param keyword
$paramKeyword = [System.Text.Encoding]::UTF8.GetBytes("param(")
$paramIndex = 0
for ($i = 0; $i -lt $bytes.Length - $paramKeyword.Length; $i++) {
    if (@(for ($j = 0; $j -lt $paramKeyword.Length; $j++) { $bytes[$i + $j] -eq $paramKeyword[$j] }) -notcontains $false) {
        $paramIndex = $i
        break
    }
}

# Show bytes around param block
$startIndex = [Math]::Max(0, $paramIndex - 100)
$endIndex = [Math]::Min($bytes.Length, $paramIndex + 200)
$paramAreaBytes = $bytes[$startIndex..$endIndex]

for ($i = 0; $i -lt $paramAreaBytes.Length; $i++) {
    $byte = $paramAreaBytes[$i]
    $char = [char]$byte
    Write-Host "Offset $($startIndex + $i): 0x$($byte.ToString('X2')) '$char'" -ForegroundColor $(if ($byte -eq 0x2C) { 'Red' } else { 'White' })
}
