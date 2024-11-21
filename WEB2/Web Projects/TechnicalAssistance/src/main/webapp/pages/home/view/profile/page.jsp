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

  <div class="text-center mt-5 max-w-6xl flex flex-col flex-wrap items-center justify-center gap-5">
    <h1 class="text-3xl">Perfil</h1>

    <div class="flex flex-col items-center justify-center gap-5">
      <div class="flex flex-col items-center justify-center gap-5">
        <label class="input input-bordered flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
               class="bi bi-person-fill" viewBox="0 0 16 16">
            <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"></path>
          </svg>
          <input disabled value="${employee.getName()}"/>
          <input name="name" type="hidden" class="hidden" value="${employee.getName()}"/>
        </label>

        <label class="input input-bordered flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
               class="bi bi-envelope-fill" viewBox="0 0 16 16">
            <path
                d="M8 1a7 7 0 0 1 7 7 7 7 0 0 1-7 7 7 7 0 0 1-7-7 7 7 0 0 1 7-7zm0 1a6 6 0 0 0 6 6 6 6 0 0 0-6 6 6 6 0 0 0-6-6 6 6 0 0 0 6-6zm0 2a4 4 0 0 1 3.464 1.936 1 1 0 0 0 1.732-1.032 6 6 0 0 0-5.196-2 6 6 0 0 0-5.196 2 1 1 0 0 0 1.732 1.032A4 4 0 0 1
                8 4z"></path>
          </svg>

          <input disabled value="${employee.getEmail()}"/>

          <input name="email" type="hidden" class="hidden" value="${employee.getEmail()}"/>

        </label>


        <section class="flex gap-3">
          <a class="btn btn-accent" href="${pageContext.request.contextPath}/home/edit/profile">
            Editar
          </a>

          <a class="btn btn-error" href="${pageContext.request.contextPath}/home/delete/profile">
            Excluir
          </a>
        </section>


  </div>
</main>
</body>
</html>
