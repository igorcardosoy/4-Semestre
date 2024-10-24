<%@ page import="br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="card bg-neutral text-neutral-content min-w-56">
  <div class="card-body items-center text-center">
    <h2 class="card-title">${param.description}</h2>
    <p>Estado: ${param.status}</p>
    <p>Data de Emissao: ${param.issueDate}</p>
    <p>Data de Finalizacao: ${param.endDate}</p>
    <p>Preco: ${param.price}</p>
    <p>Forma de Pagamento: ${param.paymentMethod}</p>
    <p>Cliente: ${param.customer}</p>

    <jsp:include page="/components/CardDeleteAndEditButtons.jsp">
      <jsp:param name="endpoint" value="order" />
      <jsp:param name="id" value="order" />
      <jsp:param name="code" value="${param.code}" />
    </jsp:include>
  </div>

</div>