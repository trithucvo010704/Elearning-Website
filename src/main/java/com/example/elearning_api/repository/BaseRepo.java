package com.example.elearning_api.repository;

import com.example.elearning_api.entity.BaseEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
@NoRepositoryBean
public interface BaseRepo<T extends BaseEntity>
        extends JpaRepository<T, Long>, JpaSpecificationExecutor<T> {
    // Tim all ban gi
    @Query("select e from #{#entityName} e where e.deletedAt is null ")
    List<T> findAllActive();
    // Lay ra 1 entity
    @Query("select e from #{#entityName} e where e.id=:id and e.deletedAt is null ")
    Optional<T> findById(@Param("id") long id);
    // Xoa mem
    @Modifying@Transactional
    @Query("update #{#entityName} e set e.deletedAt = current_timestamp "+ "where e.id = :id and e.deletedAt is null")
    void softDelete(@Param("id") long id);

}
