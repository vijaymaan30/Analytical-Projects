USE DANNYS_DINER;
SHOW TABLES;
select * from sales;
#What is the total amount each customer spent at the restaurant?
select customer_id, sum(price)
from sales join menu on sales.product_id=menu.product_id
group by customer_id ;

#How many days has each customer visited the restaurant?
select customer_id ,count(distinct order_date)
from sales
group by customer_id;

#What was the first item from the menu purchased by each customer?
select * from menu;
SELECT customer_id, MIN(order_date)
FROM sales
GROUP BY customer_id;

select sales.customer_id,sales.order_date,menu.product_name
from sales join menu on
sales.product_id=menu.product_id
where (sales.customer_id,sales.order_date)in
(SELECT customer_id, MIN(order_date)
FROM sales
GROUP BY customer_id);


#What is the most purchased item on the menu and how many times was it purchased by all customers?
select count(menu.product_name) as purchase_count
from sales join menu on sales.product_id=menu.product_id
group by menu.product_name
order by purchase_count desc
limit 1 ;

#Which item was the most popular for each customer?
SELECT s.customer_id, m.product_name, COUNT(*) AS purchase_count
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
ORDER BY s.customer_id, purchase_count DESC;


#Which item was purchased first by the customer after they became a member?
select * from members;
SELECT s.customer_id, m.product_name
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date > mem.join_date
AND 
    (s.customer_id, s.order_date) IN (
	SELECT customer_id, MIN(order_date)
	FROM sales
	WHERE order_date > join_date
	GROUP BY customer_id
    );

#Which item was purchased just before the customer became a member?
SELECT s.customer_id, m.product_name
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE 
    s.order_date < mem.join_date
AND (s.customer_id, s.order_date) IN (
SELECT customer_id, MAX(order_date)
FROM sales
WHERE order_date < join_date
GROUP BY customer_id
    );

#What is the total items and amount spent for each member before they became a member?
SELECT s.customer_id, COUNT(*) AS total_items, SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id;

#If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
#In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?