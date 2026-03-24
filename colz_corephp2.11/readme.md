#### Day 0 (Student Copy)

- **Register form only**
- **with fields (name, username, password, confirmed_password)**

#### Day 1 (Done by Teacher) - registration, form field validation without session
- **registration form complete**
- **create database 
    - create table(id, name, username, password)
    - connect the database 
- **register the user**
    - validate the input data
    - check the field is empty or not
    - check user existence
    - register user
    - insert data validate with $conn->affected_rows > 0
- **css class added for**
    - error message (red)
    - success message (green)
- **show the success message** 
    - if user registered successfully
- **show the error message**
    - if field is empty
    - if password do not match
    - if username already exist 
---------------
**TASK for Login Page**
    - login the user with valid username/password
    - show the error   
        - if username/password mismatched (authentication failed message)
        - if field is empty

#### Day 2 (Done by Teacher) - login page, redirect to dashboard page, form field validation without session
- **login form complete**
- **create page**
    - login.php page
    - dashboard.php page ('simple welcome username')
- **login page**
    - check the field is empty or not
    - validate the username and password
    - redirect to dashboard page

#### Day 3 (Done by Teacher) - getFormValue and validateForm using session, separate - css js connection file
- **welcome username in dashboard (using session)**
- **getFormValue function for FORM**
- **validateForm function for FORM**
- **Error show using**
    - method 1 - using function (DONE in login.php)
    - method 2 - using session (DONE in register.php)
- **separate file**
    - database connection file (must be done on top of file)
    - css file (assets/css/style.js)    
    - js file (assets/js/script.js)
- **url link added in login and register page**
    - already registered (login.php)    
    - forgot password (forgot.php)
    - not registered yet (register.php)
   
#### Day 4 (Student Copy) - Only Template added - index page (menu and card)
- **index.php is added**
- **TODO**
    - all menu buttons are:
        - login button
        - logout button
        - register button
        - dashboard button
        - user button
        - card button
        - home button
    - auth buttons are:
        - logout button
        - dashboard button
        - user button
        - card button
    - unauth buttons are:
        - register button
        - login button
    - common button are:
        - home button
    
#### Day 4.2 (Student Copy Latest) - CSS login/register CSS bug fixed
- **BUG Fixed**
    - login page - CSS bug fixed
    - register page - CSS bug fixed

#### Day 4.3 (Done by Teacher) - navmenu added on index and dashboard page, table added in dashboard page
- **index.php created with menu added**
    - login button
    - logout button
    - register button
    - dashboard button
    - user button (dashboard.php)
    - card button
    - home button
- **dashboard.php created**
    - copied exact code of index.php
    - cards replace with responsive table    