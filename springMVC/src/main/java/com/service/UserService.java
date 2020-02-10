package com.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shiro.entity.User;

public interface UserService {
	int insert(User user);
	int freezeUser(String uid,int status);
	User getUserByUid(String uid);
	int updateUserPass(User user);
	List<User> getUserByRid(String rid);
	int updateUserLoginDate(User user);
	int updateUserInfo(User user);
	List<User> getUsers(String uid,String uName,String eMail,String tel);
	int deleteUserRole(String uid);
	int insertUserRole(String uid,String rid);
}
