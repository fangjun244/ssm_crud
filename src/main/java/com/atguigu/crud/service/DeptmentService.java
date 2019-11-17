package com.atguigu.crud.service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 处理和部门有关的请求
 */

@Service
public class DeptmentService {

    @Autowired
    private DepartmentMapper departmentMapper;




    public List<Department> getDepts() {

        List<Department> departments = departmentMapper.selectByExample(null);

        return departments;

    }
}
