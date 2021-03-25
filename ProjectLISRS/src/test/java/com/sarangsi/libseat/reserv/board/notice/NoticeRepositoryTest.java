package com.sarangsi.libseat.reserv.board.notice;

import com.sarangsi.libseat.reserv.board.notice.domain.Notice;
import com.sarangsi.libseat.reserv.board.notice.repository.NoticeBoardRepository;
import com.sarangsi.libseat.reserv.library.domain.Library;
import com.sarangsi.libseat.reserv.member.domain.Member;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;


//JUnit5 : @ExtendWith(SpringExtension.class)
@ExtendWith(SpringExtension.class)
@SpringBootTest // Autowired를 쓰기 위해서 사용
@Transactional
public class NoticeRepositoryTest {
    @Autowired
    NoticeBoardRepository repository;

    @Autowired
    EntityManager em;

    @Test
    @DisplayName("글 저장")
    @Transactional
    @Rollback(false)
    void saveTest(){
        Notice notice = new Notice();
        notice.setTitle("title");
//        notice.setAuthor(new Member());
//        notice.setLibrary(new Library());
        notice.setContent("first content");

        repository.save(notice);

        Notice findNotice = repository.findById(1L);

        Assertions.assertThat(findNotice.getContent()).isEqualTo("first content");
    }
}
