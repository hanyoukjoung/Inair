<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.table { margin-left: 20px; display: none;}
	.jobOffer { display: none;}
	th { width: 155px; }
	td { width: 500px; }
	select { width: 350px; height: 34px; }
	.keyword { width: 700px; height: 34px; border: none;}
	.proButton {
		border: none;
		margin-top: 2px;
		margin-bottom: 2px;
		background-color: #f8f9fa;
		width: 125px;
		text-align: left;
	}
	.addButton {
		border: none;
		margin-top: 2px;
		margin-bottom: 2px;
		background-color: #f8f9fa;
		width: 125px;
		text-align: left;
	}
	.lowProButton {
		font-size: 13px; 
		height: 30px; 
		width: 180px; 
		background-color: #f8f9fa; 
		border-radius:5px; 
		margin: 5px;
	}
	.gugunButton{
		font-size: 13px; 
		height: 30px; 
		width: 85px; 
		background-color: #f8f9fa; 
		border-radius:5px; 
		margin: 5px;
	}
	.searchButton{
		width: 200px; 
		height: 55px; 
		background-color: #35829c; 
		color: white;
		font-weight: bold;
	}
	.infoDiv {
		border: 2px solid #f0f0f0;
		width: 1138px;
		margin-bottom: 40px;
	}
	.table {
		width: 1110px;
	}
	.tagH {
		margin: 30px 0px 30px 20px;
	}
</style>
<script type="text/javascript">

var contextPath = "${pageContext.request.contextPath}";

$(function() {
	$('#proTable').hide();
	$('#addTable').hide();
	
	$('.proButtonInput').click(function() {
		$('#proTable').show();
		$('.proButtonInput').css("background", "#35829c");
		$('.proButtonInput').css("color", "white");
		$('.proButtonInput').css("border", "none");
	});
	
	$('.proButtonInput').dblclick(function() {
		$('#proTable').slideUp();
		$('.proButtonInput').css("background", "white");
		$('.proButtonInput').css("color", "black");
	});
	
	$('.addButtonInput').click(function() {
		$('#addTable').show();
		$('.addButtonInput').css("background", "#35829c");
		$('.addButtonInput').css("color", "white");
		$('.addButtonInput').css("border", "none");
	});
		
	$('.addButtonInput').dblclick(function() {
		$('#addTable').slideUp();
		$('.addButtonInput').css("background", "white");
		$('.addButtonInput').css("color", "black");
	});
	
	$('#hompage').click(function() {
		var bizr_no1 = '${companyList[0].bizr_no}'.substring(0,3);
		var bizr_no2 = '${companyList[0].bizr_no}'.substring(4,6);
		var bizr_no3 = '${companyList[0].bizr_no}'.substring(7,12);
		var csn = bizr_no1 + bizr_no2 + bizr_no3;
		
		var newWindow = window.open("about:blank");
		
		newWindow.location.href = 'http://www.saramin.co.kr/zf_user/company-info/view?csn=' + csn;
	});
	
	$('#acdmcr').val($('#academicRadio option:selected').val());
	
	$('.table').slice(0,4).show();
	$('.jobOffer').slice(0,4).show();
	
	$('#load').click(function(e) {
		e.preventDefault();
		$('.table:hidden').slice(0,5).show();
		
		if ($('.table:hidden').length < 5) {
			$('#loadDiv').hide();
		}
	});

	$('#JOload').click(function(e) {
		e.preventDefault();
		$('.jobOffer:hidden').slice(0,5).show();
		
		if ($('.jobOffer:hidden').length < 5) {
			$('#JOloadDiv').hide();
		}
	});
	
});

function selectLowPROFunction(thisId) {
	$('#nextId').empty();
	
	getLowProfession($('#' + thisId).val(), '#nextId');
}

function clickedLowProfession(thisLowId) {
	$('#professionInput').val($('button[id="'+ thisLowId + '"]').val());
	$('#proTable').slideUp();
}

