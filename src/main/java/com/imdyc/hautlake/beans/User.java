package com.imdyc.hautlake.beans;

/**
 * Created by gagada on 2017/6/24.
 */
public class User {

    private int id;
    private String userName;
    private String password;
    private String gender;
    private boolean age;
    private String phone;
    private String Email;
    private int c_t;
    private int u_t;
    private boolean id_deleted;//用户是否被注销

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public boolean isAge() {
        return age;
    }

    public void setAge(boolean age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public int getC_t() {
        return c_t;
    }

    public void setC_t(int c_t) {
        this.c_t = c_t;
    }

    public int getU_t() {
        return u_t;
    }

    public void setU_t(int u_t) {
        this.u_t = u_t;
    }

    public boolean isId_deleted() {
        return id_deleted;
    }

    public void setId_deleted(boolean id_deleted) {
        this.id_deleted = id_deleted;
    }
}
