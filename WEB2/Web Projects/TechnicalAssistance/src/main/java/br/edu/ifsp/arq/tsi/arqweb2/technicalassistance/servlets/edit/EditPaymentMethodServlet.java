package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.edit;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.PaymentMethodDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/home/edit/payment-method")
public class EditPaymentMethodServlet extends HttpServlet {

    private static final String url = "/pages/home/register/payment-method/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
        Optional<PaymentMethod> paymentMethod = paymentMethodDao.getPaymentMethodByCode((long) code);
        if (paymentMethod.isEmpty()) {
            Util.dispatcherForward(req, resp, "/home", "error");
            return;
        }

        req.setAttribute("paymentMethod", paymentMethod.get());
        req.setAttribute("action", "edit");
        req.getRequestDispatcher(url).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        String name = req.getParameter("name");

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();
        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);

        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setCode((long) code);
        paymentMethod.setName(name);

        if (!paymentMethodDao.update(paymentMethod)) {
            Util.dispatcherForward(req, resp, url, "error");
            return;
        }

        Util.dispatcherForward(req, resp, "/home", "success");
    }
}
