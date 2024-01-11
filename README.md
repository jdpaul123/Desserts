<div align="center">
  <h1 align="center">Fetch Dessert App</h1>
  <h3 align="center">iOS take home project built using SwiftUI</h3>
  <a href="https://github.com/jdpaul123/Desserts/tree/main">
    <img src="https://github.com/jdpaul123/Desserts/blob/main/Desserts/Assets/Assets.xcassets/IceCreamDog.imageset/DogEatingIceCream1%202.jpeg" alt="Logo" width="200">
  </a>
</div>

<br>
<div align="center">
  <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/SuccessDessertListView.png" alt="Dessert List View" width="200"/>
  <img src="https://github.com/jdpaul123/Desserts/blob/main/DessertsImages/DessertDetailView.png" alt="Dessert Detail View for Apple Frangipan Tart" width="200"/>
</div>

<br>
Hello hiring manager or engineer reviewing my project,
<br><br>
  &emsp; I'm excited to submit my take home project for the Fetch iOS Engineer position. I have had a great time considing the architecture, testability, and UI of this app as I planned and built it. If you have any questions about my thought process, code, or design please don't hessitate to contact me. Thank you for this opportunity!
<br><br>
Best,
<br>
JD Paul

## Contact information
* (650)619-6984
* jdpaul123@gmail.com

## Software and Language Versions
* Xcode: 15.1
* Swift: 5.9
* iOS target version: 17.2

## Features meeting requirements:
* The app gets data from the two endpoints outlined in the project specification to get the list of desserts and then the details about the dessert:
https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
* Desserts are sorted alphabetically in DataService’s getDesserts() method.
* The list of desserts are displayed in the DessertListScreen.
* The meal name, instructions, and ingredients/measurements of each dessert are displayed in the DessertDetailScreen.
* Null values from the API are filtered out in the DataService method getDessertDetails(for:).
* The app only utilizes first pary frameworks that come with Xcode. No packages were used to aid development.

## Features exceeding requirements:
### Architecture
* The app is built following MVVM principles.
* Dependencies are injected.
* There is a network and data service to seperate concerns between parts of the app. It decouples the view from the network and data logic making the app more maintainable and testable.
* The service classes conform to protocols in order to allow for the creation of mock versions when unit testing.
* The views utalize composable SwiftUI views to modularize the parts that are used to build each screen. This allows views such as the Loading View to be used on both the Dessert List Screen and the Dessert Detial Screen.

### Testing
* Unit tests are written to test DefaultNetworkService using the XCTest framework.
* Created a mock version of URLSession to isolate the system under test, DefaultNetworkService, and simulate different responses from URLSession.
* Created a stub to provide data for the tests.
* The tests are focused on making sure that functions work as intended when they succeed and when they fail (ex. throw an error).

### User Interface
* Dessert Images: The app loads images in both the DessertListScreen and DessertDetailScreen in order to provide a better user experience. There is logic in the DessertListScreenViewModel to make sure images are only ever loaded once to avoid unnecessary hardware stress and internet data usage.
* Search Bar: Created a search bar on the DessertListScreen to allow for quicker access when the user already knows what dessert recipe you want to find.
* Error Banner Modifier: Created an error banner modifier to show an error banner over the current view with a message about the error any time there is an error in the app (seen in image below on the right).

There are 3 possible screen states as data is loaded and formatted:
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
