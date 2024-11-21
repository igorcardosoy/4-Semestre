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
          <h1 class="text-3xl">Bem-vindo ao sistema de assistência técnica</h1>

          <h2 class="text-xl">Relatórios</h2>

        <div class="stats shadow">
          <div class="stat">
            <div class="stat-figure text-secondary">
              <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      class="inline-block h-8 w-8 stroke-current">
                <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
            </div>
            <div class="stat-title">Venda Total</div>
            <div class="stat-value">${ordersPrice}</div>
          </div>

          <div class="stat">
            <div class="stat-figure text-secondary">
              <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      class="inline-block h-8 w-8 stroke-current">
                <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"></path>
              </svg>
            </div>
            <div class="stat-title">Número de Clientes</div>
            <div class="stat-value">${customers.size()}</div>
          </div>

          <div class="stat">
            <div class="stat-figure text-secondary">
              <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      class="inline-block h-8 w-8 stroke-current">
                <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"></path>
              </svg>
            </div>
            <div class="stat-title">Pedidos</div>
            <div class="stat-value">${orders.size()}</div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>
