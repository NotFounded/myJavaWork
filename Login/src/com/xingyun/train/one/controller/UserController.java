package com.xingyun.train.one.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.xingyun.train.one.pojo.User;
import com.xingyun.train.one.service.UserService;
import com.xingyun.train.one.util.CheckNumUtils;
import com.xingyun.train.one.util.Md5Utils;
import com.xingyun.train.one.util.SendMailUtils;

/**
 * 用户登录业务
 * @author feijunhui
 * @date 2018-08-02 18:02:00
 */
@Controller
public class UserController {
	// 返回首页
	private final String VIEW_SUCCESS = "forward:/success.jsp";
	// 跳转至登录页
	private final String VIEW_INDEX ="redirect:index.jsp";
	// 前密码字符
	private final String BEFOREPWD = "xingyun";
	// 密码后字符
	private final String AFTERPWD = "#qqw3e4e";
	
	@Autowired
	private UserService userService;

	/**
	 * 将map转json返回，用于ajax
	 * @param resp
	 * @param map
	 * @throws IOException
	 */
    private void writeText(HttpServletResponse resp, HashMap<String, Object> map) throws IOException {
        // 设置编码，否则会乱码
        resp.setHeader("Content-type", "textml;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        // map转json
        JSONObject jsonmap = new JSONObject(map);
        resp.getWriter().print(jsonmap);
    }
    /**
     * 存入map并返回
     * @param code
     * @param msg
     * @param resp
     * @throws IOException
     */
    private void returnResult(String code, String msg, HttpServletResponse resp) throws IOException {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("code", code);
        map.put("msg", msg);
        writeText(resp, map);
    }
	
	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @param view
	 * @param session
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/login")
	@ResponseBody
	public void login(String username, String password, HttpServletResponse resp, HttpSession session) throws IOException {
	    User userByname = userService.findByName(username);
		User user = userService.login(username, Md5Utils.encryptPassword(BEFOREPWD+password+AFTERPWD, userByname.getSalt()));
		if(user==null) {
		    returnResult("error", "user not exist", resp);
			 return;
		}
		// 存入session中
		session.setAttribute("user", user);
		//登录成功后移除验证码session
		session.removeAttribute("num");
		// 判断此用户是否有昵称，若无：跳转至添加昵称页面
		if (user.getNickname() == null || user.getNickname().equals("")) {
			returnResult("success", "nickname not exist", resp);
			return;
		}
		returnResult("fail", "nickname exist", resp);
		return;
	}
	
	/**
	 * 发送验证码
	 * @param session
	 * @param username
	 * @throws AddressException
	 * @throws MessagingException
	 * @throws IOException 
	 */
	@RequestMapping("/sendCheckNum")
	public void sendCheckNum(ModelAndView view, HttpSession session, HttpServletResponse resp, HttpServletRequest req) throws AddressException, MessagingException, IOException{
        String username = req.getParameter("username");
        User user = userService.findByName(username);
        //用户为空 发送验证码并存入session
        if(user == null){
            String checkNum = CheckNumUtils.getCheckNum();
            session.setAttribute("num", checkNum);
            session.setAttribute("username", username);
            //session.setMaxInactiveInterval(60*3);
            SendMailUtils.sendMail(username, "【人人网】验证码"+checkNum+"请尽快填写！", "人人网验证码");
            returnResult("succ", "send checkNum", resp);
            return;
        }
        returnResult("fail", "username exist", resp);
        return;
	}
	
	/**
	 * 用户注册
	 * @param username
	 * @param password
	 * @param view
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/regist")
	public void regist(String username,String password,String checknum, ModelAndView view,HttpSession session,HttpServletResponse resp) throws IOException{
	    String name =(String) session.getAttribute("username");
		String num = (String) session.getAttribute("num");
		//发送验证码时的用户名与输入相同
        if (!name.equals(username)) {
            returnResult("error", "username not matc", resp);
            return;
        }
        if (checknum.equals(num)){
        	 // 获取当前注册日期(时间戳)
             //String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            long currentTime = System.currentTimeMillis();
//            "xingyun" +  password + "$Faf" + random;
            //获取随机盐
            String salt = CheckNumUtils.getCheckNum();
            userService.regist(username, Md5Utils.encryptPassword(BEFOREPWD+password+AFTERPWD, salt), currentTime,salt);
            session.removeAttribute("username");
            returnResult("succ", "regist success", resp);
            return;
        }
        returnResult("fail", "checknum not match", resp);
        return;
}
	
	/**
	 * 添加昵称
	 * @param nickname
	 * @param session
	 * @return
	 */
	@RequestMapping("/addNickName")
	public ModelAndView addNickName(String nickname, HttpSession session) {
		User user1 = (User) session.getAttribute("user");
		int userid = user1.getUserid();
		String username = user1.getUsername();
		userService.addNickName(nickname, userid);
		// 重新查添加完nickname的user
		User user = userService.findByName(username);
		// 将添加完的user重新覆盖至session
		session.setAttribute("user", user);
		return new ModelAndView(VIEW_SUCCESS);
	}

	/**
	 * 注销登录
	 * 
	 * @param view
	 * @param session
	 * @return
	 */
	@RequestMapping("/logOut")
	public ModelAndView logOut(ModelAndView view, HttpSession session) {
		// 移除session中信息并跳转
		session.removeAttribute("user");
		return new ModelAndView(VIEW_INDEX);
	}

	/**
	 * 找回密码
	 * 
	 * @param username
	 * @return
	 * @throws MessagingException
	 * @throws AddressException
	 * @throws IOException 
	 */
	@RequestMapping("/findPwd")
	public void findPwd(String username,String password,String checknum, HttpSession session,HttpServletResponse resp) throws IOException{
		String name = (String) session.getAttribute("username");
		//用户名与验证码邮箱相匹配
		if (!username.equals(name)){
			returnResult("notMatch", "username not match checkNum", resp);
			return;
		}
		String num = (String) session.getAttribute("num");
		if(num.equals(checknum)){
		    String salt = CheckNumUtils.getCheckNum();
			userService.updatePwdByName(username,Md5Utils.encryptPassword(BEFOREPWD+password+AFTERPWD, salt),salt);
			//移除验证码和对应用户名的session
			session.removeAttribute("num");
			session.removeAttribute("username");
			returnResult("succ", "email", resp);
			return;
		}
		 returnResult("fail", "checkNum not match", resp);
		 return;
	}
	
	/**
	 * 忘记密码发送的验证码
	 * @param req
	 * @param session
	 * @throws AddressException
	 * @throws MessagingException
	 * @throws IOException
	 */
	@RequestMapping("/sendFindCheckNum")
	public void sendFindCheckNum(HttpServletRequest req,HttpSession session,HttpServletResponse resp) throws AddressException, MessagingException, IOException{
		String username = (req.getParameter("username"));
        User user = userService.findByName(username);
        if(user != null){
            String checkNum = CheckNumUtils.getCheckNum();
            session.setAttribute("num", checkNum);
            session.setAttribute("username", username);
            SendMailUtils.sendMail(username,"【人人网】验证码"+checkNum+"请尽快填写！", "人人网验证码");
            returnResult("succ", "sendFindCheckNum success", resp);
            return;
        }
        returnResult("fail", "username exist", resp);
        return;
        
	}

	/**
	 * ajax返回用户信息
	 * @param session
	 * @param resp
	 * @throws IOException
	 */
	@RequestMapping("/lookInfo")
	@ResponseBody
	public void lookInfo(HttpSession session, HttpServletResponse resp) throws IOException {
		// 从session中获取用户名和昵称
		User user = (User) session.getAttribute("user");
		// 昵称存在则返回，不存在则返回跳转添加昵称页面的链接
		if (user.getNickname() == null || user.getNickname().equals("")) {
			//String nickname = "您的昵称还未设置！";
		    returnResult("notExist", "nickname not exist", resp);
		} else {
			String nickname = user.getNickname();
			returnResult(nickname, "nickname exist", resp);
		}
	}
	
}
