# 获取所有*.cj文件路径
$allCjFiles = Get-ChildItem -Path cangjie_test -Filter *.cj -Recurse | Select-Object -ExpandProperty FullName

# 目标测试目录列表
$targetDirs = @("tests", "tree-sitter-cangjie/tests")

# 为每个目标目录复制文件
foreach ($targetDir in $targetDirs) {
    # 为每个目录随机选择100个文件
    $randomFilesForDir = $allCjFiles | Get-Random -Count 100
    
    Write-Host "\nCopying 100 random .cj files to $targetDir..."
    
    foreach ($file in $randomFilesForDir) {
        # 生成唯一的文件名
        $fileName = "test_$(Get-Random -Minimum 100 -Maximum 999).cj"
        $targetPath = Join-Path $targetDir $fileName
        
        # 复制文件内容
        Copy-Item -Path $file -Destination $targetPath
        
        Write-Host "Copied $file to $targetPath"
    }
}

Write-Host "\nDone! Copied 100 random .cj files to each target directory"