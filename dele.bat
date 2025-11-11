::D.svg, reward.svg, N.svg, Vc.svgを削除
@echo off
for /R %%a in (.) do (
    
    :: フォルダが存在するか確認
    echo %%a
    if exist "%%a\D.svg" (
        
        :: 削除を実行
        del "%%a\D.svg"
    )
    if exist "%%a\reward.svg" (
        
        :: 削除を実行
        del "%%a\reward.svg"
    )
    if exist "%%a\N.svg" (
        
        :: 削除を実行
        del "%%a\N.svg"
    )
    if exist "%%a\Vc.svg" (
        
        :: 削除を実行
        del "%%a\Vc.svg"
    )
)