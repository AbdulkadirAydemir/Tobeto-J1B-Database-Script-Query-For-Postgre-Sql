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

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır 
 select first_name || ' ' || last_name as full_name from employees;

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

--40. 3 numaralı ID'ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti nedir?
select p.product_name, o.order_date, od.quantity 
from order_details od
inner join orders o on od.order_id = o.order_id
inner join products p on od.product_id = p.product_id
where extract(year from o.order_date) = 1997 and o.employee_id = 3;

--41. 1997 yılında bir defasında en çok satış yapan çalışanın ID, ad soyadı nedir?
select e.employee_id, e.first_name || ' ' || e.last_name as ad_soyad, sum(od.quantity * p.unit_price) as siparis_tutari, o.order_date
from employees e inner join orders o on e.employee_id = o.employee_id inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id
where extract(year from o.order_date) = 1997 group by e.employee_id, ad_soyad, o.order_id
order by siparis_tutari desc limit 1;

--42. 1997 yılında en çok satış yapan çalışanın ID, ad soyad  nedir?
select e.employee_id, e.first_name || ' ' || e.last_name as ad_soyad, sum(od.quantity) as toplam_satis
from employees e inner join orders o on e.employee_id = o.employee_id inner join order_details od on o.order_id = od.order_id
where extract(year from o.order_date) = 1997 group by e.employee_id, ad_soyad
order by toplam_satis desc limit 1;

--43. En pahalı ürünümün adı, fiyatı ve kategorisinin adı nedir?
select p.product_name, p.unit_price, c.category_name
from products p inner join categories c on p.category_id = c.category_id
order by p.unit_price desc limit 1;

--44. Siparişi alan personelin adı, soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre nedir?
select e.first_name || ' ' || e.last_name as ad_soyad, o.order_date, o.order_id
from orders o join employees e on o.employee_id = e.employee_id
order by o.order_date asc;

--45. SON 5 siparişimin ortalama fiyatı ve order id nedir?
select avg(od.unit_price * od.quantity) as "ortalama_fiyati", o.order_id
from order_details od inner join orders o on od.order_id = o.order_id
group by o.order_id order by o.order_date desc limit 5;

--46. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
select p.product_name, c.category_name, sum(od.quantity) as "toplam_satis_miktari"
from order_details od inner join orders o on od.order_id = o.order_id
inner join products p on od.product_id = p.product_id
inner join categories c on p.category_id = c.category_id
where extract(month from o.order_date) = 1
group by p.product_name, c.category_name;

--47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
select od.order_id, sum(od.quantity) as toplam_satis
from order_details od group by od.order_id
having sum(od.quantity) > (select avg(quantity) from order_details);

--48. En çok satılan ürünümün (adet bazında) adı, kategorisinin adı ve tedarikçisinin adı nedir?
select p.product_name, c.category_name, s.company_name from order_details od inner join products p on od.product_id = p.product_id
inner join categories c on p.category_id = c.category_id
inner join suppliers s on p.supplier_id = s.supplier_id
group by p.product_name, c.category_name, s.company_name order by sum(od.quantity) desc limit 1;

--49. Kaç ülkeden müşterim var?
select count(distinct country) as "musteri_ulke_sayisi" from customers;

--50. 3 numaralı ID'ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
select sum(od.quantity * od.unit_price) as "toplam_satis_miktari" from order_details od
inner join orders o on od.order_id = o.order_id where order_date > '1997-12-31' and o.employee_id = 3;

--51. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi nedir?
select p.product_name, c.category_name, od.quantity from order_details od
inner join products p on od.product_id = p.product_id inner join categories c on p.category_id = c.category_id
where od.order_id = 10248;

--52. 10248 nolu siparişin ürünlerinin adı, tedarikçi adı nedir?
select p.product_name, s.company_name from order_details od
inner join products p on od.product_id = p.product_id inner join suppliers s on p.supplier_id = s.supplier_id
where od.order_id = 10248;

--53. 3 numaralı ID'ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti nedir?
select p.product_name, od.quantity from employees e
inner join orders o on e.employee_id = o.employee_id
inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id
where e.employee_id = 3 and extract(year from o.order_date) = 1997;

