package com.sarangsi.libseat.reserv.library.domain;

import javax.persistence.*;

@Entity
public class Room {
    @Id @GeneratedValue
    @Column(name = "room_id")
    private Long roomId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "library_id")
    private Library library;

    private String number;

    private String name;

    private String type;

    @Column(name = "open_time")
    private String openTime;

    @Column(name = "close_time")
    private String closeTime;

    private int capacity;

    @Enumerated(EnumType.STRING)
    private RoomStatus roomStatus;

}
