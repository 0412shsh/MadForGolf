<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<%@ include file="../include/header.jsp" %>

<style type="text/css">
.container{
	display:grid;
}

.main-container{
	display:grid;
	grid-template-columns:600px 600px;
	grid-template-rows:350px 350px;
}

.chart-container{
	width:500px;
	height:500px;
	margin:0px auto;
	positon:realtive
}

.content-container{
	display:grid;
	padding-top:100px;
	paddig-left:300px;
	grid-template-rows:S00px 100px;
}

</style>

	<!-- ##### Breadcrumb Area Start ##### -->
    <div class="breadcrumb-area">
        <!-- Top Breadcrumb Area -->
        <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(${pageContext.request.contextPath }/resources/img/bg-img/24.jpg);">
            <h2>My Account Book</h2>
        </div>
        
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">My Account Book</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
	<!-- ##### Breadcrumb Area End ##### -->
	
	<section class="about-us-area">
		<div class="container">
			<div class="section-heading text-center">
				<h2>My Account Book</h2>
				<p>${user_name }님의 가계부</p>
			</div>
	
			<!-- 선 -->
			<div class="col-12">
				<div class="border-line"></div>
				<br><br><br>
			</div>
			<!-- 선 -->
			
			
			<!-- JSTL -->
			<c:choose>
				<c:when test="${purchaseCnt eq 0 && saleCnt eq 0}">
					<div class="main-container">
						<div class="img-container">
							<img src="${pageContext.request.contextPath }/resources/img/geoji4.jpg" style="width:500px; height:500px; margin:0px auto;">
							<br><br>	
						</div>
						
						<div class="checkout-btn mt-30" onClick="location.href='/product/listAll'">
							<a href="/product/listAll">거래하러 가기</a>
					    	<br><br><br><br>
						</div>
					</div>
				</c:when>
					
				<c:otherwise>
					<div class="main-container">
						<!-- 차트를 그릴 영역 -->
						<div class="chart-container">
							<canvas id="MonthChart"></canvas>
							<br><br><br><br>
						</div>
						<!-- 차트를 그릴 영역 -->
						
	                    <!-- 글자 영역 -->
	                    <div class="content-container" onClick="location.href='/mypage/accountbookPurchase'">
							<!-- Icon -->
	                        <div class="icon-item" onClick="location.href='/mypage/accountbookPurchase'">
								<img src="${pageContext.request.contextPath }/resources/img/core-img/s1.png" alt="">
	                        </div>
	                        <!-- Content -->
	                        <div class="content-item" onClick="location.href='/mypage/accountbookPurchase'">
	                            <h5>이번 달 구매 내역 보러가기</h5>
	                            <p>이번 달 구매 횟수는 ${purchaseCnt }번 입니다.</p>
	                            <p>이번 달 구매 금액은 ${purchaseMonth }원 입니다.</p>
	                        </div>
							<!-- Icon -->
	                        <div class="icon-item" onClick="location.href='/mypage/accountbookSale'">
								<img src="${pageContext.request.contextPath }/resources/img/core-img/s2.png" alt="">
	                        </div>
	                        <!-- Content -->
	                        <div class="content-item" onClick="location.href='/mypage/accountbookSale'">
	                            <h5>이번 달 판매 내역 보러가기</h5>
	                            <p>이번 달 판매 횟수는 ${saleCnt }번 입니다.</p>
	                            <p>이번 달 판매 금액은 ${saleMonth}원 입니다.</p>
	                        </div>
	                    </div>
						<!-- 글자 영역 -->
					</div>
				</c:otherwise>
				</c:choose>
				<!-- JSTL -->
		</div>
	</section>


<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<script>
	var chartArea = document.getElementById('MonthChart').getContext('2d');
	
	var MonthChart = new Chart(chartArea,{
		type:'pie',
		data: {
			labels:["구매","판매"],
			datasets:[{
				label:"원",
				backgroundColor:[
					"#A1C298","#FA7070"
				],
				data:[${purchaseMonth},${saleMonth}]
			}]
		},
		options:{
			plugins:{
				title:{
					display:true,
					text:'이번 달 거래 현황',
					padding:{
						top:60,
						botton:50
					}
				}
			},
			maintainAspectRatio:false
		}
	});
</script>

<%@ include file="../include/footer.jsp" %>