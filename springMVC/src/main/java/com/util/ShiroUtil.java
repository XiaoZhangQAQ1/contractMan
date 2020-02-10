package com.util;

import java.util.UUID;

import org.apache.shiro.crypto.hash.SimpleHash;

public class ShiroUtil {

	/**
	 * 生成32位随机盐值
	 * @return
	 */
    public static String createSalt(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
    
    /**
               * 加盐加密 向数据库中写密码时使用
     * @param password
     * @param salt
     * @return
     */
    public static String getSalt(String password,String salt){
    	return new SimpleHash("MD5", password, salt, 2).toString();
    }
}
