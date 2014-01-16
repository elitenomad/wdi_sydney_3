###Objective:
Use sinatra to host a basic website with some static files and a contact-us form.


###Specification:

You will split your students list page into separate pages, and make it run on sinatra.

* There will be a main page of the app that is displayed when you ask for the root URL ('/').
* Each student-section now becomes its own page with a common route structure of "/students/<student_name>"
* The contact-form will now have its own page.
* There will be a new "about" page.
* other pages as appropriate to the solutions below...

####main page

The main page of the app will contain the list of links to the students, and
maybe you could put picture or somethign to make it look pretty.


####about page

Add an "about" page that describes the WDI course in general and what you're
learning or similar (make it fun).

####contact us page

Make sure your contact-us form has important fields like the subject of the
email and the return email address of the sender.
Use appropriate HTML5 tags where you can.

make your contact form post to a separate sinatra end-point.
Check that the person has filled in the important fields.
If they haven't, redisplay the form with error messages, otherwise
display a "thank you" page.

####student pages

Just make them look prettier.

####general page structure

Put a header at the top.
Add a menu to the header that has links to all the student-pages and the list
of students should be on the right-hand side of the header.

Make sure that the header shows up on all pages (so you can move between
student pages by clicking on the menu links).

Add a link to the left-hand side of the header that will take you back to
the main page.  Find a suitable logo/icon to use for that.

Add a footer that appears on all the pages. 
you should have three links in the footer to: home, about, contact-us
Add a suitable copyright message.

####more sinatra goodness

Download a copy of the images for the students and make them files in an
appropriate directory instead of just urls.

Figure out how to nicely handle a 404 to display a nicer page.

Make it all look pretty (you can use CSS this time!)

Try to apply the DRY principle as much as possible.


####Extra credit: 
A) Find out how you can get sinatra to *actually* email somebody from your form.

B) Have a play with twitter bootstrap to make it look awesome:
http://getbootstrap.com/
