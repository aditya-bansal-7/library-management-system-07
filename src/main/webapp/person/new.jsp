<%-- Document: person/new Created on: 08/01/2022, 23:38:26 Author: edsonpaulo --%>

<%@ page import="com.thesquad.connection.DBConnection" %>
<%@ page import="com.thesquad.utils.HtmlObj" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="../partials/html-head.jsp" %>  
<html>
    <%
        HtmlObj obj = new HtmlObj();
        DBConnection connection = new DBConnection();
    %>
    <body>
        <a href="<%=request.getContextPath()%>/person/list.jsp" class="btn btn-primary btn-sm m-4"><< Back</a>

        <div class="h-100 container d-flex justify-content-center align-items-start">
            <div class="card px-5 py-3" style="width: 100%;">

                <h5 class="text-center mb-3">New Person</h5>

                    <form class="form-container" method="POST"
                          action="<%=request.getContextPath()%>/person-servlet">

                        <div class="row">
                            <div class="form-group col-4">
                                <label for="personType" class="required">Type</label>
                                <select id="personType" name="personType" class="form-control"> 
                                    <option>Select the person's role</option>                                
                                    <option value="AUTHOR">1 - Author</option>
                                    <option value="READER">2 - Reader</option>
                                </select>
                            </div> 
                            <div class="form-group col-4">
                                <label for="name" class="required">First Name</label>
                                <input name="name" id="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group  col-4">
                                <label for="surname" class="required">Last Name</label>
                                <input name="surname" id="surname" type="text" class="form-control" required>
                            </div> 
                        </div>

                        <div class="row">
                            <div class="form-group col-4">
                                <label for="bi" class="required">ID Number</label>
                                <input name="bi" id="bi" type="text" class="form-control" required>
                            </div>
                            <div class="form-group col-4">
                                <label for="birthDate" class="required">Date of Birth</label>
                                <input name="birthDate" id="birthDate" type="date" class="form-control" required>
                            </div> 
                            <div class="form-group col-4">
                                <label for="gender" class="required">Gender</label>
                                <%=obj.getSelectBox(connection, "sexo", "gender", -1)%>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group col-4">
                                <label for="phone1" class="required">Primary Phone</label>
                                <input name="phone1" id="phone1" type="tel" class="form-control" required>
                            </div>
                            <div class="form-group col-4">
                                <label for="phone2">Secondary Phone (optional)</label>
                                <input name="phone2" id="phone2" type="tel" class="form-control">
                            </div>       
                        </div>

                        <div class="row">
                            <div class="form-group col-4">
                                <label for="email1" class="required">Primary Email</label>
                                <input name="email1" id="email1" type="email" class="form-control" required>
                            </div>   
                            <div class="form-group col-4">
                                <label for="email2">Secondary Email (optional)</label>
                                <input name="email2" id="email2" type="email" class="form-control">
                            </div>                        
                        </div>

                        <p class="h5 my-2 text-center text-muted">Address</p> 

                        <div class="row mt-3">
                            <div class="form-group col-4">
                                <label for="country" class="required">Country</label>
                                <%=obj.getSelectBox(connection, "pais", "country", -1)%>
                            </div>
                            <div class="form-group col-4">
                                <label for="province" class="required">Province</label>
                                <select id="province" name="province" class="form-control"> 
                                    <option>-- Select a country first --</option>
                                </select>
                            </div>     
                            <div class="form-group  col-4">
                                <label for="municipality" class="required">Municipality</label>
                                <select id="municipality" name="municipality" class="form-control"> 
                                    <option>-- Select a province first --</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group  col-3">
                                <label for="commune" class="required">Commune</label>
                                <select id="commune" name="commune" class="form-control"> 
                                    <option>-- Select a municipality first --</option>
                                </select>
                            </div>
                            <div class="form-group col-3">
                                <label for="district">Neighborhood</label>
                                <input name="district" id="district" type="text" class="form-control">
                            </div>
                            <div class="form-group col-3">
                                <label for="street">Street</label>
                                <input name="street" id="street" type="text" class="form-control">
                            </div>
                            <div class="form-group col-3">
                                <label for="houseNum">House Number</label>
                                <input name="houseNum" id="houseNum" type="number" class="form-control">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary my-2 float-right">
                            √ Confirm
                        </button>
                    </form>
            </div>
        </div>
    </body>

    <%  connection.closeConnection();%>

    <script type="text/javascript">

        // Get current context path or base URL path
        function getContextPath() {
            return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
        }

        function fetchList(operation, id) {
            const selectElement = document.getElementById(operation);

            fetch(getContextPath() + '/person-servlet?' + new URLSearchParams({operation, id}), {method: 'GET'})
                    .then(response => response.json())
                    .then(data => {
                        data.forEach((item) => {
                            selectElement.options[selectElement.options.length] = new Option(item.name, item[operation + 'Id']);
                        });
                    })
                    .catch(() => {
                        selectElement.options[0] = new Option('No data available', '');
                    });
        }

        function clearProvinceSelect() {
            const provinceNode = document.getElementById("province");
            while (provinceNode.firstChild)
                provinceNode.removeChild(provinceNode.lastChild);
            provinceNode.options[provinceNode.options.length] = new Option('Select a province');
        }

        function clearMunicipalitySelect() {
            const municipalityNode = document.getElementById("municipality");
            while (municipalityNode.firstChild)
                municipalityNode.removeChild(municipalityNode.lastChild);
            municipalityNode.options[municipalityNode.options.length] = new Option('Select a municipality');
        }

        function clearCommuneSelect() {
            const communeNode = document.getElementById("commune");
            while (communeNode.firstChild)
                communeNode.removeChild(communeNode.lastChild);
            communeNode.options[communeNode.options.length] = new Option('Select a commune');
        }

        // -- Handling changes for select boxes --

        document.getElementById('country').addEventListener('change', function (event) {
            clearProvinceSelect();
            clearMunicipalitySelect();
            clearCommuneSelect();
            fetchList('province', event.target.value);
        });

        document.getElementById('province').addEventListener('change', function (event) {
            clearMunicipalitySelect();
            clearCommuneSelect();
            fetchList('municipality', event.target.value);
        });

        document.getElementById('municipality').addEventListener('change', function (event) {
            clearCommuneSelect();
            fetchList('commune', event.target.value);
        });
    </script>
</html>
