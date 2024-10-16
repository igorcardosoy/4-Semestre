<%@ page import="br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    var statuses = request.getAttribute("statuses");
%>

<div class="card bg-neutral text-neutral-content min-w-56">
  <div class="card-body items-center text-center">
    <h2 class="card-title">${param.description}</h2>
    <p>Estado: ${param.status}</p>
    <p>Data de Emissao: ${param.issueDate}</p>
    <p>Data de Finalizacao: ${param.endDate}</p>
    <p>Preco: ${param.price}</p>
    <p>Forma de Pagamento: ${param.paymentMethod}</p>
    <p>Cliente: ${param.customer}</p>

    <div class="flex gap-3">

        <div class="mt-5">
          <a class="btn btn-outline w-28" href="${pageContext.request.contextPath}/home/edit/order?code=${param.code}">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
              <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
              <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"></path>
            </svg>
            Editar</a>
        </div>
    </div>
  </div>

</div>