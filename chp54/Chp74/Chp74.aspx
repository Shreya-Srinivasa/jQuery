<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chp74.aspx.cs" Inherits="chp54.Chp74.Chp74" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.js"></script>
    <script src="jquery-ui.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'CountryServiceChp74.asmx/GetCountries',
                method: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                success: function (data) {
                    var htmlString = '';
                    $(data.d).each(function (index, country) {
                        htmlString += '<h3>' + country.Name + '</h3><div>'
                            + country.CountryDescription + '</div>';
                    });
                    $('#accordion').html(htmlString).accordion({
                        collapsible: true,
                        active: 2,
                    });
                }
            });
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <div id="accordion" style="width: 600px">
        </div>
    </form>
</body>
</html>