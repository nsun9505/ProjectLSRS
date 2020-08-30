insert into tbl_group values(group_seq.nextval, '문경시립');

insert into tbl_library(libraryid, name, address, groupId) values(library_seq.nextval, '모전도서관', '모전동',1);

insert into tbl_room(roomnumber, belonglibraryid, maxuser) values(101, 1, 40);
insert into tbl_room(roomnumber, belonglibraryid, maxuser) values(201, 1, 40);

insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval, 1, 101, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,2, 101, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,3, 101, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,4, 101, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,5, 101, 1);

insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,1, 201, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,2, 201, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,3, 201, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,4, 201, 1);
insert into tbl_seat(seatId, seatnumber, belongRoomNumber, belongLibraryId)
values(seat_seq.nextval,5, 201, 1);

insert into tbl_auth(authid, authType)
values(auth_seq.nextval, 'ROLE_ADMIN');
insert into tbl_auth(authid, authType)
values(auth_seq.nextval, 'ROLE_USER');

insert into tbl_user(userid, userpw, username, phonenumber, address) 
values('admin', 'admin', '도서관관리자', '010-5678-5678', 'address');

insert into tbl_user(userid, userpw, username, phonenumber, address) 
values('user', 'user', 'test', '010-5678-5678', 'address');

insert into tbl_user_auth(libraryId, userId, authid)
values(1, 'admin', 1);
insert into tbl_user_auth(libraryId, userId, authid)
values(1, 'user', 2);

commit;

