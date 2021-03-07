package com.sarangsi.libseat.reserv.seatusagehistory.domain;

import com.sarangsi.libseat.reserv.member.domain.Member;
import com.sarangsi.libseat.reserv.seat.domain.Seat;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity(name = "seat_usage_history")
public class SeatUsageHistory {
    @Id
    @GeneratedValue
    @Column(name = "seat_usage_history_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seat_id")
    private Seat seat;

    @Column(name = "start_time")
    private LocalDateTime startTime;

    @Column(name = "end_time")
    private LocalDateTime endTime;
}
