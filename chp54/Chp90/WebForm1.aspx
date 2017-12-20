<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="chp54.Chp90.WebForm1" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-1.11.2.js"></script>
    <script src="jquery-ui.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            var dialogDiv = $('#dialog');

            dialogDiv.dialog({
                autoOpen: false,
                modal: true,
                buttons: {
                    'Create': CreateEmployee,
                    'Cancel': function () {
                        dialogDiv.dialog('close');
                        clearInputFields();
                    }
                }
            });

            function CreateEmployee() {
                var emp = {};
                emp.FirstName = $('#txtFirstName').val();
                emp.LastName = $('#txtLastName').val();
                emp.Email = $('#txtEmail').val();

                $.ajax({
                    url: 'EmployeeService.asmx/SaveEmployee',
                    method: 'post',
                    data: '{ employee:' + JSON.stringify(emp) + '}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function () {
                        loadEmployees();
                        dialogDiv.dialog('close');
                        clearInputFields();
                    }
                });
            }

            function loadEmployees() {
                var tboby = $('#employees tbody');
                tboby.empty();

                $.ajax({
                    url: 'EmployeeService.asmx/GetEmployees',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        $(data).each(function () {
                            var tr = $('<tr></tr>')
                            tr.append('<td>' + this.FirstName + '</td>')
                            tr.append('<td>' + this.LastName + '</td>')
                            tr.append('<td>' + this.Email + '</td>')
                            tboby.append(tr);
                        })
                    }
                });
            }

            function clearInputFields() {
                $('#dialog input[type="text"]').val('');
            }

            $('#btnAddEmployee').click(function () {
                dialogDiv.dialog("open");
            });

            loadEmployees();
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <div id="dialog">
            <table>
                <tr>
                    <td>First Name</td>
                </tr>
                <tr>
                    <td><input type="text" id="txtFirstName" /></td>
                </tr>
                <tr>
                    <td>Last Name</td>
                </tr>
                <tr>
                    <td><input type="text" id="txtLastName" /></td>
                </tr>
                <tr>
                    <td>Email</td>
                </tr>
                <tr>
                    <td><input type="text" id="txtEmail" /></td>
                </tr>
            </table>
        </div>
        <table id="employees" style="border-collapse: collapse" border="1">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <br />
        <input type="button" id="btnAddEmployee" value="Add New Employee" />
    </form>
</body>
</html>