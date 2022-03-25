import random
import string
import csv

mylist = list(range(1, 301))

csvfile = open('commands_movie.csv','w')
csvwriter = csv.writer(csvfile)

fields = ['m_id', 'name', 'year', 'imdb_score', 'pc_id'] 
csvwriter.writerow(fields) 

for i in mylist:
  m_id = i
  name = ''.join(random.choices(string.ascii_lowercase, k = 10))
  
  imdb_score = round(random.uniform(1, 5), 1)
  pc_id = random.randint(1, 80000)
  
  if i % 10  == 0:
    year = random.randint(1900, 1989)
  else:
    year = random.randint(1990, 2000)
  
  csvwriter.writerow([str(m_id), name, str(year), str(imdb_score), str(pc_id)])
  # file.write("INSERT INTO actor values(" + str(i) + "," + "\"" +  str(res) + "\"" + ");\n")

csvfile.close()