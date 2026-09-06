package vn.laptrinhJPA.service;

import java.util.List;
import java.time.LocalDateTime;

import vn.laptrinhJPA.entity.User;

public interface IUserService {

	boolean register(String email, String password, String username, String fullname, String phone);

	User findByOtp(String otp);

	void updateOtp(int id, String otp, LocalDateTime otpExpiry);

	void activateUser(int id);

	void updatePassword(int id, String password);

	void insert(User user);

	void update(User user);

	void delete(int id) throws Exception;

	void updateProfile(int id, String fullname, String phone, String avatar);

	User findById(int id);

	User findByUsername(String username);

	User findByEmail(String email);

	User login(String username, String password);

	List<User> findAll();

	List<User> findAll(int page, int pageSize);

	List<User> searchByName(String fullname);

	int count();

	boolean checkExistEmail(String email);

	boolean checkExistUsername(String username);

	boolean checkExistPhone(String phone);
}
