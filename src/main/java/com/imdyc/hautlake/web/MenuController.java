package com.imdyc.hautlake.web;

import com.imdyc.hautlake.entity.Menu;
import com.imdyc.hautlake.service.MenuService;
import com.imdyc.hautlake.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by gagada on 2017/6/30.
 */

@Controller
@RequestMapping(value = "/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    private ArrayList menuList = new ArrayList();
    //使用json作为数据传输的格式
    //构造返回到menuManage.jsp页面的json格式数据对象
    private JSONObject result = new JSONObject();


    @RequestMapping(value = "/menumanage", method = RequestMethod.GET)
    public String menu() {
        return "menumanage";
    }

    //菜单显示
    @RequestMapping(value = "/menumanage",method = RequestMethod.POST)
    public Object MenuManage( HttpServletResponse response){

        menuList = menuService.getMenuVerService();
        //将menuList转换成json格式的数组
        JSONArray jsonArray = JSONArray.fromObject(menuList);
        //将jsonArray作为结果设置到result中
        long totalCount = menuList.size(); //获取查询到的记录数，也就是数组长度
        result.put("total", totalCount);
        result.put("rows", jsonArray);
        try {
            ResponseUtil.print(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    //菜单查询
    @RequestMapping(value = "/query",method = RequestMethod.POST)
    public Object MenuQuery(HttpServletResponse response,String menuName) {


        menuList = menuService.queryMenuVerService(menuName);

        //将menuList转换成json格式的数组
        JSONArray jsonArray = JSONArray.fromObject(menuList);
        //将jsonArray作为结果设置到result中
        long totalCount = menuList.size(); //获取查询到的记录数，也就是数组长度
        result.put("total", totalCount);
        result.put("rows", jsonArray);
        try {
            ResponseUtil.print(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;

    }

    //菜单修改，使用实体类Menu来接收表单值
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public Object updateMenu(HttpServletResponse response, Menu menu) {


        boolean bl = menuService.updateMenuService(menu);

            result.put("success", bl);  //将是否修改成功的信息放入result中返回界面
            try {
                ResponseUtil.print(response, result);
            } catch (IOException e) {
                e.printStackTrace();
            }

        return null;
    }



}


