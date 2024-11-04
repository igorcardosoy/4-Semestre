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

  <a class="btn btn-primary" href="${pageContext.request.contextPath}/home/register/customer">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-add" viewBox="0 0 16 16">
      <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"></path>
      <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"></path>
    </svg>
    Cadastrar Cliente</a>

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
  </div>
</main>
</body>
</html>
