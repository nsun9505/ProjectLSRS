DROP TABLE tbl_group CASCADE CONSTRAINTS;
DROP TABLE tbl_library CASCADE CONSTRAINTS;
DROP TABLE tbl_room CASCADE CONSTRAINTS;
DROP TABLE tbl_seat CASCADE CONSTRAINTS;
DROP TABLE tbl_management CASCADE CONSTRAINTS;
DROP TABLE tbl_admin CASCADE CONSTRAINTS;
DROP TABLE tbl_user CASCADE CONSTRAINTS;
DROP TABLE tbl_reservation CASCADE CONSTRAINTS;
DROP TABLE tbl_return CASCADE CONSTRAINTS;

DROP SEQUENCE group_seq;
DROP SEQUENCE library_seq;
DROP SEQUENCE room_seq;
DROP SEQUENCE reserv_seq;
DROP SEQUENCE return_seq;

CREATE SEQUENCE group_seq;
CREATE TABLE tbl_group(
    goupId	NUMBER NOT NULL PRIMARY KEY,
    groupName	varchar2(50)
);

CREATE SEQUENCE library_seq;
CREATE TABLE tbl_library(
    libraryId      	Number NOT NULL primary key,
    Name    	varchar2(100) NOT NULL,
    Address 	varchar2(200) NOT NULL,
    groupId 	NUMBER NOT NULL
);

ALTER TABLE tbl_library add constraint fk_lib_group foreign key(groudId) references tbl_group(groupId);

CREATE SEQUENCE room_seq;
CREATE TABLE tbl_room(
    roomNumber          Number NOT NULL,
    belongLibraryID     Number NOT NULL,
    MaxUser             Number NOT NULL
);

ALTER TABLE tbl_room add constraint pk_room primary key(roomNumber, belongLibraryID);
ALTER TABLE tbl_room add constraint fk_room foreign key(belongLibraryID) references tbl_library(libraryId);

CREATE SEQUENCE seat_seq;
CREATE TABLE tbl_seat(
    seatNumber              	NUMBER NOT NULL,
    belongRoomNumber	NUMBER NOT NULL,
    belongLibraryId		NUMBER NOT NULL
);

ALTER TABLE tbl_seat add constraint uk_seat primary key (seatNumber, belongRoomNumber, belongLibraryId);
ALTER TABLE tbl_seat add constraint fk_room_seat foreign key(belongRoomNumber, belongLibraryId) references tbl_room(roomNumber,belongLibraryId);

CREATE TABLE tbl_admin (
    adminId		VARCHAR2(50) NOT NULL,
    password		VARCHAR2(50) NOT NULL,
    name			VARCHAR2(20) NOT NULL,
    phoneNumber		VARCHAR2(13) NOT NULL,
    belongLibraryId		NUMBER NOT NULL
);

ALTER TABLE tbl_admin add constraint pk_admin primary key(adminId);
ALTER TABLE tbl_admin add constraint fk_admin_library foreign key(belongLibraryId) references tbl_library(libraryId);

CREATE TABLE tbl_user(
    userId             VARCHAR2(50) NOT NULL,
    password           VARCHAR2(50) NOT NULL,
    name               VARCHAR2(20) NOT NULL,
    phoneNumber        VARCHAR2(13) NOT NULL,
    address             VARCHAR(200)
);

ALTER TABLE tbl_user add constraint pk_user primary key(userId);

CREATE TABLE tbl_register(
    libraryid   NUMBER NOT NULL,
    userId      VARCHAR2(50) NOT NULL
);

ALTER TABLE tbl_register add constraint pk_reg primary key(libraryId, userId);
ALTER TABLE tbl_register add constraint fk_reg_lib foreign key(libraryId) references tbl_library(libraryid);
ALTER TABLE tbl_register add constraint kf_reg_user foreign key(userId) references tbl_user(userId);

CREATE TABLE tbl_management (
    libraryId       NUMBER NOT NULL,
    adminId         VARCHAR2(50) NOT NULL
);

ALTER TABLE tbl_management add constraint pk_manage primary key(libraryId, adminId);
ALTER TABLE tbl_management add constraint fk_manage_lib foreign key(libraryId) REFERENCES tbl_library(libraryId);
ALTER TABLE tbl_management add constraint fk_manage_admin foreign key(adminId) REFERENCES tbl_admin(adminId);

CREATE SEQUENCE reserv_seq;
CREATE TABLE tbl_reservation(
    reservId        		NUMBER NOT NULL,
    seatNumber              	NUMBER NOT NULL,
    roomNumber		NUMBER NOT NULL,
    libraryId		NUMBER NOT NULL,
    userId          		VARCHAR2(50) NOT NULL,
    regDate		date default sysdate,
    startTime    		date NOT NULL,
    endTime		date NOT NULL,
    numOfExtension  	NUMBER NOT NULL      
);

ALTER TABLE tbl_reservation add constraint pk_reserv primary key(reservId);
ALTER TABLE tbl_reservation add constraint fk_reserv_seat foreign key(seatNumber, roomNumber, libraryId) references tbl_seat(seatNumber, belongRoomNumber, belongLibraryId);
ALTER TABLE tbl_reservation add constraint fk_user_seat foreign key(userId) references tbl_user(userId);
ALTER TABLE tbl_reservation add constraint uk_user_seat UNIQUE (userId);

CREATE SEQUENCE return_seq;
CREATE TABLE tbl_return(
    returnId        NUMBER NOT NULL,
    seatNumber              	NUMBER NOT NULL,
    roomNumber		NUMBER NOT NULL,
    libraryId		NUMBER NOT NULL,
    userId          VARCHAR2(50) NOT NULL,
    returnTime      date default sysdate NOT NULL
);

ALTER TABLE tbl_return add constraint pk_return primary key(returnId);
ALTER TABLE tbl_reservation add constraint fk_reserv_seat foreign key(seatNumber, roomNumber, libraryId) references tbl_seat(seatNumber, belongRoomNumber, belongLibraryId);
ALTER TABLE tbl_return add constraint fk_user_ret foreign key(userId) references tbl_user(userId);

commit;