<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm99.aspx.cs" Inherits="chp54.Chp99.WebForm99" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.js"></script>
    <script src="jquery-ui.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            $('#list1, #list2').sortable({
                connectWith: '#list1,#list2'
            });

            //OR
            //$('#list1, #list2').sortable({
            //    connectWith: 'ul[data-value="connect"]'
            //});
        });
    </script>
    <style>
        .ui-sortable-handle {
            background-color: green;
            color: white;
        }

        ul {
            float: left;
        }

        li {
            border: 1px solid black;
            padding: 10px;
            cursor: pointer;
            margin: 3px;
            width: 50px;
            color: black;
            list-style-type: none;
        }
    </style>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <ul id="list1" data-value="connect">
            <li>1</li>
            <li>2</li>
            <li>9</li>
            <li>4</li>
            <li>10</li>
        </ul>

        <ul id="list2" data-value="connect">
            <li>6</li>
            <li>5</li>
            <li>8</li>
            <li>3</li>
            <li>7</li>
        </ul>
    </form>
</body>
</html>
