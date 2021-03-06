﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm97.aspx.cs" Inherits="chp54.Chp97.WebForm97" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.js"></script>
    <script src="jquery-ui.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" /> <script type="text/javascript">
        $(document).ready(function () {
            var selectableList = $('#selectable');

            selectableList.selectable({
                stop: getSelectedItems
            });

            function getSelectedItems() {
                var selectedItems = '';
                $('.ui-selected').each(function () {
                    selectedItems += $(this).text() + '<br/>';
                });

                $('#result').html(selectedItems);
            }

            function createSelectableList(filterValue) {
                selectableList.selectable('destroy').selectable({
                    stop: getSelectedItems,
                    filter: filterValue
                });
                $('#selectable li').removeClass('ui-selected');
                $('#result').empty();

                var weekends = $('li[data-value="weekend"]');
                if (filterValue == '*') {
                    weekends.removeClass('excluded');
                }
                else {
                    weekends.addClass('excluded');
                }
            }

            $('#cbExclude').click(function () {
                if ($(this).is(':checked')) {
                    createSelectableList('li[data-value="weekday"]');
                }
                else {
                    createSelectableList('*');
                }
            });
        });
    </script>
    <style>
        li {
            display: inline-block;
            border: 1px solid black;
            padding: 20px;
            cursor: pointer;
        }

        .ui-selecting {
            background-color: grey;
            color: white;
        }

        .ui-selected {
            background-color: green;
            color: white;
        }

        .excluded {
            background-color: red;
            color:white;
            cursor:default
        }
    </style>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        Exclude Weekends :
        <input id="cbExclude" type="checkbox"/>
        <ul id="selectable">
            <li data-value="weekday">Mon</li>
            <li data-value="weekday">Tue</li>
            <li data-value="weekday">Wed</li>
            <li data-value="weekday">Thu</li>
            <li data-value="weekday">Fri</li>
            <li data-value="weekend">Sat</li>
            <li data-value="weekend">Sun</li>
        </ul>
        You selected :
        <div id="result"></div>
    </form>
</body>
</html>