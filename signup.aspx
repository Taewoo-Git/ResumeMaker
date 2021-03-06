﻿<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        txtZip.Attributes.Add("readonly", "readonly");
        txtAddr.Attributes.Add("readonly", "readonly");
    }

    protected void btnSignup_Click(object sender, EventArgs e)
    {
        if(!txtEmail.Enabled)
        {
            SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=resume_maker_db;" +
            "Integrated Security=False; uid=taewoo; pwd=1111");

            string sql = "INSERT INTO Member(email, pwd, name, phone, zip, addr, job, github, viewer, shared) " +
                    "VALUES(@email, @pwd, @name, @phone, @zip, @addr, @job, @github, @viewer, @shared)";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@pwd", txtPwd.Text);
            cmd.Parameters.AddWithValue("@name", txtName.Text);
            cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
            cmd.Parameters.AddWithValue("@zip", txtZip.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddr.Text);
            cmd.Parameters.AddWithValue("@job", listJob.SelectedValue);

            if(txtGithub.Text.Length > 0) cmd.Parameters.AddWithValue("@github", txtGithub.Text);
            else cmd.Parameters.AddWithValue("@github", DBNull.Value);

            cmd.Parameters.AddWithValue("@viewer", 0);
            cmd.Parameters.AddWithValue("@shared", 'N');

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("~/login.aspx");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('이메일 중복확인이 필요합니다.')", true);
        }
    }

    protected void btnEmail_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=resume_maker_db;" +
            "Integrated Security=False; uid=taewoo; pwd=1111");

        string sql = "SELECT count(email) FROM Member WHERE email = @email;";

        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@email", txtEmail.Text);

        con.Open();
        if (((int)cmd.ExecuteScalar()) > 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('이미 가입된 이메일입니다.')", true);
        }
        else
        {
            if(txtEmail.Enabled)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('사용 가능한 이메일입니다.')", true);
                txtEmail.Enabled = false;
                btnEmail.Text = "다시입력";
            }
            else
            {
                txtEmail.Text = "";
                txtEmail.Enabled = true;
                btnEmail.Text = "중복검사";
            }
        }
        con.Close();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <style>
        .btn-submit {
          width: 100%;
          border-radius: 5px;
          padding: 17px 20px;
          box-sizing: border-box;
          font-size: 14px;
          font-weight: 700;
          color: #fff;
          text-transform: uppercase;
          border: none;
          background-image: linear-gradient(to left, #74ebd5, #9face6);
        }
        .post-input{
            padding:8px;width:30%;margin-top:0px;
        }
        .post-btn{
            border-radius:5px; padding:8px;border:none;width:10%;margin-top:0px;
        }
    </style>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
    <title>Resume Maker</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="modal" class="w3-modal">
		    <div class="w3-container w3-content w3-card w3-white w3-round-large" style="max-width:600px; margin-top:-50px;">
			    <h2 class="font-mont">SIGN UP</h2>
		      
			    <div class="w3-section">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="w3-border" placeholder="이메일 주소 입력" style="padding:8px; width:82%;"></asp:TextBox>
                    <asp:Button ID="btnEmail" runat="server" CssClass="w3-dark-grey w3-round w3-button" Text="중복확인" style="margin-top:-3px;" OnClick="btnEmail_Click" CausesValidation="false"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="이메일을 입력해 주세요." ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="이메일 형식이 잘못되었습니다."
                        ControlToValidate="txtEmail" ValidationExpression="^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
			    </div>
		      
			    <div class="w3-section">
                    <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" CssClass="w3-input w3-border" placeholder="비밀번호(8~32자리)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="비밀번호를 입력해 주세요." ControlToValidate="txtPwd" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="비밀번호 형식이 잘못되었습니다."
                        ControlToValidate="txtPwd" ValidationExpression="\S{8,32}" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
			    </div>
		      
			    <div class="w3-section">
                    <asp:TextBox ID="txtRePwd" runat="server" TextMode="Password" CssClass="w3-input w3-border" placeholder="비밀번호 재입력"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="비밀번호를 재입력해 주세요." ControlToValidate="txtRePwd" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="비밀번호가 일치하지 않습니다." ControlToValidate="txtRePwd" ControlToCompare="txtPwd" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
			    </div>
		      
			    <div class="w3-section">
                    <asp:TextBox ID="txtName" runat="server" CssClass="w3-input w3-border" placeholder="이름"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="이름을 입력해 주세요." ControlToValidate="txtName" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
			    </div>
		      
			    <div class="w3-section">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="w3-input w3-border" placeholder="전화번호 예) 010-1234-5678"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="전화번호를 입력해 주세요." ControlToValidate="txtPhone" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="전화번호 형식이 잘못되었습니다."
                        ControlToValidate="txtPhone" ValidationExpression="^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
			    </div>
		      
			    <div id="postcodify" class="w3-section">
                    <asp:TextBox ID="txtZip" runat="server" CssClass="w3-border post-input postcodify_postcode5" placeholder="우편번호"></asp:TextBox>
                    <asp:Button ID="btnPost" runat="server" CssClass="w3-dark-grey post-btn" Text="검색" OnClientClick="return false;"/>
                    <asp:TextBox ID="txtAddr" runat="server" CssClass="w3-input w3-border w3-margin-top postcodify_english_address" placeholder="도로명 주소"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="도로명 주소를 입력해 주세요." ControlToValidate="txtAddr" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
			    </div>

                <div class="w3-section">
                    <asp:DropDownList ID="listJob" runat="server" CssClass="w3-select" style="width:30%;">
                        <asp:ListItem>직업</asp:ListItem>
                        <asp:ListItem>Developer</asp:ListItem>
                        <asp:ListItem>Engineer</asp:ListItem>
                        <asp:ListItem>Analyst</asp:ListItem>
                        <asp:ListItem>Architect</asp:ListItem>
                        <asp:ListItem>Designer</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtGithub" runat="server" CssClass="w3-border" placeholder="GitHub 주소" style="padding:8px; width:69%;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="listJob" InitialValue="직업" ErrorMessage="직업을 선택해주세요." Display="Dynamic" ForeColor="Red"/>
			    </div>
		      
			    <div class="w3-section">
                    <asp:Button ID="btnSignup" runat="server" CssClass="w3-button w3-block w3-padding btn-submit" Text="등록" ForeColor="White" OnClick="btnSignup_Click"/>
			    </div>
		  
			    <p class="w3-section">
				    계정이 이미 있으신가요 ? <a href="./login.aspx">돌아가기</a>
			    </p>
		    </div>
        </div>
    </form>

    <script>
        document.getElementById('modal').style.display = 'block';

        $(function () { $("#txtZip").postcodifyPopUp(); });
        $(function () { $("#btnPost").postcodifyPopUp(); });
        $(function () { $("#txtAddr").postcodifyPopUp(); });
    </script>
</body>
</html>
