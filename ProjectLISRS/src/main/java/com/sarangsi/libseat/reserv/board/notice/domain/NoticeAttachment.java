package com.sarangsi.libseat.reserv.board.notice.domain;

import com.sarangsi.libseat.reserv.board.Attachment;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity(name = "question_attachments")
public class NoticeAttachment  extends Attachment {
    @Id @GeneratedValue
    private Long id;
}
