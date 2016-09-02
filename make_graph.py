import csv
import pandas as pd
import matplotlib


# NOTE: To avoid the following error:
# _tkinter.TclError: no display name and no $DISPLAY environment variable
matplotlib.use('Agg')

reader = csv.reader(open('result.csv', 'rb'), delimiter=',')
date = reader.next()
data_list = {}
for row in reader:
        # row is like ['NEW', '24', '25', '25', '25', '25', '25', '25']
        # and the first is a bug status(NEW, INPROGRESS, etc.)
        bug_status = row.pop(0)
        index = 1
        #print(bug_status)
        for colum in row:
            try:
                count = int(colum)
            except ValueError:
                continue
            d = date[index]
            #print("%s: %s" % (d, count))
            if d not in data_list:
                data_list[d] = {}
            data_list[d][bug_status] = count
            index += 1

title = "Tempest bug"
filename = "tempest_bug_count.png"
df = pd.DataFrame.from_dict(data_list, orient='index')
plot = df.plot(kind='barh', stacked=True).set_title(title)
fig = plot.get_figure()
fig.savefig(filename)

