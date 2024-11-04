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

  <a class="btn btn-primary" href="${pageContext.request.contextPath}/home/register/payment-method">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-credit-card-fill" viewBox="0 0 16 16">
      <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1H0zm0 3v5a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7zm3 2h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1a1 1 0 0 1 1-1"></path>
    </svg>
    Cadastrar Forma de Pagamento</a>

  <div class="text-center mt-5 max-w-6xl flex flex-wrap items-center justify-center gap-5">
    <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14">
      <h1 class="card-title">Lista de Formas de Pagamento</h1>

      <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">
        <c:forEach var="paymentMethod" items="${paymentMethods}">
          <jsp:include page="/components/CardPaymentMethodHome.jsp">
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
