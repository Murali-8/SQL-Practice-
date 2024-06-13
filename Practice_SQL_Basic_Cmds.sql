show databases;

select * from sales;
Select GeoID,SaleDate,Amount / Boxes as 'Amount per box',Customers 
from sales
Where Customers > 100;
# Amount greater than 10,000
select * from sales
where Amount > 10000;

# Order by 
select * from sales
where Amount > 10000
order by Amount desc;

select * from sales
where GeoID='g1'
order by PID, Amount desc;

# where clause examples
# all sales value >10000 & year = 2022

select *
from sales
where Amount >10000 and SaleDate >='2022-01-01';

select *
from sales
where Amount >10000 and year(SaleDate)=2022
order by Amount desc;

# between 
select * from sales 
where Boxes>0 and Boxes<=50;

select * from sales 
where Boxes between 0 and 50;

# weekdays 
# shipments made on fridays
Select SaleDate,Amount,Boxes, weekday(SaleDate) as "Week day name"
from sales
where weekday(saleDate) = 4;

# people table
Select * from people;

# all people from delish or jucies
Select * from people 
where team="Delish" or team= "Jucies"; 
 
select * from people 
where team in ("Delish","Jucies");

# pattern matching
Select * from people 
where Salesperson like "%B%";

Select SaleDate, Amount,
	case  when Amount < 1000 then 'under 1k'
		  when Amount < 5000 then 'under 5k'
          when Amount < 10000 then 'under 10k'
		  else '10k or more '
	end as 'Amount category'
from sales;

## Joins
Select p.Salesperson,s.SaleDate,s.Amount ,p.SPID,s.SPID from sales as s
join people as p on p.SPID= s.SPID;

Select s.saledate,s.Amount,s.PID, pr.Product 
from sales s
left join products pr on pr.PID = s.PID;

# Join multiple tables

Select s.saledate,s.Amount,p.Salesperson, pr.Product, p.Team 
from sales s
join people as p on p.SPID= s.SPID
join products pr on pr.PID = s.PID;

# conditions in joins
Select s.saledate,s.Amount,p.Salesperson, pr.Product, p.Team 
from sales s
join people as p on p.SPID= s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500
and p.Team = "Delish";

Select s.saledate,s.Amount,p.Salesperson, pr.Product, p.Team 
from sales s
join people as p on p.SPID= s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500
and p.Team ='';

# 3 tables 
Select s.saledate,s.Amount,p.Salesperson, pr.Product, p.Team ,g.Geo,g.GeoID
from sales s
join people as p on p.SPID= s.SPID
join products pr on pr.PID = s.PID
join geo g on g.GeoID = s.GeoID
where s.Amount < 500
and p.Team =''
and g.Geo in ('New Zealand', "India")
order by SaleDate;

# group by 
Select g.geo , sum(Amount), avg(Amount), sum(Boxes)
from sales s 
join geo g on g.GeoID = s.GeoID
group by g.geo;

Select pr.Category, p.Team, sum(Amount), sum(Boxes)
from sales s 
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
group by pr.Category, p.Team;

Select pr.Category, p.Team, sum(Amount), sum(Boxes)
from sales s 
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where p.Team <> ''
group by pr.Category, p.Team
order by pr.Category, p.Team;

# top 10 products
Select pr.Product,sum(s.amount) as "Total Amount"
from sales s
join products pr on pr.PID = s.PID
group by pr.Product
order by "Total Amount" ;

Select pr.Product,sum(s.amount) as "Total Amount"
from sales s
join products pr on pr.PID = s.PID
group by pr.Product
order by "Total Amount" desc
limit 10;







#Having






# Workout problems.
#1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?

select * from sales
where Amount >2000 and Boxes <100;

#2. How many shipments (sales) each of the sales persons had in the month of January 2022?
select p.Salesperson ,count(*) as 'Shipment count' 
from sales s
join people p on p.SPID = s.SPID
where SaleDate between '2022-01-01' and '2022-01-31'
group by p.Salesperson;

#3. Which product sells more boxes? Milk Bars or Eclairs?
select * from products;
Select pr.Product, sum(s.Boxes) as "Total boxes"  
from products pr 
join sales s on s.PID = pr.PID
where pr.Product in ('Milk Bars', 'Eclairs')
group by pr.Product;


#4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?

select pr.product, sum(s.Boxes) as 'Total Boxes' from sales s
join products pr on pr.PID = s.PID
where s.SaleDate >= '2022-02-01' and s.SaleDate <= '2022-02-07' 
and pr.Product in ('Milk Bars','Eclairs')
group by pr.Product;

#5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?

Select *, 
	Case when weekday(saledate) =2 then "Wednesday shipment"
		 else 'Normal Shipment'
    end as "Shipment Category"
from sales
where Customers < 100 and Boxes < 100;


select *,
case when weekday(saledate)=2 then 'Wednesday Shipment'
else ''
end as 'W Shipment'
from sales
where customers < 100 and boxes < 100;

#HARD PROBLEMS
#👉 These require concepts not covered in the video

#1. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?

Select distinct p.Salesperson
from sales s
join people p on p.SPID = s.SPID
where s.SaleDate >='2022-01-01' and s.SaleDate<='2022-01-07';


#2. Which salespersons did not make any shipments in the first 7 days of January 2022?

select p.salesperson
from people p
where p.SPID not in 
(select distinct s.spid from sales s 
 where s.SaleDate between '2022-01-01' and '2022-01-07');

#3. How many times we shipped more than 1,000 boxes in each month?








#4. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
#5. India or Australia? Who buys more chocolate boxes on a monthly basis?








































































