<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        ImageButton1.Attributes.Add("onclick", "document.getElementById('FileUpload1').click(); return false;");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <title>이력서 만들기</title>
    <style>
        html,body,h1,h2,h3,h4,h5,h6 {
            font-family: "Roboto", sans-serif
        }
    </style>
</head>
<body class="w3-light-grey">
    <form id="form1" runat="server">
        <header class="w3-container w3-teal w3-center w3-margin-bottom">
          <p></p>
        </header>

        <!-- Page Container -->
        <div class="w3-content w3-margin-top" style="max-width: 1400px;">

          <!-- The Grid -->
          <div class="w3-row-padding">
  
            <!-- Left Column -->
            <div class="w3-third">
              <div class="w3-white w3-text-grey w3-card-4">
                <div class="w3-display-container">
                    <input type="file" accept="image/jpeg, image/png" id="FileUpload1" hidden="hidden"/>
                    <asp:ImageButton ID="ImageButton1" runat="server" src="./res/img/profile.png"
                        style="width:100%; height: 300px; overflow: hidden;"/>
                  <div class="w3-display-bottomleft w3-container w3-text-black">
                    <h2>Kim Taewoo</h2>
                  </div>
                </div>
                <div class="w3-container">
                  <p><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>Developer</p>
                  <p><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>Seoul, Kor</p>
                  <p><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>xass1995@gmail.com</p>
                  <p><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>010-2969-2563</p
                  <p><i class="fa fa-github fa-fw w3-margin-right w3-large w3-text-teal"></i>https://github.com/Taewoo-Git</p>
                  <hr/>

                  <p class="w3-large w3-text-theme"><b><i class="fa fa-certificate fa-fw w3-margin-right w3-text-teal"></i>Certificate</b></p>
                    <asp:Table ID="Table1" runat="server">
                        <asp:TableRow Height="35px" VerticalAlign="Top">
                            <asp:TableCell Width="100px">2018.01.02</asp:TableCell>
                            <asp:TableCell>네트워크 관리사 2급</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="35px" VerticalAlign="Top">
                            <asp:TableCell>2012.02.04</asp:TableCell>
                            <asp:TableCell>MOS master</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                  <hr/>

                  <p class="w3-large"><b><i class="fa fa-sliders fa-fw w3-margin-right w3-text-teal"></i>Skills</b></p>
                  <p>C#</p>
                  <div class="w3-light-grey w3-round-xlarge w3-small">
                    <div class="w3-container w3-center w3-round-xlarge w3-teal" style="width:70%">70%</div>
                  </div>
                  <p>ASP.NET</p>
                  <div class="w3-light-grey w3-round-xlarge w3-small">
                    <div class="w3-container w3-center w3-round-xlarge w3-teal" style="width:60%">60%</div>
                  </div>
                  <br/>
                </div>
              </div><br/>

            <!-- End Left Column -->
            </div>

            <!-- Right Column -->
            <div class="w3-twothird">
    
              <div class="w3-container w3-card w3-white w3-margin-bottom">
                <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Work Experience</h2>
                <div class="w3-container">
                  <h5 class="w3-opacity"><b>대한민국 육군</b></h5>
                  <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jul 2016 - Apr 2018</h6>
                  <p>23사단 57연대 통신중대 전술C4I운용/정비병으로 근무.</p>
                  <!-- <hr/> -->
                </div><br/>
              </div>

              <div class="w3-container w3-card w3-white w3-margin-bottom">
                <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-graduation-cap fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Education</h2>
                <div class="w3-container">
                  <h5 class="w3-opacity"><b>유한대학교</b></h5>
                  <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Feb 2015 - <span class="w3-tag w3-teal w3-round">Current</span></h6>
                  <p>IT소프트웨어공학과, 2021년 2월 졸업 예정.</p>
                  <hr/> 
                </div>
                <div class="w3-container">
                  <h5 class="w3-opacity"><b>중흥고등학교</b></h5>
                  <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Mar 2011 - Fed 2014</h6>
                </div>
                <br />
              </div>

             <div class="w3-container w3-card w3-white">
                <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-trophy fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Awards</h2>
                <div class="w3-container">
                  <h5 class="w3-opacity"><b>네이버 웨일 확장앱 콘테스트 본선 진출</b></h5>
                  <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Oct 2019</h6>
                  <p>HearNews, 시각장애인을 위해 간단한 조작으로 '네이버 뉴스'의 TTS를 제공. <br />
                      참고) https://store.whale.naver.com/detail/mpbohbjpccagbpimcagchhfibnmcngak
                  </p>
                  <!-- <hr/> -->
                </div><br/>
              </div>

            <!-- End Right Column -->
            </div>
    
          <!-- End Grid -->
          </div>
  
          <!-- End Page Container -->
        </div>

        <footer class="w3-container w3-teal w3-center w3-margin-top">
          <p></p>
        </footer>
    </form>

    <script type="text/javascript">
        document.getElementById("FileUpload1").onchange = function () {
            let img = this.files[0];
            if (img) {
                var fr = new FileReader();
                fr.onload = function () {
                    var result = fr.result;
                    document.getElementById("ImageButton1").src = result;
                };
                fr.readAsDataURL(img);
            }
        };
    </script>
</body>
</html>
