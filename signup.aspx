<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
  
        .post-input{padding:8px;border:none;border-bottom:1px solid #ccc;width:30%}
        .post-btn{border-radius:5px; padding:8px;border:none;border-bottom:1px solid #ccc;width:10%}
    </style>

	<link rel="stylesheet" type="text/css" href="./res/css/w3.css"/>
	<link rel="stylesheet" type="text/css" href="./res/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
</head>
<body style="background-color:gray;">
    <form id="form1" runat="server">
		<div class="w3-container w3-content w3-card w3-white w3-margin-top w3-round-large" style="max-width:600px;">
			<h2 class="font-mont">SIGN UP</h2><br/>
		      
			<div class="w3-section">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="w3-border" placeholder="이메일 주소 입력" style="padding:8px; border:none; border-bottom:1px solid #ccc; width:69%;"></asp:TextBox>
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="w3-select" style="width:30%;">
                    <asp:ListItem>Developer</asp:ListItem>
                    <asp:ListItem>Designer</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
		      
			<div class="w3-section">
                <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="w3-input w3-border" placeholder="비밀번호(8~32자리)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox2" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
		      
			<div class="w3-section">
                <asp:TextBox ID="TextBox3" runat="server" TextMode="Password" CssClass="w3-input w3-border" placeholder="비밀번호 재입력"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox3" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
		      
			<div class="w3-section">
                <asp:TextBox ID="TextBox4" runat="server" CssClass="w3-input w3-border" placeholder="이름을 입력해주세요."></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox4" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
		      
			<div class="w3-section">
                <asp:TextBox ID="TextBox5" runat="server" CssClass="w3-input w3-border" placeholder="전화번호를 입력해주세요."></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox5" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
		      
			<div class="w3-section">
                <asp:TextBox ID="postcodify_search_input" runat="server" CssClass="post-input w3-border postcodify_postcode5" placeholder="우편번호" ReadOnly="true"></asp:TextBox>
                <asp:Button ID="postcodify_search_button" runat="server" CssClass="w3-dark-grey post-btn" Text="검색" OnClientClick="return false;"/>
                <asp:TextBox ID="postcodify_search_addr" runat="server" CssClass="w3-input w3-border postcodify_address w3-margin-top" placeholder="도로명 주소" ReadOnly="true"></asp:TextBox>
                <asp:TextBox ID="TextBox6" runat="server" CssClass="w3-input w3-border postcodify_details w3-margin-top" placeholder="상세 주소"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox6" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="postcodify_search_addr" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>

            <div class="w3-section">
                <asp:TextBox ID="TextBox7" runat="server" CssClass="w3-input w3-border" placeholder="GitHub 주소"></asp:TextBox>
			</div>
		      
			<div class="w3-section">
                <asp:Button ID="Button1" runat="server" CssClass="w3-button w3-block w3-section w3-padding btn-submit" Text="등록" ForeColor="White"/>
			</div>
		  
			<p class="w3-section">
				계정이 이미 있으신가요 ? <a href="./login.aspx">돌아가기</a>
			</p>
		</div>
    </form>

    <script> $(function() { $("#postcodify_search_input").postcodifyPopUp(); }); </script>
	<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
	<script> $(function() { $("#postcodify_search_addr").postcodifyPopUp(); }); </script>
</body>
</html>
