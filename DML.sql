insert into tbl_group values(group_seq.nextval, '문경시립');

insert into tbl_library(libraryid, name, address, groupId) values(library_seq.nextval, '모전도서관', '모전동',1);

insert into tbl_room(roomnumber, belonglibraryid, maxuser) values(101, 1, 40);
insert into tbl_room(roomnumber, belonglibraryid, maxuser) values(201, 1, 40);

insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(1, 101, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(2, 101, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(3, 101, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(4, 101, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(5, 101, 1);

insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(1, 201, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(2, 201, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(3, 201, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(4, 201, 1);
insert into tbl_seat(seatnumber, belongRoomNumber, belongLibraryId)
values(5, 201, 1);

insert into tbl_admin(adminid,password, name, phonenumber, belonglibraryid) 
values('admin', 'admin', 'admin', '010-1234-1234', 1);

insert into tbl_management(libraryid, adminId) values(1, 'admin');

insert into tbl_user(userid, password, name, phonenumber, address) 
values('user', 'user', 'test', '010-5678-5678', 'address');

insert into tbl_register(libraryId, userid)
values(1, 'user');

commit;

