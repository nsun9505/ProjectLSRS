package com.sarangsi.libseat.reserv.library.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Seat {
    @Id @GeneratedValue
    @Column(name = "seat_id")
    private Long id;

    private String number;

    private boolean isReserve;

    private int capacity;
}
