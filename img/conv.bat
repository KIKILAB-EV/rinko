dir /S /B /A-D *.svg > pdf_list_svg.txt 
for /f "tokens=1 delims=." %%a in (pdf_list_svg.txt) do (inkscape -p %%a.svg -o %%a.pdf)