--54. 1997 yılında bir defasında en çok satış yapan çalışanın ID, ad soyad nedir?
select e.employee_id, e.first_name || ' ' || e.last_name as ad_soyad, sum(od.quantity * p.unit_price) as siparis_tutari ,o.order_date
from employees e inner join orders o on e.employee_id = o.employee_id
inner join order_details od on o.order_id = od.order_id inner join products p on od.product_id = p.product_id
where extract(year from o.order_date) = 1997 group by e.employee_id, ad_soyad, o.order_id
order by siparis_tutari desc limit 1;

--55. 1997 yılında en çok satış yapan çalışanımın ID, ad soyad nedir?
select e.employee_id, e.first_name || ' ' || e.last_name as ad_soyad, sum(od.quantity) as toplam_satis from employees e
inner join orders o on e.employee_id = o.employee_id inner join order_details od on o.order_id = od.order_id
where extract(year from o.order_date) = 1997 group by e.employee_id, ad_soyad
order by toplam_satis desc limit 1;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--85. Kaç farklı ülkeye ihracat yapıyorum..?
select count(distinct country) as "Number of export countries" from customers;

--86. a.Bu ülkeler hangileri..?
select distinct country from customers;

--87. En Pahalı 5 ürün?
select product_name, unit_price from Products order by unit_price DESC limit 5;

--88. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
select c.customer_id, count(od.quantity) as quantity_count from customers c
left join orders o on c.customer_id = o.customer_id
left join order_details od on o.order_id = od.order_id
where c.customer_id = 'ALFKI' group by c.customer_id;

--89. Ürünlerimin toplam maliyeti?
select sum(od.unit_price * od.quantity) as total_cost from order_details od
inner join products p on od.product_id = p.product_id;

--90. Şirketim, şimdiye kadar ne kadar ciro yapmış..?
select sum((od.unit_price * od.quantity) - (od.unit_price * od.quantity * od.discount)) 
as total_proceeds from order_details od inner join orders o on od.order_id = o.order_id;

--91. Ortalama Ürün Fiyatım?
select avg(unit_price) from products;

--92. En Pahalı Ürünün Adı?
select product_name from products order by unit_price DESC LIMIT 1;

--93. En az kazandıran sipariş?
select order_id, sum(od.unit_price * od.quantity) as least_proceeds_order from order_details od
group by order_id order by least_proceeds_order asc limit 1;

--94. Müşterilerimin içinde en uzun isimli müşteri?
select contact_name from customers order by length(contact_name) desc limit 1;

--95. Çalışanlarımın Ad, Soyad ve Yaşları?
select first_name, last_name, extract(year from age(now(), birth_date)) as age from employees;

--96. Hangi üründen toplam kaç adet alınmış..?
select p.product_id, p.product_name, sum(od.quantity) as total_number from order_details od
inner join products p on od.product_id = p.product_id group by p.product_id, p.product_name
order by total_number desc;

--97. Hangi siparişte toplam ne kadar kazanmışım..?
select order_id, sum(unit_price * quantity * (1 - discount)) from order_details group by order_id;

--98. Hangi kategoride toplam kaç adet ürün bulunuyor..?
select category_id, count(*) as total_products from products group by category_id;

--99. 1000 Adetten fazla satılan ürünler?
select product_id, sum(quantity) from order_details 
where product_id in (select product_id from order_details group by product_id having sum(quantity) > 1000)
group by product_id;

--100. Hangi Müşterilerim hiç sipariş vermemiş..?
select c.customer_id, c.company_name from customers c
where not exists (select 1 from orders o where c.customer_id = o.customer_id);

--101. Hangi tedarikçi hangi ürünü sağlıyor ?
select s.company_name, p.product_name
from suppliers s, products p
where s.supplier_id = p.supplier_id
order by s.company_name, p.product_name;

--102. Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
select o.order_id, sh.company_name, o.shipped_date as sending_date
from orders o inner join shippers sh on o.ship_via = sh.shipper_id;

--103. Hangi siparişi hangi müşteri verir..?
select o.order_id, c.company_name from orders o
join customers c on o.customer_id = c.customer_id;

--104. Hangi çalışan, toplam kaç sipariş almış..?
select e.employee_id, e.first_name, e.last_name, count(o.order_id) as total_order_count from employees e
left join orders o on e.employee_id = o.employee_id
group by e.employee_id, e.first_name, e.last_name
order by total_order_count desc;

