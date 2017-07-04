package com.imdyc.hautlake.entity;

/**
 * Created by gagada on 2017/7/2.
 * 新闻实体类
 */
public class News {

    private int newsId;  //编号
    private String newsTitle;   //新闻标题
    private String newsContent;  //内容
    private String newsAuthor;  //新闻发布者
    private long newsHeat;   //文章热度
    private String newsRelease;  //发布时间
    private String newsDelete;  //删除时间


    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }

    public String getNewsAuthor() {
        return newsAuthor;
    }

    public void setNewsAuthor(String newsAuthor) {
        this.newsAuthor = newsAuthor;
    }

    public long getNewsHeat() {
        return newsHeat;
    }

    public void setNewsHeat(long newsHeat) {
        this.newsHeat = newsHeat;
    }

    public String getNewsRelease() {
        return newsRelease;
    }

    public void setNewsRelease(String newsRelease) {
        this.newsRelease = newsRelease;
    }

    public String getNewsDelete() {
        return newsDelete;
    }

    public void setNewsDelete(String newsDelete) {
        this.newsDelete = newsDelete;
    }

    @Override
    public String toString() {
        return "News{" +
                "newsId=" + newsId +
                ", newsTitle='" + newsTitle + '\'' +
                ", newsContent='" + newsContent + '\'' +
                ", newsAuthor='" + newsAuthor + '\'' +
                ", newsHeat=" + newsHeat +
                ", newsRelease='" + newsRelease + '\'' +
                ", newsDelete='" + newsDelete + '\'' +
                '}';
    }
}
