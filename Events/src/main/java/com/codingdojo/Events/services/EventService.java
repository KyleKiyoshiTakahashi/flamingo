package com.codingdojo.Events.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.codingdojo.Events.models.Event;
import com.codingdojo.Events.models.Message;
import com.codingdojo.Events.models.User;
import com.codingdojo.Events.models.UserImages;
import com.codingdojo.Events.models.UserMessage;
import com.codingdojo.Events.models.UserPhoto;
import com.codingdojo.Events.repositories.EventRepo;
import com.codingdojo.Events.repositories.MessageRepo;
import com.codingdojo.Events.repositories.UserImagesRepo;
import com.codingdojo.Events.repositories.UserMessageRepo;
import com.codingdojo.Events.repositories.UserPhotoRepo;
import com.codingdojo.Events.repositories.UserRepo;

@Service
public class EventService {
	private final UserRepo userRepo;
	private final EventRepo eventRepo;
	private final UserImagesRepo imagesRepo;
	private final UserPhotoRepo photoRepo;
	
//	UserEventRepo is never used so it is not here
	private final UserMessageRepo userMessageRepo;
	private final MessageRepo messageRepo;
	
	public EventService(UserRepo userRepo, EventRepo eventRepo, MessageRepo messageRepo, UserImagesRepo imagesRepo, UserMessageRepo userMessageRepo, UserPhotoRepo photoRepo) {
		this.userRepo = userRepo;
		this.eventRepo = eventRepo;
		this.imagesRepo = imagesRepo;
		this.messageRepo = messageRepo;
		this.userMessageRepo = userMessageRepo;
		this.photoRepo = photoRepo;
	}
	//	deletes an event by id
	public void deleteEvent(Long id) {
		eventRepo.deleteById(id);
	}
	//	finds all events...had to change the findAll() method in the eventRepo to from returning an iterable to a list
    public List<Event> allEvents() {
    	return eventRepo.findAll();
    }
    
//    finds all avatar images
    public List<UserImages> allImages(){
    	return imagesRepo.findAll();
    }
// finds all photos
    public List<UserPhoto> allPhotos() {
		
		return photoRepo.findAll();
	}

    
//    find all messages with events
    public List<Message> allMessages(){
    	return messageRepo.findAll();
    }
    
//  find all messages from users only
    public List<UserMessage> allUserMessages(){
    	return userMessageRepo.findAll();
    }
    
    //	adds an event
	public Event addEvent(Event event) {
		return eventRepo.save(event);
	}

	// register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepo.save(user);
    }
 // find user by email
    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
 // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepo.findById(id);
    	if(u.isPresent()) {
            return u.get();
    	}
    	else {
    	    return null;
    	}
    }
    
//    find users avatar by  id
    public UserImages findUserImagesByUserId(Long id) {
    	Optional<UserImages> uI = imagesRepo.findById(id);
    	if(uI.isPresent()) {
            return uI.get();
    	}
    	else {
    	    return null;
    	}
    }
//    find usermessage by ID
public UserMessage findUserMessageById(Long id) {
		Optional<UserMessage> uM = userMessageRepo.findById(id);
		if(uM.isPresent()) {
			return uM.get();
		} else {
			return null;
		}
		
	}
// find users photos by id
    public UserPhoto findPhotoByUserId(Long id) {
    	Optional<UserPhoto> uP = photoRepo.findById(id);
    	if(uP.isPresent()) {
    		return uP.get();
    	} else {
    		return null;
    	}
    }
    
//    find event by id
    public Event findEventById(Long id) {
    	Optional<Event> e = eventRepo.findById(id);
    	if(e.isPresent()) {
            return e.get();
    	}
    	else {
    	    return null;
    	}
    }
    // updates event info   
    public void updateEvent(Event event) {
        eventRepo.save(event);
    }
    //  updates user info...needed when a user joins or un-joins an event  

    public void updateUser(User user) {
        userRepo.save(user);
    }
    
//    adds new avatar
    public void addImage(UserImages userImages) {
    	imagesRepo.save(userImages);
    }
// add new photo
    public void addPhoto(UserPhoto userPhoto) {
    	photoRepo.save(userPhoto);
    }

    //   creates a new message for events
    public void newMessage(Message message) {
        messageRepo.save(message);
    }
    
//    creates a new message for users
    public void newUserMessage(UserMessage userMessage) {
    	userMessageRepo.save(userMessage);
    }
    
    //Authentication, authenticates user
    public boolean authenticateUser(String email, String password) {
    	//  finds user by email  	
        User user = userRepo.findByEmail(email);
        // if we can't find the user by email, return false       
        if(user == null) {
        	System.out.println("authenticateUser page user == null " );
            return false;
            
        } else {
    	 // if the passwords match, return true, else, return false
        if(BCrypt.checkpw(password, user.getPassword())) {
        	System.out.println("authenticateUser page user password vs hashed pw");
            return true;
            
        }
        	else {
            return false;
        	}
        } 
    }
    //   checks if there is an email that already exists in the DB
    public boolean duplicateUser(String email) {
        User user = userRepo.findByEmail(email);
        if(user == null) {
            return false;
        }
        else {
        	return true;
        }
    }
	
	
	
}