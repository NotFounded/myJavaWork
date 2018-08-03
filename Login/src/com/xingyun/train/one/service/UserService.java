package com.xingyun.train.one.service;

import org.springframework.transaction.annotation.Transactional;

import com.xingyun.train.one.pojo.User;


/**
 * 用户模块 service接口
 * @author feijunhui
 *
 */
@Transactional
public interface UserService {

	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @return
	 */
	User login(String username,String password);

	/**
	 * 添加昵称
	 * @param nickname
	 * @param userid
	 */
	void addNickName(String nickname, int userid);

	/**
	 * 通过用户名查询用户
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
	void regist(String username, String password, long currentTime, String salt);

	/**
	 * 更新密码
	 * @param username
	 * @param password
	 * @param salt 
	 */
	void updatePwdByName(String username, String password, String salt);
}
