--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
 select product_name, quantity_per_unit from Products;

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
 select product_id , product_name From Products where discontinued = 0;

--3. Durdurulan Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
 select product_id, product_name From Products where discontinued = 1;

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
 select product_id, product_name, unit_price from Products where unit_price < 20;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
 select product_id, product_name, unit_price from Products where unit_price between 15 and 25; 

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
select product_name, units_on_order, units_in_stock from Products where units_in_stock < units_on_order;

--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
 select lower(product_name) from Products where Lower(product_name) like 'a%';

--8. İsmi `i` ile biten ürünleri listeleyeniz.
 select product_name from Products where product_name like '%i';

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
select product_name, unit_price, unit_price * 1.18 as unit_price_kdv from Products;

--10. Fiyatı 30 dan büyük kaç ürün var?
 select count(*) from Products where unit_price > 30;

--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
 select lower(product_name) ,unit_price from Products order by unit_price desc;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır select first_name || ' ' || last_name as full_name from employees;

--13. Region alanı NULL olan kaç tedarikçim var?
 select count(*) from suppliers where region is null;

--14. Null olmayanlar?
 select count(*) from suppliers where region is not null;

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
 select concat('TR ', UPPER(product_name)) as new_product_name from Products;

--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
 select concat('TR ', UPPER(product_name)) as new_product_name from Products where unit_price < 20;

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
 select product_name ,unit_price from Products order by unit_price desc limit 1;

--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
 select product_name ,unit_price from Products order by unit_price desc limit 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
 select product_name ,unit_price from Products where unit_price > (select avg(unit_price) from Products);

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
 select sum(unit_price * units_in_stock) as toplam_gelir from Products where units_in_stock > 0;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
 select discontinued, units_in_stock from Products where discontinued = 1 and units_in_stock > 0;  

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
 select products.product_name,categories.category_name from products JOIN categories ON products.category_id = categories.category_id;

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
 select categories.category_name,AVG(products.unit_price) as avg_price from products 
 JOIN categories on products.category_id = categories.category_id GROUP BY categories.category_name;

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
 select products.product_name,products.unit_price,categories.category_name from products 
 JOIN categories on products.category_id= categories.category_id order by products.unit_price desc LIMIT 1;

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
 select products.product_name,categories.category_name,suppliers.company_name from products 
 JOIN categories on products.category_id= categories.category_id 
 JOIN suppliers on products.supplier_id= suppliers.supplier_id order by units_on_order desc LIMIT 1;

--26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
select p.product_id, p.product_name, s.company_name, s.phone from products p
join suppliers s on p.supplier_id = s.supplier_id
where p.units_in_stock = 0;

--27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı?
select o.order_id, o.order_date, c.customer_id, c.address, concat(e.first_name,' ',e.last_name) as employee_name from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id
where extract(year from o.order_date) = 1998 and extract(month from o.order_date) = 3;
 
--28. 1997 yılı şubat ayında kaç siparişim var?
select count(order_id) as order_count from orders
where extract(year from order_date) = 1997 and extract(month from order_date) = 2;

--29. London şehrinden 1998 yılında kaç siparişim var?
select count(o.order_id) as order_count from orders o
join customers c on o.customer_id = c.customer_id
where extract(year from o.order_date) = 1998 and c.city = 'London';

--30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası?
select distinct c.contact_name, c.phone from customers c
join orders o on c.customer_id = o.customer_id
where extract(year from o.order_date) = 1997;

--31. Taşıma ücreti 40 üzeri olan siparişlerim?
select * from orders
where freight > 40;

--32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı?
select c.city, c.contact_name from orders o
join customers c on o.customer_id = c.customer_id
where o.freight >= 40;

--33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf)?
select o.order_date, c.city, concat(upper(e.first_name), upper(e.last_name)) as employee_name from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id
where extract(year from o.order_date) = 1997;
 
--34. 1997 yılında sipariş veren müşterilerin contactname'i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
select c.contact_name, regexp_replace(c.phone, '[^0-9]', '', 'g') as phone_number from customers c 
join orders o on c.customer_id = o.customer_id
where extract(year from o.order_date) = 1997;

--35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyadı?
select o.order_date, c.contact_name, e.first_name as emp_first_name, e.last_name as emp_last_name from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id;

--36. Geciken siparişlerim?
select order_id, order_date, required_date, shipped_date from orders
where shipped_date is null and required_date < current_date;
 
--37. Geciken siparişlerimin tarihi, müşterisinin adı? 
select o.order_date, c.contact_name from orders o
join customers c on o.customer_id = c.customer_id
where o.shipped_date is null and o.required_date < current_date; 

--38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi nedir?
select p.product_name, c.category_name, od.quantity from order_details od
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id
where od.order_id = 10248;

--39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı nedir?
select p.product_name, s.company_name from order_details od
join products p on od.product_id = p.product_id
join suppliers s on p.supplier_id = s.supplier_id
where od.order_id = 10248;

--40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti nedir?
select p.product_name, od.quantity from orders o
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
where o.employee_id = 3 and extract(year from o.order_date) = 1997;
