$source = "L:\3.自動車\2025年度　研究\20251119_乱数学習_検証\result"
$dest = "F:\Lab\輪講\img"

# report.pdfとoutディレクトリを除外してコピーする関数
function Copy-ItemExclude {
    param (
        [string]$Source,
        [string]$Destination
    )
    
    Get-ChildItem -Path $Source -Recurse | ForEach-Object {
        # report.pdfまたはoutディレクトリを含むパスをスキップ
        if ($_.FullName -like "*\out\*" -or $_.FullName -like "*\out" -or $_.Name -eq "out" -or $_.Name -eq "report.pdf") {
            Write-Host "除外: $($_.FullName)" -ForegroundColor Yellow
            return
        }
        
        # 相対パスを計算
        $relativePath = $_.FullName.Substring($Source.Length + 1)
        $targetPath = Join-Path -Path $Destination -ChildPath $relativePath
        
        if ($_.PSIsContainer) {
            # ディレクトリを作成
            if (-not (Test-Path $targetPath)) {
                New-Item -Path $targetPath -ItemType Directory -Force | Out-Null
                Write-Host "作成: $relativePath" -ForegroundColor Cyan
            }
        } else {
            # ファイルをコピー
            $targetDir = Split-Path -Path $targetPath -Parent
            if (-not (Test-Path $targetDir)) {
                New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
            }
            Copy-Item -Path $_.FullName -Destination $targetPath -Force
            Write-Host "コピー: $relativePath" -ForegroundColor Green
        }
    }
}

Copy-ItemExclude -Source $source -Destination $dest
Write-Host "`nコピーが完了しました。" -ForegroundColor Green
