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
		
			<table class="table table-hover table-bordered">
				<tr>
					<th>#</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>

					<c:forEach items="${pageinfo.list}" var="emp">
						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName }</th>
							<th>${emp.gender =="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>

					</c:forEach>

				</table>
		</div>
	</div>
	
	
	
	<!-- 显示分页信息 -->
	<div class="row">
		<!--分页信息  -->
		<div class="clo-md-6">
			当前第${pageinfo.pageNum }页，总共${pageinfo.pages }页，一共${pageinfo.total }条记录
		</div>
		<!-- 分页条信息 -->
		<div class="col-md-6 col-md-offset-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
					
						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						
						<c:if test="${pageinfo.hasPreviousPage == true }">
							<li><a href="${APP_PATH }/emps?pn=${pageinfo.pageNum-1}" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						</c:if>
						
						<c:forEach items="${pageinfo.navigatepageNums }" var="page_Num">
							<c:if test="${page_Num == pageinfo.pageNum}">
								<li class="active"><a href="#">${page_Num}</a></li>
							</c:if>
							
							<c:if test="${page_Num != pageinfo.pageNum }">
								<li class="disabled"><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
							</c:if>
							 
						</c:forEach>
						<c:if test="${pageinfo.hasNextPage == true}">
							<li><a href="${APP_PATH }/emps?pn=${pageinfo.pageNum+1}" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						
						
						<li><a href="${APP_PATH }/emps?pn=${pageinfo.pages}">尾页</a></li>
					</ul>
				</nav>
		</div>
	
	</div>
</div>





</body>
</html>