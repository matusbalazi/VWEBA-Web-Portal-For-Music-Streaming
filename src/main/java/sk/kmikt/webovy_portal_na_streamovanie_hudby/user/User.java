package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import java.util.Date;

public class User {
    private Integer user_id;
    private String name;
    private Date dob;
    private String email;
    private String password;
    private boolean is_admin;

    public User(Integer user_id, String name, Date dob, String email, String password, boolean is_admin) {
        this.user_id = user_id;
        this.name = name;
        this.dob = dob;
        this.email = email;
        this.password = password;
        this.is_admin = is_admin;
    }

    public User(Integer user_id, String name, Date dob, String email, String password) {
        this.user_id = user_id;
        this.name = name;
        this.dob = dob;
        this.email = email;
        this.password = password;
    }

    public User(Integer user_id, String name, Date dob, String email, boolean is_admin) {
        this.user_id = user_id;
        this.name = name;
        this.dob = dob;
        this.email = email;
        this.is_admin = is_admin;
    }

    public User(Integer user_id, String name, Date dob, String email) {
        this.user_id = user_id;
        this.name = name;
        this.dob = dob;
        this.email = email;
    }

    public User(Integer user_id) {
        this.user_id = user_id;
    }

    public User(String name, Date dob, String email, String password) {
        this.name = name;
        this.dob = dob;
        this.email = email;
        this.password = password;
    }

    public User(String name, String email, boolean is_admin) {
        this.name = name;
        this.email = email;
        this.is_admin = is_admin;
    }

    public User(Integer user_id, String password) {
        this.user_id = user_id;
        this.password = password;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isIs_admin() {
        return is_admin;
    }

    public void setIs_admin(boolean is_admin) {
        this.is_admin = is_admin;
    }
}
