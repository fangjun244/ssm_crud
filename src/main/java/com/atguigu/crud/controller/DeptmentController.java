package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DeptmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 */

@Controller
public class DeptmentController {

    @Autowired //自动装配
    private DeptmentService deptmentService;

    /**
     * 返回所有的部门信息
     *
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){

        //查出的所有部门信息
        List<Department> list = deptmentService.getDepts();

        return Msg.success().add("depts",list);

    }

}

