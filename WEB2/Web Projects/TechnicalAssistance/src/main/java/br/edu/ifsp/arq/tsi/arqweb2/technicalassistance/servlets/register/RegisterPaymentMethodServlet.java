package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.register;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.PaymentMethodDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util.dispatcherForward;

@WebServlet("/home/register/payment-method")
public class RegisterPaymentMethodServlet extends HttpServlet {

    private static final String url = "/pages/home/register/payment-method/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("action", "register");
        req.getRequestDispatcher(url).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        String name;

        try {
            name = req.getParameter("name");
        } catch (NumberFormatException e) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setName(name);

        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(DataSourceSearcher.getInstance().getDataSource());

        if (!paymentMethodDao.save(paymentMethod)) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        dispatcherForward(req, resp, "/home", "success");
    }
}


