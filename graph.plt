set datafile separator ','

set title 'Tempest bug triage'
set xlabel 'Date'
set ylabel 'Count'

set output 'result.png'
set style data histogram
set style histogram rowstacked

plot 'result.csv' using  2:xtic(1)

