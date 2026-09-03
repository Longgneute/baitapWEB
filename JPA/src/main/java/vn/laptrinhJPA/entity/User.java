package vn.laptrinhJPA.entity;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "users")
public class User implements Serializable {

	@Serial
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "email", nullable = false, unique = true, length = 255)
	private String email;

	@Column(name = "username", nullable = false, unique = true, length = 100)
	private String username;

	@Column(name = "fullname", nullable = false, length = 255)
	private String fullname;

	@Column(name = "password", nullable = false, length = 255)
	private String password;

	@Column(name = "avatar", length = 255)
	private String avatar;

	@Column(name = "roleid", nullable = false)
	private int roleid;

	@Column(name = "phone", length = 20)
	private String phone;

	@Column(name = "createddate", nullable = false)
	private LocalDate createddate;

	public User() {
	}

	public User(String email, String username, String fullname, String password, String avatar, int roleid,
			String phone, LocalDate createddate) {
		this.email = email;
		this.username = username;
		this.fullname = fullname;
		this.password = password;
		this.avatar = avatar;
		this.roleid = roleid;
		this.phone = phone;
		this.createddate = createddate;
	}
	
	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getRoleId() {
        return roleid;
    }

    public void setRoleId(int roleId) {
        this.roleid = roleId;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public LocalDate getCreateddate() {
        return createddate;
    }

    public void setCreateddate(LocalDate createddate) {
        this.createddate = createddate;
    }

}