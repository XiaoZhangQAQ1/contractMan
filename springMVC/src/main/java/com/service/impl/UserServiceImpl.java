package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.UserMapper;
import com.service.UserService;
import com.shiro.entity.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper userMapper;
	
	@Override
	public int insert(User user) {
		// TODO Auto-generated method stub
		
		return userMapper.insertUser(user);
	}


	@Override
	public User getUserByUid(String uid) {
		// TODO Auto-generated method stub
		return userMapper.getUserByUid(uid);
	}

	@Override
	public int updateUserPass(User user) {
		// TODO Auto-generated method stub
		return userMapper.updateUserPass(user);
	}

	@Override
	public List<User> getUserByRid(String rid) {
		// TODO Auto-generated method stub
		return userMapper.getUserByRid(rid);
	}

	@Override
	public int updateUserLoginDate(User user) {
		// TODO Auto-generated method stub
		return userMapper.updateUserLoginDate(user);
	}

	@Override
	public int updateUserInfo(User user) {
		// TODO Auto-generated method stub
		return userMapper.updateUserInfo(user);
	}

	@Override
	public List<User> getUsers(String uid, String uName, String eMail, String tel) {
		// TODO Auto-generated method stub
		return userMapper.getUsers(uid, uName, eMail, tel);
	}

	@Override
	public int freezeUser(String uid,int status) {
		// TODO Auto-generated method stub
		return userMapper.freezeUser(uid, status);
	}


	@Override
	public int deleteUserRole(String uid) {
		// TODO Auto-generated method stub
		return userMapper.deleteUserRole(uid);
	}


	@Override
	public int insertUserRole(String uid, String rid) {
		// TODO Auto-generated method stub
		return userMapper.insertUserRole(uid, rid);
	}

	

}
