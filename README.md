# Fetch Dessert Take Home Project

## Features meeting requirements:

Hit two endpoints to get the list of desserts and then the details about the dessert:
https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID

Sorted the Desserts Alphabetically in DataService’s getDesserts() method.

Show the list of desserts in the DessertListScreen

Show the meal name, instructions, and ingredients/measurements of each dessert in the DessertDetailScreen.

Null values from the API are filtered out in the DataService method getDessertDetails(for:).

The app builds on the latest version of Xcode (15.1) and Swift (5.9)

## Features exceeding requirements:

Follows MVVM principals focusing on injecting dependencies and using protocols in order to allow for unit testing.

Seperation of concerns using a network and data service to decouple the app making it more maintainable and testable.

Unit tests:
- Tests are written that mock the URLSession dependency in order to test the DefaultNetworkService.
- The tests are thourough and focus on making sure that functions work as intended when they succeed and when they fail (ex. throw an error).

Dessert Images. The app loads images in both the DessertListScreen and DessertDetailScreen in order to provide a better user experience. There is logic in the DessertListScreenViewModel to make sure images are only ever loaded once to avoid unnecessary hardware stress and internet data usage.

3 states Dessert List and dessert detail screens:
1. Loading state which animates the app icon as a loading indicator
2. Failed state which displays an error banner when the app fails to get the data and allows the user to pull-to-refresh the data. This would be useful if the user is not connected to internet then connects to the internet then pulls to refresh the data.
3. Success state which shows the data

Created an error banner modifier to show an error banner over the current view with a message about the error any time there is an error in the app.

Search bar on the DessertListScreen to allow for quicker access when the user already knows what dessert recipe you want to find.
