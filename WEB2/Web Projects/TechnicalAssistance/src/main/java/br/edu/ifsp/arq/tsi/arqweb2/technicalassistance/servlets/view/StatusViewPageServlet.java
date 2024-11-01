package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.view;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.StatusDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/home/view/status")
public class StatusViewPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String result = "";
        if (session != null) {
            result = (String) session.getAttribute("result");
            session.removeAttribute("result");
        }

        req.setAttribute("result", result);

        StatusDao statusDao = new StatusDao(DataSourceSearcher.getInstance().getDataSource());

        req.setAttribute("statuses", statusDao.getAllStatuses());
        req.getRequestDispatcher("/pages/home/view/status/page.jsp").forward(req, resp);
    }
}
