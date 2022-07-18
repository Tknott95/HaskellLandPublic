import requests
import shutil # to save img locally
from bs4 import BeautifulSoup
import re
import sys

def getUrl(x):
  return "https://www.wikiart.org/en/"+x+"/all-works/text-list"


artistName = sys.argv[1]
URL = getUrl(artistName) # "https://www.wikiart.org/en/salvador-dali/all-works/text-list"
PAGE = requests.get(URL)
SOUP = BeautifulSoup(PAGE.content, "html.parser")

titles = []

print('\n Searching for artist: ', artistName)
regexUrl = '/en/'+artistName+'/'

for a in SOUP.find_all('a', href=True):
    print( "Found the URL:", a['href'])
    ijk = re.split(regexUrl, a['href'])
    if len(ijk) == 2:
      titles.append(ijk[1])

      r = requests.get("https://uploads7.wikiart.org/images/"+artistName+"/"+ijk[1]+"(1).jpg", stream = True)
      if r.status_code == 200:
        r.raw.decode_content = True
      
        with open("ArtData/"+artistName+"/"+ijk[1]+".jpg", 'wb') as f:
          shutil.copyfileobj(r.raw, f)

        print('Downloaded: ', ijk[1])
      else:
        print('Image failed: ', ijk[1])


print(titles)
