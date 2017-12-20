<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="chp54.Chp86.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-1.11.2.js"></script>
    <script src="jquery-ui.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {

            $.ajax({
                url: 'MenuHandler.ashx',
                method: 'get',
                dataType: 'json',
                success: function (data) {
                    buildMenu($('#menu'), data);
                    $('#menu').menu();
                }
            });

            function buildMenu(parent, items) {
                $.each(items, function () {
                    var li = $('<li>' + this.MenuText + '</li>');
                    if (!this.Active) {
                        li.addClass('ui-state-disabled');
                    }
                    li.appendTo(parent);

                    if (this.List && this.List.length > 0) {
                        var ul = $('<ul></ul>');
                        ul.appendTo(li);
                        buildMenu(ul, this.List);
                    }
                });
            }
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <div style="width: 150px">
            <ul id="menu"></ul>
        </div>
    </form>
</body>
</html>
