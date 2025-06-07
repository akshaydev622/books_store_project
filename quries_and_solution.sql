
select * from books
where genre = "Fiction";

select * from books
where published_year > 1950;

select * from customers
where country = "Canada";

select * from orders
where order_date between '2023-11-01' and '2023-11-30';

select sum(stock) as total_stock
from books;

-- 6. Find the details of the most expensive book.
select * from books
order by price desc limit 1;

-- 7. show all customers who ordered more than 1 quantity of a book.
select customers.customer_id, customers.name, orders.Quantity from customers
join orders
on customers.Customer_ID = orders.Customer_ID
where Quantity > 1;

-- 8. Retrieve all orders where the total amount exceeds $20.
select * from orders
where Total_Amount > 20;

-- 9. List all genre available in the books table.
select genre from books
group by genre;
-- or
select distinct genre from books;

-- 10. Find the total revenue generated from all orders.
select sum(total_amount) as total_generated_revenue 
from orders;

-- 11. Find the book with the lowest stock.
select * from books
order by stock asc
limit 1;

-- advance questions

-- 1. Retrieve the total number of books sold for each genre.
select books.Book_ID,books.title, books.Genre as genre, sum(orders.Quantity) total_books from books
join orders
on books.Book_ID = orders.Book_ID
group by genre;

-- 2. Retrieve the stock of total number of books for each genre.
select genre, sum(stock) as total_books 
from books
group by genre;

-- 3.Find the average price of books in the "Fantasy" genre.
select genre, sum(price) as average_price 
from books
where genre = "Fantasy";

-- or for all genre
select genre, sum(price) as average_price 
from books
group by genre;

--4. List customers who have placed at least 2 orderes.
select customers.Name, orders.Customer_ID as customer_id, count(Order_ID) as total_order from customers
join orders
on customers.Customer_ID = orders.Customer_ID
group by customer_id
having total_order >= 2;

-- 5. Find the most frequently ordered book.
select books.Title as title, books.Book_ID as book_id, count(orders.Order_ID) as total_orders from books
join orders
on books.Book_ID = orders.Book_ID
group by book_id
order by total_orders desc;

-- 6. show the top 3 most expensive books of 'Fantasy' Genre.
select title, Genre, price from books
where genre = "Fantasy"
order by price desc
limit 3;

-- 7. Retrieve the total quantity of books sold by each author.
select books.Author as auther, sum(orders.Quantity) as total_books_sold
from books
join orders
on books.Book_ID = orders.Book_ID
group by auther
order by total_books_sold desc;

--  8. List the cities where customers who spent over $30 are located.
select customers.city as city, sum(orders.quantity*books.price) as total_price  from customers
join orders
on customers.customer_id = orders.customer_id
join books
on orders.book_id = books.book_id
group by city
having total_price > 30
order by total_price;

-- or another method
select customers.city as city, sum(orders.total_amount) as total_price  from customers
join orders
on customers.customer_id = orders.customer_id
group by city
having total_price > 30
order by total_price;

-- or another result
select distinct customers.city, orders.total_amount  from customers
join orders
on customers.customer_id = orders.customer_id
where Total_Amount > 30
order by total_amount;

-- 9. Find the customer who spent the most on orders.
select customers.customer_id as customer_id, customers.name, sum(orders.total_amount) as pay_amount from customers
join orders
on customers.customer_id = orders.customer_id
group by customer_id
order by customer_id desc
limit 1;

-- 10. Calculate the stock remaining after fulfilling all orders.
select books.book_id, books.stock , coalesce(sum(orders.quantity),0) 
as order_quantity, coalesce(books.stock - sum(orders.quantity), books.stock) as remaining_stock
from books
left join orders
on books.book_id = orders.book_id
group by book_id;



