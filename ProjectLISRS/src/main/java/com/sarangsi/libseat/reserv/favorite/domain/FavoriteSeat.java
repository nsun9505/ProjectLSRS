package com.sarangsi.libseat.reserv.favorite.domain;

import com.sarangsi.libseat.reserv.member.domain.Member;
import com.sarangsi.libseat.reserv.seat.domain.Seat;

import javax.persistence.*;

@Entity(name = "favorite_seat")
public class FavoriteSeat {
    @Id @GeneratedValue
    @Column(name = "favorite_seat_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seat_id")
    private Seat seat;
}
