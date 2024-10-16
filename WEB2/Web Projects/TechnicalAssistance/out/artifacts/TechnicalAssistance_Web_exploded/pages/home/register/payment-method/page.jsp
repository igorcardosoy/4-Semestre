<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html>
<head>
  <jsp:include page="/components/Head.jsp">
    <jsp:param name="title" value="Assistência Técninca - Registrar Forma de Pagamento" />
  </jsp:include>
</head>

<body>

<jsp:include page="/components/Header.jsp"/>
<main class="w-full flex items-center justify-center">
  <div class="container mx-auto max-w-80 mt-32">
    <div>
      <c:choose>
        <c:when test="${result == 'success'}">
          <div class="alert alert-success alert-dismissible fade show"
               role="alert">
            Forma de pagamento cadastrada com sucesso.
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
          </div>
        </c:when>
        <c:when test="${result == 'error'}">
          <div class="alert alert-error alert-dismissible fade show"
               role="alert">
            Erro ao cadastrar forma de pagamento.
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
          </div>
        </c:when>
      </c:choose>
      <form id="form" action="${pageContext.request.contextPath}/home/register/payment-method" method="post" class="mt-5">
        <h1 class="text-center ">Cadastro de Forma de Pagamento</h1>

        <div class="flex gap-3 mt-5 justify-center">
          <div class="alert flex items-center justify-center flex-wrap">

            <label class="input input-bordered flex items-center gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-braces-asterisk" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M1.114 8.063V7.9c1.005-.102 1.497-.615 1.497-1.6V4.503c0-1.094.39-1.538 1.354-1.538h.273V2h-.376C2.25 2 1.49 2.759 1.49 4.352v1.524c0 1.094-.376 1.456-1.49 1.456v1.299c1.114 0 1.49.362 1.49 1.456v1.524c0 1.593.759 2.352 2.372 2.352h.376v-.964h-.273c-.964 0-1.354-.444-1.354-1.538V9.663c0-.984-.492-1.497-1.497-1.6M14.886 7.9v.164c-1.005.103-1.497.616-1.497 1.6v1.798c0 1.094-.39 1.538-1.354 1.538h-.273v.964h.376c1.613 0 2.372-.759 2.372-2.352v-1.524c0-1.094.376-1.456 1.49-1.456v-1.3c-1.114 0-1.49-.362-1.49-1.456V4.352C14.51 2.759 13.75 2 12.138 2h-.376v.964h.273c.964 0 1.354.444 1.354 1.538V6.3c0 .984.492 1.497 1.497 1.6M7.5 11.5V9.207l-1.621 1.621-.707-.707L6.792 8.5H4.5v-1h2.293L5.172 5.879l.707-.707L7.5 6.792V4.5h1v2.293l1.621-1.621.707.707L9.208 7.5H11.5v1H9.207l1.621 1.621-.707.707L8.5 9.208V11.5z"></path>
              </svg>
              <input name="code" type="number" class="grow" placeholder="Code" required="required" />
            </label>

            <label class="input input-bordered flex items-center gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-credit-card" viewBox="0 0 16 16">
                <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v1h14V4a1 1 0 0 0-1-1zm13 4H1v5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"></path>
                <path d="M2 10a1 1 0 0 1 1-1h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1z"></path>
              </svg>
              <input name="name" type="text" class="grow" placeholder="Nome"  required="required"  />
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
