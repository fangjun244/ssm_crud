<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!-- 引入JQuery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
<!-- 引入bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!--  搭建页面-->

<div class="container">
	<!--标题行  -->
	<div class="row">
		<div class="col-md-12">
				<h1>SSM</h1>
		</div>
	</div>
		
	<!-- 按钮 -->
	<div class="row">
		<div class="col-md-4 col-md-offset-8">
			<button type="button" class="btn btn-info">新增</button>
			<button type="button" class="btn btn-danger">删除</button>
		</div>	
	</div>
	
	
	
	<!-- 显示表格数据  -->
	<div class="row">
		<div class="col-md-12">
		
			<table class="table table-hover table-bordered" id="emps_table">
			<!-- 表头 -->
				<thead>
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
				

					
				</table>
		</div>
	</div>
	
	
	
	<!-- 显示分页信息 -->
	<div class="row">
		<!--分页信息  -->
		<div class="clo-md-6" id="page_info_area">
			
		</div>
		<!-- 分页条信息 -->
		<div class="col-md-6 col-md-offset-6" id="page_nav_area">
				
		</div>
	
	</div>
</div>


<script type="text/javascript">

		//1.页面加载完成之后，直接发送一个ajax请求，要到分页数据
		$(function(){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=2",
				type:"get",
				success:function(result){
					//console.log(result)
					//1.解析并显示员工数据
					build_emps_tables(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析分页条信息
					build_page_nav(result);
					
				}
			});
		});
		
		/* 员工表格 */
		function build_emps_tables(result){
			var emps = result.extend.pageinfo.list;
			/* 遍历 */
			$.each(emps,function(index,item){
				//alert(item.empName);
				/*员工ID单元格 */
				var empIdTd =  $("<td></td>").append(item.empId);
				/* 员工姓名 */
				var empNameTd = $("<td></td>").append(item.empName);
				/* 员工性别 */
				var empGenderTd = $("<td></td>").append(item.gender =='M'?"男":"女");
				/* 员工邮箱 */
				var empEmailTd = $("<td></td>").append(item.email);
				/* 员工部门信息 */
				var empDeptNameTd = $("<td></td>").append(item.department.deptName);
				
				/* <button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button> */
				
				var tb_edit = $("<button></button>").addClass("btn btn-info btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
								.append("编辑");
				var tb_delete = $("<button></button>").addClass("btn btn-danger btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
								.append("删除");
				/* 编辑删除按钮 */
				var operation = $("<td></td>").append(tb_edit).append(" ").append(tb_delete);
				/* 创建一个tr元素 */
				/* append方法执行完还是返回原来的元素 */
				$("<tr></tr>").append(empIdTd).append(empNameTd)
								.append(empGenderTd).append(empEmailTd)
								.append(empDeptNameTd)
								.append(operation)
								.appendTo("#emps_table tbody");
			});
			
		}
		
		/* 分页信息 */
		function build_page_info(result){
			$("#page_info_area").append("当前第"+result.extend.pageinfo.pageNum+"页，总共"+result.extend.pageinfo.pages+"页，一共"+
					result.extend.pageinfo.total+"条记录")
		}
		
		/* 分页导航信息 */
		function build_page_nav(result){
			var navigatepageNums = result.extend.pageinfo.navigatepageNums;
			
			var ul = $("<ul></ul>").addClass("pagination")
			/* 首页*/
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			/* 前一页 */
			var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));

			/* 后一页 */
			var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
			/* 末页 */
			var lsstPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			
			ul.append(firstPageLi).append(prePage);
			
			/* 遍历连续需要展示的页码数 */
			$.each(navigatepageNums,function(index,item){
						var num_li = $("<li></li>").append($("<a></a>").append(index+1));
						ul.append(num_li);
					})
			ul.append(nextPage).append(lsstPageLi).appendTo("#page_nav_area");
			
		}

</script>




</body>
</html>