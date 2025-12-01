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
    // Tìm all bản ghi
    @Query("select entity from #{#entityName} entity where entity.deletedAt is null")
    List<T> findAllActive();

    // Lấy ra 1 entity
    @Query("select entity from #{#entityName} entity where entity.id = :id and entity.deletedAt is null")
    Optional<T> findById(@Param("id") long id);

    // Xóa mềm
    @Modifying
    @Transactional
    @Query("update #{#entityName} entity set entity.deletedAt = current_timestamp where entity.id = :id and entity.deletedAt is null")
    void softDelete(@Param("id") long id);

}
