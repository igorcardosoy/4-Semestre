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

      <div class="text-center mt-5 max-w-6xl flex flex-wrap items-center justify-center gap-5">
          <h1 class="text-3xl">Bem-vindo ao sistema de assistência técnica</h1>
      </div>
    </main>
  </body>
</html>
