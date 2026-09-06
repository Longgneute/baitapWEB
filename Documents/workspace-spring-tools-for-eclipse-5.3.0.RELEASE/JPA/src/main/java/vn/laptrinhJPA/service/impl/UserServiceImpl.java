package vn.laptrinhJPA.service.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import vn.laptrinhJPA.dao.UserDao;
import vn.laptrinhJPA.dao.impl.UserDaoImpl;
import vn.laptrinhJPA.entity.User;
import vn.laptrinhJPA.service.IUserService;

public class UserServiceImpl implements IUserService {

	private final UserDao userDao = new UserDaoImpl();

	@Override
	public void insert(User user) {

		if (checkExistUsername(user.getUsername())) {
			throw new RuntimeException("Tài khoản đã tồn tại");
		}

		if (checkExistEmail(user.getEmail())) {
			throw new RuntimeException("Email đã tồn tại");
		}

		if (checkExistPhone(user.getPhone())) {
			throw new RuntimeException("Số điện thoại đã tồn tại");
		}

		userDao.insert(user);
	}

	@Override
	public void update(User user) {

		User oldUser = userDao.findById(user.getId());

		if (oldUser == null) {
			throw new RuntimeException("Không tìm thấy User");
		}

		userDao.update(user);
	}

	@Override
	public void delete(int id) throws Exception {
		userDao.delete(id);
	}

	@Override
	public User findById(int id) {
		return userDao.findById(id);
	}

	@Override
	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}

	@Override
	public User findByEmail(String email) {
		return userDao.findByEmail(email);
	}

	@Override
	public User login(String username, String password) {
		return userDao.login(username, password);
	}

	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}

	@Override
	public List<User> findAll(int page, int pageSize) {
		return userDao.findAll(page, pageSize);
	}

	@Override
	public List<User> searchByName(String fullname) {
		return userDao.searchByName(fullname);
	}

	@Override
	public int count() {
		return userDao.count();
	}

	@Override
	public boolean checkExistEmail(String email) {
		return userDao.findByEmail(email) != null;
	}

	@Override
	public boolean checkExistUsername(String username) {
		return userDao.findByUsername(username) != null;
	}

	@Override
	public boolean checkExistPhone(String phone) {
		return userDao.findByPhone(phone) != null;
	}

	@Override
	public boolean register(String email, String password, String username, String fullname, String phone) {

		// Kiểm tra dữ liệu rỗng
		if (email == null || email.trim().isEmpty()) {
			throw new RuntimeException("Email không được để trống");
		}

		if (username == null || username.trim().isEmpty()) {
			throw new RuntimeException("Tài khoản không được để trống");
		}

		if (password == null || password.trim().isEmpty()) {
			throw new RuntimeException("Mật khẩu không được để trống");
		}

		if (fullname == null || fullname.trim().isEmpty()) {
			throw new RuntimeException("Họ tên không được để trống");
		}

		if (phone == null || phone.trim().isEmpty()) {
			throw new RuntimeException("Số điện thoại không được để trống");
		}

		// Kiểm tra trùng
		if (checkExistEmail(email.trim())) {
			throw new RuntimeException("Email đã tồn tại");
		}

		if (checkExistUsername(username.trim())) {
			throw new RuntimeException("Tài khoản đã tồn tại");
		}

		if (checkExistPhone(phone.trim())) {
			throw new RuntimeException("Số điện thoại đã tồn tại");
		}

		// Tạo User
		User user = new User();

		user.setEmail(email.trim());
		user.setPassword(password);
		user.setUsername(username.trim());
		user.setFullname(fullname.trim());
		user.setPhone(phone.trim());

		user.setAvatar(null);

		// KHÔNG set ID
		// ID sẽ tự tăng bởi database
		// user.setId(2);

		// User thường
		user.setRoleId(3);

		// Chưa kích hoạt, phải xác nhận OTP
		user.setActivated(false);

		user.setCreateddate(LocalDate.now());

		// Lưu database
		userDao.insert(user);

		return true;
	}

	@Override
	public void updateProfile(int id, String fullname, String phone, String avatar) {

		if (fullname == null || fullname.trim().isEmpty()) {
			throw new RuntimeException("Họ tên không được để trống");
		}

		if (phone == null || phone.trim().isEmpty()) {
			throw new RuntimeException("Số điện thoại không được để trống");
		}

		User oldUser = userDao.findById(id);

		if (oldUser == null) {
			throw new RuntimeException("Không tìm thấy User");
		}

		User phoneUser = userDao.findByPhone(phone);

		if (phoneUser != null && phoneUser.getId() != id) {
			throw new RuntimeException("Số điện thoại đã tồn tại");
		}

		userDao.updateProfile(id, fullname.trim(), phone.trim(), avatar);
	}

	@Override
	public User findByOtp(String otp) {
		return userDao.findByOtp(otp);
	}

	@Override
	public void updateOtp(int id, String otp, LocalDateTime otpExpiry) {

		userDao.updateOtp(id, otp, otpExpiry);
	}

	@Override
	public void activateUser(int id) {
		userDao.activateUser(id);
	}

	@Override
	public void updatePassword(int id, String password) {

		userDao.updatePassword(id, password);
	}
}
