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

  <script defer src="${pageContext.request.contextPath}/pages/home/script.js"></script>
</head>

<body>
<jsp:include page="/components/Header.jsp"/>

<div class="flex lex-col items-center justify-center mt-5">
  <c:choose>
    <c:when test="${result == 'success'}">
      <jsp:include page="/components/SuccessAlert.jsp"/>
    </c:when>
    <c:when test="${result == 'error'}">
      <jsp:include page="/components/ErrorAlert.jsp"/>
    </c:when>
  </c:choose>
</div>

<main class="flex flex-col items-center min-h-svh mt-14">

  <a class="btn btn-primary" href="${pageContext.request.contextPath}/home/register/order">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-fill" viewBox="0 0 16 16">
      <path fill-rule="evenodd" d="M15.528 2.973a.75.75 0 0 1 .472.696v8.662a.75.75 0 0 1-.472.696l-7.25 2.9a.75.75 0 0 1-.557 0l-7.25-2.9A.75.75 0 0 1 0 12.331V3.669a.75.75 0 0 1 .471-.696L7.443.184l.004-.001.274-.11a.75.75 0 0 1 .558 0l.274.11.004.001zm-1.374.527L8 5.962 1.846 3.5 1 3.839v.4l6.5 2.6v7.922l.5.2.5-.2V6.84l6.5-2.6v-.4l-.846-.339Z"></path>
    </svg>
    Cadastrar Servico</a>

  <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14 mt-5">
    <h1 class="card-title">Lista de Servicos</h1>

    <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">

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
</main>
</body>
</html>
