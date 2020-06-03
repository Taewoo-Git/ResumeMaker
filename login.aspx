<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="w3-container">
              <div id="id01" class="w3-modal">
                <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:400px">
  
                  <div class="w3-center"><br/>
                    <img src="./res/img/login.png" alt="Avatar" style="width:30%" class="w3-circle w3-margin-top"/>
                  </div>

                  <div class="w3-container">
                    <div class="w3-section">
                      <label><b>Username</b></label>
                      <asp:TextBox ID="TextBox1" runat="server" class="w3-input w3-border" placeholder="Enter Username"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="아이디를 입력해주세요." ControlToValidate="TextBox1" ForeColor="Red"></asp:RequiredFieldValidator>
                      <br />
                      <label><b>Password</b></label>
                      <asp:TextBox ID="TextBox2" runat="server"  class="w3-input w3-border" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="패스워드를 입력해주세요." ControlToValidate="TextBox2" ForeColor="Red"></asp:RequiredFieldValidator>
                      <br />
                      <asp:Button ID="Button1" runat="server" class="w3-button w3-block w3-teal w3-section w3-padding" Text="Login"/>
                      <asp:Button ID="Button2" runat="server" class="w3-button w3-margin-top w3-light-grey" Text="Sign up" />
                      <span class="w3-right w3-padding w3-margin-top"><a href="./index.aspx?userinfo=none">비회원으로 접속</a></span>
                    </div>
                  </div>

                </div>
              </div>
        </div>
    </form>

    <script>
        document.getElementById('id01').style.display = 'block';
    </script>
</body>
</html>
