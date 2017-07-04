package com.imdyc.hautlake.web;

import com.imdyc.hautlake.entity.User;
import com.imdyc.hautlake.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by gagada on 2017/6/27.
 * 处理管理员端的控制器
 */

@Controller

@RequestMapping(value = "/admin")
public class AdminController {

//    @RequestMapping(value = "/Login.action", method = RequestMethod.POST)
//    public ModelAndView adminLoin(User user) {
////        List list = buyWaterService.buyWaterInfo();
//        //将矿泉水表格传给view
//
//        return new ModelAndView("adminHome",    );
//    }

    @Autowired
    private UserService userService;


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String adminLoin() {
        return "login";
    }

    //判断密码是否正确，正确则返回main页面
    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public String adminLoginVer(String username, String password, HttpServletRequest request) {
        User user = userService.getUserVer(username, password);

        if(user==null){
            request.setAttribute("errMsg","用户名密码错误");
            return "error";
        }else {
            request.getSession().setAttribute("User",user);
            return "main";
        }
    }





}
