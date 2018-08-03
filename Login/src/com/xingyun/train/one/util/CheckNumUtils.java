package com.xingyun.train.one.util;
/**
 * 生成4位随机验证码工具类
 * @author feijunhui
 *
 */
public class CheckNumUtils {

	/**
	 * 生成验证码
	 * @return
	 */
	public static String getCheckNum() {
		String checkNum = "";
		for (int i = 0; i < 4; i++) {
			checkNum = checkNum + String.valueOf((int) Math.floor(Math.random() * 9 + 1));
		}
		return checkNum;
	}
}
