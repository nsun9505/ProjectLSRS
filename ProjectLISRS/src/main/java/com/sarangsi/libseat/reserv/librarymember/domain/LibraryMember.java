package com.sarangsi.libseat.reserv.librarymember.domain;

import com.sarangsi.libseat.reserv.library.domain.Library;
import com.sarangsi.libseat.reserv.member.domain.Member;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity(name = "library_member")
public class LibraryMember {
    @Id @GeneratedValue
    @Column(name = "library_member_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "library_id")
    private Library library;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @Column(name = "possible_reservation")
    private boolean possibleReservation;

    @Column(name = "possible_reservation_date")
    private LocalDateTime possibleReservationDate;
}
