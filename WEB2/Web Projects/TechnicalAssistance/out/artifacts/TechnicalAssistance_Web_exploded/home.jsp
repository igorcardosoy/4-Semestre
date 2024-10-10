<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html>
<head>
  <meta charset="UTF-8" lang="pt-br">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="./styles/global.css" type="text/css" rel="stylesheet">

  <!-- DayseUI CSS -->
  <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.12/dist/full.min.css" rel="stylesheet" type="text/css" />
  <script src="https://cdn.tailwindcss.com"></script>

  <title>Assistência Técninca - Home</title>
</head>
<body>



  <main class="flex flex-col items-center min-h-svh mt-14">

    <a class="btn btn-primary" href="./register-customer">Cadastrar Cliente</a>

    <div class="text-center mt-5 max-w-6xl">
      <div class="alert flex flex-col items-center justify-center max-w-6xl pb-14 pl-14 pr-14">
        <h1 class="card-title">Lista de Clientes</h1>

        <div class="flex flex-row flex-wrap max-w-5xl gap-5 items-center justify-center">
          <c:forEach var="customer" items="${customers}">
            <div class="card bg-neutral text-neutral-content min-w-56">
              <div class="card-body items-center text-center">
                <h2 class="card-title">${customer.getName()}</h2>
                <p>Email: ${customer.getEmail()}</p>
                <p>CPF: ${customer.getCpf()}</p>
              </div>
            </div>
          </c:forEach>
        </div>

      </div>
    </div>
  </main>
</body>
</html>
