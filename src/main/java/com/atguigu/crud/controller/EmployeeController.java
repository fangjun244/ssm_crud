package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工CRUD请求
 * @author fangjun
 *
 */
@Controller
public class EmployeeController 
{
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * @ResponseBody注解能将对象已json格式返回
	 * @ResponseBody要能正常工作要导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		
		//这不是一个分页查询
				//引入PageHelper分页插件
				//在查询之前调用,传入页码，以及每页大小
				PageHelper.startPage(pn, 5);
				//startPage后紧跟的这个查询就是分页查询
				List<Employee> emps = employeeService.getAll();
				//使用pageinfo包装查询后的结果，只需将pageinfo交给页面
				//pageinfo封装了详细的分页信息，包括我们查询出来的数据
				PageInfo page = new PageInfo(emps,5);//可以传入连续显示的页数
				
				return Msg.success().add("pageinfo", page);
	}
	
	
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		//这不是一个分页查询
		//引入PageHelper分页插件
		//在查询之前调用,传入页码，以及每页大小
		PageHelper.startPage(pn, 5);
		//startPage后紧跟的这个查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询后的结果，只需将pageinfo交给页面
		//pageinfo封装了详细的分页信息，包括我们查询出来的数据
		PageInfo pageInfo = new PageInfo(emps,5);//可以传入连续显示的页数
		model.addAttribute("pageinfo",pageInfo);
		return "list";
	}

}
