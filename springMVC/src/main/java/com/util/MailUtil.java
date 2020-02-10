package com.util;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {

	public static boolean sendMail(String to,String text) {
		//创建连接对象 连接到邮件服务器
		Properties properties = new Properties();
		 //设置发送邮件的基本参数
		//发送邮件服务器(注意，此处根据你的服务器来决定，如果使用的是QQ服务器，请填写smtp.qq.com)
		properties.put("mail.smtp.host", "smtp.qq.com");
		//发送端口（根据实际情况填写，一般均为25）
		properties.put("mail.smtp.port", "25");
		properties.put("mail.smtp.auth", "true");
		//设置发送邮件的账号和密码
		Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("1041829979@qq.com","xlblcsbrvzvbbbbe");
            }
        });
		//创建邮件对象
		Message message = new MimeMessage(session);
		//设置发件人
        try {
            message.setFrom(new InternetAddress("1041829979@qq.com"));
	        //设置收件人
	        message.setRecipient(Message.RecipientType.TO,new InternetAddress(to));//收件人
	        //设置主题
	        message.setSubject("Admin");
	        //设置邮件正文  第二个参数是邮件发送的类型
	        message.setContent("本次的验证码是："+text,"text/html;charset=UTF-8");
	        //发送一封邮件
//            Transport transport = session.getTransport();
//            transport.connect("1041829979@qq.com","xevceekqzhzpbffb");
            Transport.send(message);
            System.out.println("发送完成");
        } catch (MessagingException e) {
        	e.printStackTrace();
        	System.out.println(e.toString());
        	return false;
        }
        return true;
	}
	
}
