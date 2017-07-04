package com.imdyc.hautlake.dao;

import com.imdyc.hautlake.entity.News;
import org.apache.ibatis.annotations.*;

import java.util.ArrayList;

/**
 * Created by gagada on 2017/7/2.
 */
public interface NewsDao {

    /**
     * 查询新闻列表并显示
     * 读取删除时间为null的记录，也就是没有被删除的新闻
     * @return
     */
    @Select("SELECT news_id,news_title ,news_content ,news_author  ,news_heat,news_release " +
            "FROM t_haut_news " +
            "WHERE " +
            "news_delete is null; ")
    ArrayList<News> selectNews();


    /**
     * 新增新闻
     * 不需要插入，id，发布时间，默认自增长和当前数据库服务器系统时间
     * 关闭返回整形值为插入的主键值的功能，
     * 返回值为影响行数，非零则正确插入
     * @return
     */
    @Insert("INSERT INTO `haut`.`t_haut_news` ( " +
            "    `news_title`, `news_content`, `news_author`, `news_heat`) " +
            "    VALUES " +
            "    (#{newstitle}, #{newscontent}, #{newsauthor}, #{newsheat}); ")
    @Options(useGeneratedKeys=false)
    int insertNews(@Param("newstitle") String newsTitle ,
                   @Param("newscontent")String newsContent,
                   @Param("newsauthor")String newsAuthor,
                   @Param("newsheat")long newsHeat);

    /**
     * 根据id值标记新闻删除时间,
     * 返回整形值为SQL影响的行数，返回 1 则正确标记
     * @return
     */
    int markDeleteNews(String[] newsIds);


    /**
     * 根据id值修改新闻,
     * 返回整形值为SQL影响的行数，返回 1 则正确修改
     * @return
     */
    @Update(" UPDATE t_haut_news " +
            " SET news_title = #{newsTitle}, " +
            " news_content = #{newsContent} "+
            " WHERE " +
            " news_id = #{newsId};")
    int updateNews(@Param("newsId") int newsId ,
                   @Param("newsTitle")String newsTitle,
                   @Param("newsContent")String newsContent);
}
