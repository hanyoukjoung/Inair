<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
<style type="text/css">

#title{
	text-align: center;
}

#buttons_wrapper{
	text-align: center;
	margin-bottom: 20px;
}

.buttons{
	border: none;
	width: 100px;
	height: 50px;
	font-size: 16px;
}

li{
	margin-bottom: 20px;
}

#cancel{
	background-color: #8e8e8e;
	color: white;
	margin-right: 15px;
}

#confirm{
	background-color: #4271d7;
	color: white;
}

.li_titles{
	display: block;
}


<!--                                                                                                            -->
#aiDiv {
	background-color: #1d213c;
	height: 800px;
	width: 100%;
}

#showCondition,#barchart_icon,#radarchart_icon {
	cursor: pointer;
}

#head {
	height: 30px;
}

#myProgress {
	margin-top: -5px;
	width: 100%;
	background-color: #8a8889;
}

#myBar {
	width: 0%;
	height: 5px;
	background-color: #ff0000;
}

.voice_element {
	color: white;
}

.analysisProgress {
	display: inline-block;
	background-color: black;
	width: 100%;
}

.analysisBar {
	background-color: #5fbad5;
	height: 10px;
	width: 0%;
}

.face_element {
	color: white;
}

.percentage {
	margin-left: 5px;
	color: white;
	font-size: 10px;
}

#webcam {
	background-color: black;
}

#message {
	font-size: 18px;
	color: white;
	margin-left: 40px;
	background: none;
	font-weight: bold;
	height: 50px;
	resize: none;
	width: 840px;
	border: none;
	margin-top: 50px;
}

.btn_icon {
	position: absolute;
	top: 23px;
	left: 18px;
}

.content_div {
	background-color: black;
}

.content_div_wrapper {
	margin: 10px;
 	height: 910px; 
}

.label_key {
	color: white;
}

.label_value {
	color: white;
}

.title {
	color: white;
}

cavas {
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	margin-bottom: -3px;
	display: inline-block;
}

#top_x_div svg>g>rect {
	fill: #000;
}

.radarchart_result {
	display: none;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
var i = 2; // 로딩이미지 돌리기위한 변수
var objPopup; // 자식창을 담을 변수

$(function(){
	
	// ai모의면접 확인 버튼 클릭 이벤트
	$('#confirm').click(function(){
		var url = "/AIIMT/AIIMTForm.do";
		var popupWidth = 1920; // 팝업창 가로크기
		var popupHeight = 950; // 팝업창 세로 크기

		var popupX = (screen.availWidth / 2) - (popupWidth / 2); // 팝업창 x축위치
		var popupY = (screen.availHeight / 2) - (popupHeight / 2); // 팝업창 y축위치
		var options = "width=" + popupWidth + ", height=" + popupHeight + ", left=" + popupX + ", top=" + popupY; // 팝업창 옵션 세팅
		
		objPopup = window.open(url, 'AI모의면접', options); // 팝업창을 열고 팝업창을 담을 전역변수 초기화
		LoadingWidthMask(); // 팝업창을 띄우고 부모창 막기
	});
	
	// 로딩화면 이미지 돌리기 (0.2초마다 이미지를 바꿉니다.)
	setInterval(function(){
		i++;
		if(i==13){
			i=2;
		}
		$('#loadingImg').attr("src", "${pageContext.request.contextPath}/images/loadingImgs/loading" + i + ".png");
	}, 200);
	
	//얼굴 분석 바 차트
	var face_barchartElement = document.getElementById("face_barchart");
	var faceBarchart = new Chart(face_barchartElement, {
		type : 'bar',
		data : {
			labels : ['분노', '경멸', '혐오', '공포', '행복', '중립', '슬픔', '놀람'],
			datasets : [{
				label : '얼굴 감정 분석',
				data : [5, 5, 10, 0, 50, 20, 10, 0],
				backgroundColor : [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(255, 159, 64, 0.2)',
					'rgba(153, 102, 255, 0.2)',
					'rgba(121, 94, 12, 0.2)',
					'rgba(194, 74, 231, 0.2)'
				],
				borderColor : [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)',
					'rgba(255, 159, 64, 1)',
					'rgba(153, 102, 255, 1)',
					'rgba(121, 94, 12, 1)',
					'rgba(194, 74, 231, 1)'
				],
				borderWidth : 1
			}]
		},
		options : {
			scales : {
				yAxes : [{
					ticks : {
						beginAtZero : true,
						min : 0,
						max : 100
					}
				}]
			}
		}
	});
	
	
	createVoiceDoughnutchart('voice_doughnutchart');
	createVoiceBarchart('voice_barchart');
	createVoiceRadarchart('voice_radarchart');
// 	createFaceBarchart('face_barchart');
	createFaceRadarchart('face_radarchart');
	createWordCloud("자신감", "자신감");	
});

