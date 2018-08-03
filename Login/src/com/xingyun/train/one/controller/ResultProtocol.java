package com.xingyun.train.one.controller;

import java.util.HashMap;

public class ResultProtocol {
	private String code;
	private String msg;
	HashMap<Object, Object> map = new HashMap<Object, Object>();
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }

}
