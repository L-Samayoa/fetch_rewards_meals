# Fetch Rewards Meal by Luis Samayoa
Hello, and welcome to my demo app for Fetch Rewards! 

This demo app uses TheMealDB (https://themealdb.com/api.php) to fetch meals (desserts) and output them in a list. From there, users are able to select any meal on the list to then see the details on that meal. 

## How the app works
This App starts in the MealsListView. As soon as the MealListViewModel is initialized, the meals are fetched from TheMealDB using the APIRequestHandler. 
As long as no errors occur, then the meals are loaded. All images are loaded as AsyncImages (more on that later).

From there, when a user taps on a row in the list, the MealDetailsView is loaded onto the screen, and the meal details for that meal are then fetched from the TheMealDB. Again, as long as no errors occur, the details for that 
meal are shown. Users can then go back and select any other meals. 

If for some reason there is any error in fetching either the meal or the meal details, a message and button appear on the screen, informing the user of some error and allowing them to attempt to refetch using the button. 

## Why certain things were done
I added this section to explain why certain design choices were made and alternate choices I could have done. 

Why Async Images? Why not just fetch all the images in the beginning when fetching the meals and save them once? Well, there's 2 reasons. 
1) Saving images would have required another url call for each image, per meal, right after fetching all the meals. This would have taken even more time to load all the meals. For this demo app, its probably better to just load the app quickly. If this app had to be used offline though, that would be another story.
2) AsyncImage is a cool way of fetching images from a url. You can have a loading spinner and a default image if the image doesn't load, all in the UI pretty easily. I just wanted to get better using it.

_________________________________________________________________

Why no unit tests?
Originally I was going to add unit tests, but then as I worked on the app, the only thing to actually unit test would have been the APIRequestHandler. That would have required:
1) Adding fake data for testing
2) Testing for when making requests while offline
3) Testing for changes in the response
4) Testing for successes
   
All in all, a lot of testing for this little demo app. If given more time and if the app had more complicated features, I would have added them 100%. 
