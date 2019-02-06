package com.codingdojo.Events.controllers;

import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.Events.models.Event;
import com.codingdojo.Events.models.Message;
import com.codingdojo.Events.models.User;
import com.codingdojo.Events.models.UserImages;
import com.codingdojo.Events.models.UserMessage;
import com.codingdojo.Events.models.UserPhoto;
import com.codingdojo.Events.services.EventService;
import com.codingdojo.Events.validators.UserValidator;



@Controller
public class EventsController {
	private final EventService eventService;
	private final UserValidator userValidator;

	public EventsController(EventService eventService, UserValidator userValidator) {
		this.eventService = eventService;
		this.userValidator = userValidator;
	}
	//	this will create an ArrayList of states for use in the dropdown menu for selecting a state. Arrays.asList() method explained here-> https://www.geeksforgeeks.org/arrays-aslist-method-in-java-with-examples/
	//	there are other ways to display all the states in the dropdown. This is just what I found first.
	ArrayList<String> states = new ArrayList<String>(Arrays.asList("AL", "AK", "AZ", "AR", "CA", "CO", "CT",
			"DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN",
			"MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI",
			"SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"));
	
	//Index, will send the states list to be used in the dropdown menu. Renders index.jsp.
	@GetMapping("")
	public String index(@ModelAttribute("userObj") User user, Model model) {
		// we have to send the states in the Get request so we can use it in the registration form		
		model.addAttribute("states", states);
		return "index.jsp";
	}
	//Registration form. 	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("userObj") User user, BindingResult result, Model model, HttpSession session) {
		//validation: checks if the password and confirmPassword match		
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			model.addAttribute("states", states);
			return "index.jsp";
		}
		//validation: checks to see if there is already an existing email		
		boolean isDuplicate = eventService.duplicateUser(user.getEmail());
		if(isDuplicate) {
			model.addAttribute("error", "Email already in use! Please try again with a different email address!");
			return "index.jsp";
		}
		//If no errors, register user to DB and set userId in session	
		User u = eventService.registerUser(user);
		session.setAttribute("userId", u.getId());
		System.out.println("registering user "+u.getId() );
		return "redirect:/home";
	}
	@GetMapping("/login")
	public String loginPage() {
		return "login.jsp";
	}
	
	//login
	@PostMapping("/login")
	public String signIn(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		//	validation: if users email exists then checks if the email matches the password	
		boolean isAuthenticated = eventService.authenticateUser(email, password);
		// if user isAuthenticated then userId is stored in session 		
		if(isAuthenticated == false) {
			System.out.println("error1");
			model.addAttribute("error", "Invalid Credentials!");
			System.out.println("error2");
			return "index.jsp";
		}
		else {
			User u = eventService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/home";
		}
	}
	
	@GetMapping("/home")
	public String home( @ModelAttribute("messageObj") UserMessage userMessage, BindingResult result, HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", user);
		List<UserMessage> messages = eventService.allUserMessages();
		
		Collections.reverse(messages);
		model.addAttribute("messages", messages);
		return "dashboard.jsp";
	}
	
	@PostMapping("/dashboard/addmsg")
	public String addUserMessage(@Valid @ModelAttribute("messageObj") UserMessage userMessage, BindingResult result, Model model, HttpSession session) {
		
		if(result.hasErrors()) {
			
			return "dashboard.jsp";
		}
		//	get user 	
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		// send user info		
		model.addAttribute("user", user);
		//	sends message	
		eventService.newUserMessage(userMessage);
		return "redirect:/home";
		
	}
	
	@GetMapping("/photos")
	public String photos(@ModelAttribute("imageObj") UserPhoto userPhoto, BindingResult result, Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		User userInfo = eventService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", userInfo);
		List<UserPhoto> photo = eventService.allPhotos();
		Collections.reverse(photo);
		model.addAttribute("photos", photo);
		return "photos.jsp";
	}
	
	@PostMapping("/addPhoto")
	public String addPhotos(@ModelAttribute("imageObj") UserPhoto userPhoto, BindingResult result, Model model, HttpSession session) {
		User user1 = eventService.findUserById((Long)session.getAttribute("userId"));
		if(result.hasErrors()) {
			
			return "photos.jsp";
		}
		else {		
			
			eventService.addPhoto(userPhoto);
			
			System.out.println("added an photo " + userPhoto);
			return "redirect:/photos";
		}
	}
	
	@GetMapping("/events")
	public String events(@Valid @ModelAttribute("eventObj") Event event, BindingResult result, HttpSession session, Model model) {
		// if you tried to go directly to the url without signing in		
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		//	gets user info from session	
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		//	sends user info to page	
		model.addAttribute("user", user);
		//	gets the state the user is in and stores it in session for later	
		session.setAttribute("states", states);
//		gets all the images
		UserImages userImg =  eventService.findUserImagesByUserId(user.getId());
		model.addAttribute("userImages", userImg);
//	    
		
		//  gets all events
		List<Event> events = eventService.allEvents();
		// creates an empty list of events the user is located in       
		List<Event> instate = new ArrayList<Event>();
		// creates an empty list on events in other states      
		List<Event> outofstate = new ArrayList<Event>();
		//  origin: events is like for i in events       
		for(Event location: events) {
			//  if the state with events is the same as the users location, add it to the list of instate events      	
			if(location.getState().equals(user.getState())) {
        		instate.add(location);
			}
			//	if the state does not match the users location add them to outofstate		
        	else {
        		outofstate.add(location);
        	}
        }
		//	sends the instate events and outofstate events to the page	
        model.addAttribute("instate", instate);
        model.addAttribute("outofstate", outofstate);
		return "events.jsp";
	}
	
	@GetMapping("/chat")
	public String chatApp() {
		return "chat.jsp";
	}
	
	@GetMapping("/avatar/{id}")
	public String addAvatarPage(@PathVariable("id") Long id, @ModelAttribute("userAvtr") UserImages user, BindingResult result, Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		User userInfo = eventService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", userInfo);
		return "addAvatar.jsp";
	}
	
	@PostMapping("/avatar")
	public String addAvatar( @ModelAttribute("userAvtr") UserImages userImg, BindingResult result, Model model, HttpSession session) {
		User user1 = eventService.findUserById((Long)session.getAttribute("userId"));
		if(result.hasErrors()) {
			
			return "addAvatar.jsp";
		}
		else {		
			
			eventService.addImage(userImg);
			
			System.out.println("added an avatar pic" + userImg);
			return "redirect:/home";
		}
	}
