#!/usr/bin/python


import sys #used to facilitate arguments in terminal
import requests
from bs4 import BeautifulSoup
import wikipedia
from nltk.corpus import stopwords
import string
from nltk.stem import PorterStemmer
stemmer = PorterStemmer()
from nltk.tokenize import sent_tokenize, word_tokenize

if sys.argv[1] == "--h":
	print ''
	print '***************************************'
	print '************** help menu **************'
	print '***************************************'
	print ''
	print 'author: JJ Espinoza'
	print 'description: Pulls data from various sources'
	print 'created: 2017-12-13'
	print ''
	print 'commands:                 descriptions:'
	print '_______________________________________'
	print ''
	print '--h                           help menu'
	print '--wikisearch ["keword"]       returns related wiki pages'
	print '--wikiinfo ["page"]           provides page summary'
	print '--wikiscrape ["page"]         scrapes page'
	print '--links ["url"]               scrapes hyperlinks on page'


#####################
if sys.argv[1] == "--links":
	url = sys.argv[2]
	#returns HTML content
	r = requests.get(url)
	#Converted into something useful
	soup = BeautifulSoup(r.content)
	#extract all hyperlinks for each link document
	for link in soup.find_all('a'):
		print(link.text, link.get('href'))

if sys.argv[1] == "--wikisearch":
		print(wikipedia.search(sys.argv[2]))

if sys.argv[1] == "--wikiinfo":
		print(wikipedia.summary(sys.argv[2]))

if sys.argv[1] == "--wikiscrape":
		#dictionary of wikipages
		titles = ['20th Century Women', '47 Meters Down', 'A Bad Moms Christmas', 'A Cure for Wellness','A Question of Faith', 'A Quiet Passion', 'Alien: Covenant', 'All Eyez on Me (film)', 
		'All Saints (film)', 'Alvin_and_the_Chipmunks__The_Road_Chip', 'American_Assassin', 'American_Hustle', 'American Made (film)', 'An_Inconvenient_Sequel_Truth_to_Power', 'Annabelle__Creation', 'Annie (2014 film)','Ant-Man', 'Arrival (film)', 'Atomic_Blonde','Avengers: Age of Ultron', 'Baby Driver','Bad_Moms', 'Badrinath_Ki_Dulhania','Barbershop__The_Next_Cut','Batman_v_Superman__Dawn_of_Justice','Battle of the Sexes (film)','Baywatch (film)','Beatriz_At_Dinner', 'Beauty and the Beast (2017 film)','Before_I_Fall (film)','Birth_of_the_Dragon','Blade_Runner_2049','Born_In_China', 'Bridge of Spies (film)','Brooklyn (film)', 'Call Me by Your Name (film)','Captain Fantastic (film)','Captain_Underpants__The_First_Epic_Movie', 'Carol (film)', 'Cars_3', 'Central_Intelligence', 'Cinderella (film)','Coco (2017 film)','Collide (film)', 'Colossal (film)', 'Creed','Deadpool (film)','Despicable_Me_3', 'Detroit (film)','Diary_of_a_Wimpy_Kid__The_Long_Haul','Divergent_allegiant', 'Doctor Strange (2016 film)', 'Dunkirk (2017 film)','Everybody_Loves_Somebody_film','Everything_everything_film', 'Ex Machina (film)', 'Eye in the Sky (2015 film)', 'Fantastic_Beasts_and_Where_to_Find_Them_film', 'Fences_film', 'Fifty_Shades_Darker', 'Fifty_Shades_Of_Grey', 'Finding_Dory', 'Fist_Fight_film','Friend_Request', 'Furious_7', 'Geostorm', 'Get_Hard', 'Get_Out', 'Ghost in the Shell (2017 film)','Gifted_film', 'Girls_Trip', 'Gone Girl (film)', 'Goosebumps_film', 'Guardians_of_the_Galaxy_Vol._2', 'Happy_Death_Day', 'Hazlo_Como_Hombre', 'Hell or High Water (film)', 'Hello__My_Name_is_Doris', 'Hidden_Figures', 'Home Again (2017 film)', 'Hotel_Transylvania_2','How_to_Be_a_Latin_Lover', 'I_Am_Not_Your_Negro', 'Independence_Day__Resurgence','Inside Out (2015 film)', 'It_Comes_At_Night', 'Jackie (2016 film)', 'Jigsaw (2017 film)', 'John_Wick__Chapter_2', 'Jurassic_World', 'Justice_League_film', 'Kidnap (2017 film)', 'King_Arthur__Legend_of_the_Sword', 'Kingsman__The_Golden_Circle', 'Kong__Skull_Island', 'Kubo_and_the_Two_Strings', 'Kung_Fu_Panda_3', 'La La Land (film)', 'Lady_Bird_film', 'Let There Be Light (2017 film)', 'Logan_film', 'Logan_Lucky', 'Love Friendship film', 'Lowriders_film', 'Mad_Max__Fury_Road', 'Magic_Mike_XXL', 'Manchester_by_the_Sea_film', 'Maudie (film)', 'Maze_Runner__The_Scorch_Trials', 'Megan_Leavey_film', 'Minions', 'Miracles_from_Heaven_film', 'Mission__Impossible_-_Rogue_Nation', 'Moana (2016 film)', 'Monster_Trucks_films','Mother!', 'Murder on the Orient Express (2017 film)']
		
		for movie in titles:
			page = wikipedia.page(movie)
			print(page.title)
			print(page.url)
			page_content = page.content

			#extracting plot
			def find_between(s, first, last):
				try:
					start = s.index(first) + len(first)
					end = s.index(last, start)
					return s[start:end]
				except ValueError:
					return ""

			plot = find_between(page_content, "== Plot ==", "== Cast ==")
			plot_utf8 = str(plot.encode('utf8'))

			#remove stop words
			cachedStopWords = stopwords.words('english')
			plot_nostop = ' '.join([word for word in plot_utf8.split() if word not in cachedStopWords])

			#removing punctuation
			plot_nopunc = plot_nostop.translate(None, string.punctuation)

			#stemming words (removing tense)
			#http://www.nltk.org/howto/stem.html

			#Implement LSMD to reduce variables (see Miguel's paper)

			#saving final file
			f = open(page.title + '.txt', 'w')
			f.write(plot_nopunc)
			f.close()