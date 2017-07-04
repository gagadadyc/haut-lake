package com.imdyc.hautlake.service;

import com.imdyc.hautlake.entity.User;

/**
 * Created by gagada on 2017/6/29.
 */
public interface UserService {

    //验证账号密码
    User getUserVer(String username, String password);

}
