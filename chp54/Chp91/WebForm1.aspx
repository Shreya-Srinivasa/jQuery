<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="chp54.Chp91.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../jquery-3.2.1.js"></script>
    <link href="../jquery-ui.css" rel="stylesheet" />
    <script src="../jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            $('input[type="checkbox"], input[type="submit"], a').button().click(function () {
                var ic = $(this).is(':checked') ? 'Checked' : 'Unchecked';
                alert($(this).attr('id') + ' checkbox is ' + ic);
            });

        });

        //icons:
                //{
                //    primary: 'ui-icon-circle-triangle-w',
                //    secondary: 'ui-icon-circle-triangle-e'
                //}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="checkbox" id="Bold" /><label for="Bold">B</label>
        <input type="checkbox" id="Underline" /><label for="Underline">U</label>
        <input type="checkbox" id="Italic" /><label for="Italic">I</label>
        <%--<input type="button" value="Button Element" />
        <input type="submit" value="Submit Button" />
      <a href="#">Anchor Element</a>--%>
    </form>
</body>
</html>
