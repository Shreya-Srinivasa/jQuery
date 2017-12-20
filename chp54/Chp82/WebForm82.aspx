<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm82.aspx.cs" Inherits="chp54.Chp82.WebForm82" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script src="../jquery-3.2.1.js"></script>
    <link href="../jquery-ui.css" rel="stylesheet" />
    <script src="../jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.displayTooltip').tooltip({
                content: getTooltip
            });

            function getTooltip() {
                var returnValue = '';

                $.ajax({
                    url: 'TooltipService.asmx/GetTooltip',
                    method: 'post',
                    data: { fieldName: $(this).attr('id') },
                    async: false,
                    success: function (data) {
                        returnValue = data.TooltipText;
                    }
                });

                return returnValue;
            }
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <table>
            <tr>
                <td>First Name</td>
                <td>
                    <input id="firstName" class="displayTooltip" title="" type="text" />
                </td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td>
                    <input id="lastName" class="displayTooltip" title="" type="text" />
                </td>
            </tr>
            <tr>
                <td>Department</td>
                <td>
                    <input id="department" class="displayTooltip" title="" type="text" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>