//------------------------------------------------------------ 차트 부분 ------------------------------------------------------------

//word cloud 생성 함수
function createWordCloud(key, value){
	word_array.push({"text" : key, "weight" : value});
	$('#word_cloud').jQCloud(word_array);
}

//음성 분석 바차트
function createVoiceBarchart(target){
	var ctx = document.getElementById(target);
	var voiceBarchart = new Chart(ctx, {
		type : 'bar',
		data : {
			labels : ['차분', '분노', '행복', '슬픔', '활기'],
			datasets : [{
				label : '음성 감정 분석',
				data : [10, 10, 60, 50, 30],
				backgroundColor : [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(255, 159, 64, 0.2)'
				],
				borderColor : [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)',
					'rgba(255, 159, 64, 1)'
				],
				borderWidth : 1
			}]
		},
		options : {
			scales : {
				yAxes : [{
					ticks : {
						beginAtZero : true,
						min : 0,
						max : 100
					}
				}]
			}
		}
	});
}


//음성 분석 레이다 차트
function createVoiceRadarchart(target){
	var ctx = document.getElementById(target);
	var voiceRadarchart = new Chart(ctx, {
		type : 'radar',
		data : {
			labels : ['차분', '분노', '행복', '슬픔', '활기'],
			datasets : [{
				label : '점수',
				data : [10, 0, 30, 20, 30],
				lineTension : 0.1,
				backgroundColor: "rgba(178, 223, 219,0.2)",
				borderColor : '#009688',
				pointBackGroundColor : '#004D40',
				pointBorderColor : '#fff',
				pointHoverBackgroundColor : '#fff',
				pointHoverBorderColor : 'rgba(255, 99, 132, 1)',
			}]
		},
		options : {
			responsive : false,
			tooltips : {
				enable : true,
				mode : 'label'
			},
			legend : {
				display : false
			},
			scale : {
				gridLines : {
					color : '#9E9E9E'
				},
				angleLines : {
					color : '#9E9E9E'
				},
				reverse : false,
				ticks : {
					showLabelBackdrop : false,
					min : 0,
					max : 100
				}
			},
			scaleOverride : false,
			scaleSteps : 5,
			scaleStepWidth : 20,
			scalStartValue : 100
		}
	});
}

//얼굴분석 레이다차트
function createFaceRadarchart(target){
	var ctx = document.getElementById(target);
	faceRadarchartConfig = {
		type : 'radar',
		data : {
			labels : ['분노', '경멸', '혐오', '공포', '행복', '중립', '슬픔', '놀람'],
			datasets : [{
				label : '점수',
				data : [face_anger, face_contempt, face_disgust, face_fear, face_happiness, face_neutral, face_sadness, face_surprise],
				lineTension : 0.1,
				backgroundColor: "rgba(178, 223, 219,0.2)",
				borderColor : '#009688',
				pointBackGroundColor : '#004D40',
				pointBorderColor : '#fff',
				pointHoverBackgroundColor : '#fff',
				pointHoverBorderColor : 'rgba(255, 99, 132, 1)',
			}]
		},
		options : {
			responsive : false,
			tooltips : {
				enable : true,
				mode : 'label'
			},
			legend : {
				display : false
			},
			scale : {
				gridLines : {
					color : '#9E9E9E'
				},
				angleLines : {
					color : '#9E9E9E'
				},
				reverse : false,
				ticks : {
					showLabelBackdrop : false,
					min : 0,
					max : 100
				}
			},
			scaleOverride : false,
			scaleSteps : 5,
			scaleStepWidth : 20,
			scalStartValue : 100
		}
	};
	
	faceRadarchart = new Chart(ctx, faceRadarchartConfig);
}

//목소리 분석 도넛차트
function createVoiceDoughnutchart(target){
	var ctx = document.getElementById(target);
	var voiceDoughnutchart = new Chart(ctx, {
		type : 'doughnut',
		data : {
			labels : ['긍정', '부정', '중립'],
			datasets : [{
				data : [6, 1, 3],
				backgroundColor : [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)'
				]
			}]
		},
		options : {
			cutoutPercentage : 50
		}
	});
}


//------------------------------------------------------------ 차트 부분 ------------------------------------------------------------

