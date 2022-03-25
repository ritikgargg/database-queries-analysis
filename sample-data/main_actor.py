import random
import string
import csv

mylist = list(range(1, 301))

csvfile = open('commands_actor.csv','w')
csvwriter = csv.writer(csvfile)

fields = ['a_id', 'name'] 
csvwriter.writerow(fields) 

for i in mylist:
  res = ''.join(random.choices(string.ascii_lowercase, k = 15))
  csvwriter.writerow([str(i), res])
  # file.write("INSERT INTO actor values(" + str(i) + "," + "\"" +  str(res) + "\"" + ");\n")

csvfile.close()