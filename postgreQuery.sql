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
 select categories.category_name,AVG(products.unit_price) as avg_price from products JOIN categories on products.category_id = categories.category_id GROUP BY categories.category_name;

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
 select products.product_name,products.unit_price,categories.category_name from products JOIN categories on products.category_id= categories.category_id order by products.unit_price desc LIMIT 1;

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
 select products.product_name,categories.category_name,suppliers.company_name from products JOIN categories on products.category_id= categories.category_id JOIN suppliers on products.supplier_id= suppliers.supplier_id order by units_on_order desc LIMIT 1;