// 자식창 종료 이벤트 (body에 closePopup()함수 실행시 콜백)
function closePopup(){
	if(objPopup != null) {
		objPopup.close();
	}
}

// ai모의면접 진행시 부모창 막기
function LoadingWidthMask() {
	var maskHeight = $(document).height();
	var maskWidth = window.document.body.clientWidth;
	
	var mask = '';
	mask += "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'>";
	mask += "</div>";
	
	var img = '';
	img += "<div style='background-color: white; width: 600px; height: 300px; display:inline-block; position: absolute; z-index: 9001; top: 350px; left:650px; margin: auto; border: 1px solid black;'>";
	img += " <img src='${pageContext.request.contextPath}/images/loadingImgs/loading1.png' id='loadingImg' style=' width:128px; height:128px; display: block; margin: auto; margin-top: 20px; margin-bottom: 20px;'/>";
	img += " <b style='color: black; font-size: 32px; margin-left: 40px; margin-top: 30px;'>AI모의면접이 진행중입니다. (종료:F5)</b>";
	img += "</div>";
	
	$('body').append(mask);
	$('body').append(img);
	$('#mask').css({'width' : maskWidth, 'height' : maskHeight, 'opacity' : '0.3'});
	$('#mask').css({'display' : 'inline-block'});
}

</script>
</head>
<body style="position: relative;" onunload="closePopup();">
	<section class="ftco-section bg-light">
		<div class="container">
			<div id="title"><h3>AI 모의면접 설명</h3></div>
			<dir>
				<ul>
					<li>
						<b class="li_titles">1. 대충 중요한 설명제목1</b>
						<span>대충 중요한 설명1</span>
					</li>
				</ul>
			</dir>
			<div id="aiDiv">
				<div style="clear: both;">
					<div style="float: left; width: 50%; height: 100%;">
						<div class="content_div_wrapper">
							<h5 class="title" style="display: inline-block;">Video</h5>
							<div class="content_div" style="height:45%; margin-bottom:10px; text-align:center;">
								<img src="${pageContext.request.contextPath }/images/dong.jpg" alt="증명사진" style="height:65%; margin-top:5%; margin-bottom:7%;">
								<div id="myProgress">
									<div id="myBar"></div>
								</div>
								<div class="content_div" style="height:186px; font-size:12px; color:white; padding-top:5%;">
									마이크에 "안녕하세요. 만나서 반갑습니다."라고 천천히 또박또박 말씀해주세요.
								</div>
							</div>
							<div class="content_div" style="background-color:#1d213c; clear:both;">
								<div style="display: inline-block;width: 47.5%;float: left; margin-top: 5%;">
									<h5 class="title">Voice Graph</h5>
									<img src="${pageContext.request.contextPath }/images/voiceGraph.png" style="width:100%;height: 232px;" />
								</div>
								<div style="display: inline-block;width: 47.5%;margin-left: 4%; margin-top: 5%;">
									<h5 class="title">Voice Analysis</h5>
									<div style="width: 100%;height: 228px;display: inline-block;background-color: black; margin-top: 2%;">
										<canvas id="voice_doughnutchart" style="width: 100%;height: 228px;display: inline-block; margin-top: 20%;" ></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="float: right; width: 50%; height: 100%; margin-top: 3%;">
						<div class="content_div_wrapper" style="height:100%;">
							<div class="wrapper_content_barchart_result">
								<div>
									<h5 class="title" style="display: inline-block;">Voice Analysis</h5>
									<h5 class="title" style="display: inline-block;margin-left: 26%;">Face Analysis</h5>
									<img src="${pageContext.request.contextPath }/images/barchart.png" id="barchart_icon" style="width: 32px; height: 32px; float: right;">
								</div>
								<div style="display: inline-block;width: 47.5%;height: 250px;margin-right: 14px;background-color: black;">
									<canvas id="voice_barchart" width="100%" height=100%"></canvas>
								</div>
								<div style="display: inline-block;width: 47.5%;height: 250px;background-color: black;margin-left: 1%;">
									<canvas id="face_barchart" width="100%" height="100%"></canvas>
								</div>
							</div>
							<div style="margin-top: 10%;">
								<h5 class="title">Word Cloud</h5>
								<div id="word_cloud" style="background-color: black; height: 332px;">
									<img src="${pageContext.request.contextPath }/images/wordCloud.png" style="margin-top: 10%;"/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="buttons_wrapper" style="margin-top:5%; ">
				<button class="buttons" id="cancel">취소</button>
				<button class="buttons" id="confirm">확인</button>
			</div>
		</div>
	</section>
</body>
</html>