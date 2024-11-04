<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
  <jsp:include page="/components/Head.jsp">
    <jsp:param name="title" value="Assistência Técninca - Login" />
  </jsp:include>
</head>
<body>
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
<main class="hero bg-base-200 min-h-screen">
  <div class="hero-content flex-col lg:flex-row-reverse">
    <div class="text-center lg:text-left max-w-3xl">
      <h1 class="text-5xl font-bold">Acesso ao TechAssist</h1>
      <p class="py-6 mx-12 lg:m-0">
        <strong>Bem-vindo a Assistência Técnica</strong>, o sistema de gerenciamento de ordens de serviço.
      </p>
    </div>
    <div class="card bg-base-100 w-full max-w-sm shrink-0 shadow-2xl">
      <form action="login" method="post" class="card-body">
        <div class="form-control">
          <label class="label">
            <span class="label-text">Email</span>
          </label>
          <label>
            <input type="email" name="email" placeholder="Email" class="input input-bordered w-full max-w-sm" required />
          </label>
        </div>
        <div class="form-control">
          <label class="label">
            <span class="label-text">Senha</span>
          </label>
          <label>
            <input type="password" name="password" placeholder="Senha" class="input input-bordered w-full max-w-sm" required />
          </label>
        </div>
        <div class="form-control mt-6 space-y-2">
          <button type="submit" class="btn btn-primary">Entrar</button>
          <a href="${pageContext.request.contextPath}/register" class="btn btn-outline btn-info">Cadastrar</a>
        </div>
      </form>
    </div>
  </div>
</main>
</body>
</html>
