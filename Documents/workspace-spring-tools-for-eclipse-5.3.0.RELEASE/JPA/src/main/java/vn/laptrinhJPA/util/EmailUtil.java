package vn.laptrinhJPA.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

	private static final String FROM_EMAIL = "nhoanglong233@gmail.com";

	private static final String APP_PASSWORD = "tdxvyhjctoyhhkbp";

	private EmailUtil() {
	}

	public static void sendOTP(String toEmail, String otp) {

		try {

			Properties props = new Properties();

			props.put("mail.smtp.auth", "true");

			props.put("mail.smtp.starttls.enable", "true");

			props.put("mail.smtp.host", "smtp.gmail.com");

			props.put("mail.smtp.port", "587");

			Session session = Session.getInstance(props, new Authenticator() {

				@Override
				protected PasswordAuthentication getPasswordAuthentication() {

					return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
				}
			});

			Message message = new MimeMessage(session);

			message.setFrom(new InternetAddress(FROM_EMAIL));

			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

			message.setSubject("Mã OTP - Shopping MVC");

			message.setText("Mã OTP của bạn là: " + otp + "\n\n" + "Mã OTP có hiệu lực trong 5 phút.");

			Transport.send(message);

		} catch (Exception e) {

			e.printStackTrace();

			throw new RuntimeException("Không thể gửi email OTP");
		}
	}
}