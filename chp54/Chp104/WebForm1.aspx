<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="chp54.Chp104.WebForm1" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var continentsDDL = $('#continents');
            var countriesDDL = $('#countries');
            var citiesDDL = $('#cities');

            $.ajax({
                url: 'DataService.asmx/GetContinents',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    continentsDDL.append($('<option/>', { value: -1, text: 'Select Continent' }));
                    countriesDDL.append($('<option/>', { value: -1, text: 'Select Country' }));
                    citiesDDL.append($('<option/>', { value: -1, text: 'Select City' }));
                    countriesDDL.prop('disabled', true);
                    citiesDDL.prop('disabled', true);

                    $(data).each(function (index, item) {
                        continentsDDL.append($('<option/>', { value: item.Id, text: item.Name }));
                    });
                },
                error: function (err) {
                    alert(err);
                }
            });

            continentsDDL.change(function () {
                if ($(this).val() == "-1") {
                    countriesDDL.empty();
                    citiesDDL.empty();
                    countriesDDL.append($('<option/>', { value: -1, text: 'Select Country' }));
                    citiesDDL.append($('<option/>', { value: -1, text: 'Select City' }));
                    countriesDDL.val('-1');
                    citiesDDL.val('-1');
                    countriesDDL.prop('disabled', true);
                    citiesDDL.prop('disabled', true);
                }
                else {
                    citiesDDL.val('-1');
                    citiesDDL.prop('disabled', true);
                    $.ajax({
                        url: 'DataService.asmx/GetCountriesByContinentId',
                        method: 'post',
                        dataType: 'json',
                        data: { ContinentId: $(this).val() },
                        success: function (data) {
                            countriesDDL.empty();
                            countriesDDL.append($('<option/>', { value: -1, text: 'Select Country' }));
                            $(data).each(function (index, item) {
                                countriesDDL.append($('<option/>', { value: item.Id, text: item.Name }));
                            });
                            countriesDDL.val('-1');
                            countriesDDL.prop('disabled', false);
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });

            countriesDDL.change(function () {
                if ($(this).val() == "-1") {
                    citiesDDL.empty();
                    citiesDDL.append($('<option/>', { value: -1, text: 'Select City' }));
                    citiesDDL.val('-1');
                    citiesDDL.prop('disabled', true);
                }
                else {
                    $.ajax({
                        url: 'DataService.asmx/GetCitiesByCountryId',
                        method: 'post',
                        dataType: 'json',
                        data: { CountryId: $(this).val() },
                        success: function (data) {
                            citiesDDL.empty();
                            citiesDDL.append($('<option/>', { value: -1, text: 'Select City' }));
                            $(data).each(function (index, item) {
                                citiesDDL.append($('<option/>', { value: item.Id, text: item.Name }));
                            });
                            citiesDDL.val('-1');
                            citiesDDL.prop('disabled', false);
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });
        });
    </script>
    <style>
        select {
            width: 150px;
        }
    </style>
</head>
<body style="font-family: Arial">
    <form id="form1" runat="server">
        <table>
            <tr>
                <td>Continent
                </td>
                <td>
                    <select id="continents">
                    </select>
                </td>
            </tr>
            <tr>
                <td>Country</td>
                <td>
                    <select id="countries">
                    </select>
                </td>
            </tr>
            <tr>
                <td>City</td>
                <td>
                    <select id="cities">
                    </select>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>