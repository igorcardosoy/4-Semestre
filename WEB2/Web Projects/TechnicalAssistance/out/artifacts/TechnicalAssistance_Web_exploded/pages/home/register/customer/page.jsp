<%@ page contentType="text/html; charset=UTF-8"
				 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html>
	<head>
		<jsp:include page="/components/Head.jsp">
			<jsp:param name="title" value="Assistência Técninca - Registrar Cliente" />
		</jsp:include>

		<script defer src="${pageContext.request.contextPath}/pages/home/register/customer/script.js"></script>
  </head>

  <body>

	<jsp:include page="/components/Header.jsp"/>

  	<main class="w-full flex items-center justify-center flex-col">

			<c:choose>
				<c:when test="${result == 'success'}">
					<jsp:include page="/components/SuccessAlert.jsp"/>
				</c:when>
				<c:when test="${result == 'error'}">
					<jsp:include page="/components/ErrorAlert.jsp"/>
				</c:when>
			</c:choose>

			<div class="container mt-32 mb-32">
				<div class="flex justify-center">

					<form id="form" action="${pageContext.request.contextPath}/home/${action}/customer" method="post" class="mt-5">
						<h1 class="text-center ">Cadastro de Clientes</h1>

						<div class="flex gap-3 mt-5 justify-center">
							<div class="alert flex items-center justify-center flex-wrap max-w-80">
								<h1 class="card-title ">Dados Pessoais</h1>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-braces-asterisk" viewBox="0 0 16 16">
										<path fill-rule="evenodd" d="M1.114 8.063V7.9c1.005-.102 1.497-.615 1.497-1.6V4.503c0-1.094.39-1.538 1.354-1.538h.273V2h-.376C2.25 2 1.49 2.759 1.49 4.352v1.524c0 1.094-.376 1.456-1.49 1.456v1.299c1.114 0 1.49.362 1.49 1.456v1.524c0 1.593.759 2.352 2.372 2.352h.376v-.964h-.273c-.964 0-1.354-.444-1.354-1.538V9.663c0-.984-.492-1.497-1.497-1.6M14.886 7.9v.164c-1.005.103-1.497.616-1.497 1.6v1.798c0 1.094-.39 1.538-1.354 1.538h-.273v.964h.376c1.613 0 2.372-.759 2.372-2.352v-1.524c0-1.094.376-1.456 1.49-1.456v-1.3c-1.114 0-1.49-.362-1.49-1.456V4.352C14.51 2.759 13.75 2 12.138 2h-.376v.964h.273c.964 0 1.354.444 1.354 1.538V6.3c0 .984.492 1.497 1.497 1.6M7.5 11.5V9.207l-1.621 1.621-.707-.707L6.792 8.5H4.5v-1h2.293L5.172 5.879l.707-.707L7.5 6.792V4.5h1v2.293l1.621-1.621.707.707L9.208 7.5H11.5v1H9.207l1.621 1.621-.707.707L8.5 9.208V11.5z"></path>
									</svg>
									<c:choose>
										<c:when test="${customer == null}">
											<input name="code" type="number" class="grow" placeholder="Code" required="required" />
										</c:when>
										<c:otherwise>
											<input disabled value="${customer.getCode()}"/>
											<input name="code" type="hidden" class="hidden" value="${customer.getCode()}" />
										</c:otherwise>
									</c:choose>
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
										<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"></path>
									</svg>
									<input name="name" type="text" class="grow" placeholder="Nome"  required="required" value="${customer.getName()}">
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-fill" viewBox="0 0 16 16">
										<path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414zM0 4.697v7.104l5.803-3.558zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586zm3.436-.586L16 11.801V4.697z"></path>
									</svg>
									<input name="email" type="email" class="grow" placeholder="Email"  required="required"  value="${customer.getEmail()}">
								</label>

								<label class="input input-bordered flex items-center gap-2">

									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-vcard-fill" viewBox="0 0 16 16">
										<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5M9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8m1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5m-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96q.04-.245.04-.5M7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0"></path>
									</svg>
									<input name="cpf" type="text" class="grow" placeholder="CPF"  required="required"  value="${customer.getCpf()}">
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-fill" viewBox="0 0 16 16">
										<path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"></path>
									</svg>
									<input name="phone" type="text" class="grow" placeholder="Telefone"  required="required"  value="${customer.getPhone()}">
								</label>
							</div>

							<div class="alert flex items-center justify-center flex-wrap max-w-80">

								<h1 class="card-title">Endereço</h1>

								<label class="hidden" for="addressId">
									<input id="addressId" name="addressId" type="text" class="hidden" value="${customer.getAddress().getId()}" />
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
										<path fill-rule="evenodd" d="M8 0a5.53 5.53 0 0 1 5.5 5.5c0 3.217-4.018 8.363-5.285 9.715a.56.56 0 0 1-.43.235.56.56 0 0 1-.43-.235C6.518 13.863 2.5 8.717 2.5 5.5A5.53 5.53 0 0 1 8 0zM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4z"></path>
									</svg>
									<input id="zipcode" name="zipcode" type="text" class="grow" placeholder="CEP" required value="${customer.getAddress().getZipCode()}" />
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-signpost-2-fill" viewBox="0 0 16 16">
										<path d="M7.293.707A1 1 0 0 0 7 1.414V2H2a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h5v1H2.5a1 1 0 0 0-.8.4L.725 8.7a.5.5 0 0 0 0 .6l.975 1.3a1 1 0 0 0 .8.4H7v5h2v-5h5a1 1 0 0 0 1-1V8a1 1 0 0 0-1-1H9V6h4.5a1 1 0 0 0 .8-.4l.975-1.3a.5.5 0 0 0 0-.6L14.3 2.4a1 1 0 0 0-.8-.4H9v-.586A1 1 0 0 0 7.293.707"></path>
									</svg>
									<input id="street" name="street" type="text" class="grow" placeholder="Rua" required value="${customer.getAddress().getStreet()}" />
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door-fill" viewBox="0 0 16 16">
										<path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5"></path>
									</svg>
									<input id="number" name="number" type="text" class="grow" placeholder="Número" required value="${customer.getAddress().getComplement()}" />
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-houses-fill" viewBox="0 0 16 16">
										<path d="M7.207 1a1 1 0 0 0-1.414 0L.146 6.646a.5.5 0 0 0 .708.708L1 7.207V12.5A1.5 1.5 0 0 0 2.5 14h.55a2.5 2.5 0 0 1-.05-.5V9.415a1.5 1.5 0 0 1-.56-2.475l5.353-5.354z"></path>
										<path d="M8.793 2a1 1 0 0 1 1.414 0L12 3.793V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v3.293l1.854 1.853a.5.5 0 0 1-.708.708L15 8.207V13.5a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 4 13.5V8.207l-.146.147a.5.5 0 1 1-.708-.708z"></path>
									</svg>
									<input id="neighborhood" name="neighborhood" type="text" class="grow" placeholder="Bairro" required value="${customer.getAddress().getNeighborhood()}" />
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-buildings-fill" viewBox="0 0 16 16">
										<path d="M15 .5a.5.5 0 0 0-.724-.447l-8 4A.5.5 0 0 0 6 4.5v3.14L.342 9.526A.5.5 0 0 0 0 10v5.5a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5V14h1v1.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5zM2 11h1v1H2zm2 0h1v1H4zm-1 2v1H2v-1zm1 0h1v1H4zm9-10v1h-1V3zM8 5h1v1H8zm1 2v1H8V7zM8 9h1v1H8zm2 0h1v1h-1zm-1 2v1H8v-1zm1 0h1v1h-1zm3-2v1h-1V9zm-1 2h1v1h-1zm-2-4h1v1h-1zm3 0v1h-1V7zm-2-2v1h-1V5zm1 0h1v1h-1z"></path>
									</svg>
									<input id="city" name="city" type="text" class="grow" placeholder="Cidade" required value="${customer.getAddress().getCity()}" />
								</label>

								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-globe-americas" viewBox="0 0 16 16">
										<path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0M2.04 4.326c.325 1.329 2.532 2.54 3.717 3.19.48.263.793.434.743.484q-.121.12-.242.234c-.416.396-.787.749-.758 1.266.035.634.618.824 1.214 1.017.577.188 1.168.38 1.286.983.082.417-.075.988-.22 1.52-.215.782-.406 1.48.22 1.48 1.5-.5 3.798-3.186 4-5 .138-1.243-2-2-3.5-2.5-.478-.16-.755.081-.99.284-.172.15-.322.279-.51.216-.445-.148-2.5-2-1.5-2.5.78-.39.952-.171 1.227.182.078.099.163.208.273.318.609.304.662-.132.723-.633.039-.322.081-.671.277-.867.434-.434 1.265-.791 2.028-1.12.712-.306 1.365-.587 1.579-.88A7 7 0 1 1 2.04 4.327Z"></path>
									</svg>
									<input id="state" name="state" type="text" class="grow" placeholder="Estado" required value="${customer.getAddress().getState()}" />
								</label>



								<label class="input input-bordered flex items-center gap-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sticky-fill" viewBox="0 0 16 16">
										<path d="M2.5 1A1.5 1.5 0 0 0 1 2.5v11A1.5 1.5 0 0 0 2.5 15h6.086a1.5 1.5 0 0 0 1.06-.44l4.915-4.914A1.5 1.5 0 0 0 15 8.586V2.5A1.5 1.5 0 0 0 13.5 1zm6 8.5a1 1 0 0 1 1-1h4.396a.25.25 0 0 1 .177.427l-5.146 5.146a.25.25 0 0 1-.427-.177z"></path>
									</svg>
										<c:choose>
											<c:when test="${customer == null}">
												<input name="complement" type="text" class="grow" placeholder="Complemento" />
											</c:when>
											<c:otherwise>
												<input name="complement" type="text" class="grow" placeholder="Complemento" value="${customer.getAddress().getComplement()}" />
											</c:otherwise>
										</c:choose>
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
