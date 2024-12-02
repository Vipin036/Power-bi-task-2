create table sales(OrderID int, CustomerID varchar, ProductID varchar, Quantity int, SalesAmount real, Profit real,
                      OrderDate date, Region varchar);
create type loyaltytier_enum as enum('Bronze','Silver','Gold','Platinum');

create table customer(CustomerID varchar, CustomerName varchar(30), Gender varchar, Age int, LoyaltyTier loyaltytier_enum);
	
create table product(ProductID varchar, ProductName varchar, Category varchar, Subcategory varchar, Price real);


	
\copy sales from '/Users/vipinhedaoo/Documents/Data_Analytics/Power BI/Power BI Task/cust_sales.csv' delimiter ',' csv header;
\copy customer from '/Users/vipinhedaoo/Documents/Data_Analytics/Power BI/Power BI Task/cust_customer.csv' delimiter ',' csv header;
\copy product from '/Users/vipinhedaoo/Documents/Data_Analytics/Power BI/Power BI Task/cust_product.csv' delimiter ',' csv header;

select * from sales;
select * from customer;
select * from product;

alter table sales add column profit_margin double precision;
update sales set profit_margin = round((profit/salesamount) * 100);

alter table customer add column age_group varchar;
update customer set age_group = case 
	     when age between 18 and 25 then 'Youth'
         when age between 26 and 40 then 'Young Adult'
         when age between 41 and 60 then 'Adult'
         when age > 60 then 'Senior'
	     end;


select s.region,p.category,sum(s.salesamount) as Total_sales,sum(s.profit) as total_profit,
round(avg(s.profit_margin)) as avg_profit_margin from sales s
join product p on p.productid = s.productid
group by region,category
order by avg_profit_margin desc;

select customerid,sum(salesamount) as total_price from sales
group by customerid
order by total_price desc limit 10;

select p.productname,p.category,max(s.profit_margin) as highest_profit_margin from sales s
join product p on p.productid = s.productid
group by p.productname,p.category
order by highest_profit_margin desc limit 10;

--Power BI link
--https://app.powerbi.com/view?r=eyJrIjoiOTU5YjEyNzItZTdiMS00M2M2LWIyZjgtYmIyOWU0YTY1NjA1IiwidCI6IjMwYjNlZGY0LWYzNzEtNGU2Ni1hZTQyLWJhN2M0NTlmNDY4MSJ9

--<iframe title="Customer_Sales&Profit_Analysis" width="600" height="373.5" src="https://app.powerbi.com/view?r=eyJrIjoiOTU5YjEyNzItZTdiMS00M2M2LWIyZjgtYmIyOWU0YTY1NjA1IiwidCI6IjMwYjNlZGY0LWYzNzEtNGU2Ni1hZTQyLWJhN2M0NTlmNDY4MSJ9" frameborder="0" allowFullScreen="true"></iframe>

--git link
--https://github.com/Vipin036/Power-bi-task-2.git

