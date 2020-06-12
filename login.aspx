<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if(Page.IsValid)
        {
            lblDeny.Text = "이메일 또는 패스워드가 틀렸습니다.";
        }

        string email = txtEmail.Text;
        string pwd = txtPwd.Text;

        // SqlConnection 개체 생성
        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=resume_maker_db;" +
        "Integrated Security=False; uid=taewoo; pwd=1111");

        // SqlCommand 개체 생성
        string sql = "SELECT pwd FROM Member WHERE email='" + email + "'";
        SqlCommand cmd = new SqlCommand(sql, con);

        // SqlConnection 개체 열기
        con.Open();

        // SqlDataReader 개체 생성
        SqlDataReader rd = cmd.ExecuteReader();

        // 데이터 조회
        if (rd.Read())
        {
            if (pwd == String.Format("{0}", rd["pwd"]))
            {
                Session["uid"] = email;
                Response.Redirect("resume.aspx?useremail=" + email);
            }
        }

        //SqlDataReader 및 SqlConnection 개체 닫기
        rd.Close();
        con.Close();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" type="text/css" href="./res/css/w3.css"/>
<link href="https://fonts.googleapis.com/css2?family=Righteous&display=swap" rel="stylesheet"/>
    <title></title>
    <style>
        .font-righteous {font-family: 'Righteous', cursive;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="w3-container">
            <div id="id01" class="w3-modal">
                <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:400px; height: 510px">
                    
                    <div class="w3-container w3-teal">
                        <h3 class="font-righteous">Resume Maker</h3>
                    </div>
                    
                    <div class="w3-center"><br/>
                        <img src="./res/img/login.png" alt="Avatar" style="width:30%" class="w3-circle w3-margin-top"/>
                    </div>
                    
                    <div class="w3-container">
                        <div class="w3-section">
                            <label><b>Email</b></label>
                            <asp:TextBox ID="txtEmail" runat="server" class="w3-input w3-border" placeholder="Enter Username"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="이메일을 입력해주세요." ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <br />
                            <label><b>Password</b></label>
                            <asp:TextBox ID="txtPwd" runat="server"  class="w3-input w3-border" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="비밀번호를 입력해주세요." ControlToValidate="txtPwd" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblDeny" runat="server" Text="" ForeColor="Red"></asp:Label>
                            <br />
                            <asp:Button ID="btnLogin" runat="server" class="w3-button w3-block w3-teal w3-padding" Text="Login" OnClick="btnLogin_Click" OnClientClick="initLabel()"/>
                            <input type="button" class="w3-button w3-margin-top w3-light-grey" value="Sign up" onclick="btnSignup_Click()" />
                            <span class="w3-right w3-padding w3-margin-top"><a href="./resume.aspx?useremail=none">비회원으로 접속</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        document.getElementById('id01').style.display = 'block';

        function initLabel() {
            document.getElementById('Label1').innerHTML = "";
        }

        function btnSignup_Click() {
            location.href = "./signup.aspx";
        }
    </script>
</body>
</html>