--105. En fazla siparişi kim almış..?
select e.employee_id, e.first_name, e.last_name, count(o.order_id) as total_order_count from employees e
join orders o on e.employee_id = o.employee_id
group by e.employee_id, e.first_name, e.last_name
order by total_order_count desc limit 1;

--106. Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
select o.order_id, concat(e.first_name , ' ' , e.last_name) as employeer_name, c.company_name from orders o
inner join customers c on o.customer_id = c.customer_id
inner join employees e on o.employee_id = e.employee_id;

--107. Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
select p.product_name, c.category_name, s.company_name from products p
join categories c on p.category_id = c.category_id
join suppliers s on p.supplier_id = s.supplier_id;

--108. Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, hangi fiyattan alınmış, ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış?
select o.order_id,
       cu.customer_id,
       CONCAT(cu.contact_name, ' ', cu.contact_title),
       e.employee_id,
       CONCAT(e.first_name, ' ', e.last_name),
       o.order_date,
       s.company_name,
       p.product_name,
       od.quantity,
       od.unit_price,
       c.category_name,
       sup.company_name FROM orders o
join customers cu on o.customer_id = cu.customer_id
join employees e on o.employee_id = e.employee_id
join shippers s on o.ship_via = s.shipper_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id
join suppliers sup on p.supplier_id = sup.supplier_id;
 
--109. Altında ürün bulunmayan kategoriler?
select c.category_id, c.category_name from categories c
join products p on c.category_id = p.category_id
where p.product_id is NULL;

--110. Manager ünvanına sahip tüm müşterileri listeleyiniz?
select customer_id, company_name,contact_name from customers where contact_title like '%Manager%';

--111. FR ile başlayan 5 karekter olan tüm müşterileri listeleyiniz?
select customer_id, company_name, contact_name from customers
where customer_id like 'FR__%' and length(customer_id) = 5;

--112. (171) alan kodlu telefon numarasına sahip müşterileri listeleyiniz?
select customer_id, company_name, contact_name, phone from customers
where phone like '%(171)%';

--113. BirimdekiMiktar alanında boxes geçen tüm ürünleri listeleyiniz?
select product_id, product_name, quantity_per_unit from products
where quantity_per_unit like '%boxes%';

--114. Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager) Adını ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)?
select c.contact_name, c.phone from customers c
where c.country in ('France', 'Germany') and c.contact_title like '%Manager%';

--115. En yüksek birim fiyata sahip 10 ürünü listeleyiniz?
select * from products order by unit_price desc limit 10;

--116. Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyiniz?
select * from customers order by country, city;

--117. Personellerin ad,soyad ve yaş bilgilerini listeleyiniz?
select first_name, last_name, extract(year from age(now(), birth_date)) as age from employees;

--118. 35 gün içinde sevk edilmeyen satışları listeleyiniz?
select * from orders where shipped_date is NULL or (order_date - shipped_date) > 35;

--119. Birim fiyatı en yüksek olan ürünün kategori adını listeleyiniz? (Alt Sorgu)
select category_name from categories 
where category_id = ( select category_id from products
order by unit_price desc limit 1);

--120. Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz? (Alt Sorgu)
select product_name, category_name from products
join categories on products.category_id = categories.category_id
where lower(category_name) like '%on%';

--121. Konbu adlı üründen kaç adet satılmıştır?
select sum(quantity) as total_sold from order_details
where product_id = (select product_id from products
        			where product_name = 'Konbu');
--122. Japonyadan kaç farklı ürün tedarik edilmektedir?
select count(distinct p.product_id) from products p
join suppliers s ON p.supplier_id = s.supplier_id
where s.country = 'Japan';

--123. 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?
select max(freight) as maximum_fee, min(freight) as minimum_fee, avg(freight) as average_fee
from orders where extract(year from order_date) = 1997;

--124. Faks numarası olan tüm müşterileri listeleyiniz?
select customer_id, company_name, fax from customers
where fax is not NULL;

--125. 1996-07-16 ile 1996-07-30 arasında sevk edilen satışları listeleyiniz?
select order_id, customer_id, order_date, shipped_date from orders
where shipped_date between '1996-07-16' and '1996-07-30';
