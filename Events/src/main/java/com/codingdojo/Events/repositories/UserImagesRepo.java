package com.codingdojo.Events.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.Events.models.UserImages;

@Repository
public interface UserImagesRepo extends CrudRepository<UserImages, Long> {
	List <UserImages> findAll();
}
