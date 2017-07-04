package com.imdyc.hautlake.service.impl;

import com.imdyc.hautlake.dao.MenuDao;
import com.imdyc.hautlake.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * Created by gagada on 2017/6/30.
 */
@Service
public class MenuServiceImpl implements com.imdyc.hautlake.service.MenuService {

    @Autowired
    private MenuDao menuDao;

    @Override
    public ArrayList getMenuVerService(){

        ArrayList list = menuDao.selectMenu( );
        return list;
    }

    @Override
    public  ArrayList<Menu> queryMenuVerService(String menuName) {

        ArrayList list = menuDao.queryMenu(menuName);

        return list;
    }

    @Override
    public boolean updateMenuService(Menu menu) {

        int Record = menuDao.updateMenu(menu.getId(), menu.getMenuNo(), menu.getMenuName(),
                menu.getMenuDesc(), menu.getParentNo(), menu.getAction());

        if (Record == 1) {//如果更新执行成功
            return true;
        } else {
            return false;  //返回值非1代表插入失败
        }
    }


}
