-- Language: SQL


3.1)

drop procedure if exists most_rented;
delimiter $
create procedure most_rented(choice char,size int, date1 datetime, date2 datetime)
begin
declare filmid smallint(3);
declare mtitle varchar(128);
declare seriesid smallint(3);
declare stitle varchar(128);
declare fflag int;
declare mcursor cursor for
select film.film_id,film.title from film 
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id=rental.inventory_id
group by film.film_id
where rental.rental_date>=date1 and rental.rental_date<=date2
having max(count(inventory_id));
declare scursor cursor for
select series.series_id,series.title from series 
inner join series_inventory on series.series_id=series_inventory.series_id
inner join series_rental on series_inventory.inventory_id=series_rental.inventory_id
group by series.series_id
where series_rental.rental_date>=date1 and series_rental.rental_date<=date2
having max(count(series_inventory_id));

declare continue handler for not found set fflag=1;
set fflag=0;

case (choice)
when m then

open mcursor;
repeat
fetch mcursor into filmid,mtitle;
if (fflag=0) then
while(count(mtitle<size)) do
select filmid,mtitle from film;
end while;
end if;
until(fflag=1)
end repeat;
close mcursor;

when s then

set fflag=0;
open scursor;
repeat
fetch scursor into seriesid,stitle;
if (fflag=0) then
while(count(stitle<size)) do
select seriesid,stitle from series;
end while;
end if;
until(fflag=1)
end repeat;
close scursor;

end case;
end$
delimiter ;







3.2) 

drop procedure if exists rentals;
delimiter $
create procedure rentals(cemail varchar(50), date1 datetime)
begin 
declare cust_id int(11);
declare rent_date date;
declare cust2_id int(11);
declare rent2_date date;
declare flag int;
declare rcursor cursor for 
    select customer.customer_id,DATE(rental_date)
    from customer
    inner join rental on rental.customer_id=customer.customer_id
    where email=cemail AND DATE(rental_date)=date1;
declare rcursor2 cursor for 
    select customer.customer_id,DATE(series_rental.rental_date)
    from customer
    inner join series_rental on series_rental.customer_id=customer.customer_id
    where email=cemail AND DATE(series_rental.rental_date)=date1;

declare continue handler for not found set flag=1;

set flag=0;


open rcursor;
repeat
    fetch rcursor into cust_id,rent_date;
    until (flag=1)
end repeat;
select cust_id AS'ID pelath',count(rent_date) AS 'arithmos enoikiasewn tainiwn'
from rental
where customer_id=cust_id AND DATE(rental_date)=date1;
close rcursor;

set flag=0;
open rcursor2;
repeat
    fetch rcursor2 into cust2_id,rent2_date;
    until (flag=1)
end repeat;
select cust2_id as'ID pelath',count(rent2_date) as 'arithmos enoikiasewn seirwn'
from series_rental
where customer_id=cust2_id AND DATE(series_rental.rental_date)=date1;
close rcursor2;

end$
delimiter ;




3.3) 

drop procedure if exists earnings;
delimiter $
create procedure earnings()
begin

select sum(amount) as 'Synoliko poso plhrwmwn tainiwn Febrouariou' from payment where payment_date like'%-02-%';

select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Apriliou' from series_payment where series_payment_date like'%-04-%';

select sum(amount) as 'Synoliko poso plhrwmwn tainiwn Maiou' from payment where payment_date like'%-05-%';
select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Maiou' from series_payment where series_payment_date like'%-05-%';

select sum(amount) as 'Synoliko poso plhrwmwn tainiwn Iouniou' from payment where payment_date like'%-06-%';
select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Iouniou' from series_payment where series_payment_date like'%-06-%';

select sum(amount) as 'Synoliko poso plhrwmwn tainiwn Iouliou' from payment where payment_date like'%-07-%';
select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Iouliou' from series_payment where series_payment_date like'%-07-%';

select sum(amount) as 'Synoliko poso plhrwmwn tainiwn Augoustou' from payment where payment_date like'%-08-%';
select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Augoustou' from series_payment where series_payment_date like'%-08-%';

select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Septembriou' from series_payment where series_payment_date like'%-09-%';

select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Okrobriou' from series_payment where series_payment_date like'%-10-%';

select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Noembriou' from series_payment where series_payment_date like'%-11-%';

select sum(series_amount) as 'Synoliko poso plhrwmwn seirwn Decembriou' from series_payment where series_payment_date like'%-12-%';
end$
delimiter ;



3.4.α) 

drop procedure if exists lastnames;
delimiter $
create procedure lastnames(lastname1 varchar(45),lastname2 varchar(45))
begin
declare fflag int;
declare fname varchar(45);
declare lname varchar(45);
declare lcursor cursor for
select first_name,last_name from actor  where last_name>=lastname1 and last_name<=lastname2 order by last_name;
declare continue handler for not found set fflag=1;
open lcursor;
set fflag=0;
repeat
fetch lcursor into fname,lname;
if (fflag=0) then
select fname as 'Onoma',lname as 'Epitheto';
end if;
until(fflag=1)
end repeat;
select count(first_name) as 'Plithos Hthopoiwn' from actor where last_name>=lastname1 and last_name<=lastname2;
close lcursor;
end$
delimiter ;

3.4.β) 

drop procedure if exists actordata;
delimiter $
create procedure actordata(lastname varchar(45))
begin
declare fflag int;
declare fname varchar(45);
declare lname varchar(45);
declare lcursor cursor for
select first_name,last_name from actor  where last_name=lastname order by last_name;
declare continue handler for not found set fflag=1;
open lcursor;
set fflag=0;
repeat
fetch lcursor into fname,lname;
if (fflag=0) then
select fname as 'Onoma',lname as 'Epitheto';
end if;
until(fflag=1)
end repeat;
select count(first_name) as 'Plithos Hthopoiwn' from actor where last_name=lastname;
close lcursor;
end$
delimiter ;

























