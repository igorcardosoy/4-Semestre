package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.register;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.OrderDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.PaymentMethodDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.StatusDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;

import static br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util.dispatcherForward;

@WebServlet("/home/register/order")
public class RegisterOrderServlet extends HttpServlet {

    private static final String url = "/pages/home/register/order/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();


        CustomerDao customerDao = new CustomerDao(dataSource);
        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
        StatusDao statusDao = new StatusDao(dataSource);


        req.setAttribute("paymentMethods", paymentMethodDao.getAllPaymentMethods());
        req.setAttribute("customers", customerDao.getAll());
        req.setAttribute("statuses", statusDao.getAllStatuses());
        req.setAttribute("action", "register");

        req.getRequestDispatcher(url).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        //Dados do Pedido
        long code, statusCode, customerCode;
        double price;
        String description, observation;
        String paymentMethodCode;
        LocalDate issueDate, endDate;

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        try {
            code = Long.parseLong(req.getParameter("code"));
            description = req.getParameter("description");
            issueDate = LocalDate.parse(req.getParameter("issueDate"));
            endDate = LocalDate.parse(req.getParameter("endDate"));
            price = Double.parseDouble(req.getParameter("price"));
            observation = req.getParameter("observation");
            customerCode = Long.parseLong(req.getParameter("customer"));
            paymentMethodCode = (req.getParameter("paymentMethod"));
            statusCode = Long.parseLong(req.getParameter("status"));
        } catch (NumberFormatException e) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        CustomerDao customerDao = new CustomerDao(dataSource);
        Optional<Customer> customer = customerDao.getByCode(customerCode);
        if (customer.isEmpty()) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
        Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(Long.parseLong(paymentMethodCode));
        if (paymentMethod.isEmpty()) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        StatusDao statusDao = new StatusDao(dataSource);
        Optional<Status> statusOptional = statusDao.getStatusdByCode(statusCode);
        if (statusOptional.isEmpty()) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        OrderDao orderDao = new OrderDao(dataSource);

        Order order = new Order();

        order.setCode((long) code);
        order.setDescription(description);
        order.setIssueDate(issueDate);
        order.setEndDate(endDate);
        order.setPrice(price);
        order.setObservation(observation);
        order.setCustomer(customer.get());
        order.setPaymentMethod(paymentMethod.get());
        order.setStatus(statusOptional.get());

        if (!orderDao.save(order)) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        dispatcherForward(req, resp, url,"success");
    }

}
