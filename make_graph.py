#!/usr/bin/env python2

import csv

from dateutil import parser as date_parser
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd

matplotlib.style.use('ggplot')


with open('result.csv', mode='rb') as csvfd:
    reader = csv.reader(csvfd, delimiter=',')
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
            d = date_parser.parse(d).date()
            if d not in data_list:
                data_list[d] = {}
            data_list[d][bug_status] = count
            index += 1

title = "Tempest bug"
filename = "tempest_bug_count.png"
plt.figure()
plt.title(title)
df = pd.DataFrame.from_dict(data_list, orient='index')
df_plot = df.plot(kind='bar', stacked=True, cmap=plt.get_cmap('Accent'))
df_plot.legend(loc='upper center', bbox_to_anchor=(0.5, 1.05), ncol=3,
          fancybox=True, shadow=True)
plt.tight_layout()
plt.savefig(filename, dpi=900)
