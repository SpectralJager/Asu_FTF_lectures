Write-Output "start building"
xelatex -shell-escape OsipenkoDV_595_report | Out-Null
Write-Output "adding bibliography"
biber OsipenkoDV_595_report | Out-Null
xelatex -shell-escape OsipenkoDV_595_report | Out-Null
Write-Output "finish building, removing temp files"
rm *.aux, *.log, *.bbl, *.bcf, *.blg, *.toc, *.run.xml, *.out, *.fdb_latexmk, *.fls | Out-Null
Write-Output "done!"
