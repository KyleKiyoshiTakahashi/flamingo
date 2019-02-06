package com.codingdojo.Events.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name="user_messages")
public class UserMessage {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotBlank(message="must not be blank!")
	@Size(min=1, max=60, message="must be more than 0 and less than 60 characters!")
	private String message;
	

	
    @Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    		name="user_message_like",
    		joinColumns = @JoinColumn(name="user_message_id"),
    		inverseJoinColumns = @JoinColumn(name="user_id")
    )
    private List<User> likedMessage;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User user;
	
	public UserMessage() {
	}
	
	public UserMessage(String message, User user) {
		this.message = message;
		this.user = user;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<User> getLikedMessage() {
		return likedMessage;
	}
	public void setLikedMessage(List<User> likedMessage) {
		this.likedMessage = likedMessage;
	}
	
}
