--Задание №1
SELECT  cus.last_name ||' ' || cus.first_name as "Фамилия и имя",
		a.address as "Адрес",
		city.city as "Город",
		country.country as "Страна"
from customer cus 
inner join address a on cus.address_id = a.address_id
inner join city on a.city_id = city.city_id
inner join country on city.country_id = country.country_id

--Задание №2
select	store_id "ID магазина", 
		count(DISTINCT customer_id) as "Количество покупателей"
from customer
GROUP BY store_id


select	store_id "ID магазина", 
		count(DISTINCT customer_id) "Количество покупателей"
from customer
GROUP BY store_id
having count(DISTINCT customer_id) > 300


select  store_id "ID магазина",
		"Количество покупателей",
		"Город магазина",
		"Фамилия и имя продавца"
from (select count(DISTINCT customer_id) as "Количество покупателей", store_id from customer
	GROUP by store_id having count(DISTINCT customer_id) > 300) c
join (select store_id as store_store_id , manager_staff_id, address_id as store_add from store 	GROUP BY store_id) st 
	on c.store_id = st.store_store_id 
join (select staff_id, last_name  || ' ' || first_name as "Фамилия и имя продавца" from staff) staff
	on st.manager_staff_id = staff.staff_id
join (select address_id as store_add, city_id as store_city from address) add_store
	on st.store_add = add_store.store_add
join (select city as "Город магазина", city_id  from city) city 
	on add_store.store_city = city.city_id

--Задание №3
select "Фамилия и имя покупателя",
		"Количество фильмов"
from (select count(rental_id) as "Количество фильмов", customer_id from rental
	GROUP by customer_id
	ORDER BY count(rental_id) desc limit 5) rental
join (select customer_id, last_name  || ' ' || first_name as "Фамилия и имя покупателя" from customer) cus 
	on rental.customer_id = cus.customer_id 
ORDER BY "Количество фильмов" desc

--Задание №4
select "Фамилия и имя покупателя",
		"Количество фильмов",
		"Общая стоимость платежей",
		"Минимальная стоимость платежа",
		"Максимальная стоимость платежа"
from (select count(rental_id) as "Количество фильмов", 
		customer_id, 
		round(sum(amount)) as "Общая стоимость платежей",
		min(amount) as "Минимальная стоимость платежа",
		max(amount) as "Максимальная стоимость платежа"
	from payment
	GROUP by customer_id) pay
join (select customer_id, last_name  || ' ' || first_name as "Фамилия и имя покупателя" from customer) cus 
	on pay.customer_id = cus.customer_id
	
--Задание №5
select city as "Город 1",
		"Город 2"
from city
cross join (select city as "Город 2", city_id from city) city_2
where city != "Город 2"

--Задание №6
select customer_id, sum(return_date - rental_date)/count(rental_id)
from rental
GROUP by customer_id
