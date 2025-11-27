# 简单的脚本，用于将随机的*.cj文件复制到测试目录

# 获取所有*.cj文件路径
$allCjFiles = Get-ChildItem -Path cangjie_test -Filter *.cj -Recurse | Select-Object -ExpandProperty FullName

# 目标目录
$targetDirs = @("tests", "tree-sitter-cangjie/tests")

# 为每个目录复制50个随机文件
foreach ($dir in $targetDirs) {
    Write-Host "复制文件到 $dir..."
    $randomFiles = $allCjFiles | Get-Random -Count 50
    $counter = 0
    
    foreach ($file in $randomFiles) {
        $counter++
        $newName = "test_$(Get-Date -Format 'HHmmss')_$counter.cj"
        $destPath = Join-Path $dir $newName
        
        try {
            Copy-Item -Path $file -Destination $destPath -Force
            Write-Host "✓ 复制 $file 到 $destPath"
        } catch {
            Write-Host "✗ 复制失败: $file 到 $destPath - $_"
        }
    }
    
    Write-Host "完成复制 $counter 个文件到 $dir"
}

Write-Host "\n所有操作完成！"