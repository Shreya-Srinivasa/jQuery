<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm101.aspx.cs" Inherits="chp54.Chp101.WebForm101" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title> 
    <script src="../jquery-3.2.1.js"></script>
    <link href="../jquery-ui.css" rel="stylesheet" />
    <script src="../jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var toggleColor = false;

            $('#btnAnimate').click(function () {
                var divElement = $('#myDiv');
                if (toggleColor) {
                    divElement.animate({
                        'font-size': '15',
                        'border-width': '1',
                        'background-color': 'red',
                        'color': 'white',
                        'border-color':'green'
                    },2000);
                }
                else {
                    divElement.animate({
                        'font-size': '20',
                        'border-width': '5',
                        'background-color': 'green',
                        'color': 'white',
                        'border-color': 'red'
                    }, 2000);
                }

                toggleColor = !toggleColor;
            });
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <div id="myDiv" style="width: 500px; border: 1px solid black;
                               padding: 5px; font-size: 15px">
            At Pragim Technologies, training is delivered by real time software experts
            having more than 10 years of experience. Interview questions and real time
            scenarios discussion on topics covered for the day. Realtime projects
            discussion relating to the possible interview questions. Trainees can attend
            training and use lab untill you get a job. Resume preperation and mock up
            interviews. 100% placement assistance. 24 hours lab facility.
        </div>
        <br />
        <input type="button" id="btnAnimate" value="Animate" />
    </form>
</body>
</html>

