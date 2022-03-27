import random
import csv

movies = list(range(1, 1001))

csvfile = open('commands_casting.csv','w')
csvwriter = csv.writer(csvfile) 

fields = ['m_id', 'a_id'] 
csvwriter.writerow(fields) 

for i in movies:
  l = list(random.sample(range(1, 300001), 4))
  for j in l:
    row = [str(i), str(j)]
    csvwriter.writerow(row)
    # file.write("INSERT INTO casting values(" + str(i) + "," + str(j) + ");\n")

csvfile.close()