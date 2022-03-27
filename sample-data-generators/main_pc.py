import random
import string
import csv

mylist = list(range(1, 31))

csvfile = open('commands_pc.csv','w')
csvwriter = csv.writer(csvfile)

fields = ['pc_id', 'name', 'address'] 
csvwriter.writerow(fields) 

for i in mylist:
  name = ''.join(random.choices(string.ascii_lowercase, k = 10))
  address = ''.join(random.choices(string.ascii_lowercase, k = 30))
  csvwriter.writerow([str(i), name, address])

csvfile.close()