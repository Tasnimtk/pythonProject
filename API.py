#calling the necessary packages
import pandas
import json
import requests

#The dataset containts a total of 115506 artworks.
#we are going to extract 1500 observations. We set the limit to 100 and we paginate through 15 pages
#create a list of characters to loop in and append to the url
pages = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]

#we make a loop to extract the 15 pages
for i in pages:
  url = "https://api.artic.edu/api/v1/artworks?page=" + i + "&fields=id%2Ctitle%2Cdate_display%2Cmain_reference_number%2Ccolorfulness%2Chas_not_been_viewed_much%2Cexhibition_history%2Cartist_title%2Cstyle_title%2Cclassification_title%2Cdate_start%2Cdate_end%2Cdepartment_title%2Cartist_display%2Cplace_of_origin%2Cpage%3D&limit=100"
  response = requests.get(url)
  file = open("./file-" + i + ".json", "w+")
  print(file.name)
  file.writelines(response.text)
  file.close()

#we create an empty list to put in it the data we need, and append them
result = []

#now we loop
for i in pages:
    json_data = json.load(open("./file-" + i + ".json"))
    #there are two sections in the json file, pagination and data.
    #We are only interested in data as it includes the values we would like to see in our dataset.
    for h in json_data['data']:
        x = [i] + list(h.values())
        result.append(x)
##### now we create a csv file

#we name it
csv_file_path = 'merged_pages.csv'

#the list "result" includes our data: structured
df = pandas.DataFrame(result)

#we define the column names
df.columns = ['page', 'id', 'title', 'main_reference_number','has_not_been_viewed_much', 'date_start', 'date_end', 'date_display', 'artist_display', 'place_of_origin', 'exhibition_history', 'colorfulness', 'department_title', 'artist_title', 'style_title', 'classification_title']

#finally, we save it in a csv file
df.to_csv(csv_file_path, index=False, sep =";")






