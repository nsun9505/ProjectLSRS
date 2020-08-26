insert into tbl_library(libraryid, name, address) values(library_seq.nextval, '모전도서관', '모전동');

insert into tbl_room(roomnumber, belonglibraryid, maxuser) values(101, 1, 40);
insert into tbl_room(roomnumber, belonglibraryid, maxuser) values(201, 1, 40);

insert into tbl_admin(adminid,password, name, phonenumber, belonglibraryid) 
values('admin', 'admin', 'admin', '010-1234-1234', 1);

insert into tbl_management(libraryid, adminId) values(1, 'admin');

insert into tbl_user(userid, password, name, phonenumber, address) 
values('user', 'user', 'test', '010-5678-5678', 'address');

insert into tbl_register(libraryId, userid)
values(1, 'user');
commit;

