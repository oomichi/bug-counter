git checkout master
git pull
./merge-counts-into-single-csv.sh
git add data/
git commit -m "Add new data"
git push origin master
