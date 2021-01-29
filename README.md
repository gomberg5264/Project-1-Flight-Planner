# Project-1-Flight-Planner

A flight booking website (mimicking aviation company's online booking systems) made for the second project of the GA Software Engineering Course

Live Website: https://floating-refuge-91114.herokuapp.com/

## Further Improvements

* The site alerts users when they cancel bookings or delete flights, but it might be better to give them the option to cancel the action as well
* A CRUD system for airports could be added to the site

## Technologies Used
* HTML (with embedded Ruby)
* CSS and Bootstrap for styling
* Ruby on Rails
* PostgreSQL
* Heroku (for deployment)
* Geokit Gem (to calculate flight distances)

## Website Production Updates

### 29/01/21 1:00pm

Step Five Complete: The website can determine flight distances and estimate arrival times in local time. It is more user friendly, displaying local times in a readable way. I didn't have time to add a CRUD system for the airports. I reviewed the code, adding comments to the controllers and tested the website to ensure it is stable.

### 27/01/21 11:50pm

Step Four in Progress Complete: Styling Complete. Seat number tracking complete. The next step is to determine flight distances / arrival time and make the website more user friendly (addressing the issues listed above). Adding a CRUD system for airport is a lower priority.

### 26/01/21 5:30pm

Step Three Complete: Permissions added. Pages that require user login are only available to logged in users and pages that require admin status are only accessible to admin. In the current version, users must be logged in to search for and view flights. This may be changed in later versions. Bootstrap and basic styling added. Website deployed on Heroku. The next step is to improve the styling and start adding bonus functionality.

### 25/01/21 9:40pm

Step Two Complete: Basic functionality added, including CRUD systems for users and flights, as well as the ability to search for, book and cancel flights. Users can log in, though the site currently gives no indication as to who is logged in and all of the site's functionality is available to all users. The next step is to ensure that only logged in users can access the site's functionality and that only admins can access admin-specific pages and forms.

### 24/01/21 11:50pm

Step One Complete: Database set up and seeded (users and flights appear on the website correctly). Routes, controller and views set up for users and flights. No routes, controllers or views will be needed for the airports, though they may be added as bonus functionality in Step Four. The next step is to add basic functionality (user CRUD systems, user log in / log out, flight searching / booking and flight CRUD systems).

## Website Production Plan

### Step One
* Create a new Ruby on Rails project
* Design, create and seed a database with information about users, flights, airports and how they're connected
* Design a user story and use that to set up the routes, controllors and views needed for the website
* Add the basic site layout to application.html.erb (navber, headings, etc.)
* Commit initial version to GitHub and edit readme file

### Step Two
* Add general functionality related to the users (sign up, log in, edit details, sign out)
* Add general functionality related to the flights (view booked flights, search for flights, book flights, cancel flights)
* Add admin specific functionality (view user index, create flights, edit flights, delete flights)
* Commit updated version to GitHub and edit readme file

### Step Three
* Apply permissions (make sure that users need to be logged in to use the site and that admin-specific functionality is only accessible to admins)
* Style the website using CSS and Bootstrap
* Test the website as a potential user/admin to make sure everything works
* Deploy the website (if it hasn't been deployed already)
* Commit updated version to Heroku and edit readme file

### Step Four - bonus functionality
* Prevent users from massively overbooking a flight by including data about the plane and number of seats available
* Use the Google Maps API to estimate flight distances and therefore arrival times
* Enable airports to be added, edited and deleted
* Commit updated version to Heroku and edit readme file (copy this readme file into the readme file from the main project and add heroku link to the description)

### Step Five
* Review and optimise code wherever possible
* Test the website as a potential user/admin to make sure everything (including bonus functionality) works
* Commit updated version to Heroku and edit readme file
