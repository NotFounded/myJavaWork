package com.xingyun.train.one.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xingyun.train.one.dao.UserMapper;
import com.xingyun.train.one.pojo.User;

/**
 * 用户模块serviceImpl
 * 
 * @author feijunhui
 *
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired()
	private UserMapper userMapper;

	/**
	 * 登录
	 */
	@Override
	public User login(String username, String password) {
		return userMapper.login(username, password);
	}

	/**
	 * 增加昵称
	 */
	@Override
	public void addNickName(String nickname, int userid) {
		userMapper.addNickName(nickname, userid);
	}

	/**
	 * 通过用户名查询
	 */
	@Override
	public User findByName(String username) {
		return userMapper.findByName(username);
	}

	/**
	 * 用户注册
	 */
	@Override
	public void regist(String username, String password, long currentTime,String salt) {
		userMapper.regist(username, password, currentTime,salt);
	}

	/**
	 * 更新密码
	 */
	@Override
	public void updatePwdByName(String username, String password,String salt) {
		userMapper.updatePwdByName(username, password,salt);
	}


}
