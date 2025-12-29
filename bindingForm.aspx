<%@ Page Language="vb" AutoEventWireup="false"
        CodeFile="bindingForm.aspx.vb" Inherits="bindingForm" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>會員身分綁定</title>
    <style>
        body { font-family: "Segoe UI", Arial, sans-serif; margin: 2rem; }
        .form-table td { padding: .4rem .6rem; }
        .btn-primary { padding:.4rem 1.2rem; border:1px solid #006; background:#048;
                       color:#fff; border-radius:4px; cursor:pointer; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <h2>請選擇您的身分</h2>

    <!-- 身分選單 -->
    <asp:RadioButtonList ID="rblIdentity" runat="server" RepeatDirection="Vertical"
                         AutoPostBack="true"
                         OnSelectedIndexChanged="rblIdentity_SelectedIndexChanged">
        <asp:ListItem Value="Parent">家長，我的孩子有參與計畫</asp:ListItem>
        <asp:ListItem Value="Teacher">教師，我的學生有參與計畫</asp:ListItem>
        <asp:ListItem Value="General">一般民眾 (研究人員、計畫訪員…等)</asp:ListItem>
    </asp:RadioButtonList>

    <!-- 家長專用欄位 -->
    <asp:Panel ID="pnlParentBinding" runat="server" Visible="false">
        <h3>家長綁定資料</h3>
        <table class="form-table">
            <tr>
                <td>兒童姓名</td>
                <td><asp:TextBox ID="txtChildName" runat="server" /></td>
            </tr>
            <tr>
                <td>兒童生日</td>
                <td><asp:TextBox ID="txtChildBirthday" runat="server" TextMode="Date" /></td>
            </tr>
            <tr>
                <td>家長姓名</td>
                <td><asp:TextBox ID="txtParentName" runat="server" /></td>
            </tr>
            <tr>
                <td>聯絡電話</td>
                <td><asp:TextBox ID="txtPhone" runat="server" /></td>
            </tr>
        </table>
    </asp:Panel>

    <!-- 送出 -->
    <asp:Button ID="btnSubmit" runat="server" Text="送出"
                CssClass="btn-primary" OnClick="btnSubmit_Click" />
</form>
</body>
</html>
