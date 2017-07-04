package com.imdyc.hautlake.web;

import com.imdyc.hautlake.entity.News;
import com.imdyc.hautlake.entity.User;
import com.imdyc.hautlake.service.NewsService;
import com.imdyc.hautlake.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by gagada on 2017/7/2.
 */
@Controller
@RequestMapping(value = "/news")
public class NewsController {

    @Autowired
    private NewsService newsService;

    private ArrayList newsList = new ArrayList();
    //使用json作为数据传输的格式
    //构造返回到menuManage.jsp页面的json格式数据对象
    private JSONObject result = new JSONObject();

    @RequestMapping(value = "/newsmanage", method = RequestMethod.GET)
    public String news() {
        return "newsmanage";
    }

    //显示新闻
    @RequestMapping(value = "/newsmanage", method = RequestMethod.POST)
    public String newsManage(HttpServletResponse response) {
        newsList = newsService.getNewsService();  //执行查询
        //将menuList转换成json格式的数组
        JSONArray jsonArray = JSONArray.fromObject(newsList);
        //将jsonArray作为结果设置到result中
        long totalCount = newsList.size(); //获取查询到的记录数，也就是数组长度
        result.put("total", totalCount);
        result.put("rows", jsonArray);
        try {
            ResponseUtil.print(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    //添加新闻
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String updateNews(HttpServletRequest request,HttpServletResponse response, News news) {

        //从session中读取用户名
        User user = (User) request.getSession().getAttribute("User");
        String username = user.getUsername();

        news.setNewsAuthor(username);//发布者既为当前用户

        boolean bl = newsService.insertNewsService(news);

        result.put("success", bl);  //将是否修改成功的信息放入result中返回界面
        try {

            ResponseUtil.print(response, result);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    //删除新闻
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String updateNews(HttpServletRequest request,HttpServletResponse response) {

        String reqIds = request.getParameter("ids");
        //将接收到的参数使用","分割成数组
        String[] newsids = reqIds.split(",");


        boolean bl = newsService.markDeleteNewsService(newsids);

        result.put("success", bl);  //将是否删除成功的信息放入result中返回界面

        try {
            ResponseUtil.print(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    //修改新闻
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String UpdateNews(HttpServletResponse response, News news) {


        System.out.print(news.toString());

        boolean bl = newsService.updateNewsService(news);

        result.put("success", bl);  //将是否修改成功的信息放入result中返回界面
        try {
            ResponseUtil.print(response, result);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

}
