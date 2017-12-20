<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm84.aspx.cs" Inherits="chp54.Chp84.WebForm84" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../jquery-3.2.1.js"></script>
    <link href="../jquery-ui.css" rel="stylesheet" />
    <script src="../jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnUpload').click(function () {
                var files = $('#FileUpload1')[0].files;
                 
                if (files.length > 0)
                {
                    var formData = new FormData();
                    for (var i = 0; i < files.length; i++)
                    {
                        formData.append(files[1].name, files[i]);
                    }
                    var pbl = $('#pbl');
                    var pbd = $('#progressbar');

                    $.ajax({
                        url: 'UploadHandler.ashx',
                        method: 'post',
                        data: formData,
                        contentType: false,
                        processedData: false,
                        success: function ()
                        {
                            pbl.text('Complete');
                            pbd.fadeOut(2000);
                        },
                        error: function (er)
                        {
                            alert(er.statusText);
                        }
                    });

                    pbl.text('Uploading...');
                    pbd.progressbar({
                        value: false
                    }).fadeIn(500);

                }

            });
        });
    </script>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        Select Files :
        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="true" />
        <br /><br />
        <input type="button" id="btnUpload" value="Upload Files" />
        <br /><br />
        <div style="width: 300px">
            <div id="progressbar" style="position: relative; display: none">
                <span style="position: absolute; left: 35%; top: 20%" id="pbl">
                    Uploading...
                </span>
            </div>
        </div>
    </form>
</body>
</html>