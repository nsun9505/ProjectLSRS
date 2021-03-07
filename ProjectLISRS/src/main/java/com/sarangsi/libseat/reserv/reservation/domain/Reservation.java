package com.sarangsi.libseat.reserv.reservation.domain;

import com.sarangsi.libseat.reserv.seat.domain.Seat;
import com.sarangsi.libseat.reserv.member.domain.Member;

import javax.persistence.*;
import javax.validation.OverridesAttribute;

@Entity
public class Reservation {
    @Id @GeneratedValue
    @Column(name = "reservation_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seat_id")
    private Seat seat;

    private String startTime;

    private String endTime;

    private int extensionCount;

    @ManyToOne(fetch = FetchType.LAZY)
    // JoinColumn (name = "owner_id") : 매핑할 FK 이름 = owner_id
    @JoinColumn(name = "owner_id")
    private Member owner;
}
