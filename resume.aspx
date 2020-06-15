<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    // SqlConnection 개체 생성
    SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=resume_maker_db;" +
            "Integrated Security=False; uid=taewoo; pwd=1111");

    protected void Page_Load(object sender, EventArgs e)
    {
        string email = Request.QueryString["useremail"];

        selectProfile(email);

        // 이미지 버튼 클릭 이벤트 추가
        ImageButton1.Attributes.Add("onclick", "document.getElementById('FileUpload1').click(); return false;");
    }

    protected void selectProfile(string email)
    {
        // SqlCommand 개체 생성
        string sql = "SELECT * FROM Member WHERE email='" + email + "'";
        SqlCommand cmd = new SqlCommand(sql, con);

        // SqlConnection 개체 열기
        con.Open();

        // SqlDataReader 개체 생성
        SqlDataReader rd = cmd.ExecuteReader();

        // 데이터 조회 및 출력
        if (rd.Read())
        {
            lblName.Text = String.Format("{0}", rd["name"]);
            lblJob.Text = String.Format("{0}", rd["job"]);
            lblAddr.Text = String.Format("({0}) {1}",  rd["zip"], rd["addr"]);
            lblEmail.Text = String.Format("{0}", rd["email"]);
            lblPhone.Text = String.Format("{0}", rd["phone"]);
            lblGithub.Text = String.Format("{0}", rd["github"]);
        }

        //SqlDataReader 및 SqlConnection 개체 닫기
        rd.Close();
        con.Close();
    }

    protected void btnProfile_Click(object sender, EventArgs e)
    {
        if(btnProfile.Text.Equals("수정"))
        {
            btnProfile.Text = "완료";

            txtName.Text = lblName.Text;
            listJob.SelectedValue = lblJob.Text;
            txtAddr.Text = lblAddr.Text;
            txtPhone.Text = lblPhone.Text;
            txtGithub.Text = lblGithub.Text;

            txtName.Visible = true;
            lblName.Visible = false;

            listJob.Visible = true;
            lblJob.Visible = false;

            txtAddr.Visible = true;
            lblAddr.Visible = false;

            txtPhone.Visible = true;
            lblPhone.Visible = false;

            txtGithub.Visible = true;
            lblGithub.Visible = false;
        }
        else
        {
            btnProfile.Text = "수정";

            lblName.Text = txtName.Text;
            lblJob.Text = listJob.SelectedValue;
            lblAddr.Text = txtAddr.Text;
            lblPhone.Text = txtPhone.Text;
            lblGithub.Text = txtGithub.Text;

            txtName.Visible = false;
            lblName.Visible = true;

            listJob.Visible = false;
            lblJob.Visible = true;

            txtAddr.Visible = false;
            lblAddr.Visible = true;

            txtPhone.Visible = false;
            lblPhone.Visible = true;

            txtGithub.Visible = false;
            lblGithub.Visible = true;
        }

    }

    protected void btnCerti_Click(object sender, EventArgs e)
    {
        if (btnCerti.Text.Equals("수정"))
        {
            btnCerti.Text = "취소";
            tbCertiFix.Visible = true;
            gvCerti.Columns[3].Visible = true;
        }
        else
        {
            btnCerti.Text = "수정";
            tbCertiFix.Visible = false;
            gvCerti.Columns[3].Visible = false;
        }
    }

    protected void calCerti_SelectionChanged(object sender, EventArgs e)
    {
        txtCertiDate.Text = calCerti.SelectedDate.ToShortDateString();
    }

    protected void insertCertiBtn_Click(object sender, EventArgs e)
    {
        if(txtCertiDate.Text.Length != 0 && txtCertiName.Text.Length != 0)
        {
            string sql = "INSERT INTO Certificate VALUES(@email, @date, @name)";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
            cmd.Parameters.AddWithValue("@date", txtCertiDate.Text);
            cmd.Parameters.AddWithValue("@name", txtCertiName.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            txtCertiDate.Text = "";
            txtCertiName.Text = "";

            Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
        }
    }

    protected void deleteSkillsBtn_Command(object sender, CommandEventArgs e)
    {
        string sql = "DELETE FROM Skills WHERE email = @email and num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", e.CommandArgument.ToString());

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnSkills_Click(object sender, EventArgs e)
    {
        if(btnSkills.Text.Equals("수정"))
        {
            btnSkills.Text = "취소";
            for (int i = 0; i < dlSkills.Items.Count; i++)
            {
                dlSkills.Items[i].Controls[1].Visible = true;
            }
            rangeSkillsPanel.Visible = true;
        }
        else
        {
            btnSkills.Text = "수정";
            for (int i = 0; i < dlSkills.Items.Count; i++)
            {
                dlSkills.Items[i].Controls[1].Visible = false;
            }
            rangeSkillsPanel.Visible = false;
        }
    }

    protected void insertSkillsBtn_Click(object sender, EventArgs e)
    {
        if(txtSkillsName.Text.Length != 0)
        {
            string sql = "INSERT INTO Skills VALUES(@email, @value, @name)";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
            cmd.Parameters.AddWithValue("@value", fieldSkillsValue.Value);
            cmd.Parameters.AddWithValue("@name", txtSkillsName.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            txtSkillsName.Text = "";

            Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
        }
    }

    protected void gvCerti_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnWorkAdd_Click(object sender, EventArgs e)
    {
        Panel1.Visible = true;
    }

    protected void btnWorkEdit_Click(object sender, EventArgs e)
    {
        Panel2.Visible = true;
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
        html, body {
            font-family: "Roboto", sans-serif
        }
        input[type=range] {
            -webkit-appearance: none;
            margin: 20px 0;
            width: 100%;
        }
        input[type=range]:focus {
            outline: none;
        }
        input[type=range]::-webkit-slider-runnable-track {
            width: 100%;
            height: 4px;
            cursor: pointer;
            background: #009688;
            border-radius: 25px;
        }
        input[type=range]::-webkit-slider-thumb {
            height: 20px;
            width: 20px;
            border-radius: 50%;
            background: #fff;
            box-shadow: 0 0 4px 0 rgba(0,0,0, 1);
            cursor: pointer;
            -webkit-appearance: none;
            margin-top: -8px;
        }
        input[type=range]:focus::-webkit-slider-runnable-track {
            background: #009688;
        }
        .range-wrap{
            width: 100%;
            position: relative;
        }
        .range-value{
            position: absolute;
            top: -50%;
        }
        .range-value span{
            width: 30px;
            height: 24px;
            line-height: 24px;
            text-align: center;
            background: #009688;
            color: #fff;
            font-size: 12px;
            display: block;
            position: absolute;
            left: 50%;
            transform: translate(-50%, 0);
            border-radius: 6px;
        }
        .range-value span:before{
            content: "";
            position: absolute;
            width: 0;
            height: 0;
            border-top: 10px solid #009688;
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            margin-top: -1px;
        }
    </style>
    <script type="text/javascript">
        function show_calendar() {
            var cal = document.getElementById("calendar");

            if (cal.className.indexOf("w3-show") == -1) {
                cal.className += " w3-show";
            }
            else {
                cal.className = cal.className.replace(" w3-show", "");
            }
            return false;
        }
    </script>
</head>
<body class="w3-light-grey">
    <form id="form1" runat="server">
        <header class="w3-container w3-teal w3-center w3-margin-bottom">
          <p></p>
        </header>

        <div class="w3-content w3-margin-top" style="max-width: 1400px;">
            
            <div class="w3-row-padding">
                
                <div class="w3-third">
                    <div class="w3-white w3-text-grey w3-card-4">
                        <div class="w3-display-container">
                            <input type="file" accept="image/jpeg, image/png" id="FileUpload1" hidden="hidden"/>
                            <asp:ImageButton ID="ImageButton1" runat="server" src="./res/img/profile.png"
                                style="width:100%; height: 300px; overflow: hidden;"/>

                            <asp:Button ID="btnProfile" runat="server" Text="수정" CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:15px; margin-right:20px;" OnClick="btnProfile_Click"/>
                            <asp:TextBox ID="txtName" runat="server" Visible="false" CssClass="w3-margin-left" style="width:75%; height:30px; margin-top:15px;" placeholder="이름" Font-Italic="true" Font-Size="Medium"></asp:TextBox>
                            <h2 style="margin-bottom: 0px"><asp:Label ID="lblName" runat="server" CssClass="w3-margin-left" Text="이름" Font-Bold="true" Font-Italic="true"/></h2>
                        </div>

                        <div class="w3-container">

                            <p><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:Label ID="lblEmail" runat="server" Text="이메일"/></p>
                            <p><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:DropDownList ID="listJob" runat="server" Visible="false" CssClass="w3-select" style="width:70%; margin-top:0px;">
                                    <asp:ListItem>직업</asp:ListItem>
                                    <asp:ListItem>Developer</asp:ListItem>
                                    <asp:ListItem>Designer</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label ID="lblJob" runat="server" Text="직업"/></p>
                            <p><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:TextBox ID="txtAddr" runat="server" Visible="false" style="width:70%;" placeholder="현 거주지"></asp:TextBox>
                                <asp:Label ID="lblAddr" runat="server" Text="현 거주지"/></p>
                            <p><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:TextBox ID="txtPhone" runat="server" Visible="false" style="width:70%;" placeholder="전화번호"></asp:TextBox>
                                <asp:Label ID="lblPhone" runat="server" Text="전화번호"/></p>
                            <p><i class="fa fa-github fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:TextBox ID="txtGithub" runat="server" Visible="false" style="width:70%;" placeholder="GitHub 주소"></asp:TextBox>
                                <asp:Label ID="lblGithub" runat="server" Text="GitHub 주소"/></p>
                            <hr/>

                            <p class="w3-large w3-text-theme"><b><i class="fa fa-certificate fa-fw w3-margin-right w3-text-teal"></i>Certificate</b></p>
                            <asp:Button ID="btnCerti" runat="server" Text="수정" CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-50px; margin-right:2.5px;" OnClick="btnCerti_Click" />
                            
                            <asp:GridView ID="gvCerti" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowDeleted="gvCerti_RowDeleted"
                                Height="35px" Width="100%" BorderStyle="None" BorderColor="White" ShowHeader="false" DataKeyNames="num" >
                                <Columns>
                                    <asp:BoundField DataField="date" SortExpression="date" ItemStyle-Width="130" ItemStyle-CssClass="w3-padding-small">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="name" SortExpression="name" ItemStyle-Width="250">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="num" SortExpression="num" ItemStyle-Width="10" Visible="false">
                                    </asp:BoundField>
                                    <asp:CommandField ButtonType="Button" ShowDeleteButton="true" ControlStyle-CssClass="w3-button w3-red w3-right w3-padding-small" Visible="false"/>
                                </Columns>
                            </asp:GridView>
                            
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                                SelectCommand="SELECT [date], [name], [num] FROM [Certificate] WHERE ([email] = @email)"
                                DeleteCommand="DELETE FROM [Certificate] WHERE ([num] = @num and [email] = @email)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="num" Type="String" />
                                    <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                                </DeleteParameters>
                            </asp:SqlDataSource>

                            <asp:Table ID="tbCertiFix" runat="server" Visible="false">
                                <asp:TableRow Height="35px" VerticalAlign="Top">
                                    <asp:TableCell Width="130">
                                        <div style="border: 1px solid #A6A6A6; height: 28.5px; padding-left:5px;">
                                            <i class="fa fa-calendar w3-dropdown-click" onclick="show_calendar()"></i>
                                            <div class="w3-dropdown-content w3-bar-block w3-card-4" id="calendar">
                                                <asp:Calendar ID="calCerti" runat="server" OnSelectionChanged="calCerti_SelectionChanged"></asp:Calendar>
                                            </div>
                                            <asp:TextBox ID="txtCertiDate" runat="server" placeholder="취득 일자" Width="80%" BorderStyle="None" style="padding-left:5px; outline:none;"></asp:TextBox>
                                        </div>
                                    </asp:TableCell>
                                    <asp:TableCell Width="250">
                                        <asp:TextBox ID="txtCertiName" runat="server" placeholder="자격증 이름" style="padding-left:5px; outline:none;"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button ID="insertCertiBtn" runat="server" Text="추가" CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-right:-0.5px;" OnClick="insertCertiBtn_Click"/>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <hr/>
                            
                            <p class="w3-large w3-text-theme"><b><i class="fa fa-sliders fa-fw w3-margin-right w3-text-teal"></i>Skills</b></p>
                            <asp:Button ID="btnSkills" runat="server" Text="수정" OnClick="btnSkills_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-50px; margin-right:2.5px;" />

                            <asp:DataList ID="dlSkills" runat="server" DataSourceID="SqlDataSource2" ItemStyle-Width="430px">
                                <ItemTemplate>
                                    <p style="margin-top:5px; margin-bottom:5px; padding-left:5px;"><%# Eval("name") %></p>
                                    <asp:Button ID="deleteSkillsBtn" runat="server" Text="삭제" OnCommand="deleteSkillsBtn_Command" CommandArgument='<%# Eval("num") %>'
                                        CssClass="w3-button w3-red w3-right w3-padding-small" style="margin-top:-40px; margin-right:1px;" Visible="false"/>
                                    <div class="w3-light-grey w3-round-xlarge w3-small w3-margin-bottom">
                                        <div class="w3-container w3-center w3-round-xlarge w3-teal valSkills" style="width:100%"><%# Eval("value") %>%</div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList><br />

                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                                SelectCommand="SELECT [num], [value], [name] FROM [Skills] WHERE ([email] = @email)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:Panel ID="rangeSkillsPanel" runat="server" CssClass="w3-margin-bottom" Visible="false">
                                <div class="range-wrap">
                                    <div class="range-value" id="skillsRangeDivision"></div>
                                    <input id="skillsRange" type="range" min="1" max="100" value="1" step="1" onchange="skillsRange_Change()" />
                                    <asp:HiddenField ID="fieldSkillsValue" runat="server" Value=""/>
                                </div>
                                <asp:TextBox ID="txtSkillsName" runat="server" Width="350px" style="padding-left:5px; outline:none;" placeholder="보유 기술 명칭"></asp:TextBox>
                                <asp:Button ID="insertSkillsBtn" runat="server" Text="추가" OnClick="insertSkillsBtn_Click"
                                    CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-right:2px;" /><br /><br />
                            </asp:Panel>
                            
                        </div>
                    </div>
                </div>
                
                <div class="w3-twothird">
                    
                    <div class="w3-container w3-card w3-white w3-margin-bottom">
                        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Work Experience</h2>
                        <asp:Button ID="btnWorkAdd" runat="server" Text="추가" OnClick="btnWorkAdd_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-60px; margin-right:2.5px;" />
                        <asp:Button ID="btnWorkEdit" runat="server" Text="수정" OnClick="btnWorkEdit_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-60px; margin-right:60px;" />

                        <asp:ListView ID="lvWork" runat="server" DataSourceID="SqlDataSource3">
                            <ItemTemplate>
                                <div class="w3-container">
                                    <h5 class="w3-opacity"><b><%# Eval("title") %></b></h5>
                                    <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i><%# Eval("joindate") %> - <%# Eval("leavedate") %></h6>
                                    <p><%# Eval("contents") %></p>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>

                        <asp:DataPager ID="DataPager1" runat="server" PageSize="1" PagedControlID="lvWork">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="w3-button w3-teal w3-padding-small w3-margin-left"/>
                            </Fields>
                        </asp:DataPager>

                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                            SelectCommand="SELECT [title], [joindate], [leavedate], [contents] FROM [Work] WHERE ([email] = @email)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br /><br />

                        <asp:Panel ID="Panel1" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="TextBox1" runat="server" placeholder="회사 명" style="width:92%; height:37px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="Button2" runat="server" Text="등록" OnClick="btnSkills_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="TextBox6" runat="server" Width="50"></asp:TextBox>
                                <asp:Label ID="Label2" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="TextBox5" runat="server" Width="30"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" Text="월  입사" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="TextBox3" runat="server" Width="50"></asp:TextBox>
                                <asp:Label ID="Label3" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="TextBox7" runat="server" Width="30"></asp:TextBox>
                                <asp:Label ID="Label4" runat="server" Text="월  퇴사" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="TextBox4" runat="server" placeholder="직무 내용을 입력해 주세요." TextMode="MultiLine" style="width:100%; height:250px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>

                        <asp:Panel ID="Panel2" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="TextBox2" runat="server" placeholder="회사 명" style="width:85%; height:38px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="Button4" runat="server" Text="삭제" OnClick="btnSkills_Click" 
                                    CssClass="w3-button w3-red w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <asp:Button ID="Button3" runat="server" Text="등록" OnClick="btnSkills_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="TextBox8" runat="server" Width="50"></asp:TextBox>
                                <asp:Label ID="Label5" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="TextBox9" runat="server" Width="30"></asp:TextBox>
                                <asp:Label ID="Label6" runat="server" Text="월  입사" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="TextBox10" runat="server" Width="50"></asp:TextBox>
                                <asp:Label ID="Label7" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="TextBox11" runat="server" Width="30"></asp:TextBox>
                                <asp:Label ID="Label8" runat="server" Text="월  퇴사" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="TextBox12" runat="server" placeholder="직무 내용을 입력해 주세요." TextMode="MultiLine" style="width:100%; height:250px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>

                    </div>
                    
                    <!-- <div class="w3-container w3-card w3-white w3-margin-bottom">
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
                        </div><br />
                    </div>
                    
                    <div class="w3-container w3-card w3-white">
                        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-trophy fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Awards</h2>
                        <div class="w3-container">
                            <h5 class="w3-opacity"><b>네이버 웨일 확장앱 콘테스트 본선 진출</b></h5>
                            <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Oct 2019</h6>
                            <p>HearNews, 시각장애인을 위해 간단한 조작으로 '네이버 뉴스'의 TTS를 제공. <br />
                                참고) https://store.whale.naver.com/detail/mpbohbjpccagbpimcagchhfibnmcngak
                            </p>
                        </div><br/>
                    </div>-->

                </div>
            </div>
        </div>

        <footer class="w3-container w3-teal w3-center w3-margin-top">
          <p></p>
        </footer>
    </form>

    <script type="text/javascript">
        var valSkills = document.getElementsByClassName('valSkills');
        for (element of valSkills) {
            element.style.width = element.innerText;
        }

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

        const
            range = document.getElementById('skillsRange'),
            rangeV = document.getElementById('skillsRangeDivision'),
            setValue = () => {
                const
                    newValue = Number((range.value - range.min) * 100 / (range.max - range.min)),
                    newPosition = 10 - (newValue * 0.2);
                rangeV.innerHTML = `<span>${range.value}</span>`;
                rangeV.style.left = `calc(${newValue}% + (${newPosition}px))`;
            };
        document.addEventListener("DOMContentLoaded", setValue);
        range.addEventListener('input', setValue);

        function skillsRange_Change() {
            fieldSkillsValue.value = skillsRange.value;
        }
    </script>
</body>
</html>
