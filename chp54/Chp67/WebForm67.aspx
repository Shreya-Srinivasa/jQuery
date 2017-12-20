<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm67.aspx.cs" Inherits="chp54.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnGetEmployee').click(function () {
                var empId = $('#txtId').val();
                $.ajax({
                    url: 'WebForm67.aspx/GetEmployeeById',
                    method: 'post',
                    contentType: "application/json",
                    data: '{employeeId:' + empId + '}',
                    dataType: "json",
                    success: function (data) {
                        $('#txtName').val(data.d.Name);
                        $('#txtGender').val(data.d.Gender);
                        $('#txtSalary').val(data.d.Salary);
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        ID :
        <input id="txtId" type="text" style="width: 86px" />
        <input type="button" id="btnGetEmployee" value="Get Employee" />
        <br /><br />
        <table border="1" style="border-collapse: collapse">
            <tr>
                <td>Name</td>
                <td><input id="txtName" type="text" /></td>
            </tr>
            <tr>
                <td>Gender</td>
                <td><input id="txtGender" type="text" /></td>
            </tr>
            <tr>
                <td>Salary</td>
                <td><input id="txtSalary" type="text" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
