package com.sarangsi.libseat.reserv.board;

import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@MappedSuperclass
public abstract class Attachment {
    private String path;
    private LocalDateTime crate_date;
    private LocalDateTime modify_date;
}
