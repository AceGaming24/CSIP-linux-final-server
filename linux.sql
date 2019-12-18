create table users
(usersLast varchar2(20) not null,
usersFirst varchar2(15) not null,
username varchar2(15) not null,
password varchar2(15) not null,
email varchar2(25) not null,
address varchar2(25),
zipCode char(5),
usersID number(6) not null,
isAdmin char(1) not null,
constraint usersID_pk primary key (usersID));

alter table users add constraint isAdmin_cc check (isAdmin in('y','n','Y','N'));

create table orders
(ordersID number(6) not null,
ordersDate date not null,
ordersTime date not null,
missedorders char(1),
address varchar2(25) not null,
usersID number(6) not null,
constraint ordersID_pk primary key (ordersID));

alter table orders add constraint missedorders_cc check (missedorders in('Y','N'));
alter table orders modify (missedorders default 'N');
alter table orders add constraint usersID_fk foreign key (usersID) references users(usersID);

create table product
(productID number(6) not null,
productName varchar2(20) not null,
productDesc varchar2(200) not null,
productPrice number(6,2) not null,
constraint productID_pk primary key (productID));

create table orderDetail
(orderDetailID number(4) not null,
ordersID number(6) not null,
productID number(6) not null,
orderDetailName varchar2(20),
orderDetailCost number(6,2),
orderDetailQuantity number(3),
constraint orderDetail_ps_pk primary key (ordersID, productID),
constraint orderDetail_orders_fk foreign key(ordersID) references orders(ordersID),
constraint orderDetail_product_fk foreign key(productID) references product(productID));

alter table orderDetail add constraint orderDetailCost_cc check (orderDetailCost > 0);


select * from users inner join orders on users.usersID = orders.usersID;
select address from orders, users where users.usersID(+) = orders.usersID;
select * from orderDetail;
select * from product;
