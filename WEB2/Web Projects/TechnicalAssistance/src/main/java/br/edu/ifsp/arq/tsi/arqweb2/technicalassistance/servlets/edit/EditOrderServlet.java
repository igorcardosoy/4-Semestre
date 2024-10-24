package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.edit;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.OrderDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.PaymentMethodDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.StatusDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util;
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

@WebServlet("/home/edit/order")
public class EditOrderServlet extends HttpServlet {

    private static final String url = "/pages/home/register/order/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        CustomerDao customerDao = new CustomerDao(dataSource);
        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
        StatusDao statusDao = new StatusDao(dataSource);
        OrderDao orderDao = new OrderDao(dataSource);


        Optional<Order> order = orderDao.getByCode((long) code);
        if (order.isEmpty()) {
            req.setAttribute("error", "Order not found");
            req.getRequestDispatcher(url).forward(req, resp);
            return;
        }

        req.setAttribute("paymentMethods", paymentMethodDao.getAllPaymentMethods());
        req.setAttribute("customers", customerDao.getAll());
        req.setAttribute("statuses", statusDao.getAllStatuses());
        req.setAttribute("order", order.get());
        req.setAttribute("action", "edit");
        req.getRequestDispatcher(url).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        CustomerDao customerDao = new CustomerDao(dataSource);
        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
        StatusDao statusDao = new StatusDao(dataSource);
        OrderDao orderDao = new OrderDao(dataSource);

        Optional<Order> order = orderDao.getByCode((long) code);
        if (order.isEmpty()) {
            req.setAttribute("result", "error");
            req.getRequestDispatcher(url).forward(req, resp);
            return;
        }

        Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode(Long.parseLong(req.getParameter("paymentMethod")));
        Optional<Status> status = statusDao.getByCode(Long.parseLong(req.getParameter("status")));
        Optional<Customer> customer = customerDao.getByCode(Long.parseLong(req.getParameter("customer")));

        if (paymentMethod.isEmpty() || status.isEmpty() || customer.isEmpty()) {
            Util.dispatcherForward(req, resp, url, "error");
            return;
        }

        order.get().setCode((long) code);
        order.get().setDescription(req.getParameter("description"));
        order.get().setIssueDate(LocalDate.parse(req.getParameter("issueDate")));
        order.get().setEndDate(LocalDate.parse(req.getParameter("endDate")));
        order.get().setPrice(Double.parseDouble(req.getParameter("price")));
        order.get().setObservation(req.getParameter("observation"));
        order.get().setPaymentMethod(paymentMethod.get());
        order.get().setStatus(status.get());
        order.get().setCustomer(customer.get());

        if (!orderDao.update(order.get())){
            req.setAttribute("result", "error");
            req.getRequestDispatcher(url).forward(req, resp);
            return;
        }

        dispatcherForward(req, resp, "/home", "success");
    }
}
