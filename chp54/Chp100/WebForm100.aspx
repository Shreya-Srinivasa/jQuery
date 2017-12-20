<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm100.aspx.cs" Inherits="chp54.Chp100.WebForm100" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../jquery-3.2.1.js"></script>
    <link href="../jquery-ui.css" rel="stylesheet" />
    <script src="../jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'QuestionService.asmx/GetQuestionData',
                dataType: "json",
                method: 'post',
                success: function ()
                {
                    $('#question').text(data.QuestionText);

                    $(data.QuestionOptions).each(function () {
                        $('#questionOptions').append('<li id=' + this.Id + '>' + this.OptionText + '<li/>');
                    });

                    $(data.AnswerOptions).each(function () {
                        $('#answerOptions').append('<li id=' + this.Id + '>' + this.OptionText + '<li/>');
                    });

                    $('#answerOptions').sortable({
                        placeholder: 'placeholder',
                        axis: 'y',
                        start: function ()
                        {
                            $('#answerOptions li').removeClass('correctAnswer wrongAnswer')
                        }
                    });
                },
                error: function (e)
                {
                    alert(e.statusText);
                }
            });

            $('#btnCheck').click(function () {

                $.ajax({
                    url: 'QuestionService.asmx/GetAnswer',
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var userAnswer = '';
                        $('#answerOptions li').each(function () {
                            userAnswer += $(this).attr('Id') + ',';
                        });

                        userAnswer = userAnswer.substr(0, userAnswer.lastIndexOf(','));

                        if (userAnswer == data.AnswerText) {
                            $('#answerOptions li')
                                .removeClass('wrongAnswer').addClass('correctAnswer');
                        }
                        else {
                            $('#answerOptions li')
                                .removeClass('correctAnswer').addClass('wrongAnswer');
                        }
                    },
                    error: function (err) {
                        alert(err.statusText);
                    }
                });

            });
        });
    </script>
    <style>
        .ui-sortable-handle {
            background-color: grey;
        }

        ul {
            float: left;
        }

        li {
            border: 1px solid black;
            padding: 10px;
            height: 20px;
            cursor: pointer;
            width: 150px;
            margin: 3px;
            color: black;
            list-style-type: none;
        }

        .placeholder {
            border: 1px solid black;
            padding: 10px;
            height: 20px;
            width: 150px;
            margin: 3px;
            color: black;
            background-color: silver;
        }

        .correctAnswer {
            background-color: green;
            color: white;
        }

        .wrongAnswer {
            background-color: red;
            color: white;
        }
    </style>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <div id="question"></div>

        <ul id="questionOptions">
        </ul>

        <ul id="answerOptions">
        </ul>
        <br />
        <input id="btnCheck" type="button" value="Check Answer"
               style="clear: both; float: left;" />
    </form>
</body>
</html>