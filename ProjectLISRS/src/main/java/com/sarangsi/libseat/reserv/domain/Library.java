package com.sarangsi.libseat.reserv.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity(name="library")
public class Library {
    @Id @GeneratedValue
    @Column(name = "library_id")
    private Long libraryId;

    private String name;

    private String address;

    private String zipcode;

    private String tel;
}
