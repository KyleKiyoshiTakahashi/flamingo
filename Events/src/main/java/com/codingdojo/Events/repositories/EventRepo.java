package com.codingdojo.Events.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.Events.models.Event;

@Repository
public interface EventRepo extends CrudRepository <Event, Long> {
//	While a List is guaranteed to be an Iterable an Iterable may not be a List. This means that if you do cast an Iterable to a List it may fail at runtime. Even if it works, there's no guarantee that it will continue to work in the future as it could change in new versions of Spring Data JPA without breaking the interface's contract.
	List<Event> findAll();
}
