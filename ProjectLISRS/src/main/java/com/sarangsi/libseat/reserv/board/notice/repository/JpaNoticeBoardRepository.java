package com.sarangsi.libseat.reserv.board.notice.repository;

import com.sarangsi.libseat.reserv.board.notice.domain.Notice;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class JpaNoticeBoardRepository implements NoticeBoardRepository {
    // 엔티티 매니저 주입
    private final EntityManager em;

    @Override
    public void save(Notice notice) {
        em.persist(notice);
    }

    @Override
    public void delete(Long noticeId) {
        em.remove(noticeId);
    }

    @Override
    public List<Notice> findAll() {
        return em.createQuery("select notice from Notice notice", Notice.class)
                .getResultList();
    }

    @Override
    public Notice findById(Long noticeId) {
        return em.find(Notice.class, noticeId);
    }
}
