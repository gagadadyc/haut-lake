package com.imdyc.hautlake.dao;

import com.imdyc.hautlake.entity.Menu;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.ArrayList;

/**
 * Created by gagada on 2017/6/30.
 */
public interface MenuDao {

    /**
     * 查询目录列表并显示
     * @return
     */
    ArrayList selectMenu();

    /**
     * @param menuName
     * @return
     */
    @Select(" SELECT id,menu_name ,menu_no ,menu_desc ,action ,parent_no " +
            " FROM t_haut_menu "+
            " WHERE menu_name = #{menuname} ;")
    ArrayList<Menu> queryMenu(@Param("menuname") String menuName);


    /**
     * 根据id值修改菜单,
     * 返回整形值为SQL影响的行数，返回 1 则正确修改
     * @return
     */
    @Update(" UPDATE t_haut_menu " +
            " SET menu_no = #{menuno}, " +
            " menu_name = #{menuname}, " +
            " menu_desc = #{menudesc}, " +
            " parent_no = #{parentno}, " +
            " action = #{action} " +
            " WHERE " +
            " id = #{id};")
    int updateMenu(@Param("id") int id ,
                   @Param("menuno")int menuNo,
                   @Param("menuname")String menuName,
                   @Param("menudesc")String menuDesc,
                   @Param("parentno")int parentNo,
                   @Param("action")String action);



}
