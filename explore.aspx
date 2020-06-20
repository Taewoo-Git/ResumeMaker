<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
    <title>Resume Maker</title>
</head>
<body style="background-color:gray;">
    <form id="form1" runat="server">
        <div class="w3-container w3-content w3-card w3-white w3-margin-top w3-round-large" style="max-width:600px;">
            <div class="w3-section">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="email" DataSourceID="SqlDataSource1" Width="100%"
                    HeaderStyle-CssClass="w3-teal w3-padding-small" BorderColor="White">
                    <Columns>
                        <asp:TemplateField HeaderText="Resume" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='resume.aspx?useremail=<%# Eval("email") %>'><%# Eval("name") %>(<%# Eval("email") %>)님의 이력서</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="viewer" HeaderText="Views" SortExpression="viewer" ItemStyle-HorizontalAlign="Center">
                        </asp:BoundField>
                        <asp:BoundField DataField="stars" HeaderText="Stars" ReadOnly="True" SortExpression="stars" ItemStyle-HorizontalAlign="Center">
                        </asp:BoundField>
                        <asp:ButtonField ButtonType="Button" CommandName="Delete" HeaderText="" ShowHeader="True" Text="탈퇴"
                            ItemStyle-HorizontalAlign="Center" ControlStyle-CssClass="w3-button w3-red w3-padding-small"/>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:resume_maker_dbConnectionString %>"
                    SelectCommand="SELECT m.email, m.name, m.viewer, (select count(num) from Stars where email=m.email) as 'stars' FROM Member m;"
                    DeleteCommand="DELETE FROM Member WHERE email = @email">
                    <DeleteParameters>
                        <asp:Parameter Name="email" Type="String" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
</body>
</html>
