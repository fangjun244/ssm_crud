package com.atguigu.crud.service;

import java.util.List;

import com.atguigu.crud.bean.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.EmployeeMapper;


@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub

		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 保存员工数据
	 */
	public void saveEmployee(Employee employee) {

		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * @param empName
	 * @return
	 */
	public boolean checkEmpName(String empName) {


		long count = employeeMapper.countByEmpName(empName);
		return count == 0;//true是没有，false是已存在

		//return false;

	}
}
