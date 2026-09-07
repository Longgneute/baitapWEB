package vn.laptrinhJPA.util;

public class ValidationUtil {

	private ValidationUtil() {
	}

	/**
	 * Kiểm tra chuỗi rỗng
	 */
	public static boolean isEmpty(String value) {
		return value == null || value.trim().isEmpty();
	}

	/**
	 * Email
	 */
	public static boolean isValidEmail(String email) {

		if (isEmpty(email)) {
			return false;
		}

		return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
	}

	/**
	 * Số điện thoại Việt Nam
	 */
	public static boolean isValidPhone(String phone) {

		if (isEmpty(phone)) {
			return false;
		}

		return phone.matches("^(0|\\+84)(3|5|7|8|9)[0-9]{8}$");
	}

	/**
	 * Password Tối thiểu 6 ký tự
	 */
	public static boolean isValidPassword(String password) {

		if (isEmpty(password)) {
			return false;
		}

		return password.length() >= 6;
	}

	/**
	 * OTP 6 số
	 */
	public static boolean isValidOTP(String otp) {

		if (isEmpty(otp)) {
			return false;
		}

		return otp.matches("^\\d{6}$");
	}

	/**
	 * Kiểm tra số nguyên dương
	 */
	public static boolean isPositiveInteger(String value) {

		if (isEmpty(value)) {
			return false;
		}

		try {

			int number = Integer.parseInt(value);

			return number > 0;

		} catch (NumberFormatException e) {

			return false;
		}
	}

	/**
	 * Kiểm tra số thực dương
	 */
	public static boolean isPositiveDouble(String value) {

		if (isEmpty(value)) {
			return false;
		}

		try {

			double number = Double.parseDouble(value);

			return number > 0;

		} catch (NumberFormatException e) {

			return false;
		}
	}

	/**
	 * Kiểm tra độ dài chuỗi
	 */
	public static boolean isLengthBetween(String value, int min, int max) {

		if (isEmpty(value)) {
			return false;
		}

		int length = value.trim().length();

		return length >= min && length <= max;
	}

}