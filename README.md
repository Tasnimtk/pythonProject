# pythonProject
This repository is dedicated to the project within the python and R for data science Lab.
The file API.py represents the first step of the project, which is collecting data from an API.
The data chosen is from the Art institute of Chicago (https://api.artic.edu/docs/#introduction) We collected 1500 observations related to artworks.
Before collecting the data, we chose the features we deemed important for our analysis. To do so, we edited the URL using 'fields'.
The features chosen are:
page: the page in which the observation is [from 1 to 15]
id: integer - Unique identifier of this resource. Taken from the source system.
title: string - The name of this resource
main_reference_number: string - Unique identifier assigned to the artwork upon acquisition
has_not_been_viewed_much: boolean - Whether the artwork hasn't been visited on our website very much
date_start: number - The year of the period of time associated with the creation of this work
date_end: number - The year of the period of time associated with the creation of this work
date_display: string - Readable, free-text description of the period of time associated with the creation of this work. This might include date terms like Dynasty, Era etc. Written by curators and editors in house style, and is the preferred field for display on websites and apps.
artist_display: string - Readable description of the creator of this work. Includes artist names, nationality and lifespan dates
place_of_origin: string - The location where the creation, design, or production of the work took place, or the original location of the work
exhibition_history: string - List of all the places this work has been exhibited
colorfulness: float - Unbounded positive float representing an abstract measure of colorfulness.
department_title: string - Name of the curatorial department that this work belongs to
artist_title: string - Name of the preferred artist/culture associated with this work
style_title: string - The name of the preferred style term for this work
classification_title: string - The name of the preferred classification term for this work

We then set the limit of the page to 100 instead of the default 12 to facilitate looping.
Finally, we extracted the data from 15 pages, and then we merged them all in a new file.
