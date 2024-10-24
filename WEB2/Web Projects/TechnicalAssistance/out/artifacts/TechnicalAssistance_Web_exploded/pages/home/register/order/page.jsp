<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html>
<head>
  <jsp:include page="/components/Head.jsp">
    <jsp:param name="title" value="Assistência Técninca - Registrar Serviço<"/>
  </jsp:include>

  <script defer src="${pageContext.request.contextPath}/pages/home/register/order/script.js"></script>
</head>

<body>

<jsp:include page="/components/Header.jsp"/>

<main class="w-full flex items-center justify-center">
  <div class="container mx-auto mt-32 mb-16">
    <div>
      <c:choose>
        <c:when test="${result == 'success'}">
          <div class="alert alert-success alert-dismissible fade show"
               role="alert">
            Serviço cadastrado com sucesso.
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
          </div>
        </c:when>
        <c:when test="${result == 'error'}">
          <div class="alert alert-error alert-dismissible fade show"
               role="alert">
            Erro ao cadastrar serviço.
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
          </div>
        </c:when>
      </c:choose>
      <form id="form" action="${pageContext.request.contextPath}/home/${action}/order" method="post" class="mt-5">
        <div class="flex gap-3 mt-5 justify-center">
          <div class="alert flex items-center justify-center flex-wrap max-w-min">
            <h1 class="card-title">Cadastro de Serviço</h1>

            <div>
              <c:choose>
                <c:when test="${order.getCode() != null}">
                  <label id="selected-customer" for="select-customer-modal" class="btn btn-outline w-96">Cliente - ${order.getCustomer().getName()}</label>
                </c:when>
                <c:otherwise>
                  <label id="selected-customer" for="select-customer-modal" class="btn btn-outline w-96">Selecione o Cliente</label>
                </c:otherwise>
              </c:choose>

              <input type="checkbox" id="select-customer-modal" class="modal-toggle" />
              <div class="modal" role="dialog">
                <div class="modal-box min-w-6/12 max-w-screen-sm">

                    <div class="flex flex-wrap gap-5 justify-center">
                      <c:forEach var="customer" items="${customers}" varStatus="status">
                        <div id="div-${status.index}" class="card bg-neutral text-neutral-content min-w-64 cursor-pointer flex items-center justify-top h-56">
                          <label class="mt-5">
                            <c:choose>
                              <c:when test="${order.getCustomer().getCode() == customer.getCode()}">
                                <input id="input-${status.index}" type="radio" name="customer" value="${customer.getCode()}" checked />
                              </c:when>
                              <c:otherwise>
                                <input id="input-${status.index}" type="radio" name="customer" value="${customer.getCode()}" />
                              </c:otherwise>
                            </c:choose>
                          </label>
                          <h2 id="customer-name-${status.index}" class="card-title">${customer.getName()}</h2>
                          <div class="mt-3">
                            <p>Codigo: ${customer.getCode()}</p>
                            <p>Email: ${customer.getEmail()}</p>
                            <p>CPF: ${customer.getCpf()}</p>
                            <p>Telefone: ${customer.getPhone()}</p>
                            <p>CEP: ${customer.getAddress().getZipCode()}</p>
                          </div>
                        </div>
                      </c:forEach>
                    </div>

                  <div class="modal-action">
                    <label for="select-customer-modal" class="btn">Salvar</label>
                  </div>
                </div>

                <label class="modal-backdrop" for="select-customer-modal">Close</label>
              </div>
            </div>


              <c:choose>
                <c:when test="${order.getCode() != null}">
                  <label class="input input-bordered flex items-center gap-2 w-96">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-braces-asterisk" viewBox="0 0 16 16">
                      <path fill-rule="evenodd" d="M1.114 8.063V7.9c1.005-.102 1.497-.615 1.497-1.6V4.503c0-1.094.39-1.538 1.354-1.538h.273V2h-.376C2.25 2 1.49 2.759 1.49 4.352v1.524c0 1.094-.376 1.456-1.49 1.456v1.299c1.114 0 1.49.362 1.49 1.456v1.524c0 1.593.759 2.352 2.372 2.352h.376v-.964h-.273c-.964 0-1.354-.444-1.354-1.538V9.663c0-.984-.492-1.497-1.497-1.6M14.886 7.9v.164c-1.005.103-1.497.616-1.497 1.6v1.798c0 1.094-.39 1.538-1.354 1.538h-.273v.964h.376c1.613 0 2.372-.759 2.372-2.352v-1.524c0-1.094.376-1.456 1.49-1.456v-1.3c-1.114 0-1.49-.362-1.49-1.456V4.352C14.51 2.759 13.75 2 12.138 2h-.376v.964h.273c.964 0 1.354.444 1.354 1.538V6.3c0 .984.492 1.497 1.497 1.6M7.5 11.5V9.207l-1.621 1.621-.707-.707L6.792 8.5H4.5v-1h2.293L5.172 5.879l.707-.707L7.5 6.792V4.5h1v2.293l1.621-1.621.707.707L9.208 7.5H11.5v1H9.207l1.621 1.621-.707.707L8.5 9.208V11.5z"></path>
                    </svg>
                          <input class="grow" disabled="disabled" value="${order.getCode()}"/>
                          <input name="code" type="number" class="grow hidden" placeholder="Code" value="${order.getCode()}" required="required" />
                  </label>
                </c:when>
              </c:choose>

            <label class="input input-bordered flex items-center gap-2 w-96">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-text-indent-left" viewBox="0 0 16 16">
                <path d="M2 3.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5m.646 2.146a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L4.293 8 2.646 6.354a.5.5 0 0 1 0-.708M7 6.5a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5m0 3a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5m-5 3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5"></path>
              </svg>
              <input name="description" type="text" class="grow" placeholder="Descrição" value="${order.getDescription()}" required="required" />
            </label>

            <label class="input input-bordered flex items-center gap-2 w-96 justify-between">
              <span class="badge badge-neutral">Data de Emissão</span>
              <input name="issueDate" type="date" required="required" value="${order.getIssueDate()}" />
            </label>

            <label class="input input-bordered flex items-center gap-2 w-96 justify-between">
              <span class="badge badge-neutral">Data de Finalização</span>
              <input name="endDate" type="date" required="required" value="${order.getEndDate()}" />
            </label>

            <label class="input input-bordered flex items-center gap-2 w-96">

              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-currency-dollar" viewBox="0 0 16 16">
                <path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73z"></path>
              </svg>
              <input name="price" type="number" step="0.01" class="grow" placeholder="Preço" value="${order.getPrice()}" required="required" />
            </label>

            <label>
              <select id="paymentMethod-select" class="select select-bordered w-96" required="required" name="paymentMethod">
                <option disabled selected value="disabled">Forma de Pagamento</option>
                <c:forEach var="paymentMethod" items="${paymentMethods}">
                  <c:choose>
                    <c:when test="${order.getPaymentMethod() != null && order.getPaymentMethod().getCode() == paymentMethod.getCode()}">
                      <option value="${paymentMethod.getCode()}" selected>${paymentMethod.getName()}</option>
                    </c:when>
                    <c:otherwise>
                      <option value="${paymentMethod.getCode()}">${paymentMethod.getName()}</option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </label>

            <label>
              <select id="status-select" class="select select-bordered w-96" required="required" name="status">
                <option disabled selected value="disabled">Status</option>
                <c:forEach var="status" items="${statuses}">
                  <c:choose>
                    <c:when test="${order.getStatus() != null && order.getStatus().getCode() == status.getCode()}">
                      <option value="${status.getCode()}" selected>${status.getName()}</option>
                    </c:when>
                    <c:otherwise>
                      <option value="${status.getCode()}">${status.getName()}</option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </label>

            <label>
              <textarea class="textarea textarea-bordered w-96 max-h-56" placeholder="Observações" name="observation">${order.getObservation()}</textarea>
            </label>

            <jsp:include page="/components/ConfirmButtons.jsp"/>

          </div>
        </div>

      </form>
    </div>
  </div>
</main>

</body>
</html>
