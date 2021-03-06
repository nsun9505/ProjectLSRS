package com.sarangsi.libseat.reserv.board.regularmember.request.domain;

import com.sarangsi.libseat.reserv.board.Attachment;

import javax.persistence.*;

@Entity(name = "notice_attachments")
public class RequestAttachment extends Attachment {
    @Id @GeneratedValue
    private Long id;
}
