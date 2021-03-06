package com.sarangsi.libseat.reserv.member.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Member {
    @Id @GeneratedValue
    @Column(name = "member_id")
    private Long id;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "password")
    private String password;

    private String name;

    @Column(name = "phone_number")
    private String phoneNumber;

    private String email;

    private String address;

    private String zipcode;

    @Column(name = "type")
    private MemberType memberType;

    @Column(name = "is_admin")
    private boolean isAdmin;
}
