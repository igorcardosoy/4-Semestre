<div class="card bg-neutral text-neutral-content min-w-56">
  <div class="card-body items-center text-center">
    <h2 class="card-title">${param.name}</h2>
    <p>Email: ${param.email}</p>
    <p>CPF: ${param.cpf}</p>

    <jsp:include page="/components/CardDeleteAndEditButtons.jsp">
      <jsp:param name="endpoint" value="customer" />
      <jsp:param name="id" value="customer" />
      <jsp:param name="code" value="${param.code}" />
    </jsp:include>
  </div>
</div>