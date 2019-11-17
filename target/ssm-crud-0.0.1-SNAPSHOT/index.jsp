<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工管理</title>

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


<%--员工新增模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">员工新增</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal">
<%--					//姓名输入框--%>
					<div class="form-group">
						<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
							<span class="help-block"></span>
						</div>
					</div>

<%--					//email输入框--%>
					<div class="form-group">
						<label for="empName_add_email" class="col-sm-2 control-label">empEmail</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control" id="empName_add_email" placeholder="empEmail">
							<span class="help-block"></span>
						</div>
					</div>

<%--					//性别选择框--%>
					<div class="form-group">
						<label for="gender_check" class="col-sm-2 control-label">empGender</label>
						<div class="col-sm-10">
							<select class="form-control" id="gender_check" name="gender">
								<option name="gender" value="sl">请选择</option>
								<option name="gender" value="M">男</option>
								<option name="gender" value="F">女</option>
							</select>
						</div>
					</div>

<%--					部门名--%>
					<div class="form-group">
						<label for="dId"  class="col-sm-2 control-label">deptName</label>
						<div class="col-sm-10">
					<%--	部门提交部门id即可--%>
							<select class="form-control" id="dId" name="dId">
							</select>
						</div>
					</div>


				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="close_add_btn">取消</button>
				<button type="button" class="btn btn-primary" id="emps_save_btn">保存</button>
			</div>
		</div>
	</div>
</div>




<!--  搭建页面-->

