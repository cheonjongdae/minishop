<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


	
	<!--Custom styles-->
	<link rel="stylesheet" href="/minishop/resources/custom/css/userboard.css">
	<div class="col-lg-8">
	<input type="hidden" id="pg" value="${pg}"/>
		 <div class="row" id="titleDiv">
		 	<div class="col" align="center" style="padding-bottom: 20px;">
				<h3>답변대기중인 문의글 현황</h3>
			</div>	
		</div>
		
		<div class="table">
			<table id="qaTable" class="table justify-content-center">
			  <thead class="thead-dark">
			    <tr>
					<th scope="col">#</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">상품번호</th>					
					<th scope="col">작성일</th>
					<th scope="col">구분</th>					
			  </tr>
			   </thead>  
			   <tbody>
			   	<tr>
			   		<th scope="row"></th>
			   		<td colspan="5"></td>			   		
			   	</tr>
			   </tbody> 	  
			</table>
		</div>		

	<div class="container-fluid">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center" id="boardPagingDiv"></ul>
			</nav>
	</div>
 			
	</div>	







<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="/minishop/resources/custom/js/board.qa.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$.ajax({
		type : 'get',
		url : '/minishop/admin/board/getQaList.do',
		data : 'pg='+$('#pg').val(),
		dataType : 'json',
		success : function(data){
			
			$('#qaTable tr:gt(0)').empty();					
			$.each(data.qalist, function(index, items){
				var state = '<i class="fas fa-lock"></i>';
				var subject = '[비밀글로 작성된 문의글입니다]';
				var isreplied ='<i class="far fa-square"></i>';
				var productid ='[비공개]';
				if (items.qa_state=='0'){//공개글
					subject = items.qa_subject;
					state = '<a><i class="fas fa-lock-open"></i></a>';
					if(items.productid!=null){
						productid ='['+items.productid+']';}	
					else if(items.productid==null){productid = '[문의 상품 없음]';}
				}
				if(items.qa_reply=='1'){
					isreplied ='<a><i class="far fa-check-square"></i></a>';
				}
			
				$('<tr/>').append($('<th/>',{
					scope : 'row',
					align : 'center',
					text : items.qa_seq
				})).append($('<td/>',{
					}).append($('<a/>',{
						href : 'javascript:void(0)',
						id : 'subjectA',
						text : subject,
						class : items.qa_seq+''
						}))).append($('<td/>',{
					align : 'center',
					text : items.name,
				})).append($('<td/>',{
					align : 'center',
					text : productid				
				})).append($('<td/>',{
					align : 'center',
					text : items.qa_logtime					
				})).append($('<td/>',{
					align : 'center',
					html : state			
				})).appendTo($('#qaTable tbody'));
			});//each
			
			$('#boardPagingDiv').html(data.boardPaging.pagingHTML);
			
			$('#qaTable').on('click','#subjectA',function(){
				var qa_seq = $(this).parent().prev().text();
				window.location='/minishop/admin/board/qaManageView.do?qa_seq='+qa_seq+'&pg='+$('#pg').val();
			});//제목 클릭시!
		}//success
	});//ajax
});//onready

function boardPaging(pg){
	location.href='/minishop/admin/board/qaManage.do?pg='+pg;
}
</script>
