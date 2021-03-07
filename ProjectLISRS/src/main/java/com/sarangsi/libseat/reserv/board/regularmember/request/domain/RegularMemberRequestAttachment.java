package com.sarangsi.libseat.reserv.board.regularmember.request.domain;

import com.sarangsi.libseat.reserv.board.Attachment;

import javax.persistence.*;

@Entity(name = "regular_member_request_attachment")
public class RegularMemberRequestAttachment extends Attachment {
    @Id @GeneratedValue
    @Column(name = "regular_member_request_attachment_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "regular_member_request_id")
    private RegularMemberRequest regularMemberRequest;

}
