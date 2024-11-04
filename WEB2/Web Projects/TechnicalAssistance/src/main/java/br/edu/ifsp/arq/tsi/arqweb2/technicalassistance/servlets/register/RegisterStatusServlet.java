package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.register;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Status;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.StatusDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;

import static br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util.dispatcherForward;

@WebServlet("/home/register/status")
public class RegisterStatusServlet extends HttpServlet {

    private static final String url = "/pages/home/register/status/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();
        StatusDao statusDao = new StatusDao(dataSource);

        Status status = new Status();
        status.setName(name);

        if (!statusDao.save(status)) {
            dispatcherForward(req, resp, url, "error");
            return;
        }

        dispatcherForward(req, resp,"/home/view/status", "success");
    }
}
