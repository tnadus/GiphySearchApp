# GiphySearchApp by Murat Sudan
A showcase project which let the user search gif images on the GIPHY portal with using GIPHY API.

The App is a demonstration of below items:

- Allow the user to enter a search term
- Use [GiphyAPI](https://developers.giphy.com/) to perform live search on user's entered term
- Display search results
- Allow user to tap on a GIF to see basic GIF information, such as creation date, author, rating and title

### Language
This app is written in swift language (%100)

### How to run
Since the project is an implementation of basic task,
this project is not using any 3rd party libraries, so to run the app, it's enough
to hit the build button.

### Added missed tasks
- images have real images sizes in search list
- pinterest style collection view layout is used
- thumbnail gif images are used for seachlist, original gif image is used for the detailed screen
- live search capability is added

### Notes
This project is nice example of how to implement testable code with using
SOLID princibles and a good abstraction between different architectural layers

- First implementation took 6-7 hours and the refinement tooke 2 hours
- I think, all the tests are important, but the business logic tests (these are the presenter tests in the project) are the most vital ones.
