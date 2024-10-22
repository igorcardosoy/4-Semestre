<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html>
<head>
  <jsp:include page="/components/Head.jsp">
    <jsp:param name="title" value="Assistência Técninca - Registrar Status" />
  </jsp:include>
</head>

<body>

<jsp:include page="/components/Header.jsp"/>
<main class="w-full flex items-center justify-center">
  <div class="container mx-auto max-w-80 mt-32">
    <div>
      <<c:choose>
      <c:when test="${result == 'success'}">
        <jsp:include page="/components/SuccessAlert.jsp"/>
      </c:when>
      <c:when test="${result == 'error'}">
        <jsp:include page="/components/ErrorAlert.jsp"/>
      </c:when>
    </c:choose>
      <form id="form" action="${pageContext.request.contextPath}/home/register/status" method="post" class="mt-5">
        <h1 class="text-center ">Cadastro de Status</h1>

        <div class="flex gap-3 mt-5 justify-center">
          <div class="alert flex items-center justify-center flex-wrap">
<%--            <label class="input input-bordered flex items-center gap-2">--%>
<%--              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-text-center" viewBox="0 0 16 16">--%>
<%--                <path fill-rule="evenodd" d="M4 12.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5m-2-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5m2-3a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5m-2-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5"></path>--%>
<%--              </svg>--%>
<%--              <input name="name" type="text" class="grow" placeholder="Nome"  required="required"  />--%>
<%--            </label>--%>

            <label>
              <select name="name" class="select select-bordered">
                <option value="IN_APROVAL">Em Apravação</option>
                <option value="IN_PROGRESS">Em Progresso</option>
                <option value="FINISHED">Finalizado</option>
                <option value="APPROVED">Aprovado</option>
              </select>
            </label>
          </div>
        </div>


        <jsp:include page="/components/ConfirmButtons.jsp"/>

      </form>
    </div>
  </div>
</main>

</body>
</html>
