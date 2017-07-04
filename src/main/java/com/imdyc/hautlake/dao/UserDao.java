package com.imdyc.hautlake.dao;

import com.imdyc.hautlake.entity.User;
import org.apache.ibatis.annotations.Param;

/**
 * Created by gagada on 2017/6/28.
 */
public interface UserDao {
    /**
     * 根据用户名和密码查询用户信息
     * @param username
     * @param password
     * @return
     */
     User selectUser(@Param("username") String username, @Param("password") String password);
}
