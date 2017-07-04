package com.imdyc.hautlake.entity;

/**
 * Created by gagada on 2017/6/30.
 */
public class Menu {
    private int id;
    private int menuNo;
    private String menuName;
    private String menuDesc;
    private String action;
    private int parentNo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMenuNo() {
        return menuNo;
    }

    public void setMenuNo(int menuNo) {
        this.menuNo = menuNo;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getMenuDesc() {
        return menuDesc;
    }

    public void setMenuDesc(String menuDesc) {
        this.menuDesc = menuDesc;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public int getParentNo() {
        return parentNo;
    }

    public void setParentNo(int parentNo) {
        this.parentNo = parentNo;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", menuNo=" + menuNo +
                ", menuName='" + menuName + '\'' +
                ", menuDesc='" + menuDesc + '\'' +
                ", action='" + action + '\'' +
                ", parentNo=" + parentNo +
                '}';
    }
}
