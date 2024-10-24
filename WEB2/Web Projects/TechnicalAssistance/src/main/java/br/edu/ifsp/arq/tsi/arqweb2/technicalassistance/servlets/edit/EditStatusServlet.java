package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.edit;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.PaymentMethod;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;
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
import java.util.Optional;

@WebServlet("/home/edit/status")
public class EditStatusServlet extends HttpServlet {

    private static final String url = "/pages/home/register/status/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long code = Integer.parseInt(req.getParameter("code"));

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();

        StatusDao statusDao = new StatusDao(dataSource);
        Optional<Status> status = statusDao.getByCode(code);
        if (status.isEmpty()) {
            Util.dispatcherForward(req, resp, "/home", "error");
            return;
        }

        req.setAttribute("status", status.get());
        req.setAttribute("action", "edit");
        req.getRequestDispatcher(url).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long code = Integer.parseInt(req.getParameter("code"));
        String name = req.getParameter("name");

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();
        StatusDao statusDao = new StatusDao(dataSource);

        Status status = new Status();
        status.setCode(code);
        status.setName(name);

        if (!statusDao.update(status)) {
            Util.dispatcherForward(req, resp, url, "error");
            return;
        }

        Util.dispatcherForward(req, resp, "/home", "success");
    }
}
