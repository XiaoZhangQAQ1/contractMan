package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shiro.entity.User;

public interface UserMapper {
	public int insertUser(User user);
	public User getUserByUid(@Param("uid") String uid);
	//public int UpdateUser(User user);
	public int freezeUser(@Param("uid") String uid,@Param("status")int status);
	public int updateUserPass(User user);
	public int updateUserLoginDate(User user);
	public List<User> getUserByRid(@Param("rid")String rid);
	public int updateUserInfo(User user);
	public List<User> getUsers(@Param("uid")String uid,@Param("uName")String uName,@Param("eMail")String eMail,@Param("tel")String tel);
	public int deleteUserRole(@Param("uid") String uid);
	public int insertUserRole(@Param("uid") String uid,@Param("rid")String rid);
}
