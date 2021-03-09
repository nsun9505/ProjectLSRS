package com.sarangsi.libseat.reserv.board;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Setter
@Getter
@MappedSuperclass
public abstract class Board {
    private String title;
    private String content;
    private LocalDateTime createDate;
    private LocalDateTime modifyDate;
}
