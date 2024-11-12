<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
  <jsp:include page="/components/Head.jsp">
    <jsp:param name="title" value="Assistência Técninca - Login" />
  </jsp:include>

  <script defer src="${pageContext.request.contextPath}/pages/home/script.js"></script>
</head>
<body class="bg-base-200">
<div class="navbar bg-base-200">
  <div class="navbar-start">
  </div>
  <div class="navbar-center hidden lg:flex">
  </div>
  <div class="navbar-end">
    <button class="btn" data-toggle-theme="dark,cupcake" data-act-class="ACTIVECLASS">
      <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-6 w-6"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor">
        <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
      </svg>
      Mudar Tema
    </button>
  </div>
</div>

<div class="flex lex-col items-center justify-center mt-5 bg-base-200">
  <c:choose>
    <c:when test="${result == 'success'}">
      <jsp:include page="/components/SuccessAlert.jsp"/>
    </c:when>
    <c:when test="${result == 'error'}">
      <jsp:include page="/components/ErrorAlert.jsp"/>
    </c:when>
  </c:choose>
</div>


<main class="hero bg-base-200 mt-56">

  <div class="hero-content flex-col lg:flex-row-reverse">
    <div class="text-center lg:text-left max-w-3xl">
      <h1 class="text-5xl font-bold">Acesso ao TechAssist</h1>
      <p class="py-6 mx-12 lg:m-0">
        <strong>Bem-vindo a Assistência Técnica</strong>, o sistema de gerenciamento de ordens de serviço.
      </p>
    </div>
    <div class="card bg-base-100 w-full max-w-sm shrink-0 shadow-2xl">
      <form action="signin" method="post" class="card-body">
        <label class="input input-bordered flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
               class="bi bi-envelope-fill" viewBox="0 0 16 16">
            <path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414zM0 4.697v7.104l5.803-3.558zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586zm3.436-.586L16 11.801V4.697z"></path>
          </svg>
          <input name="email" type="email" class="grow" placeholder="Email" required="required">
        </label>
        <label class="input input-bordered flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-lock2-fill" viewBox="0 0 16 16">
            <path d="M7 6a1 1 0 0 1 2 0v1H7z"></path>
            <path d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2m-2 6v1.076c.54.166 1 .597 1 1.224v2.4c0 .816-.781 1.3-1.5 1.3h-3c-.719 0-1.5-.484-1.5-1.3V8.3c0-.627.46-1.058 1-1.224V6a2 2 0 1 1 4 0"></path>
          </svg>
          <input name="password" type="password" class="grow" placeholder="Senha" required="required">
        </label>
        <div class="form-control mt-6 space-y-2">
          <button type="submit" class="btn btn-primary">Entrar</button>
          <a href="${pageContext.request.contextPath}/signup" class="btn btn-outline btn-info">Cadastrar</a>
        </div>
      </form>
    </div>
  </div>
</main>
</body>
</html>
