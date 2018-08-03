package com.xingyun.train.one.dao;

import org.apache.ibatis.annotations.Param;

import com.xingyun.train.one.pojo.User;

/**
 * 用户模块 Mapper
 * @author feijunhui
 *
 */
public interface UserMapper {
	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @return
	 */
    User login(@Param("username")String username,@Param("password")String password);

    /**
     * 添加昵称
     * @param nickname
     * @param userid
     */
	void addNickName(@Param("nickname")String nickname,@Param("userid") int userid);

	/**
	 * 通过用户名查询
	 * @param username
	 * @return
	 */
	User findByName(String username);

	/**
	 * 用户注册
	 * @param username
	 * @param password
	 * @param currentTime 
	 * @param salt 
	 */
	void regist(@Param("username")String username, @Param("password")String password, @Param("currentTime")long currentTime,@Param("salt") String salt);

	/**
	 * 更新密码
	 * @param username
	 * @param password
	 * @param salt 
	 */
	void updatePwdByName(@Param("username")String username,@Param("password") String password,@Param("salt") String salt);
	
}