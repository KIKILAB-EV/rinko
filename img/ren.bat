@echo off
for /R %%a in (.) do (
    
    :: フォルダが存在するか確認
    echo %%a
    if exist "%%a\グラフ" (
        
        :: リネームを実行
        ren "%%a\グラフ" "graph"
    )
)