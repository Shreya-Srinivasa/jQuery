<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chp72.aspx.cs" Inherits="chp54.Chp72.Chp72" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.js"></script>
    <script src="jquery-ui.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtName').autocomplete({
                source: 'StudentHandlerChp72.ashx'
            });
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        Student Name :
        <asp:TextBox ID="txtName" runat="server">
        </asp:TextBox>
    </form>
</body>
</html>