//	view the users profile
	@GetMapping("/userProfile/{id}")
	public String viewProfile(@PathVariable("id") Long id,Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		User user = eventService.findUserById(id);
		model.addAttribute("user", user);
		
		List<UserPhoto> photo = eventService.allPhotos();
		Collections.reverse(photo);
		model.addAttribute("photos", photo);
		return "myProfile.jsp";
	}
	
	
	
	//	view a single event by eventId
	@GetMapping("/events/{id}")
	public String viewEvent(@PathVariable("id") Long id, @Valid @ModelAttribute("messageObj") Message message, BindingResult result, Model model, HttpSession session) {
		//	if someone not in session tries to go directly to url	
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		//	gets the user info from session	
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		//	finds the event by id 	
		Event event = eventService.findEventById(id);
		//	gets all the messages	
		List<Message> messages = event.getMessages();
		// this method reverses the order of the messages from oldest first to newest first	
		Collections.reverse(messages);
		//	sends the event info to be viewed	
		model.addAttribute("event", event);
		//	sends the user "host" info	
		model.addAttribute("user", user);
		// gets all the users attending the event and sends it		
		model.addAttribute("attendees", event.getJoinedUsers());
		//	sends all the messages	to be displayed
		model.addAttribute("messages", messages);
		return "details.jsp";
	}
	// renders the edit event page
	@GetMapping("/events/{id}/edit")
	public String editPage(@PathVariable("id") Long id, @ModelAttribute("event") Event event, Model model, HttpSession session) {
		//	if not in session	
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		//	gets user info from session	
		User user = eventService.findUserById((Long)session.getAttribute("userId"));
		//	checks if the event was created by the user. if so, they can edit the event	
		if(eventService.findEventById(id).getUser().getId() == user.getId()) {
			//	gets the event info that is going to be edited		
			model.addAttribute("event", eventService.findEventById(id));
			return "edit.jsp";
		}
		else {
			return "redirect:/";
		}
	}
	//	logout: kills session
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	
	
	//CRUD
	//	Adds event
	@PostMapping("/addevent")
	public String addEvent(@Valid @ModelAttribute("eventObj") Event event, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "events.jsp";
		}
		else {
			eventService.addEvent(event);
			return "redirect:/events";	
		}	
	}
	// updates an event	
	@PutMapping("/events/{id}/edit")
	public String editEvent(@Valid @PathVariable("id") Long id, @ModelAttribute("event") Event event, BindingResult result, Model model, HttpSession session) {
		//	gets user info from session	
		User user = eventService.findUserById((Long)session.getAttribute("userId"));
		//	checks if the event was created by the user. if so, they can edit the event	
		if(eventService.findEventById(id).getUser().getId() == user.getId()) {
			if(result.hasErrors()) {
				model.addAttribute("event", eventService.findEventById(id));
				return "edit.jsp";
			}
			else {
				//	finds the event to edit			
				Event eventEdit = eventService.findEventById(id);
				// for the form to edit an event 				
				model.addAttribute("event", eventEdit);
				// associates the user to the event via a hidden input			
				model.addAttribute("user", user);
				//	sets the user to the event again			
				event.setUser(user);
				//	adds the users already joined before edit back			
				event.setJoinedUsers(event.getJoinedUsers());
				// updates the event in the DB			
				eventService.updateEvent(event);
				return "redirect:/events";
			}
		}
		else {
			return "redirect:/";
		}
	}
	// join an event 	
	@RequestMapping("/events/{id}/join")
	public String joinEvent(@PathVariable("id") Long id, HttpSession session) {
		// gets the user info from session		
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		// finds the event by url id		
		Event event = eventService.findEventById(id);
		//	gets the list of users attending the event	
		List<User> attendees = event.getJoinedUsers();
		//	adds the user to the list of attendees	
		attendees.add(user);
		// sets the list of attendees to the event		
		event.setJoinedUsers(attendees);
		// updates the user info, events they are attending		
		eventService.updateUser(user);	
		return "redirect:/events";
	}
	@RequestMapping("/message/{id}/like")
	public String likeMessage(@PathVariable("id") Long id, HttpSession session) {
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		UserMessage userMessage = eventService.findUserMessageById(id);
		List<User> likes = userMessage.getLikedMessage();
		likes.add(user);
		userMessage.setLikedMessage(likes);
		eventService.updateUser(user);
		return "redirect:/home";
	}
	
	@RequestMapping("/photo/{id}/like")
	public String likePhoto(@PathVariable("id") Long id, HttpSession session) {
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		UserPhoto userPhoto = eventService.findPhotoByUserId(id);
		List<User> likes = userPhoto.getLikedPhoto();
		likes.add(user);
		userPhoto.setLikedPhoto(likes);
		eventService.updateUser(user);
		return "redirect:/photos";
	}
	
	
	//	removes user from joined event 
    @RequestMapping("/events/{id}/cancel")
    public String cancelEvent(@PathVariable("id") Long id, HttpSession session) {
    	//  gets user info from session  	
    	User user = eventService.findUserById((Long) session.getAttribute("userId"));
    	//	find the event to be canceled	
    	Event event = eventService.findEventById(id);
    	//  gets the list of users attending the event  	
    	List<User> attendees = event.getJoinedUsers();
    	// removes user from list of  attendees from the event.  for loop is needed to iterate through the list to find the userId that matches the logged in userId       
    	for(int i=0; i<attendees.size(); i++) {
            if(attendees.get(i).getId() == user.getId()) {
            	attendees.remove(i);
            }
        }
    	//  sets the attendees to the event again without the logged in user  	
        event.setJoinedUsers(attendees);
        //  updates the user info      
        eventService.updateUser(user);
    	return "redirect:/events";
    }
    //  deletes an event entirely
    @RequestMapping("/events/{id}/delete")
    public String delete(@PathVariable("id") Long id) {
    	// gets the event from the url id    	
    	Event event = eventService.findEventById(id);
    	//   for loop going through event and its attendees 	
    	for(User user: event.getJoinedUsers()) {
    		//  creates list of events the logged in user has joined  		
    		List<Event> myevents = user.getJoinedevents();
    		// removes  event  from list of events associated with user  		
    		myevents.remove(event);
    		// sets the list of joined events minus what was removed  		
    		user.setJoinedevents(myevents);;
    		eventService.updateUser(user);
    	}
    	// deletes the event   	
    	eventService.deleteEvent(id);
    	return "redirect:/events";
    }
    // send a message 	
	@PostMapping("events/addmsg")
	public String addMessage(@ModelAttribute("messageObj") Message message, Model model, HttpSession session) {
		//	get user 	
		User user = eventService.findUserById((Long) session.getAttribute("userId"));
		// send user info		
		model.addAttribute("user", user);
		//	sends message	
		eventService.newMessage(message);
		return "redirect:/events";
		
	}
}
