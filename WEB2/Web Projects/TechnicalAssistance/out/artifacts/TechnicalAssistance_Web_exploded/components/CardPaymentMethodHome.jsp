<div class="card bg-neutral text-neutral-content min-w-56">
  <div class="card-body items-center text-center">
    <h2 class="card-title">${param.name}</h2>
    <p>Code: ${param.code}</p>

    <jsp:include page="/components/CardDeleteAndEditButtons.jsp">
      <jsp:param name="endpoint" value="payment-method" />
      <jsp:param name="id" value="paymentMethod" />
      <jsp:param name="code" value="${param.code}" />
    </jsp:include>
  </div>
</div>