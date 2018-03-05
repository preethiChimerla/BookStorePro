# BookStorePro

| <img src="https://github.com/preethiChimerla/BookStorePro/blob/master/AppScreenShots/1.jpg" width="240" height="400"> | <img src="https://github.com/preethiChimerla/BookStorePro/blob/master/AppScreenShots/2.jpg" width="240" height="400"> |
|--|--|
| <img src="https://github.com/preethiChimerla/BookStorePro/blob/master/AppScreenShots/3.jpg" width="240" height="400"> | <img src="https://github.com/preethiChimerla/BookStorePro/blob/master/AppScreenShots/4.jpg" width="240" height="400"> |


## Implementation:
 - UI designed as per the mockups at http://prolific-interview.herokuapp.com/5a95a8a94ba45b000a4399df/
 - UI Components include TableView & a custom TableView cell, Text Fields, Buttons, NavigationControllers.
 - Used Auto Layouts, StackViews to align components
 - Used Alamofire Networking library to perform basic async networking calls to interact with API
 - Please find the attached screenshots
 - Developed project in MVC pattern.
 
 ## How to run this App:
 - Download Project and run the app in Xcode.
 - If any errors, try cleaning the project in Xcode and rerun the app.

## User Operations:

**Landing Page:**
 - Click '+' icon to add new book details
 - Swipe a book to left to delete a book
 - 'Trash' Icon will prompt to delete all books
 
**Book Details Page**
 - '>Books' click to go back to view list of books
 - 'Share Icon' on top right will allow to share the following text 
	 "ex: Harry Potter by J.K. Rowling is a great book to read!"
 - Checkout button prompts user to enter his/her name and will updates book with user name and time details as checked out user.

	 
**Add Book Page**
 - Fill all the book details to create a new book, all fields are mandatory else displays an alert.
 - Once a book is created, it displays message to user and allows user to create another book, when "Done" button on the top right is clicked it navigates to previous page.