<div class="container">
	<!--标题行  -->
	<div class="row">
		<div class="col-md-12">
				<h2>SpringMVC-Spring-Mybatis</h2>
		</div>
	</div>
		
	<!-- 按钮 -->
	<div class="row">
		<div class="col-md-4 col-md-offset-8">
			<button type="button" class="btn btn-info btn-sm" id="emp_add_modal_btn">新增</button>
			<button type="button" class="btn btn-danger btn-sm">删除</button>
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
			//页面加载完先去首页
			to_page(1);

		});
		
		//抽取to_page跳转页面方法
		function to_page(pn) {

			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
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
			
		}
		
		
		
		
		/* 员工表格 */
		function build_emps_tables(result){
			//清空页面
			$("#emps_table tbody").empty();
			var emps = result.extend.pageinfo.list;
			/* 遍历 */
			$.each(emps,function(){
				//alert(item.empName);
				/*员工ID单元格 */
				var empIdTd =  $("<td></td>").append(this.empId);
				/* 员工姓名 */
				var empNameTd = $("<td></td>").append(this.empName);
				/* 员工性别 */
				var empGenderTd = $("<td></td>").append(this.gender =='M'?"男":"女");
				/* 员工邮箱 */
				var empEmailTd = $("<td></td>").append(this.email);
				/* 员工部门信息 */
				var empDeptNameTd = $("<td></td>").append(this.department.deptName);
				
				/* <button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button> */
				
				var tb_edit = $("<button></button>").addClass("btn btn-info btn-sm")
								.attr("id","edit_table_btn")
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
			//清空元素
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageinfo.pageNum+"页，总共"+result.extend.pageinfo.pages+"页，一共"+
					result.extend.pageinfo.total+"条记录")
		}
		
		/* 分页导航信息
		* 解析显示分页条，点击分页能去下一页 */
		function build_page_nav(result){

			$("#page_nav_area").empty();
			var navigatepageNums = result.extend.pageinfo.navigatepageNums; //12345
			
			var ul = $("<ul></ul>").addClass("pagination")

			//创建首页分页，并绑定点击事件
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			firstPageLi.click(function () {

				to_page(1);

			});


			/* 前一页 */
			var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
			prePage.click(function () {
				to_page((result.extend.pageinfo.pageNum-1));
			});

			//增加判断，hasPreviousPage为true的时候可以点击前一页面或首页
			if (result.extend.pageinfo.hasPreviousPage == !true){
				firstPageLi.addClass("disabled");
				prePage.addClass("disabled");
			}

			//后一页按钮，并绑定事件
			var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
			nextPage.click(function () {
				to_page((result.extend.pageinfo.pageNum+1));
			});
			//尾页分页按钮，并添加事件
			var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			lastPageLi.click(function () {
				to_page(result.extend.pageinfo.pages);
			});

			//增加判断，hasNextPage为true的时候就可以点击尾页和下一页
			if (result.extend.pageinfo.hasNextPage == !true){
				nextPage.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			
			ul.append(firstPageLi).append(prePage);
			
			/* 遍历连续需要展示的页码数 */
			$.each(navigatepageNums,function(index,item){
						if (item == result.extend.pageinfo.pageNum){
							var num_li = $("<li></li>").addClass("active").append($("<a></a>").append(item));
							ul.append(num_li);

						}else{
							var num_li = $("<li></li>").append($("<a></a>").append(navigatepageNums[index]));
							ul.append(num_li);
							num_li.click(function () {
								to_page(item);
							});
						}

					})
			ul.append(nextPage).append(lastPageLi).appendTo("#page_nav_area");
			
		}



		//点击新增按钮，弹出新增页面
		//弹出模态框之前应该发送一个ajax请求，查询部门信息
		$("#emp_add_modal_btn").click(function () {

			//清楚表单数据
			$("#empAddModal form")[0].reset();
				//$("#dId").empty();
				getDepts();

				$("#empAddModal").modal({
					backdrop:"static"
				});
		});


		//抽取一个获取部门信息的方法
		function getDepts() {

			//发送一个ajax请求
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function (result) {
					var depts = result.extend.depts;

					$.each(depts,function (index,item) {
						var deptname = item.deptName;
						$("<option></option>").append(deptname)
								.attr("value",item.deptId).attr("name","deptname")
								.appendTo("#dId");
					});
				}
			})
		}


		//校验表单数据
		function validate_add_form(){
			//1.拿到要校验的数据
			var empsName = $("#empName_add_input").val();
			//正则
			var regName =/(^[0-9A-Za-z_-]{6,16}$)|(^[\u4E00-\u9FA5]{2,5})/;

			//alert(regName.test(empsName));
			if (!regName.test(empsName)){
				//alert("英文用户名必须是6-16位大小写都可以，中文2-5位汉字！");
				show_validate_msg("#empName_add_input","error","英文用户名必须是6-16位大小写都可以，中文2-5位汉字！");
				// $("#empName_add_input").parent().addClass("has-error");
				// $("#empName_add_input").next("span").text("英文用户名必须是6-16位大小写都可以，中文2-5位汉字！");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
				// $("#empName_add_input").parent().addClass("has-success");
				// $("#empName_add_input").next("span").text("");
			}
			//校验邮箱信息
			var empEmail = $("#empName_add_email").val();
			var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/
			if (!regEmail.test(empEmail)){
				//alert("邮箱数据格式不正确，请检查后输入！");
				show_validate_msg("#empName_add_email","error","英文用户名必须是6-16位大小写都可以，中文2-5位汉字！");
				// $("#empName_add_email").parent().addClass("has-error");
				// $("#empName_add_email").next("span").text("英文用户名必须是6-16位大小写都可以，中文2-5位汉字！");
				return false;
			}else{
				show_validate_msg("#empName_add_email","success","");
				// $("#empName_add_email").parent().addClass("has-success");
				// $("#empName_add_email").next("span").text("");
			}

			//校验性别
			var genderSele = $("#gender_check").val();
			if (genderSele == "sl") {
				alert("性别为必输项，请您选择");
				return false;
			}

			return true;

		}

		//表格校验方法
		function show_validate_msg(ele,status,msg){
			//每一次校验之前都要清楚之前的属性
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if(status == "success"){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if (status == "error") {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}

		}

		//员工用户名重名校验
		$("#empName_add_input").change(function () {
			//发送ajax请求校验用户名是否可用
			var empName = $("#empName_add_input").val();
			$.ajax({
				url:"${APP_PATH}/checkEmpName",
				type:"get",
				data:"empName="+empName,
				success:function (result) {
					//result.extend.boolean
					//true是没有，false是已存在
					if (!result.extend.boolean){
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);

						$("#emps_save_btn").removeClass(" ajax_id").attr("ajax_id","success");
					}
					if (result.extend.boolean) {
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emps_save_btn").removeClass("has-success has-error ajax_id").attr("ajax_id","false");
					}
				}
			})

		});

		//保存按钮
		$("#emps_save_btn").click(function () {

			//先校验输入框内容是否合法
			if (validate_add_form()){

				//在校验是否重复
				if ($("#emps_save_btn").attr("ajax_id") == "false"){
					//1.保存先发送请求到服务器
					save_emps();
					//保存后刷新数据在关闭模态框
					setTimeout(function () {
						window.location.reload()
					},2000);
					//2.关闭新增框
					close_modal();
				}else {
					return false;
				}

			} else {
				return false;
			}


		});

		function save_emps() {

			//alert($("#empAddModal form").serialize())

			//模态框中填写表单信息保存到服务器
			//发送ajax请求
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function (result) {

					alert(result.msg);

				}
			});

		}

		function close_modal(){
			$("#close_add_btn").click();
		}
		


</script>


</body>
</html>