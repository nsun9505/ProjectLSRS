package com.sarangsi.libseat.reserv.library.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity(name="library")
@Getter @Setter
@NoArgsConstructor
public class Library {
    @Id @GeneratedValue
    @Column(name = "library_id")
    private Long libraryId;

    private String name;

    private String address;

    private String zipcode;

    private String tel;
}
