package com.xingyun.train.one.pojo;

/**
 * 用户实体
 * @author feijunhui
 * id、用户名、密码、昵称、权限
 *
 */
public class User {
	//id
	private Integer userid;
	//用户名或邮箱
	private String username;
	//密码
	private String password;
	//昵称
	private String nickname;
	//日期
	private Long date;
	//密码加密的盐
	private String salt;
	
	public String getSalt() {
        return salt;
    }
    public void setSalt(String salt) {
        this.salt = salt;
    }
    public Long getDate() {
        return date;
    }
    public void setDate(Long date) {
        this.date = date;
    }
    public Integer getUserid() {
        return userid;
    }
    public void setUserid(Integer userid) {
        this.userid = userid;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getNickname() {
        return nickname;
    }
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    @Override
    public String toString() {
        return "User [userid=" + userid + ", username=" + username + ", password=" + password + ", nickname=" + nickname
                + ", date=" + date + ", salt=" + salt + "]";
    }
   
}
