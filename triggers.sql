-- Language: SQL


4.2)

drop trigger if exists sale;
delimiter $
create trigger sale
before insert on payment
for each row
begin
declare mcount int;
declare mdate datetime;
declare scount int;
declare sdate datetime;
declare flag int;
declare mcursor cursor for 
select count(customer_id),payment_date 
from payment;
declare scursor cursor for 
select count(customer_id),series_payment_date 
from series_payment;
declare continue handler for not found set flag=1;

set flag=0;

open mcursor;
repeat
fetch mcursor into mcount,mdate;
if(mcount>=3 and mdate=new.payment_date) then
set new.cost_per_film=cost_per_film/2 and new.amount=amount/2;
end if;
until(flag=1)
end repeat;
close mcursor;

set flag=0;

open scursor;
repeat
fetch scursor into scount,sdate;
if(scount>=3 and sdate=new.payment_date) then
set new.cost_per_film=cost_per_film/2 and new.amount=amount/2;
end if;
until(flag=1)
end repeat;
close scursor;

end$
delimiter ;



4.3) 

drop trigger if exists not_allowed;
delimiter $
create trigger not_allowed
before update on customer
for each row
begin
if (new.customer_id IS NOT NULL) then
SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'You cannot change your Customer Id.';
end if;
end$
delimiter ;

