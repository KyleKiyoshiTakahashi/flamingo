package com.codingdojo.Events.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.Events.models.UserPhoto;

@Repository
public interface UserPhotoRepo extends CrudRepository<UserPhoto, Long> {
	List<UserPhoto> findAll();
}
