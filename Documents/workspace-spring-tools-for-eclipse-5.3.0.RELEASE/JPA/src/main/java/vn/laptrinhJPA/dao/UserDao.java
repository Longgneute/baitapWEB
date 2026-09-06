package vn.laptrinhJPA.dao;

import java.util.List;
import java.time.LocalDateTime;

import vn.laptrinhJPA.entity.User;

public interface UserDao {

	void insert(User user);

	void update(User user);

	void updateProfile(int id, String fullname, String phone, String avatar);

	void delete(int id) throws Exception;

	User findById(int id);

	User findByUsername(String username);

	User findByEmail(String email);

	User findByPhone(String phone);

	User login(String username, String password);

	User findByOtp(String otp);

	void updateOtp(int id, String otp, LocalDateTime otpExpiry);

	void activateUser(int id);

	void updatePassword(int id, String password);

	List<User> findAll();

	List<User> findAll(int page, int pageSize);

	List<User> searchByName(String fullname);

	int count();
}