<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    // SqlConnection 개체 생성
    SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=resume_maker_db;" +
            "Integrated Security=False; uid=taewoo; pwd=1111");

    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(Session["usersession"]);
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

        if(lblGithub.Text.Length == 0)
        {
            panLabelGithub.Visible = false;
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
            txtZip.Text = lblAddr.Text.Split(')')[0].TrimStart('(');
            txtAddr.Text = lblAddr.Text.Split(')')[1].TrimStart(' ');
            txtPhone.Text = lblPhone.Text;
            txtGithub.Text = lblGithub.Text;

            txtName.Visible = true;
            lblName.Visible = false;

            listJob.Visible = true;
            lblJob.Visible = false;

            txtZip.Visible = true;
            txtAddr.Visible = true;
            lblAddr.Visible = false;

            txtPhone.Visible = true;
            lblPhone.Visible = false;

            panTextGithub.Visible = true;
            panLabelGithub.Visible = false;
        }
        else
        {
            btnProfile.Text = "수정";

            string sql = "UPDATE Member SET name = @name, phone = @phone, zip = @zip, addr = @addr, job = @job, github = @github " +
                "WHERE email = @email";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@name", txtName.Text);
            cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
            cmd.Parameters.AddWithValue("@zip", txtZip.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddr.Text);
            cmd.Parameters.AddWithValue("@job", listJob.SelectedValue);
            cmd.Parameters.AddWithValue("@github", txtGithub.Text);

            cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
        }

    }

    protected void btnCerti_Click(object sender, EventArgs e)
    {
        if (!tbCertiFix.Visible)
        {
            btnCerti.Text = "취소";
            tbCertiFix.Visible = true;
            gvCerti.Columns[4].Visible = true;
        }
        else
        {
            btnCerti.Text = "수정";
            tbCertiFix.Visible = false;
            gvCerti.Columns[4].Visible = false;
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
        if(!panAddWork.Visible)
        {
            btnWorkAdd.Text = "취소";
            panAddWork.Visible = true;

            btnWorkEdit.Text = "수정";
            panEditWork.Visible = false;
        }
        else
        {
            btnWorkAdd.Text = "추가";
            panAddWork.Visible = false;
        }
    }

    protected void btnWorkEdit_Click(object sender, EventArgs e)
    {
        if(!panEditWork.Visible)
        {
            btnWorkEdit.Text = "취소";
            panEditWork.Visible = true;

            btnWorkAdd.Text = "추가";
            panAddWork.Visible = false;

            String[] joinDate = ((Label)lvWork.Items[0].FindControl("lblWorkJoinDate")).Text.Split('년');
            String[] leaveDate = ((Label)lvWork.Items[0].FindControl("lblWorkLeaveDate")).Text.Split('년');

            txtEditWorkTitle.Text = ((Label) lvWork.Items[0].FindControl("lblWorkTitle")).Text;
            txtEditWorkJoinYear.Text = joinDate[0];
            txtEditWorkJoinMonth.Text = joinDate[1].TrimEnd('월').TrimStart(' ');
            txtEditWorkLeaveYear.Text = leaveDate[0];
            txtEditWorkLeaveMonth.Text = leaveDate[1].TrimEnd('월').TrimStart(' ');
            txtEditWorkContents.Text = ((Label) lvWork.Items[0].FindControl("lblWorkContents")).Text.ToString().Replace("<br />", "\n");
        }
        else
        {
            btnWorkEdit.Text = "수정";
            panEditWork.Visible = false;
        }
    }

    protected void btnInsertWork_Click(object sender, EventArgs e)
    {
        string WorkJoinDate = txtWorkJoinYear.Text.ToString() + "년 " + txtWorkJoinMonth.Text.ToString() + "월";
        string WorkLeaveDate = txtWorkLeaveYear.Text.ToString() + "년 " + txtWorkLeaveMonth.Text.ToString() + "월";

        string sql = "INSERT INTO Board(email, title, joindate, leavedate, contents, type) VALUES(@email, @title, @joindate, @leavedate, @contents, @type)";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@title", txtWorkTitle.Text);
        cmd.Parameters.AddWithValue("@joindate", WorkJoinDate);
        cmd.Parameters.AddWithValue("@leavedate", WorkLeaveDate);
        cmd.Parameters.AddWithValue("@contents", txtWorkContents.Text);
        cmd.Parameters.AddWithValue("@type", "1");

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnDeleteWork_Click(object sender, EventArgs e)
    {
        string workNum = ((HiddenField) lvWork.Items[0].FindControl("fieldWorkNum")).Value.ToString();

        string sql = "DELETE FROM Board WHERE email = @email and num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", workNum);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnUpdateWork_Click(object sender, EventArgs e)
    {
        string WorkNum = ((HiddenField) lvWork.Items[0].FindControl("fieldWorkNum")).Value.ToString();
        string WorkTitle = txtEditWorkTitle.Text.ToString();
        string WorkJoinDate = txtEditWorkJoinYear.Text.ToString() + "년 " + txtEditWorkJoinMonth.Text.ToString() + "월";
        string WorkLeaveDate = txtEditWorkLeaveYear.Text.ToString() + "년 " + txtEditWorkLeaveMonth.Text.ToString() + "월";
        string WorkContents = txtEditWorkContents.Text.ToString();

        string sql = "UPDATE Board SET title = @title, joindate = @joindate, leavedate = @leavedate, contents = @contents " +
                "WHERE email = @email AND num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@title", WorkTitle);
        cmd.Parameters.AddWithValue("@joindate", WorkJoinDate);
        cmd.Parameters.AddWithValue("@leavedate", WorkLeaveDate);
        cmd.Parameters.AddWithValue("@contents", WorkContents);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", WorkNum);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnEduAdd_Click(object sender, EventArgs e)
    {
        if(!panAddEdu.Visible)
        {
            btnEduAdd.Text = "취소";
            panAddEdu.Visible = true;

            btnEduEdit.Text = "수정";
            panEditEdu.Visible = false;
        }
        else
        {
            btnEduAdd.Text = "추가";
            panAddEdu.Visible = false;
        }
    }

    protected void btnEduEdit_Click(object sender, EventArgs e)
    {
        if(!panEditEdu.Visible)
        {
            btnEduEdit.Text = "취소";
            panEditEdu.Visible = true;

            btnEduAdd.Text = "추가";
            panAddEdu.Visible = false;

            String[] joinDate = ((Label)lvEdu.Items[0].FindControl("lblEduJoinDate")).Text.Split('년');
            String[] leaveDate = ((Label)lvEdu.Items[0].FindControl("lblEduLeaveDate")).Text.Split('년');

            txtEditEduTitle.Text = ((Label) lvEdu.Items[0].FindControl("lblEduTitle")).Text;
            txtEditEduJoinYear.Text = joinDate[0];
            txtEditEduJoinMonth.Text = joinDate[1].TrimEnd('월').TrimStart(' ');
            txtEditEduLeaveYear.Text = leaveDate[0];
            txtEditEduLeaveMonth.Text = leaveDate[1].TrimEnd('월').TrimStart(' ');
            txtEditEduContents.Text = ((Label) lvEdu.Items[0].FindControl("lblEduContents")).Text.ToString().Replace("<br />", "\n");
        }
        else
        {
            btnEduEdit.Text = "수정";
            panEditEdu.Visible = false;
        }
    }

    protected void btnInsertEdu_Click(object sender, EventArgs e)
    {
        string EduJoinDate = txtEduJoinYear.Text.ToString() + "년 " + txtEduJoinMonth.Text.ToString() + "월";
        string EduLeaveDate = txtEduLeaveYear.Text.ToString() + "년 " + txtEduLeaveMonth.Text.ToString() + "월";

        string sql = "INSERT INTO Board(email, title, joindate, leavedate, contents, type) VALUES(@email, @title, @joindate, @leavedate, @contents, @type)";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@title", txtEduTitle.Text);
        cmd.Parameters.AddWithValue("@joindate", EduJoinDate);
        cmd.Parameters.AddWithValue("@leavedate", EduLeaveDate);
        cmd.Parameters.AddWithValue("@contents", txtEduContents.Text);
        cmd.Parameters.AddWithValue("@type", "2");

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnDeleteEdu_Click(object sender, EventArgs e)
    {
        string EduNum = ((HiddenField) lvEdu.Items[0].FindControl("fieldEduNum")).Value.ToString();

        string sql = "DELETE FROM Board WHERE email = @email and num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", EduNum);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnUpdateEdu_Click(object sender, EventArgs e)
    {
        string EduNum = ((HiddenField) lvEdu.Items[0].FindControl("fieldEduNum")).Value.ToString();
        string EduTitle = txtEditEduTitle.Text.ToString();
        string EduJoinDate = txtEditEduJoinYear.Text.ToString() + "년 " + txtEditEduJoinMonth.Text.ToString() + "월";
        string EduLeaveDate = txtEditEduLeaveYear.Text.ToString() + "년 " + txtEditEduLeaveMonth.Text.ToString() + "월";
        string EduContents = txtEditEduContents.Text.ToString();

        string sql = "UPDATE Board SET title = @title, joindate = @joindate, leavedate = @leavedate, contents = @contents " +
                "WHERE email = @email AND num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@title", EduTitle);
        cmd.Parameters.AddWithValue("@joindate", EduJoinDate);
        cmd.Parameters.AddWithValue("@leavedate", EduLeaveDate);
        cmd.Parameters.AddWithValue("@contents", EduContents);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", EduNum);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnAwardsAdd_Click(object sender, EventArgs e)
    {
        if(!panAddAwards.Visible)
        {
            btnAwardsAdd.Text = "취소";
            panAddAwards.Visible = true;

            btnAwardsEdit.Text = "수정";
            panEditAwards.Visible = false;
        }
        else
        {
            btnAwardsAdd.Text = "추가";
            panAddAwards.Visible = false;
        }
    }

    protected void btnAwardsEdit_Click(object sender, EventArgs e)
    {
        if(!panEditAwards.Visible)
        {
            btnAwardsEdit.Text = "취소";
            panEditAwards.Visible = true;

            btnAwardsAdd.Text = "추가";
            panAddAwards.Visible = false;

            String[] joinDate = ((Label)lvAwards.Items[0].FindControl("lblAwardsJoinDate")).Text.Split('년');
            String[] leaveDate = ((Label)lvAwards.Items[0].FindControl("lblAwardsLeaveDate")).Text.Split('년');

            txtEditAwardsTitle.Text = ((Label) lvAwards.Items[0].FindControl("lblAwardsTitle")).Text;
            txtEditAwardsJoinYear.Text = joinDate[0];
            txtEditAwardsJoinMonth.Text = joinDate[1].TrimEnd('월').TrimStart(' ');
            txtEditAwardsLeaveYear.Text = leaveDate[0];
            txtEditAwardsLeaveMonth.Text = leaveDate[1].TrimEnd('월').TrimStart(' ');
            txtEditAwardsContents.Text = ((Label) lvAwards.Items[0].FindControl("lblAwardsContents")).Text.ToString().Replace("<br />", "\n");
        }
        else
        {
            btnAwardsEdit.Text = "수정";
            panEditAwards.Visible = false;
        }
    }

    protected void btnInsertAwards_Click(object sender, EventArgs e)
    {
        string AwardsJoinDate = txtAwardsJoinYear.Text.ToString() + "년 " + txtAwardsJoinMonth.Text.ToString() + "월";
        string AwardsLeaveDate = txtAwardsLeaveYear.Text.ToString() + "년 " + txtAwardsLeaveMonth.Text.ToString() + "월";

        string sql = "INSERT INTO Board(email, title, joindate, leavedate, contents, type) VALUES(@email, @title, @joindate, @leavedate, @contents, @type)";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@title", txtAwardsTitle.Text);
        cmd.Parameters.AddWithValue("@joindate", AwardsJoinDate);
        cmd.Parameters.AddWithValue("@leavedate", AwardsLeaveDate);
        cmd.Parameters.AddWithValue("@contents", txtAwardsContents.Text);
        cmd.Parameters.AddWithValue("@type", "3");

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnDeleteAwards_Click(object sender, EventArgs e)
    {
        string AwardsNum = ((HiddenField) lvAwards.Items[0].FindControl("fieldAwardsNum")).Value.ToString();

        string sql = "DELETE FROM Board WHERE email = @email and num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", AwardsNum);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void btnUpdateAwards_Click(object sender, EventArgs e)
    {
        string AwardsNum = ((HiddenField) lvAwards.Items[0].FindControl("fieldAwardsNum")).Value.ToString();
        string AwardsTitle = txtEditAwardsTitle.Text.ToString();
        string AwardsJoinDate = txtEditAwardsJoinYear.Text.ToString() + "년 " + txtEditAwardsJoinMonth.Text.ToString() + "월";
        string AwardsLeaveDate = txtEditAwardsLeaveYear.Text.ToString() + "년 " + txtEditAwardsLeaveMonth.Text.ToString() + "월";
        string AwardsContents = txtEditAwardsContents.Text.ToString();

        string sql = "UPDATE Board SET title = @title, joindate = @joindate, leavedate = @leavedate, contents = @contents " +
                "WHERE email = @email AND num = @num";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@title", AwardsTitle);
        cmd.Parameters.AddWithValue("@joindate", AwardsJoinDate);
        cmd.Parameters.AddWithValue("@leavedate", AwardsLeaveDate);
        cmd.Parameters.AddWithValue("@contents", AwardsContents);

        cmd.Parameters.AddWithValue("@email", Request.QueryString["useremail"]);
        cmd.Parameters.AddWithValue("@num", AwardsNum);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("resume.aspx?useremail=" + Request.QueryString["useremail"]);
    }

    protected void lvWork_PagePropertiesChanged(object sender, EventArgs e)
    {
        btnWorkEdit.Text = "수정";
        panEditWork.Visible = false;

        btnWorkAdd.Text = "추가";
        panAddWork.Visible = false;
    }

    protected void lvEdu_PagePropertiesChanged(object sender, EventArgs e)
    {
        btnEduEdit.Text = "수정";
        panEditEdu.Visible = false;

        btnEduAdd.Text = "추가";
        panAddEdu.Visible = false;
    }

    protected void lvAwards_PagePropertiesChanged(object sender, EventArgs e)
    {
        btnAwardsEdit.Text = "수정";
        panEditAwards.Visible = false;

        btnAwardsAdd.Text = "추가";
        panAddAwards.Visible = false;
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
                            <asp:TextBox ID="txtName" runat="server" Visible="false" CssClass="w3-margin-left" style="width:75%; height:30px; margin-top:15px;" placeholder="이름" Font-Size="Medium"></asp:TextBox>
                            <h2 style="margin-bottom: 0px"><asp:Label ID="lblName" runat="server" CssClass="w3-margin-left" Text="이름" Font-Bold="true"/></h2>
                        </div>

                        <div class="w3-container">

                            <p><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:Label ID="lblEmail" runat="server" Text="이메일"/></p>
                            <p><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:DropDownList ID="listJob" runat="server" Visible="false" CssClass="w3-select" style="width:70%; margin-top:0px;">
                                    <asp:ListItem>Front-End</asp:ListItem>
                                    <asp:ListItem>Back-End</asp:ListItem>
                                    <asp:ListItem>Full Stack</asp:ListItem>
                                    <asp:ListItem>DBA</asp:ListItem>
                                    <asp:ListItem>Designer</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label ID="lblJob" runat="server" Text="직업"/></p>
                            <p><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:TextBox ID="txtZip" runat="server" Visible="false" style="width:13%;" placeholder="우편번호"></asp:TextBox>
                                <asp:TextBox ID="txtAddr" runat="server" Visible="false" style="width:56%;" placeholder="주소"></asp:TextBox>
                                <asp:Label ID="lblAddr" runat="server" Text="주소"/></p>
                            <p><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:TextBox ID="txtPhone" runat="server" Visible="false" style="width:70%;" placeholder="전화번호"></asp:TextBox>
                                <asp:Label ID="lblPhone" runat="server" Text="전화번호"/></p>
                            <asp:Panel ID="panLabelGithub" runat="server">
                                <p><i class="fa fa-github fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:Label ID="lblGithub" runat="server" Text="GitHub"/></p>
                            </asp:Panel>
                            <asp:Panel ID="panTextGithub" runat="server" Visible="false">
                                <p><i class="fa fa-github fa-fw w3-margin-right w3-large w3-text-teal"></i>
                                <asp:TextBox ID="txtGithub" runat="server" style="width:70%;" placeholder="GitHub"></asp:TextBox></p>
                            </asp:Panel>
                            <hr/>

                            <p class="w3-large w3-text-theme"><b><i class="fa fa-certificate fa-fw w3-margin-right w3-text-teal"></i>Certificate</b></p>
                            <asp:Button ID="btnCerti" runat="server" Text="수정" CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-50px; margin-right:2.5px;" OnClick="btnCerti_Click" />
                            
                            <asp:GridView ID="gvCerti" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowDeleted="gvCerti_RowDeleted"
                                Height="35px" Width="100%" BorderStyle="None" BorderColor="White" ShowHeader="false" DataKeyNames="num" >
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="5">
                                        <ItemTemplate>
                                            <i class="fa fa-calendar" style="padding-left:6.5px;"></i>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="date" SortExpression="date" ItemStyle-Width="105" ItemStyle-CssClass="w3-padding-small">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="name" SortExpression="name" ItemStyle-Width="230">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="num" SortExpression="num" ItemStyle-Width="10" Visible="false">
                                    </asp:BoundField>
                                    <asp:CommandField ButtonType="Button" ShowDeleteButton="true"
                                        ControlStyle-CssClass="w3-button w3-red w3-right w3-padding-small" Visible="false"/>
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
                                    <asp:TableCell Width="132">
                                        <div style="border: 1px solid #A6A6A6; height: 28.5px; padding-left:5px;">
                                            <i class="fa fa-calendar w3-dropdown-click w3-text-teal" onclick="show_calendar()"></i>
                                            <div class="w3-dropdown-content w3-bar-block w3-card-4" id="calendar">
                                                <asp:Calendar ID="calCerti" runat="server" OnSelectionChanged="calCerti_SelectionChanged"></asp:Calendar>
                                            </div>
                                            <asp:TextBox ID="txtCertiDate" runat="server" placeholder="취득 일자" Width="80%" BorderStyle="None" style="padding-left:7px; outline:none;"></asp:TextBox>
                                        </div>
                                    </asp:TableCell>
                                    <asp:TableCell Width="250">
                                        <asp:TextBox ID="txtCertiName" runat="server" placeholder="자격증 이름" style="padding-left:4px; outline:none; width:95%;"></asp:TextBox>
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

                        <asp:ListView ID="lvWork" runat="server" DataSourceID="SqlDataSource3" OnPagePropertiesChanged="lvWork_PagePropertiesChanged">
                            <ItemTemplate>
                                <div class="w3-container">
                                    <h5 class="w3-opacity">
                                        <asp:Label ID="lblWorkTitle" runat="server" Text='<%# Eval("title") %>' Font-Bold="true"></asp:Label>
                                    </h5>
                                    <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw"></i>
                                        <asp:Label ID="lblWorkJoinDate" runat="server" Text='<%# Eval("joindate") %>'></asp:Label>
                                        -
                                        <asp:Label ID="lblWorkLeaveDate" runat="server" Text='<%# Eval("leavedate") %>'></asp:Label>

                                    </h6>
                                    <p><asp:Label ID="lblWorkContents" runat="server" Text='<%# Eval("contents").ToString().Replace("\n", "<br />") %>'></asp:Label></p>
                                    <asp:HiddenField ID="fieldWorkNum" runat="server" Value='<%# Eval("num") %>'/>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>

                        <asp:DataPager ID="DataPager1" runat="server" PageSize="1" PagedControlID="lvWork" >
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="w3-button w3-teal w3-padding-small w3-margin-left"/>
                            </Fields>
                        </asp:DataPager>

                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                            SelectCommand="SELECT [num], [title], [joindate], [leavedate], [contents] FROM [Board] WHERE ([email] = @email AND [type] = 1)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br /><br />

                        <asp:Panel ID="panAddWork" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="txtWorkTitle" runat="server" placeholder="회사 명" style="width:92%; height:37px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="btnInsertWork" runat="server" Text="등록" OnClick="btnInsertWork_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="txtWorkJoinYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblWorkJoinYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtWorkJoinMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblWorkJoinMonth" runat="server" Text="월  입사" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="txtWorkLeaveYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblWorkLeaveYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtWorkLeaveMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblWorkLeaveMonth" runat="server" Text="월  퇴사" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="txtWorkContents" runat="server" placeholder="직무 내용을 입력해 주세요." TextMode="MultiLine"
                                style="width:100%; height:200px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>

                        <asp:Panel ID="panEditWork" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="txtEditWorkTitle" runat="server" style="width:85%; height:38px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="btnDeleteWork" runat="server" Text="삭제" OnClick="btnDeleteWork_Click" 
                                    CssClass="w3-button w3-red w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <asp:Button ID="btnUpdateWork" runat="server" Text="등록" OnClick="btnUpdateWork_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="txtEditWorkJoinYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditWorkJoinYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEditWorkJoinMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditWorkJoinMonth" runat="server" Text="월  입사" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="txtEditWorkLeaveYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditWorkLeaveYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEditWorkLeaveMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditWorkLeaveMonth" runat="server" Text="월  퇴사" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="txtEditWorkContents" runat="server" TextMode="MultiLine" style="width:100%; height:200px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>
                    </div>

                    <div class="w3-container w3-card w3-white w3-margin-bottom">
                        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Education</h2>
                        <asp:Button ID="btnEduAdd" runat="server" Text="추가" OnClick="btnEduAdd_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-60px; margin-right:2.5px;" />
                        <asp:Button ID="btnEduEdit" runat="server" Text="수정" OnClick="btnEduEdit_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-60px; margin-right:60px;" />

                        <asp:ListView ID="lvEdu" runat="server" DataSourceID="SqlDataSource4" OnPagePropertiesChanged="lvEdu_PagePropertiesChanged">
                            <ItemTemplate>
                                <div class="w3-container">
                                    <h5 class="w3-opacity">
                                        <asp:Label ID="lblEduTitle" runat="server" Text='<%# Eval("title") %>' Font-Bold="true"></asp:Label>
                                    </h5>
                                    <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw"></i>
                                        <asp:Label ID="lblEduJoinDate" runat="server" Text='<%# Eval("joindate") %>'></asp:Label>
                                        -
                                        <asp:Label ID="lblEduLeaveDate" runat="server" Text='<%# Eval("leavedate") %>'></asp:Label>

                                    </h6>
                                    <p><asp:Label ID="lblEduContents" runat="server" Text='<%# Eval("contents").ToString().Replace("\n", "<br />") %>'></asp:Label></p>
                                    <asp:HiddenField ID="fieldEduNum" runat="server" Value='<%# Eval("num") %>'/>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>

                        <asp:DataPager ID="DataPager2" runat="server" PageSize="1" PagedControlID="lvEdu" >
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="w3-button w3-teal w3-padding-small w3-margin-left"/>
                            </Fields>
                        </asp:DataPager>

                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                            SelectCommand="SELECT [num], [title], [joindate], [leavedate], [contents] FROM [Board] WHERE ([email] = @email AND [type] = 2)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br /><br />

                        <asp:Panel ID="panAddEdu" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="txtEduTitle" runat="server" placeholder="학교 명" style="width:92%; height:37px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="btnInsertEdu" runat="server" Text="등록" OnClick="btnInsertEdu_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="txtEduJoinYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEduJoinYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEduJoinMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEduJoinMonth" runat="server" Text="월  입학" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="txtEduLeaveYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEduLeaveYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEduLeaveMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEduLeaveMonth" runat="server" Text="월  졸업" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="txtEduContents" runat="server" placeholder="활동 내용을 입력해 주세요." TextMode="MultiLine"
                                style="width:100%; height:200px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>

                        <asp:Panel ID="panEditEdu" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="txtEditEduTitle" runat="server" style="width:85%; height:38px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="btnDeleteEdu" runat="server" Text="삭제" OnClick="btnDeleteEdu_Click" 
                                    CssClass="w3-button w3-red w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <asp:Button ID="btnUpdateEdu" runat="server" Text="등록" OnClick="btnUpdateEdu_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="txtEditEduJoinYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditEduJoinYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEditEduJoinMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditEduJoinMonth" runat="server" Text="월  입학" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="txtEditEduLeaveYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditEduLeaveYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEditEduLeaveMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditEduLeaveMonth" runat="server" Text="월  졸업" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="txtEditEduContents" runat="server" TextMode="MultiLine" style="width:100%; height:200px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>
                    </div>

                    <div class="w3-container w3-card w3-white w3-margin-bottom">
                        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Awards</h2>
                        <asp:Button ID="btnAwardsAdd" runat="server" Text="추가" OnClick="btnAwardsAdd_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-60px; margin-right:2.5px;" />
                        <asp:Button ID="btnAwardsEdit" runat="server" Text="수정" OnClick="btnAwardsEdit_Click" 
                                CssClass="w3-button w3-teal w3-right w3-padding-small" style="margin-top:-60px; margin-right:60px;" />

                        <asp:ListView ID="lvAwards" runat="server" DataSourceID="SqlDataSource5" OnPagePropertiesChanged="lvAwards_PagePropertiesChanged">
                            <ItemTemplate>
                                <div class="w3-container">
                                    <h5 class="w3-opacity">
                                        <asp:Label ID="lblAwardsTitle" runat="server" Text='<%# Eval("title") %>' Font-Bold="true"></asp:Label>
                                    </h5>
                                    <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw"></i>
                                        <asp:Label ID="lblAwardsJoinDate" runat="server" Text='<%# Eval("joindate") %>'></asp:Label>
                                        -
                                        <asp:Label ID="lblAwardsLeaveDate" runat="server" Text='<%# Eval("leavedate") %>'></asp:Label>

                                    </h6>
                                    <p><asp:Label ID="lblAwardsContents" runat="server" Text='<%# Eval("contents").ToString().Replace("\n", "<br />") %>'></asp:Label></p>
                                    <asp:HiddenField ID="fieldAwardsNum" runat="server" Value='<%# Eval("num") %>'/>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>

                        <asp:DataPager ID="DataPager3" runat="server" PageSize="1" PagedControlID="lvAwards" >
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="w3-button w3-teal w3-padding-small w3-margin-left"/>
                            </Fields>
                        </asp:DataPager>

                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                            SelectCommand="SELECT [num], [title], [joindate], [leavedate], [contents] FROM [Board] WHERE ([email] = @email AND [type] = 3)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="email" QueryStringField="useremail" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br /><br />

                        <asp:Panel ID="panAddAwards" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="txtAwardsTitle" runat="server" placeholder="대회 명" style="width:92%; height:37px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="btnInsertAwards" runat="server" Text="등록" OnClick="btnInsertAwards_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="txtAwardsJoinYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblAwardsJoinYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtAwardsJoinMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblAwardsJoinMonth" runat="server" Text="월  참가" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="txtAwardsLeaveYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblAwardsLeaveYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtAwardsLeaveMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblAwardsLeaveMonth" runat="server" Text="월  종료" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="txtAwardsContents" runat="server" placeholder="수상 내용을 입력해 주세요." TextMode="MultiLine"
                                style="width:100%; height:200px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>

                        <asp:Panel ID="panEditAwards" runat="server" Visible="false">
                            <hr />

                            <asp:TextBox ID="txtEditAwardsTitle" runat="server" style="width:85%; height:38px; padding-left:5px;"></asp:TextBox>
                            <asp:Button ID="btnDeleteAwards" runat="server" Text="삭제" OnClick="btnDeleteAwards_Click" 
                                    CssClass="w3-button w3-red w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <asp:Button ID="btnUpdateAwards" runat="server" Text="등록" OnClick="btnUpdateAwards_Click" 
                                    CssClass="w3-button w3-teal w3-right" style="margin-top:0px; margin-right:2.5px;" />
                            <br /><br />

                            <div>
                                <asp:TextBox ID="txtEditAwardsJoinYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditAwardsJoinYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEditAwardsJoinMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditAwardsJoinMonth" runat="server" Text="월  참가" ForeColor="Gray"></asp:Label>
                                &nbsp; <a style="color:gray;">~</a> &nbsp;
                                <asp:TextBox ID="txtEditAwardsLeaveYear" runat="server" Width="50" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditAwardsLeaveYear" runat="server" Text="년" ForeColor="Gray"></asp:Label> &nbsp;
                                <asp:TextBox ID="txtEditAwardsLeaveMonth" runat="server" Width="30" CssClass="w3-center"></asp:TextBox>
                                <asp:Label ID="lblEditAwardsLeaveMonth" runat="server" Text="월  종료" ForeColor="Gray"></asp:Label>
                            </div><br />

                            <asp:TextBox ID="txtEditAwardsContents" runat="server" TextMode="MultiLine" style="width:100%; height:200px; padding-left:5px;"></asp:TextBox>
                            <br /><br />
                        </asp:Panel>
                    </div>
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
