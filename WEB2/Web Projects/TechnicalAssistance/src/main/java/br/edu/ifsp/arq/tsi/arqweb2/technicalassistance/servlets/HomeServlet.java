package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
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
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        CustomerDao customerDao = new CustomerDao(dataSource);
        OrderDao orderDao = new OrderDao(dataSource);
        StatusDao statusDao = new StatusDao(dataSource);
        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);

        req.setAttribute("paymentMethods", paymentMethodDao.getAllPaymentMethods());
        req.setAttribute("customers", customerDao.getAll());
        req.setAttribute("orders", orderDao.getAll());
        req.setAttribute("statuses", statusDao.getAllStatuses());
        req.getRequestDispatcher("./pages/home/page.jsp").forward(req, resp);
    }
}
