package com.imdyc.hautlake.service.impl;

import com.imdyc.hautlake.dao.NewsDao;
import com.imdyc.hautlake.entity.News;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * 新闻业务处理类
 * Created by gagada on 2017/7/2.
 */
@Service
public class NewsServiceImpl implements com.imdyc.hautlake.service.NewsService{

    @Autowired
    private NewsDao newsDao;

    //取得新闻列表
    @Override
    public ArrayList getNewsService(){
        ArrayList arrayList = newsDao.selectNews();
        return arrayList;
    }


    //发布新闻
    @Override
    public boolean insertNewsService(News news){

        //提交参数： 新闻标题、内容、发布者、热度
        int r = newsDao.insertNews(news.getNewsTitle(),news.getNewsContent(),
                news.getNewsAuthor(),news.getNewsHeat());

        if (r != 0) {//如果更新执行成功
            return true;
        } else {
            return false;  //返回值为0代表插入失败
        }
    }
    //删除新闻
    @Override
    public boolean markDeleteNewsService(String[] newIds){

        int r = newsDao.markDeleteNews(newIds);

        if (r != 0){
            return true;
        } else{
            return false;
        }
    }

    //修改新闻
    @Override
    public boolean updateNewsService(News news){
        int r = newsDao.updateNews(news.getNewsId(), news.getNewsTitle(), news.getNewsContent());

        if (r != 0){
            return true;
        } else{
            return false;
        }
    }





}
