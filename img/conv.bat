for /f %%f in ('dir /S /B /A-D *.svg') do (
    inkscape "%%f" --export-filename="%%~dpnf.pdf"
)