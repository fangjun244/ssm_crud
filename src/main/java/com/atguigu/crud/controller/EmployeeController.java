package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
	 * 员工保存
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "emp",method = RequestMethod.POST)
	public Msg saveEmp(Employee employee){ //页面提交的会自动封装成employee对象
		//调用员工的保存方法
		employeeService.saveEmployee(employee);
		return Msg.success();
	}
	
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



	/**
	 * 返回用户名是否可用的方法
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkEmpName")
	public Msg checkEmpName(@RequestParam("empName") String empName){
		//1，先判断用户名是否合法
		//var regName =/(^[0-9A-Za-z_-]{6,16}$)|(^[\u4E00-\u9FA5]{2,5})/;
		String regx= "(^[0-9A-Za-z_-]{6,16}$)|(^[\\u4E00-\\u9FA5]{2,5})";
		boolean matches = empName.matches(regx);
		if (!matches){
			return Msg.fail().add("va_msg","英文用户名必须是6-16位大小写都可以，中文2-5位汉字！！！");
		}

		//数据库校验
		boolean boolean1 = employeeService.checkEmpName(empName);
		//true是没有，false是已存在

		if (boolean1){
			return  Msg.success().add("boolean",boolean1);
		}
		return  Msg.fail().add("boolean",boolean1).add("va_msg","用户名不可用");
	}

}
