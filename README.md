<div align="center">
  <h3 align="center">Fetch Dessert SwiftUI Take Home Project</h3>
  <a href="https://github.com/jdpaul123/Desserts/tree/main">
    <img src="https://github.com/jdpaul123/Desserts/blob/main/Desserts/Assets/Assets.xcassets/IceCreamDog.imageset/DogEatingIceCream1%202.jpeg" alt="Logo" width="200">
  </a>
</div>

<br>
<div align="center">
  <p float="left">
    <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/SuccessDessertListView.png" alt="Dessert List View" width="200"/>
    <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/DessertDetailView.png" alt="Dessert Detail View for Apple Frangipan Tart" width="200"/>
  </p>
</div>

## Features meeting requirements:

Hit two endpoints to get the list of desserts and then the details about the dessert:
https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID

Sorted the Desserts Alphabetically in DataService’s getDesserts() method.

Show the list of desserts in the DessertListScreen

Show the meal name, instructions, and ingredients/measurements of each dessert in the DessertDetailScreen.

Null values from the API are filtered out in the DataService method getDessertDetails(for:).

The app utalizes SwiftUI and builds on the latest version of Xcode (15.1) and Swift (5.9)

## Features exceeding requirements:

### Architecture
Follows MVVM principals focusing on injecting dependencies and using protocols in order to allow for unit testing.

Seperation of concerns using a network and data service to decouple the app making it more maintainable and testable.

### Testing
- Tests are written for DefaultNetworkService.
- Created a mock verion of URLSession to isolate the system under test, DefaultNetworkService, and simulate different responses from URLSession.
- Created a stub to provide data for the tests.
- The tests are focus on making sure that functions work as intended when they succeed and when they fail (ex. throw an error).

### User Interface
Dessert Images: The app loads images in both the DessertListScreen and DessertDetailScreen in order to provide a better user experience. There is logic in the DessertListScreenViewModel to make sure images are only ever loaded once to avoid unnecessary hardware stress and internet data usage.

Search Bar: Created a search bar on the DessertListScreen to allow for quicker access when the user already knows what dessert recipe you want to find.

Error Banenr Modifier: Created an error banner modifier to show an error banner over the current view with a message about the error any time there is an error in the app (seen in image below on the right).

3 states Dessert List and dessert detail screens:
1. Loading state which animates the app icon as a loading indicator
2. Failed state which displays an error banner when the app fails to get the data and allows the user to pull-to-refresh the data. This would be useful if the user is not connected to internet then connects to the internet then pulls to refresh the data.
3. Success state which shows the data

<div align="center">
  <p float="left">
    <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/SuccessDessertListView.png" alt="Success State for the Dessert List Screen" width="200"/>
    <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/LoadingView.png" alt="Loading State with spinning dog icon" width="200"/>
    <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/FailedViewWithBanner.png" alt="Failed State with Error Banner" width="200"/>
  </p>
</div>
