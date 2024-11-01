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

  <a class="btn btn-outline btn-primary" href="${pageContext.request.contextPath}/home/register/status">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
      <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"></path>
      <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"></path>
    </svg>
    Cadastrar Status</a>

  <div class="text-center mt-5 max-w-6xl flex flex-wrap items-center justify-center gap-5">
    <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14">
      <h1 class="card-title">Lista de Status</h1>

      <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">
        <c:forEach var="status" items="${statuses}">
          <jsp:include page="/components/CardStatusHome.jsp">
            <jsp:param name="name" value="${status.getName()}" />
            <jsp:param name="code" value="${status.getCode()}" />
          </jsp:include>
        </c:forEach>
      </div>
    </div>
  </div>
</main>
</body>
</html>
