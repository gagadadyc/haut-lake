package com.imdyc.hautlake.service;

import com.imdyc.hautlake.entity.News;

import java.util.ArrayList;

/**
 * Created by gagada on 2017/7/2.
 */
public interface NewsService {

    ArrayList getNewsService();//取得所有菜单记录

    boolean insertNewsService(News news);//新增菜单并返回是否成功

    boolean markDeleteNewsService(String[] newIds);//标记为删除,可以批量删除

    boolean updateNewsService(News news);//修改新闻

}
