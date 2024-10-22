<%@ page import="java.util.List" %>
<%@ page import="br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status" %>
<%@ page import="br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.StatusDao" %>
<%@ page import="br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html>
  <head>
    <jsp:include page="/components/Head.jsp">
      <jsp:param name="title" value="Assistência Técninca - Home" />
    </jsp:include>
  </head>

  <body>
    <jsp:include page="/components/Header.jsp"/>

    <c:choose>
      <c:when test="${result == 'success'}">
        <jsp:include page="/components/SuccessAlert.jsp"/>
      </c:when>
      <c:when test="${result == 'error'}">
        <jsp:include page="/components/ErrorAlert.jsp"/>
      </c:when>
    </c:choose>

    <main class="flex flex-col items-center min-h-svh mt-14">

      <div class="text-center mt-5 max-w-6xl flex flex-wrap items-center justify-center gap-5">
        <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14">
          <h1 class="card-title">Lista de Clientes</h1>

          <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">
            <c:forEach var="customer" items="${customers}">
              <jsp:include page="/components/CardCustomerHome.jsp">
                <jsp:param name="code" value="${customer.getCode()}" />
                <jsp:param name="name" value="${customer.getName()}" />
                <jsp:param name="email" value="${customer.getEmail()}" />
                <jsp:param name="cpf" value="${customer.getCpf()}" />
              </jsp:include>
            </c:forEach>
          </div>
        </div>

        <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14">
          <h1 class="card-title">Lista de Servicos</h1>

          <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">

            <%
              StatusDao statusDao = new StatusDao(DataSourceSearcher.getInstance().getDataSource());
              List<Status> statuses = statusDao.getAllStatuses();

              request.setAttribute("statuses", statuses);
            %>

            <c:forEach var="order" items="${orders}">
              <jsp:include page="/components/CardOrderHome.jsp">
                <jsp:param name="code" value="${order.getCode()}" />
                <jsp:param name="description" value="${order.getDescription()}" />
                <jsp:param name="status" value="${order.getStatus().getName()}" />
                <jsp:param name="issueDate" value="${order.getIssueDate()}" />
                <jsp:param name="endDate" value="${order.getEndDate()}" />
                <jsp:param name="price" value="${order.getPrice()}" />
                <jsp:param name="paymentMethod" value="${order.getPaymentMethod().getName()}" />
                <jsp:param name="customer" value="${order.getCustomer().getName()}" />
              </jsp:include>
            </c:forEach>
          </div>
        </div>

        <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14">
          <h1 class="card-title">Lista de Formas de Pagamento</h1>

          <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">
            <c:forEach var="paymentMethod" items="${paymentMethods}">
              <jsp:include page="/components/CardPaymentMethod.jsp">
                <jsp:param name="name" value="${paymentMethod.getName()}" />
                <jsp:param name="code" value="${paymentMethod.getCode()}" />
              </jsp:include>
            </c:forEach>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>
