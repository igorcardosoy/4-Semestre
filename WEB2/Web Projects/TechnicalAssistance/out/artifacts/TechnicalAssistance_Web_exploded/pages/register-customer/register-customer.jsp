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

	<link href="../../styles/global.css" type="text/css" rel="stylesheet">

	<!-- DayseUI CSS -->
	<link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.12/dist/full.min.css" rel="stylesheet" type="text/css" />
	<script src="https://cdn.tailwindcss.com"></script>

		<script src="script.js"></script>

    <title>Assistência Técninca - Registrar Cliente</title>
  </head>
  <body>
  	<main class="w-full flex items-center justify-center">
			<div class="container mx-auto max-w-80 mt-32">
				<div>
					<c:choose>
						<c:when test="${result == 'success'}">
							<div class="alert alert-success alert-dismissible fade show"
									 role="alert">
								Cliente cadastrado com sucesso.
								<button type="button" class="btn-close" data-bs-dismiss="alert"
												aria-label="Close"></button>
							</div>
						</c:when>
						<c:when test="${result == 'error'}">
							<div class="alert alert-error alert-dismissible fade show"
									 role="alert">
								Erro ao cadastrar cliente.
								<button type="button" class="btn-close" data-bs-dismiss="alert"
												aria-label="Close"></button>
							</div>
						</c:when>
					</c:choose>
					<form id="form" action="" method="post" class="mt-5">
						<h1 class="text-center ">Cadastro de Clientes</h1>

						<div class="flex flex-col gap-3 mt-5">
							<label class="input input-bordered flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-braces-asterisk" viewBox="0 0 16 16">
									<path fill-rule="evenodd" d="M1.114 8.063V7.9c1.005-.102 1.497-.615 1.497-1.6V4.503c0-1.094.39-1.538 1.354-1.538h.273V2h-.376C2.25 2 1.49 2.759 1.49 4.352v1.524c0 1.094-.376 1.456-1.49 1.456v1.299c1.114 0 1.49.362 1.49 1.456v1.524c0 1.593.759 2.352 2.372 2.352h.376v-.964h-.273c-.964 0-1.354-.444-1.354-1.538V9.663c0-.984-.492-1.497-1.497-1.6M14.886 7.9v.164c-1.005.103-1.497.616-1.497 1.6v1.798c0 1.094-.39 1.538-1.354 1.538h-.273v.964h.376c1.613 0 2.372-.759 2.372-2.352v-1.524c0-1.094.376-1.456 1.49-1.456v-1.3c-1.114 0-1.49-.362-1.49-1.456V4.352C14.51 2.759 13.75 2 12.138 2h-.376v.964h.273c.964 0 1.354.444 1.354 1.538V6.3c0 .984.492 1.497 1.497 1.6M7.5 11.5V9.207l-1.621 1.621-.707-.707L6.792 8.5H4.5v-1h2.293L5.172 5.879l.707-.707L7.5 6.792V4.5h1v2.293l1.621-1.621.707.707L9.208 7.5H11.5v1H9.207l1.621 1.621-.707.707L8.5 9.208V11.5z"></path>
								</svg>
								<input name="code" type="number" class="grow" placeholder="Code" required="required" />
							</label>

							<label class="input input-bordered flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
									<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"></path>
								</svg>
								<input name="name" type="text" class="grow" placeholder="Nome"  required="required"  />
							</label>

							<label class="input input-bordered flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-fill" viewBox="0 0 16 16">
									<path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414zM0 4.697v7.104l5.803-3.558zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586zm3.436-.586L16 11.801V4.697z"></path>
								</svg>
								<input name="email" type="email" class="grow" placeholder="Email"  required="required"  />
							</label>

							<label class="input input-bordered flex items-center gap-2">

								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-vcard-fill" viewBox="0 0 16 16">
									<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5M9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8m1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5m-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96q.04-.245.04-.5M7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0"></path>
								</svg>
								<input name="cpf" type="number" class="grow" placeholder="CPF"  required="required"  />
							</label>

							<label class="input input-bordered flex items-center gap-2">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-fill" viewBox="0 0 16 16">
									<path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"></path>
								</svg>
								<input name="phone" type="text" class="grow" placeholder="Telefone"  required="required"  />
							</label>

						</div>

						<div class="flex mt-5 gap-3 justify-center">
								<a href="./home"  class="btn btn-primary">Voltar</a>
								<button type="submit" class="btn btn-secondary">Enviar</button>
						</div>

					</form>
				</div>
			</div>
		</main>
    
	</body>
</html>
