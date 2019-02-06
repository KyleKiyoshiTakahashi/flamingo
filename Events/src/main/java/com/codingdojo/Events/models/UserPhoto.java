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
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;

@Entity
@Table(name="user_photos")
public class UserPhoto {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	public String image;
	
	@Column(updatable=false)
	private Date createdAt;
	private Date updatedAt;
	
	
	
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    		name="user_image_like",
    		joinColumns = @JoinColumn(name="user_photo_id"),
    		inverseJoinColumns = @JoinColumn(name="user_id")
    )
    private List<User> likedPhoto;
    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
    
    public UserPhoto() {
    	
    }
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
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
	public List<User> getLikedPhoto() {
		return likedPhoto;
	}
	public void setLikedPhoto(List<User> likedPhoto) {
		this.likedPhoto = likedPhoto;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
    
}
