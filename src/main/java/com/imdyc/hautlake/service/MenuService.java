package com.imdyc.hautlake.service;

import com.imdyc.hautlake.entity.Menu;

import java.util.ArrayList;

/**
 * Created by gagada on 2017/6/30.
 */
public interface MenuService {

    ArrayList getMenuVerService();//取得所有菜单记录

    ArrayList<Menu> queryMenuVerService(String menuName);//查询指定菜单

    boolean updateMenuService(Menu menu);//修改菜单并返回记录



}
