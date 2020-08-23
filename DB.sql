CREATE SEQUENCE library_seq;
CREATE TABLE tbl_library(
    libraryId      Number NOT NULL,
    Name    varchar2(100) NOT NULL,
    Address varchar2(200) NOT NULL
);

CREATE SEQUENCE room_seq;
CREATE TABLE tbl_room(
    roomNumber          Number NOT NULL,
    belongLibrary       Number NOT NULL,
    MaxUser             Number
);

ALTER TABLE tbl_room add constraint pk_room key(roomNumber, belongLibarayId);
ALTER TABLE tbl_room add constraint fk_room foreign key(belongLibrary) references tbl_library(libraryId);

CREATE SEQUENCE seat_seq;
CREATE TABLE tbl_seat(
    seatId                   NUMBER NOT NULL,
    seatNumber               NUMBER NOT NULL,
    belongRoomNumber         NUMBER NOT NULL,
    belongLibarayId          NUMBER NOT NULL,
);
ALTER TABLE tbl_seat add constraint pk_seat key(seatId);
ALTER TABLE tbl_seat add constraint fk_room foreign key(belongRoomNumber) references tbl_room(roomNumber);
ALTER TABLE tbl_seat add constraint fk_library foreign key(belongLibraryId) references tbl_room(belongLibraryId);

CREATE TABLE tbl_management (
    libraryId       NUMBER NOT NULL,
    adminId         VARCHAR2(50) NOT NULL
);

ALTER TABLE tbl_management add constraint pk_manage key(libraryId, adminId);
ALTER TABLE tbl_management add constraint fk_manage_lib foreign key(libraryId) tbl_library(libraryId);
ALTER TABLE tbl_management add constraint fk_manage_admin foreign key(adminId) tbl_admin(adminId);

CREATE TABLE tbl_admin (
    adminId            VARCHAR2(50) NOT NULL,
    password           VARCHAR2(50) NOT NULL,
    name               VARCHAR2(20) NOT NULL,
    phoneNumber        VARCHAR2(13) NOT NULL,
    belongLibraryId    NUMBER NOT NULL
);

ALTER TABLE tbl_admin add constraint pk_admin key(adminId);
ALTER TABLE tbl_admin add constraint fk_admin_library foreign key(belongLibraryId) references tbl_library(libraryId);

CREATE TABLE tbl_user(
    userId             VARCHAR2(50) NOT NULL,
    password           VARCHAR2(50) NOT NULL,
    name               VARCHAR2(20) NOT NULL,
    phoneNumber        VARCHAR2(13) NOT NULL,
    address,
    belongLibraryId      NUMBER NOT NULL
);

ALTER TABLE tbl_user add constraint pk_user key(userId);
ALTER TABLE tbl_user add constraint fk_user_library foreign key(belongLibraryId) references tbl_library(libraryId);

CREATE SEQUENCE reserv_seq;
CREATE TABLE tbl_reservation(
    reservId        NUMBER NOT NULL,
    seatId          NUMBER NOT NULL,
    userId          VARCHAR2(50) NOT NULL,
    reservedTime    sysdate NOT NULL,
    numOfExtension  NUMBER NOT NULL      
);

ALTER TABLE tbl_reservation add constraint pk_reserv key(reservId);
ALTER TABLE tbl_reservation add constraint fk_reserv_seat foreign key(seatid) references tbl_seat(seatId);
ALTER TABLE tbl_reservation add constraint fk_user_seat foreign key(userId) references tbl_user(userId);

CREATE SEQUENCE return_seq;
CREATE TABLE tbl_return(
    returnId        NUMBER NOT NULL,
    seatId          NUMBER NOT NULL,
    userId          VARCHAR2(50) NOT NULL,
    returnTime      sysdate
);

ALTER TABLE tbl_return add constraint pk_return key(returnId);
ALTER TABLE tbl_return add constraint fk_seat_ret foreign key(seatId) references tbl_seat(seatId);
ALTER TABLE tbl_return add constraint fk_user_ret foreign key(userId) references tbl_user(userId);