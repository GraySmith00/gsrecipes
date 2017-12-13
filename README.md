# README

Main Project for Professional Ruby on Rails 5 Developer Course / Mashrur / Udemy

Layout of the application

Integration Testing

Model Tests - unit testing

TDD - design the app functionality based on a test first approach

  Write the test for the functionality
  Build minimum code necessary to make each test pass
  Re-factor code so the code doesn't smell - clean code, confidence
  
Recipe
- recipe should be valid
- name should be present
- description should be present
- chef_id should be present
- maximum and minimum length for name and description

Chef
- chefname should be present
- email should be present
- size restrictions on email and chefname
- email address should be valid format
- email should be unique, case insensitive

what we already know about chefs
- chefs have a chefname, email
- chefs have a one-to-many association with recipes
- chefs can be created in the console
- we have a test suite already in place to test our chef model

what do we need going forward
- ability to sign-up chefs from the application
- we'll need to show the chef profile page
- a way to log in and log out
- chefs ability to create recipes from the application
- restrictions for the apps features, only logged in chefs can create recipes, only recipe owners can edit their recipes
- admin feature so admins can monitor the app
