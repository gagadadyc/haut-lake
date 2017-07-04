package com.imdyc.hautlake.service.impl;

import com.imdyc.hautlake.dao.UserDao;
import com.imdyc.hautlake.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by gagada on 2017/6/29.
 */
@Service
public class UserServiceImpl implements com.imdyc.hautlake.service.UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User getUserVer(String username,String password){

        User user = userDao.selectUser(username,password);

        return user;
    }



}
