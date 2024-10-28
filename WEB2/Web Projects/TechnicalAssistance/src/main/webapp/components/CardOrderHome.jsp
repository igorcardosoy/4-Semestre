<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<div class="card bg-neutral text-neutral-content min-w-56">
  <div class="card-body items-center text-center">
    <h2 class="card-title">${param.description}</h2>
    <p>Estado: ${param.status}</p>
    <p>
      <fmt:parseDate value="${param.issueDate}"
                     pattern="yyyy-MM-dd" var="parsedDate" type="date" /> <fmt:formatDate
            value="${parsedDate}" var="formattedIssueDate" type="date"
            pattern="dd/MM/yyyy" />
      Data de Emissao: ${formattedIssueDate}
    </p>
    <p>
      <fmt:parseDate value="${param.endDate}"
                     pattern="yyyy-MM-dd" var="parsedDate" type="date" /> <fmt:formatDate
            value="${parsedDate}" var="formattedEndDate" type="date"
            pattern="dd/MM/yyyy" />
      Data de Finalizacao: ${formattedEndDate}</p>

    <%
      String price = request.getParameter("price");
      String formatedPrice = String.format("%.2f", Double.parseDouble(price));

      request.setAttribute("formatedPrice", formatedPrice);
    %>
    <p>Preco: R$ ${formatedPrice}</p>
    <p>Forma de Pagamento: ${param.paymentMethod}</p>
    <p>Cliente: ${param.customer}</p>

    <jsp:include page="/components/CardDeleteAndEditButtons.jsp">
      <jsp:param name="endpoint" value="order" />
      <jsp:param name="id" value="order" />
      <jsp:param name="code" value="${param.code}" />
    </jsp:include>
  </div>

</div>