package com.sarangsi.libseat.reserv.board.notice.domain;

import com.sarangsi.libseat.reserv.board.Attachment;

import javax.persistence.*;

@Entity(name = "notice_attachments")
public class NoticeAttachment  extends Attachment{
    @Id @GeneratedValue
    @Column(name = "notice_attachment_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "notice_id")
    private Notice notice;
}