function getLowProfession(value, appendId) {
	$.ajax({
		url : contextPath + '/individualMember/lowPROList.do'
		, dataType : 'json'
		, data : { uppro_num : value }
		, error : function(result) {
					alert(result.status);
				}
		, success : function(result) {
					$.each(result, function(index, item) {
						var changeOption = $('<button type="button" name="corp_lowPro" class="lowProButton" id="lowPro' + item.lowpro_num
											+ '"value="'+ item.lowpro_num 	
											+ '"onclick="clickedLowProfession(this.id)">'
											+ item.lowpro_name +'</button>');
						
						
						$(appendId).append(changeOption);
					});
				}
	});
}

function selectSearchAddr(thisId) {
	var gugun = getGugun($('#'+thisId).val());
	
	$('#nextAddId').empty();
	
	for(var i = 1; i < gugun.length; i++){
		var changeOption = '<button type="button" class="gugunButton" value="' + gugun[i] 
							+ '"id="gugun' + i 
							+ '"onclick="clickedGugun(this.id)" >' + gugun[i] + '</button>';
							
		$('#nextAddId').append(changeOption);
	}
}

function clickedGugun(thisId) {
	$('#addressInput').val($('button[id="' + thisId + '"]').text());
	$('#addTable').slideUp();
}

</script>
</head>
<body>
<section class="ftco-section bg-light">
	<div class="container">
		<div class="row">
			<h2>채용정보 상세검색</h2>
			<br>
			<form name="searchForm" action="/companySearch/companySearchHome.do" method="post">
			<table class="table">
			    <tbody style="margin-left: 10px;">
			    	<tr>
			    		<th>검색어</th>
			    		<td colspan="3">
			    			<div>
			    				<input type="text" name="corp_name"/>
			    			</div>
			    		</td>
			    	</tr>
			    	<tr>
			    		<th>직종</th>
			    		<td colspan="3">
			    			<div>
			    				<span><input type="button" class="proButtonInput" style="border: none;" value="직종 선택"></span> 
			    				<span style="margin-left: 300px;"><input type="hidden" id="professionInput" name="corp_lowPro" style="width: 400px; border: none; background-color: white;" readonly="readonly"></span>
			    			</div>
			    			<div id="proTable" style="border-top: 2px solid #35829c;">
			    				<table>
			    					<tr>
										<td style="width: 135px;">
											<c:forEach items="${upProList}" var="proInfo" varStatus="stat" >
												<c:if test="${stat.index <= 6 }">
													<div>
														<button type="button" id="proButton${proInfo.uppro_num}" class="proButton" value="${proInfo.uppro_num}" onclick="selectLowPROFunction(this.id)">${proInfo.uppro_name }</button>
													</div>
												</c:if>
											</c:forEach>
										</td>
										<td style="width: 135px;">
											<c:forEach items="${upProList}" var="proInfo" varStatus="stat">
												<c:if test="${stat.index >= 7 && stat.index <= 13}"> 
													<div>
														<button type="button" id="proButton${proInfo.uppro_num}" class="proButton" value="${proInfo.uppro_num}" onclick="selectLowPROFunction(this.id)">${proInfo.uppro_name }</button>
													</div>
												</c:if>
											</c:forEach>
											<div>&nbsp;</div>
										</td>
										<td id="nextId" style="width: 600px; border-left: 1.5px solid #e4e5e5; padding: 13px 10px 0px 10px;"></td>
									</tr>
			    				</table>
			    			</div>
			    		</td>
			    	</tr>
			    	<tr>
			    		<th>지역</th>
			    		<td colspan="3">
			    			<div>
			    				<span><input type="button" class="addButtonInput" value="지역 선택" style="border: none;"></span>
			    				<span style="margin-left: 300px;"><input type="text" id="addressInput" name="corp_add" style="width: 400px; border: none; background-color: white;" readonly="readonly"></span>
			    			</div>
			    			<div id="addTable" style="border-top: 2px solid #35829c;">
								<table>
									<tr>
										<td style="width: 135px;">
											<div class="addressDiv">
												<button type="button" class="addButton" id="addButton1" value="서울" onclick="selectSearchAddr(this.id)">서울특별시</button>
											    <button type="button" class="addButton" id="addButton2" value="부산" onclick="selectSearchAddr(this.id)">부산광역시</button>
											    <button type="button" class="addButton" id="addButton3" value="대구" onclick="selectSearchAddr(this.id)">대구광역시</button>
											    <button type="button" class="addButton" id="addButton4" value="인천" onclick="selectSearchAddr(this.id)">인천광역시</button>
											    <button type="button" class="addButton" id="addButton5" value="광주" onclick="selectSearchAddr(this.id)">광주광역시</button>
											    <button type="button" class="addButton" id="addButton6" value="대전" onclick="selectSearchAddr(this.id)">대전광역시</button>
											    <button type="button" class="addButton" id="addButton7" value="울산" onclick="selectSearchAddr(this.id)">울산광역시</button>
											    <button type="button" class="addButton" id="addButton8" value="경기" onclick="selectSearchAddr(this.id)">경기도</button> 
											</div>
										</td>
										<td style="width: 135px;">
											<div class="addressDiv">
											    <button type="button" class="addButton" id="addButton9" value="강원" onclick="selectSearchAddr(this.id)">강원도</button> 
											    <button type="button" class="addButton" id="addButton10" value="충북" onclick="selectSearchAddr(this.id)">충청북도</button>
											    <button type="button" class="addButton" id="addButton11" value="충남" onclick="selectSearchAddr(this.id)">충청남도</button>
											    <button type="button" class="addButton" id="addButton12" value="전북" onclick="selectSearchAddr(this.id)">전라북도</button>
											    <button type="button" class="addButton" id="addButton13" value="전남" onclick="selectSearchAddr(this.id)">전라남도</button>
											    <button type="button" class="addButton" id="addButton14" value="경북" onclick="selectSearchAddr(this.id)">경상북도</button>
											    <button type="button" class="addButton" id="addButton15" value="경남" onclick="selectSearchAddr(this.id)">경상남도</button>
	    										<button type="button" class="addButton" id="addButton16" value="제주" onclick="selectSearchAddr(this.id)">제주도</button>
											</div>
										</td>
										<td id="nextAddId" style="width: 600px; border-left: 1.5px solid #e4e5e5; padding: 0px 10px;"></td>
									</tr>
								</table>
							</div>
			    		</td>
			    		
			    	</tr>
			    	<tr>
			    		<th>경력</th>
			    		<td>
			    			<span style="margin-right: 20px;"><input type="radio" name="careerRadio" value="신입"> 신입</span>
			    			<span style="margin-right: 20px;"><input type="radio" name="careerRadio" value="경력"> 경력</span>
			    			<span style="margin-right: 20px;"><input type="radio" name="careerRadio" value="경력무관"> 경력무관</span>
			    		</td>
			    		<th>학력</th>
			    		<td>
			    			<select name="corp_acdmcr" id="academicRadio">
	    						<option value="">선택</option>
			    				<c:forEach items="${finalAcademicList }" var="finalAcademic">
			    					<option value="${finalAcademic.fin_acdmcr }">${finalAcademic.fin_acdmcr }</option>
			    				</c:forEach>
			    			</select>
			    		</td>
			    	</tr>
			    	<tr>
			    		<th>고용형태</th>
			    		<td>
			    			<select name="corp_employment">
			    				<option value="">선택</option>
			    				<c:forEach items="${employmentList }" var="employ">
			    					<option value="${employ.emplym}">${employ.emplym }</option>			    					
			    				</c:forEach>
			    			</select>
			    		</td>
			    		<th>희망임금</th>
			    		<td>
			    			<select name="corp_salary">
			    				<option value="">선택</option>
			    				<c:forEach items="${salaryList}" var="salary">
			    					<option value="${salary.salary_scope }">${salary.salary_scope }</option>
			    				</c:forEach>
			    			</select>
			    		</td>
			    	</tr>
			  	</tbody>
		  	</table>
		  	<div>&nbsp;</div>
		  	<div style="text-align: center;">
		  		<button type="submit" class="searchButton">검색하기</button>
		  	</div>
		  	<div>&nbsp;</div>
		  	</form>
		  	
		  	<div id="infoDiv" class="infoDiv">
			  	<c:if test="${!empty companyList }">
			  		<h2 class="tagH">기업정보</h2>
				  	<c:forEach items="${companyList }" var="company">
				  		<table class="table">
				  			<tbody id="infoTbody">
				  				<tr>
				  					<td colspan="4"><h4 id="hompage" style="cursor: pointer;">${company.corp_name }</h4></td>
				  				</tr>
				  				<tr>
				  					<th>설립일</th>
				  					<td>${company.est_dt.split(" ")[0] }</td>
				  					<th>대표자명</th>
				  					<td>${company.ceo_nm }</td>
				  				</tr>		  				
				  				<tr>
				  					<th>기업주소</th>
				  					<td>${company.adres }</td>
				  					<th>전화번호</th>
				  					<td>${company.phn_no }</td>
				  				</tr>
				  				<tr><td colspan="4"></td></tr>
				  			</tbody>
				  		</table>
				  	</c:forEach>
			  	</c:if>
			  	
			  	<div id="loadDiv" align="center">
			  		<hr>
			  		<a id="load" href="#">더보기(more)</a>
			  		<hr>
			  	</div>
			  	
			</div>
		  	
		  	<div id="infoDiv" class="infoDiv">
			  	<c:if test="${!empty jobOfferList }">
			  	<h2 class="tagH">구인정보</h2>
				  	<c:forEach items="${jobOfferList}" var="jobOfferInfo">
						<div class="jobOffer col-md-12 ftco-animate">
				            <div class="job-post-item p-4 d-block d-lg-flex align-items-center">
				              <div class="one-third mb-4 mb-md-0" style="width:100%">
				                <div class="job-post-item-header align-items-center">
				                	<span class="subadge">등록일 : ${jobOfferInfo.jo_rgsde.split(" ")[0] }</span>
				                	<span class="subadge" style="margin-left:3%;">마감일 : ${jobOfferInfo.jo_clos.split(" ")[0] }</span>
				                  <h2 class="mr-3 text-black" style="margin-top:10px;"><a href="/individualMember/jobOffer/jobOfferView.do?jo_num=${jobOfferInfo.jo_num}">${jobOfferInfo.jo_sj}</a></h2>
				                </div>
				                <div class="job-post-item-body d-block d-md-flex">
				                	<c:forEach items="${jobOfferInfo.recruitmentFieldList}" var="recruitmentFieldInfo" varStatus="status">
				                		<c:if test="${status.first}">
						                  	<div class="mr-3"><span class="icon-layers"></span> ${recruitmentFieldInfo.recruitment_field_name}</div>
						                  	<div class="mr-3"><span class="${(recruitmentFieldInfo.recruitment_field_personnel eq 1)? 'icon-user' : 'icon-users' }"></span> ${recruitmentFieldInfo.recruitment_field_personnel}명 모집</div>
						                  	<div class="mr-3"><span class="icon-tags"></span> ${recruitmentFieldInfo.recruitment_field_career}</div>
				                		</c:if>
				                	</c:forEach>
				                </div>
				              </div>
				            </div>
	          			</div>
	         		</c:forEach>
			  	</c:if>
			  	
			  	<div id="JOloadDiv" align="center">
			  		<hr>
			  		<a id="JOload" href="#">더보기(more)</a>
			  		<hr>
			  	</div>
			  	
			  	<c:if test="${empty jobOfferList}">
			  		<c:if test="${empty companyList }">
			  		<div style="text-align: center;">
			  			<strong style="color: #35829c;"> ${corp_name }</strong>&nbsp;과(와) 관련된 정보가 없습니다.
			  		</div>
			  		</c:if>
			  	</c:if>
		  	</div>
		</div>
	</div>
</section>
		
</body>
</html>