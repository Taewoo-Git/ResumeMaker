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
                      <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="usrname" required/>
                      <label><b>Password</b></label>
                      <input class="w3-input w3-border" type="text" placeholder="Enter Password" name="psw" required/>
                      <button class="w3-button w3-block w3-teal w3-section w3-padding" type="submit">Login</button>
                      <button class="w3-button w3-margin-top w3-light-grey">Sign up</button>
                      <span class="w3-right w3-padding w3-margin-top"><a href="./index.aspx">비회원으로 접속</a></span>
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
