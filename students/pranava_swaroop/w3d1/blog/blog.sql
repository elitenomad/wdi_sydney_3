create table blog(
	id serial8 primary key,
	title varchar(255),
	description varchar(80),
	bodydesc text,
	author varchar(50),
	created_at timestamp
);

INSERT INTO blog  (title, description, bodydesc, author, created_at) values ('Sinatra Postgres SQL app','Practicing Sinatra APP ice.','Practicing Sinatra APP ice.','Pranava','2014-01-20');