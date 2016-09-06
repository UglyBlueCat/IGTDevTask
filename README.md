# IGTDevTask

## Task description

Implement a simple 2 view application. The app should parse the JSON file provided with the test

and display the info as described below. The application must adhere to proper MVC design

guidelines, to be established by the developer.

Model:

The application will need to pull the latest version of the JSON from the url provided using the

right iOS Foundation api’s. The data retrieved will then need to be cached into a text file with an

expiry date of 1 hour. The application will then use the data from this text file to populate its views.

View 1:

Display a list of items using the value of data.name as the label. On clicking an item it should take

you to View 2 which will display the details of the game.

View 2:

Display the name, jackpot and date of the game, using best practices for locale formatting. Use

currency provided in JSON to format jackpot.

Provide navigations to return back to View 1.

Send us the source code of the completed task.

JSON file location :- https://dl.dropboxusercontent.com/u/49130683/nativeapp-test.json

## Requirements:

• All dates and numbers must have correct localisation support and should be displayed using

the device’s locale.

• Code must be written and leverage the latest Swift syntax.

The project must be done in XCode7

• Code must be compatible with iOS8+

• Use of third party libraries is not preferred

• Correct attribution must be kept for all code

• Views must use adaptive layout, and the app should be Universal.
