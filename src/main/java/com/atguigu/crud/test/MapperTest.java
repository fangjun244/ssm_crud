package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.DepartmentExample;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * 测试dao层功能
 * @author fangjun
 *推荐spring项目可以使用Spring的单元测试，可以自动注入我们需要的注解
 *1.导入SpringTest模块
 *2.@@ContextConfiguration指定Spring配置文件的位置
 *3.直接autowired 要使用的组件即可
 */


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest 
{
	/**
	 * 测试DepartmentMapper
	 */

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		//1.创建SpringIOC容器
		//ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		//DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		
		System.out.println(departmentMapper);
		//System.out.println(bean);
		
		//1.插入几个部门
		
		//Department department = new Department(null,"开发部");
		//Department department1 = new Department(null,"测试部");
		//departmentMapper.insertSelective(new Department(null,"开发部"));
		//departmentMapper.insertSelective(new Department(null,"测试部"));
		
		//2.修改部门信息
		//department.setDeptName("开发二部");
		//department.setDeptId(1);
		//DepartmentExample departmentExample = new DepartmentExample();
		//departmentMapper.updateByPrimaryKey(department);
		
		
		//3.生成员工数据，测试员工插入
		//Employee employee = new Employee(null,"杨哲","m","244026447@qq.com",1);
		//employeeMapper.insertSelective(employee);
		
		//批量插入与员工数据
		EmployeeMapper emapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			//使用UUID前五位
			String uid = UUID.randomUUID().toString().substring(0,5);
			emapper.insertSelective(new Employee(null,uid,"m",uid+"@ceair.com",2));
		}
		
		
	}

}
