package io.satendra.authorizationserver.dao;

import io.satendra.authorizationserver.entity.UsersEntity;
import org.springframework.data.repository.CrudRepository;

public interface UsersDao extends CrudRepository<UsersEntity, Integer> {

    UsersEntity findByUsername(String username);
}
