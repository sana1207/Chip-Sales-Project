
Select *
from Chip..Pur_Trans

Select *
from Chip..Trans


CREATE VIEW All_DATA AS
SELECT a.DATE, a.store_nbr, a.lylty_card_nbr, a.txn_id, a.prod_name,
a.prod_qty, a.tot_sales, b.lifestage, b.premium_customer
From Chip..Pur_Trans as a,
Chip..Trans as b
where a.lylty_card_nbr = b.lylty_card_nbr


------------------------------------------------------------------------------------------------------------


Select *
FROM ALL_DATA
order by lylty_card_nbr

-------------------------------------------------------------------------------------------------------------

----Total sales [ visual ]

Select SUM(tot_sales) as total_sales , SUM(prod_qty ) as num_of_items_sold
from ALL_DATA


---------------------------------------------------------------------------------------------------------------------


Select SUM(tot_sales) as total_sales,prod_name
from ALL_DATA 
group by prod_name
order by total_sales desc

---- Sales per product [visual]


Select TOP 10 CAST(SUM(tot_sales) AS int) as total_sales_per_product,prod, size
from NEW_DATA 
group by prod, size
order by total_sales_per_product desc

-----------------------------------------------------------------------------------------------------------------------

------Sales per lifestage

Select CAST(SUM(tot_sales) AS INT) as total_sales_per_lifestage, lifestage 
from ALL_DATA 
group by lifestage
order by total_sales_per_lifestage desc


------------------------------------------------------------------------------------------------------------------------

----- Sales divide premium customer
Select CAST(SUM(tot_sales) AS INT) as total_sales_per_customer, premium_customer
from ALL_DATA 
group by premium_customer
order by total_sales_per_customer desc



------------------------------------------------------------------------------------------------------------------------

------ Sales per store
Select TOP 50 CAST(SUM(tot_sales) as INT) as total_sales_per_store, store_nbr
from ALL_DATA 
group by store_nbr
order by total_sales_per_store desc


---------------------------------------------------------------------------------------------------------

Select *
from Chip..Pur_Trans

Select *
From Chip..New_Trans


ALTER TABLE Pur_Trans
ADD prod varchar(255) null

UPDATE  Pur_Trans
SET prod = SUBSTRING(Prod_name, 1, PATINDEX ( '%[0-9]%', PROD_NAME )-1 ) 


ALTER TABLE Pur_Trans
ADD size varchar(255) null

UPDATE  Pur_Trans
SET size = SUBSTRING(Prod_name, PATINDEX ( '%[0-9]%', PROD_NAME)  ,LEN(Prod_name))


CREATE VIEW NEW_DATA AS
SELECT a.DATE, a.store_nbr, a.lylty_card_nbr, a.txn_id,
a.prod_nbr, a.prod_qty, a.tot_sales, a.prod, a.size,
b.lifestage, b.premium_customer
From Chip..New_Trans as a,
Chip..Trans as b
where a.lylty_card_nbr = b.lylty_card_nbr

DROP VIEW NEW_DATA

Select *
from new_data


---------------------------------------------------------------------------------------------------------

------ Sales Per Size of Product

Select SUM(tot_sales) as total_sales_per_size, size
from NEW_DATA 
group by size
order by total_sales_per_size desc



Select CAST(SUM(tot_sales) AS int) as total_sales_per_product, size
from NEW_DATA 
group by size
order by total_sales_per_product desc




