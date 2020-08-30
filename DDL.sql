DROP TABLE tbl_group CASCADE CONSTRAINTS;
DROP TABLE tbl_library CASCADE CONSTRAINTS;
DROP TABLE tbl_room CASCADE CONSTRAINTS;
DROP TABLE tbl_seat CASCADE CONSTRAINTS;
DROP TABLE tbl_user CASCADE CONSTRAINTS;
DROP TABLE tbl_auth CASCADE CONSTRAINTS;
DROP TABLE tbl_user_auth CASCADE CONSTRAINTS;
DROP TABLE tbl_reservation CASCADE CONSTRAINTS;
DROP TABLE tbl_return CASCADE CONSTRAINTS;

DROP SEQUENCE group_seq;
DROP SEQUENCE library_seq;
DROP SEQUENCE room_seq;
DROP SEQUENCE seat_seq;
DROP SEQUENCE auth_seq;
DROP SEQUENCE reserv_seq;
DROP SEQUENCE return_seq;

CREATE SEQUENCE group_seq;
CREATE TABLE tbl_group(
    groupId	NUMBER NOT NULL PRIMARY KEY,
    groupName	varchar2(50)
);

CREATE SEQUENCE library_seq;
CREATE TABLE tbl_library(
    libraryId      	Number NOT NULL primary key,
    Name    	varchar2(100) NOT NULL,
    Address 	varchar2(200) NOT NULL,
    groupId 	NUMBER NOT NULL
);
ALTER TABLE tbl_library add constraint fk_lib_group foreign key(groupId) references tbl_group(groupId);

CREATE SEQUENCE room_seq;
CREATE TABLE tbl_room(
    roomNumber          Number NOT NULL,
    belongLibraryID     Number NOT NULL,
    MaxUser             Number NOT NULL
);
ALTER TABLE tbl_room add constraint pk_room primary key(roomNumber, belongLibraryID);
ALTER TABLE tbl_room add constraint fk_room foreign key(belongLibraryID) references tbl_library(libraryId);

CREATE TABLE tbl_seat(
    seatId              NUMBER NOT NULL,
    seatNumber          NUMBER NOT NULL,
    belongRoomNumber	NUMBER NOT NULL,
    belongLibraryId		NUMBER NOT NULL
);
ALTER TABLE tbl_seat add constraint uk_seat primary key (seatId);
ALTER TABLE tbl_seat add constraint uk_seat UNIQUE (seatNumber, belongRoomNumber, belongLibraryId);
ALTER TABLE tbl_seat add constraint fk_room_seat foreign key(belongRoomNumber, belongLibraryId) references tbl_room(roomNumber,belongLibraryId);

CREATE TABLE tbl_user(
    userId              VARCHAR2(50) NOT NULL,
    userpw              VARCHAR2(100) NOT NULL,
    username            VARCHAR2(50) NOT NULL,
    phoneNumber         VARCHAR2(13) NOT NULL,
    address             VARCHAR(200),
    enabled             char(1) default '1'
);
ALTER TABLE tbl_user add constraint pk_user primary key(userId);

CREATE SEQUENCE auth_seq;
CREATE TABLE tbl_auth(
    authId              NUMBER PRIMARY KEY,
    authType            VARCHAR2(50)
);

CREATE TABLE tbl_user_auth(
    libraryid   NUMBER NOT NULL,
    userId      VARCHAR2(50) NOT NULL,
    authId      NUMBER NOT NULL
);
ALTER TABLE tbl_user_auth add constraint pk_userauth primary key(libraryId, userId);
ALTER TABLE tbl_user_auth add constraint fk_userauth_lib foreign key(libraryId) references tbl_library(libraryid);
ALTER TABLE tbl_user_auth add constraint fk_userauth_user foreign key(userId) references tbl_user(userId);
ALTER TABLE tbl_user_auth add constraint fk_userauth_auth foreign key(authId) references tbl_auth(authId);

CREATE SEQUENCE reserv_seq;
CREATE TABLE tbl_reservation(
    reservId            NUMBER NOT NULL,
    seatId              NUMBER NOT NULL,
    userId              VARCHAR2(50) NOT NULL,
    reservDate          date default sysdate,
    startTime           date NOT NULL,
    endTime             date NOT NULL,
    numOfExtension      NUMBER NOT NULL
);
ALTER TABLE tbl_reservation add constraint pk_reserv primary key(reservId);
ALTER TABLE tbl_reservation add constraint fk_reserv_seat foreign key(seatId) references tbl_seat(seatId);
ALTER TABLE tbl_reservation add constraint fk_user_seat foreign key(userId) references tbl_user(userId);
ALTER TABLE tbl_reservation add constraint uk_reserv_user UNIQUE (userId);
ALTER TABLE tbl_reservation add constraint uk_reserv_seat UNIQUE (seatid);

CREATE SEQUENCE return_seq;
CREATE TABLE tbl_return(
    returnId        NUMBER NOT NULL,
    seatId          NUMBER NOT NULL,
    userId          VARCHAR2(50) NOT NULL,
    returnTime      date default sysdate NOT NULL
);

ALTER TABLE tbl_return add constraint pk_return primary key(returnId);
ALTER TABLE tbl_return add constraint fk_return_seat foreign key(seatId) references tbl_seat(seatId);
ALTER TABLE tbl_return add constraint fk_return_user foreign key(userId) references tbl_user(userId);

commit;