package com.sarangsi.libseat.reserv.board.notice.repository;

import com.sarangsi.libseat.reserv.board.notice.domain.Notice;

import java.util.List;

public interface NoticeBoardRepository {
    void save(Notice notice);
    void delete(Long noticeId);
    List<Notice> findAll();
    Notice findById(Long noticeId);
}
