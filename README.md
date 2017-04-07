# hair_salon
An app for a hair salon

The following user stories were:
As a salon owner, I want to view, add, update and delete stylists.
As a salon owner, I want to view, add, update and delete clients.
As a salon owner, I want to add clients to a stylist.

To view this app you will need to create a database:
1. Install and run psql
2. CREATE DATABASE hair_salon;
3. CREATE TABLE clients (id serial primary key, name varchar);
4. CREATE TABLE stylists (id serial primary key, name varchar, stylist_id int);
5. CREATE DATABASE hair_salon_test TEMPLATE hair_salon;
6. Open another tab in terminal and save this in an appropriate folder by running git clone https://github.com/kenNg1/hair_salon.git
7. Navigate into the folder created and run ruby app.rb

To view the functionality, click on ADMIN in the top right corner of the page.



