package com.sarangsi.libseat.reserv.board.regularmember.request.domain;

import com.sarangsi.libseat.reserv.board.Board;
import com.sarangsi.libseat.reserv.board.regularmember.answer.domain.RegularMemberAnswer;
import com.sarangsi.libseat.reserv.library.domain.Library;
import com.sarangsi.libseat.reserv.member.domain.Member;

import javax.persistence.*;

@Entity(name = "regular_member_request")
public class RegularMemberRequest extends Board {
    @Id @GeneratedValue
    @Column(name = "regular_member_request_id")
    private Long id;

    @OneToOne
    private RegularMemberAnswer answer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member author;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "library_id")
    private Library library;
}
