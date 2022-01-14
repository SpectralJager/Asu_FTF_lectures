Write-Output "start building"
xelatex -shell-escape main-report-csae | Out-Null
Write-Output "adding bibliography"
biber main-report-csae | Out-Null
xelatex -shell-escape main-report-csae | Out-Null
Write-Output "finish building, removing temp files"
rm *.aux, *.log, *.bbl, *.bcf, *.blg, *.toc, *.run.xml, *.out | Out-Null
Write-Output "done!"
