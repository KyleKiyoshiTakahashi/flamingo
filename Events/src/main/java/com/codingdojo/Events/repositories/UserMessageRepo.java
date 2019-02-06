package com.codingdojo.Events.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.Events.models.UserMessage;

@Repository
public interface UserMessageRepo extends CrudRepository<UserMessage, Long>{
	List <UserMessage> findAll();
}
