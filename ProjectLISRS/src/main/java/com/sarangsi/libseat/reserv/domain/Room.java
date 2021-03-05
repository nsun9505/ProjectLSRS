package com.sarangsi.libseat.reserv.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Room {
    @Id
    @GeneratedValue
    @Column(name = "room_id")
    private Long roomId;
}
