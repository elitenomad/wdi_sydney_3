Build a simple blog
This is a CRUD app with the resource being the "post"

posts have:
1) title
2) short description/abstract
3) body text (possibly very long)
4) author (just a single string for the name)
5) date+time created (call it created_at)


Your app should let you:
1. display a list of posts
2. each item on the list has a title and the short description
3. the title should take the user to the "show" page for a post
4. the URL for showing a post should be like: /posts/1234
where 1234 is the id of the post
5. the "show" page shoud list allt he relevant details of a post
6. the list page should have a "create" button that takes the user to the
form that lets you create a new post. 
7. the form should POST the details to the /posts URL
8. The user shouldn't be allowed to update the "created_at" field... that will be
set just in your code before you save the information to the database

This seems like a huge set of things... don't try to build it all at once.
1) First - spend *at least* 15min writing down a full list of things you need to do as a todo list. you will do that right now before we leave.
2) Then decide which thing is the simplest thing you could do, and do that first.
3) check it works! if it doesn't fix it before moving on
4) repeat steps 2-4


Extra credit:
8. The "show" page for a post should have a "delete" button that will delete the post by POSTing to /posts/1234/destroy
9. The "show" page for a post should have an "edit" button that will take you to a page where you can edit and re-save the post. The URL for this should be /posts/1234/edit and the form should POST to /posts/1234 - the show page should still work with the same URL!
10. Refactor the database connection initialization so that it appears ONLY ONCE in the program (ie db = PgConn.new...)  ( Hint : before ... do )
11. Use the sinatra/rails convention for changing a POST to a DELETE and change sinatra to respond to a delete instead



Remember - it's not important to get this site pretty. 
Meet the spec *first* and when you're done with that - then spend time on
nice-to-haves like prettiness or any neat ideas you come up with along the
way.
Put those nice-to-haves in your todo list so that you don't lose them, but
put them last on the list so you know that you shouldn't be working with
them until the end.