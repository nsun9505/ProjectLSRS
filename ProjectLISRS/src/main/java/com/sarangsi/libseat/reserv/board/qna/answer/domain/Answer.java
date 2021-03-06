package com.sarangsi.libseat.reserv.board.qna.answer.domain;

import com.sarangsi.libseat.reserv.board.Board;
import com.sarangsi.libseat.reserv.library.domain.Library;
import com.sarangsi.libseat.reserv.member.domain.Member;

import javax.persistence.*;

@Entity
public class Answer extends Board {
    @Id @GeneratedValue
    @Column(name = "answer_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member author;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "library_id")
    private Library library;
}
